From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 05:03:58 -0700
Message-ID: <7v3998kb0x.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <20120316091019.GB22273@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8VtE-0000Jj-9M
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 13:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747Ab2CPMEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 08:04:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422728Ab2CPMED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 08:04:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7CB4F30;
	Fri, 16 Mar 2012 08:04:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSSCa7WmGYaTdenz2ADJHb3kA9A=; b=rZ7Mqd
	2VGNFPPiuKtMNr6a/gkm++44OeDxdfmE3Imq8YZSSLeUmJXAK+Lp8ZF06jY0+gH5
	+HhMAnxwPJq43Cw9PRri8i49ML4zJHwA457E3I2tvwA0PIf3i2/f5tsSLHuqr6iS
	gB0LzW9BvfZ6Ihh51GhzQ+Ww0E8SGs5AZ8FoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3mw5jY0ZE1SHfQELqkVTX0tw/iXM4FN
	wMYAg00IBiLsz5iD3stE010MEc/TDoheMNnChdrA/HfjXu0Sm/zhNgzmk+Zll7BB
	xtKCb9NzQgh0nlzFNgLcugQZtqvrsFyRqkE+hfk5y/zbLKucRCYWnkxy225m3jsA
	MUDTaPuZDls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFCEB4F2F;
	Fri, 16 Mar 2012 08:04:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3326A4F2D; Fri, 16 Mar 2012
 08:04:00 -0400 (EDT)
In-Reply-To: <20120316091019.GB22273@ecki> (Clemens Buchacher's message of
 "Fri, 16 Mar 2012 10:10:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D9D3BFC-6F60-11E1-83F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193255>

Clemens Buchacher <drizzd@aon.at> writes:

> On Thu, Mar 15, 2012 at 10:36:22PM -0700, Junio C Hamano wrote:
>>
>> +static const char message_advice_pull_before_push[] =
>> +	N_("Update was rejected because the tip of your current branch is behind\n"
>> +	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
>> +	   "pushing again. See the 'Note about fast-forwards' section of\n"
>> +	   "'git push --help' for details.");
>> +
>> +
>> +static const char message_advice_use_upstream[] =
>> +	N_("Some of your local branches were stale with respect to their\n"
>> +	   "remote counterparts. If you did not intend to push these branches,\n"
>> +	   "you may want to set the 'push.default' configuration variable to\n"
>> +	   "'current' or 'upstream' to push only the current branch.");
>> +
>> +static const char message_advice_checkout_pull_push[] =
>> +	N_("Updates were rejected because the tip of some of your branches are\n"
>> +	   "behind the remote. Check out the branch and merge the remote\n"
>> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
>> +	   "'Note about fast-forwards' section of 'git push --help'\n"
>> +	   "for details.");
>
> The first sentence of the above two warnings state the same thing, but
> in different ways. Yet the difference does not reflect the different
> situations. They should be the same, or maybe the first one should be
> changed to the following variant of the second:
>
>  "Updates were rejected because the tip of some of your branches are
>  behind the remote branches with matching names."

That defeats the whole point of Christpher's patch and suggestion by Peff
in the original discussion.

They apply to two different situations. If your current branch is behind,
you get the first one, if your current branch is *NOT* behind, but some
others are, you get the second one. The suggested solutions are different.

Read each of them in isolation, imagining that you just saw your action
resulted in a corresponding error condition. I thought they are clear
enough (that is why I sent the pach), but the wording may still need to be
polished, and updates are welcome.

> We should not give advise_use_upstream if the user specified git push
> --all. The advice_checkout_pull_push would make more sense in that case.

Yeah, "default_matching_used" variable should be looked at somewhere
around that, but I *think* the approach Christpher and Peff took (and I
agree with them) is to help solving the immediate problem the user has and
can address.  Deal with the current branch first (which would solve "the
current branch is behind" problem).  The next push may then show that
other branches are behind, and at that time the other advice will tell him
how to deal with it ("check out and fix them, and then push").

Again, updates are welcome.

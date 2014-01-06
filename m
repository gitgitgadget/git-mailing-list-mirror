From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 12:38:30 -0800
Message-ID: <xmqq1u0kj16h.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GwZ-0007OI-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbaAFUif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:38:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbaAFUie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:38:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC14761858;
	Mon,  6 Jan 2014 15:38:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4WSSly9bmrdcgz4VekaHRP1+aPc=; b=aCuWXD
	kBGZxVftT39ic/uFDkuXMi+2kD438UGfFqo/CmF8jxtlcDWihAoJGFVt+XO7CAgh
	g0VchW2FuX+c5eUrcFshWc/+ewESTk9VuFJCL3bskXylTp88i/3rwtHp41YMe06x
	5DbfWJCyCCOK9gJ8dpUfhZjJ5xaLRZpGApBQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRk8ukb0Nmsc/rXO0fb1zk5BQ5UIx+2m
	AtJvirxw6o7aMIQjBuENDVnVwJPKJYwPvvG46P3n+0rbRrDKlHdCD0F6adXLh1pf
	NfgU//z3l4ic7BG/Dna+MFmZ2WBbpLZ1eW8HUWBH/5LZ2I08gF/CHVxVFL4gKoZ4
	5ICYMlE5cio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B767661857;
	Mon,  6 Jan 2014 15:38:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 114B761856;
	Mon,  6 Jan 2014 15:38:32 -0500 (EST)
In-Reply-To: <20140106201854.GA28162@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2014 15:18:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82525FD0-7712-11E3-82DF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240059>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 06, 2014 at 12:06:51PM -0800, Junio C Hamano wrote:
>
>> Unless you set @{u} to this new configuration, in which case the
>> choice becomes dynamic depending on the current branch, but
>> 
>>  - if that is the only sane choice based on the current branch, why
>>    not use that as the default without having to set the
>>    configuration?
>> 
>>  - Or if that is still insufficient, don't we need branch.*.forkedFrom
>>    that is different from branch.*.merge, so that different branches
>>    you want to show "format-patch" output can have different
>>    reference points?
>
> Yeah, I had similar thoughts. I personally use "branch.*.merge" as
> "forkedFrom", and it seems like we are going that way anyway with things
> like "git rebase" and "git merge" defaulting to upstream. But then there
> is "git push -u" and "push.default = upstream", which treats the
> upstream config as something else entirely.
>
> So it seems like there is already some confusion, and either way we go,
> thisis making it worse to some degree (I do not blame Ram, but rather he
> has stumbled into a hidden sand pit that we have been building for the
> past few years... :).
>
> I wonder if it is too late to try to clarify this dual usage. It kind of
> seems like the push config is "this is the place I publish to". Which,
> in many workflows, just so happens to be the exact same as the place you
> forked from. Could we introduce a new branch.*.pushupstream variable
> that falls back to branch.*.merge? Or is that just throwing more fuel on
> the fire (more sand in the pit in my analogy, I guess).
>
> I admit I haven't thought it through yet, though. And even if it does
> work, it may throw a slight monkey wrench in the proposed push.default
> transition.

Yeah, when I say "upstream", I never mean it as "where I publish".
Your upstream is where you get others' work from.

For a "push to somewhere for safekeeping or other people to look at"
triangular workflow, it does not make any sense to treat that "I
publish there" place as an upstream (hence having branch.*.remote
pointing at that publishing point).  Once you stop doing that, and
instead using branch.*.remote = origin, and branch.*.merge = master,
where 'origin' is not your publishing point, @{u} will again start
making sense, I think.

And I thought that is what setting "remote.pushdefault" to the
publishing point repository was about.

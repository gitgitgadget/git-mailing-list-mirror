From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Tue, 03 Apr 2012 15:29:34 -0700
Message-ID: <7vsjgkbga9.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
 <20120403205906.GB24815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCER-0001EF-ED
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab2DCW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:29:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690Ab2DCW3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:29:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20F267AA5;
	Tue,  3 Apr 2012 18:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vzLGAprTy3BdAQcs31oHBubF0R4=; b=n17MWv
	lkxf9lYWl85ze06JBe59ZAQHQUgp5YmQAxsJAYxeNloXLTcNfJGNV++1wurw5uFt
	TVLsh7IMw68Aq16+R/xP/PtjapPp2ytSy6Z+vAt7m8lQnziRkJmCUIUp86nLeWTS
	gFhYSvGIK6dIp96xv9xJf5C5MeKELy4+z8Xzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZu4otMqihqVz7ZRDaaGsVPpRyfJuSrY
	B/rS1BTVLxH2t5vcFBjoQrklefo8hUklD7v4/xwwXG/BZurw/raC1Aiu0el7pz6a
	gmZpeuKvvyGaNaDLzSrdq3NrryfG1EdG0iSwP/yAn80ciglQDw/5S5l6yW9gCscx
	ZA5431gIC+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 191937AA4;
	Tue,  3 Apr 2012 18:29:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94C6C7AA3; Tue,  3 Apr 2012
 18:29:35 -0400 (EDT)
In-Reply-To: <20120403205906.GB24815@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Apr 2012 16:59:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DE41078-7DDC-11E1-91FF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194658>

Jeff King <peff@peff.net> writes:

>> +	if (strcmp(branch->remote_name, remote->name)) {
>> +		struct remote *branch_dest = remote_get(branch->remote_name);
>> +		const char **branch_dest_url, **dest_url;
>> +
>> +		if (!push_url_of_remote(remote, &dest_url) ||
>> +		    !push_url_of_remote(branch_dest, &branch_dest_url) ||
>> +		    strcmp(dest_url[0], branch_dest_url[0]))
>> +			die(_("You are pushing to remote '%s', which is not the "
>> +			      "upstream of your\ncurrent branch '%s'.\n"),
>> +			    remote->name, branch->name);
>> +	}
>
> Hmm. So this will actually detect "git push $URL" when $URL matches the
> remote's configured URL. I feel like this distinction has come up
> before, and we decided not to equate the two. But now I can't remember
> where (maybe it when fetching via URL versus via remote?).
>
> What should happen if there are multiple push URLs configured?

This is me merely try to be extra nice without succeeding.

Perhaps it was an ill-thought-out part of the patch.  The reasoning was
that when you know that your 'origin' is at $URL, it might be irritating
if "git push $URL" did not do what "git push origin" did, but we can
always say 'origin' that is a remoteo nickname is different from $URL; a
remote nickname does not have to be _only_ substitute of the URL, but it
can do more for you.  That would give you more incentive to define remotes
that you interact with often, while keeping the bare-metal flexibility
when interacting with other remotes in a one-shot fashion.

I personally would be perfectly fine if

	$ git push $URL

that does not say what to push out how, regardless of push.default
settings, errors out.

The same can be said when a remote has more than one URL to be pushed to.

Personally I do not care too much about it, but this is one more reason
not to support "upstream" over "current" as the default setting.

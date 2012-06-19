From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Editing the root commit
Date: Tue, 19 Jun 2012 03:09:34 -0700
Message-ID: <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
References: <20120619091657.GA28005@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 12:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgvNW-0005Y1-HP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 12:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab2FSKJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 06:09:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab2FSKJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 06:09:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9037646;
	Tue, 19 Jun 2012 06:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sbefcR0NHgVFRTulTJNLfKQd1eQ=; b=WMmmtg
	lq1weZ+dJAnXabWg8llxLSjZmJjYIifJGrvrWvOUpiWhys/uFB29AqZIc7+RAHUr
	EFsInwJS4QZYCMXMYUetIsZ0x358UbYltJLOUPcP0nfR311uNXeHXrwglH2pxR7A
	Vtq/s0x39q2BnbglXx8ZGVyUUh85I3gaupJuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S/l8ISD9zq3yMLxMf19NzwCEcDrQ4bmw
	R8TOBJ+g84trSsYjG+0lz15tpxoSBuZHHJCf8Br1ERa1ntAU+rG/fa2ne6+2OPbb
	TMPpvGYe2c5ZUhzjros7bLYNqQ5iFvcS0nTAlMb5BAEpLRl44JrH9ePK4xFpirI9
	P3QeyGz/CUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F667645;
	Tue, 19 Jun 2012 06:09:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 498527644; Tue, 19 Jun 2012
 06:09:36 -0400 (EDT)
In-Reply-To: <20120619091657.GA28005@arachsys.com> (Chris Webb's message of
 "Tue, 19 Jun 2012 10:16:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFA61580-B9F6-11E1-BC60-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200192>

Chris Webb <chris@arachsys.com> writes:

> The first is whether there's a clever symbolic way to refer to the root of
> the current branch, rather than tailing git log output? gitrevisions(7)
> doesn't obviously suggest one.

There is not, for a few good reasons.

The very first commit is no more special than any other commit in
the history.  Some projects may start with "the first working
version", in which case there may be some value to be able to refer
to it, while some other projects may start with "the initial
snapshot" whose specialness comes _only_ from it being the first
one.

"The first working version" specialness may deserve to be tagged,
and in that case you would already have a name to refer to it.  If
on the other hand the first one isn't even worth to be tagged, it
does not deserve to waste a short-hand to refer to it at the
machinery level.  So there is nothing listed in the gitrevisions(7)
for it.

Also there is a more important question: Which root commit?  There
does not necessarily have to be a single "the root" commit in the
history.

>   git checkout --orphan rewritten
>   git rm -rf
>   git rebase --interactive --root --onto rewritten master

The argument to "--onto" must be a commit, but "checkout --orphan"
is not a way to create a commit; it is a way to bring you to a state
without any commit.

I personally think "git rebase -i --root" should be made to just
work without requiring "--onto" and let you "edit" even the first
one in the history. It is understandable that nobody bothered, as
people are a lot less often rewriting near the very beginning of the
history than otherwise.

Even though I wouldn't bother doing this myself, I wouldn't mind
reviewing a patch series ;-)

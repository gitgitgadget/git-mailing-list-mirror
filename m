From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #01; Thu, 1)
Date: Mon, 05 Aug 2013 08:18:31 -0700
Message-ID: <7vsiyonp2w.fsf@alter.siamese.dyndns.org>
References: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org>
	<87a9kz3uy4.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6MYX-0005Gi-7l
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab3HEPSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:18:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab3HEPSk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:18:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5F7367C9;
	Mon,  5 Aug 2013 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Co7hLhD7lQtMVaAcZNC6ydv1BcY=; b=Q+ntYL
	d5TGlosOV5xrJMc9j0+oZj1zQKlKlB/4R8cixuE7iy2fNLBIFyQ9EzwE9OOeeEAM
	M7PozOZchdO/aeJyOqt/lyKJXoMYc2WBGJXtd53/osB2qlhGhM5h3BCk3rJTokWR
	/n8CxBIiY3pW+buNoUNafy7JDzsLhN1anxCYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzh92pUmQrlolGGisHEOWq0MTRZRSqPh
	KIi3v1pSleKcE2KhIEV3nle4U8IFzG09DEeuU+2KJDZJqM90JuS7nvpVuMo6f4wJ
	BjeJuBR2BIoKBK6y3eCiqWksb7SEF+G7sE7d2IUawNqt2XdjmGM0EnbeI0B7Vkab
	edQrD56O23Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E4AA367C8;
	Mon,  5 Aug 2013 15:18:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A05A367C7;
	Mon,  5 Aug 2013 15:18:33 +0000 (UTC)
In-Reply-To: <87a9kz3uy4.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Sat, 3 Aug 2013 12:55:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B00EDB6-FDE2-11E2-84C8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231652>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tr/log-full-diff-keep-true-parents (2013-08-01) 1 commit
>>  - log: use true parents for diff even when rewriting
>>
>>  Output from "git log --full-diff -- <pathspec>" looked strange,
>>  because comparison was done with the previous ancestor that touched
>>  the specified <pathspec>, causing the patches for paths outside the
>>  pathspec to show more than the single commit has changed.
>>
>>  I am not sure if that is necessarily a problem, though.  Output
>>  from "git log --full-diff -2 -- <pathspec>" without this change
>>  will be applicable to some codebase, but after this change that
>>  will no longer be true (you will get only tiny parts of the change
>>  that were made by the two commits in question, while missing all
>>  the other changes).
>
> Hmm.  Uwe's original complaint was that --stat -- as in "what other
> things are touched when we modify foo" -- is nonsensical.
>
> In addition, applying what you describe above would be a very strange
> form of rebase: one that squashes everything into the commits that
> affect the given files.  When would it ever make sense to do such
> squashing?  After all, you'd lose all the commit splits&messages in
> between.

I am not so worried about actually applying that kind of patch, but
more about reviewing what happened in each of the single logical
step shown.  If you made two changes in two far-apart commits to
files you are interested in and want to look at the changes made to
other files to make each of them a complete solution, depending on
how the change was split across files, you would get useful to
useless result with your patch.  In one extreme, if your commits are
too fine-grained and you committed one path at a time, then
"full-diff" will not show anything useful, as the commits that hit
the pathspec do not have changes to any other paths.  In another
extreme, you may have preparatory changes to other paths in commits
that immediately precede the commit that hits the pathspec and then
finally conclude the topic by introducing a caller of the prepared
codepath in other files to the file you are interested in, and your
patch will show only the endgame change without showing the
preparatory steps, which may or may not be useful, depending on what
you are looking for.

So while I do understand why sometimes you wish to see full diff 
"git log --full-diff -- <pathspec>" to match output from "git show"
without pathspec, I am not sure doing it unconditionally and by
default like your patch does is the best way to go.

In the meantime:

    git rev-list --header --parents HEAD -- <pathspec> |
    git -p diff-tree -p --stdin

would be one way to do so.

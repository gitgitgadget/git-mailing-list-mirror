From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries
 user-friendly.
Date: Wed, 06 Jan 2010 09:13:07 -0800
Message-ID: <7veim3yx5o.fsf@alter.siamese.dyndns.org>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZRi-0003ZQ-0g
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab0AFRNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262Ab0AFRNR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:13:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259Ab0AFRNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:13:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30EC78EA34;
	Wed,  6 Jan 2010 12:13:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RTeWH895icDjywyUq/nZAbT3eM8=; b=ohtlvAxMo+jIpC7zE6SH8Bp
	mxNP6wk7qjDwwAXzCYqmnaipQBHG5597vNs3nLPGgZZzI5oCeALOGzzX2BXATl0a
	1GQ9VmJV7cpg1xkI/51SAke85T5cys8QZbWFr03lxiyOm5Cqs6hWWDybYrhjIaw4
	9O+abLTVGS8bMScWYZks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ajCYQMpk9NXOsHannCq8OldQtoNgClep3iw0Q27sOKYAi5v8J
	Qbglov8foy9BU56o0LUH8+tjga9I5o8wUtvA/GsP+fnM/bFBIWJM4pRbzem9mSp9
	nblDfczmhaj1Hqi5nede1uiWq40mYF2Xmd43N68ZioRmCIRXehQwunPMBk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 065CD8EA2F;
	Wed,  6 Jan 2010 12:13:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B8CA8EA29; Wed,  6 Jan
 2010 12:13:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4DCA5C4-FAE6-11DE-B5EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136275>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The error message used to look like this:
>
> $ git commit
> foo.txt: needs merge
> foo.txt: unmerged (c34a92682e0394bc0d6f4d4a67a8e2d32395c169)
> foo.txt: unmerged (3afcd75de8de0bb5076942fcb17446be50451030)
> foo.txt: unmerged (c9785d77b76dfe4fb038bf927ee518f6ae45ede4)
> error: Error building trees
>
> The "need merge" line is given by refresh_cache. We add the IN_PORCELAIN
> option to make the output more consistant with the other porcelain
> commands, and catch the error in return, to stop with a clean error
> message. The next lines were displayed by a call to cache_tree_update(),
> which is not reached anymore if we noticed the conflict.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> As usual, I try to have error messages point to the solution, not just
> the origin of the problem.

Seems to be a sensible approach to me.  

> Two questions:
>
> * Did anyone actually use the 3 "file: unmerged (sha1)" lines?

I don't think anybody does these days, and even if the question were about
the historical practice, I doubt anybody used "git merge-file" using these
blob object names to come up with a resolution.  Besides, if they really
want to, they can ask "ls-files -u" for that information themselves. 

> * Do you like my new message?

That would have been much easier to answer if you wrote "Here is an error
message produced with this patch" in the proposed commit log message.  I
haven't applied nor read your patch carefully, but I imagine you would say
something like this?

  With this patch, the error looks like this:

  $ git commit
  U foo.txt
  fatal: Commit is not possible because you have unmerged files.
  Please, resolve the conflicts listed above, and then mark them
  as resolved with 'git add <filename>', or use 'git commit -a'

Do I like it?  Hmmm.

 - "Please, ", especially with the comma, looks superfluous;

 - Some people consider "please resolve the conflicts" to mean the whole
   process of "fix them up in the work tree, and mark them resolved in the
   index", and others consider it to mean only the first step to "fix them
   up in the work tree".  I happen to be in the former camp, and to me
   ",and then mark them as..., add <filename>'," look superfluous because
   of that.

   I however think it is more helpful to new people who benefit from this
   advice message if we spell out these two steps.  Unfortunately, for
   that purpose, the description of the latter "mark them resolved in the
   index" step you have looks inadequate; e.g. sometimes it needs to be
   done with "git rm <filename>".

The need to give this advice on how to resolve conflicts is shared among
commands like 'git merge', 'git cherry-pick', and 'git status', to name a
few.  I think we should consolidate them all.

 - Decide if we go one-step (i.e. just say "resolve conflicts" and nothing
   else) or two-step (i.e. say "Fix them up in the work tree" and "mark
   them resolved in the index") approach; I am leaning toward the latter.

 - Decide the exact language used.  I think "Fix them up in the work tree"
   is passably okay, but "Mark them resolved in the index" needs to be
   made more concrete, and "git add <filename>" is not quite it, I am
   afraid.

 - Omit issuing the advisory message when advice.resolveConflict is set to
   false.

 - Perhaps have a common helper function to do this from the commands that
   need to give the advice.

Thanks.

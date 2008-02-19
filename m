From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] doc: documentation update for the branch track
 changes
Date: Tue, 19 Feb 2008 13:34:06 -0800
Message-ID: <7vfxvoiqb5.fsf@gitster.siamese.dyndns.org>
References: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
 <1203438278-73786-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa7G-0005Lc-49
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYBSVeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbYBSVeb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:34:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYBSVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:34:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 841187CCE;
	Tue, 19 Feb 2008 16:34:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 55D797CCC; Tue, 19 Feb 2008 16:34:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74457>

Jay Soffian <jaysoffian@gmail.com> writes:

> Documents the branch.autosetupmerge=always setting and usage of --track
> when branching from a local branch.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I was trying to change too much at once. This is the bare minimum to
> document the functionality changes.

This is very much appreciated.  Bite-sized changes make
reviewing much more pleasant.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 7e8874a..c5426a5 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -105,20 +104,19 @@ OPTIONS
>  	Display the full sha1s in output listing rather than abbreviating them.
>  
>  --track::
> -	Set up configuration so that git-pull will automatically
> -	retrieve data from the remote branch.  Use this if you always
> -	pull from the same remote branch into the new branch, or if you
> -	don't want to use "git pull <repository> <refspec>" explicitly.
> -	This behavior is the default.  Set the
> -	branch.autosetupmerge configuration variable to false if you
> -	want git-checkout and git-branch to always behave as if
> -	'--no-track' were given.
> +	When creating a new branch, set up configuration so that git-pull
> +	will automatically retrieve data from the start point, which must be
> +	a branch. Use this if you always pull from the same upstream branch
> +	into the new branch, or if you don't want to use "git pull
> +	<repository> <refspec>" explicitly. ...

Micronit; I think this ", or" should be ", and".

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index b4cfa04..7c7cfb1 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -48,21 +48,19 @@ OPTIONS
>  	may restrict the characters allowed in a branch name.
>  
>  --track::
> ...
>  --no-track::
> ...

Micronit; we would want to create track-options.txt and then
include::track-options.txt[] from here and in git-branch.txt
(that can be done later).

Otherwise, the patch looks fine, and I'll queue this as-is,
together with your [1/2] (with the "oops, commit message is
stale" amended in).  We can incrementally improve on these
in-tree from here on.

I am very tempted to squish the "s/,or /, and/" change in while
applying [2/2], though.

By the way, please do not get discouraged to send-in the doc
clean-ups.  I "gave up (for now)" last night because it was
getting late, I had other patches to review and accept/respond,
and I felt I did not have time to comment on a patch that mixes
clean-ups and feature enhancements at that point.

It is a good idea to organize a series so that clean-ups to
existing stuff that you are going to touch come first, and then
your own enhancements come on top, for a few reasons:

 (1) It is good for reviewers, because each can be looked at
     individually.

     * A clean-up is not supposed to change the behaviour and/or
       semantics unless it is a bugfix.  An error in rewriting
       becomes easier to spot if it is done standalone.
       Otherwise the reviewers need to wonder "why is it this
       way now?  Is it a thinko, or is it because it interacts
       with the new feature?"

     * An enhancement on top of the cleaned-up base will be
       smaller and easier to understand what gets changed.

 (2) It is good for the maintainer, for the same reason as
     above, and in addition, even when the list does not yet
     agree with the proposed enhancements, the clean-ups to
     allow any other future work (not limited to the
     contributor's) may be received favorably already.  The
     clean-up can be applied early while potentially
     controversial enhancements are still being discussed and
     polished.  This reduces the total amount of changes in
     flight --- smaller number of things to keep track of.
     
 (3) It is good for contributors, because the new work (which is
     what the contributors are more interested in) can be done
     on solidified base, and the patch that may need to go
     through multiple rounds of polishing would become smaller,
     if clean-ups are accepted independently in earlier rounds.

The same principle applies to both code and documentation.

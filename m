From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve description of git filter-branch.
Date: Thu, 20 Mar 2008 12:31:42 -0700
Message-ID: <7v8x0dw5sx.fsf@gitster.siamese.dyndns.org>
References: <20080315103900.GC14769@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcQVE-0003bm-Im
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 20:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbYCTTbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYCTTbw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 15:31:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYCTTbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 15:31:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C8D251F3;
	Thu, 20 Mar 2008 15:31:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2261E51F2; Thu, 20 Mar 2008 15:31:44 -0400 (EDT)
In-Reply-To: <20080315103900.GC14769@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Sat, 15 Mar 2008 11:39:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77682>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 543a1cf..3f7df04 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -20,12 +20,12 @@ DESCRIPTION
>  Lets you rewrite git revision history by rewriting the branches mentioned
>  in the <rev-list options>, applying custom filters on each revision.
>  Those filters can modify each tree (e.g. removing a file or running
> -a perl rewrite on all files) or information about each commit.
> +a perl script on all files) or information about each commit.
>  Otherwise, all information (including original commit times or merge
>  information) will be preserved.

We could go either way, methinks.  IOW, your update is not worse, but not
a huge improvement either.

>  The command will only rewrite the _positive_ refs mentioned in the
> -command line (i.e. if you pass 'a..b', only 'b' will be rewritten).
> +command line (i.e. if you pass 'a..b', 'a' will not be rewritten).

This one talks about which refs (i.e. pointers to commit DAG) are
rewritten, not about which commits are rewritten.  Because there are only
two things, 'a' and 'b', are involved (remember, the statement does not
talk anything about the commits in between), "only 'b' will" and "'a' will
not" are the same thing.

Saying "only 'b'" would actually make it more consistent with the body of
the description: "We only rewrite _positive_ ones" (i.e. it does not say
"We do not rewrite negative ones").

By the way, that "i.e." should probably be "e.g.".

> @@ -42,7 +42,7 @@ Always verify that the rewritten version is correct: The original refs,
>  if different from the rewritten ones, will be stored in the namespace
>  'refs/original/'.
>  
> -Note that since this operation is extensively I/O expensive, it might
> +Note that since this operation is extremely I/O expensive, it might
>  be a good idea to redirect the temporary directory off-disk with the
>  '-d' option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.

Can we say "very"?  extremely/extensively expensive is using ex'es
excessively to express what can be said in much easier way, I think.

> @@ -51,14 +51,15 @@ Filters
>  ~~~~~~~
>  
>  The filters are applied in the order as listed below.  The <command>
> -argument is always evaluated in shell using the 'eval' command (with the
> -notable exception of the commit filter, for technical reasons).
> +argument is always evaluated in the shell context using the 'eval' command
> +(with the notable exception of the commit filter, for technical reasons).

Ok.

>  Prior to that, the $GIT_COMMIT environment variable will be set to contain
>  the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
>  GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
> -and GIT_COMMITTER_DATE are set according to the current commit. If any
> -evaluation of <command> returns a non-zero exit status, the whole operation
> -will be aborted.
> +and GIT_COMMITTER_DATE are set according to the current commit.  The values
> +of these variables after the filters have run, are used for the new commit.
> +If any evaluation of <command> returns a non-zero exit status, the whole
> +operation will be aborted.

Probably a good clarification, but I am currently too busy to check if the
additional sentence is correct.

> @@ -71,9 +72,9 @@ OPTIONS
>  -------
>  
>  --env-filter <command>::
> -	This is the filter for modifying the environment in which
> -	the commit will be performed.  Specifically, you might want
> -	to rewrite the author/committer name/email/time environment
> +	This filter may be used if you only need to modify the environment
> +	in which the commit will be performed.  Specifically, you might
> +	want to rewrite the author/committer name/email/time environment

Ok.  Without needless line rewrapping this would have been much less time
consuming to review, though.

> @@ -149,7 +150,7 @@ definition impossible to preserve signatures at any rate.)
>  -d <directory>::
>  	Use this option to set the path to the temporary directory used for
>  	rewriting.  When applying a tree filter, the command needs to
> -	temporary checkout the tree to some directory, which may consume
> +	temporarily checkout the tree to some directory, which may consume

Ok, but isn't the verb to "check out" two words?

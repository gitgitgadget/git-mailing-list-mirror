From: =?ISO-8859-1?Q?Conrad=A0Irwin?= <conrad.irwin@gmail.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Wed, 10 Oct 2012 22:51:28 -0700
Message-ID: <CAOTq_ptaXMUzSi-PomMa9K9-Fnus0pnsO+vq92ZnxfeRQZPAxw@mail.gmail.com>
References: <20121005225758.GA1202@sigill.intra.peff.net> <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net> <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net> <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net> <7vr4paovjq.fsf@alter.siamese.dyndns.org>
 <20121007214958.GC1743@sigill.intra.peff.net> <7vehl9q5uk.fsf@alter.siamese.dyndns.org>
 <20121007222502.GA3263@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 07:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMBmS-0006xE-0I
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 07:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab2JKF5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 01:57:49 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42459 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212Ab2JKF5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 01:57:45 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so1734350vcb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H4hknWa8CRcq8HvzNqw9D7lsUei4f5p1TcdLjK8HDAs=;
        b=Kb0ir8bZcP1EwPWw+y22miN9/oQsIBr+YHvXHwT6Ccd8hOGwVVWEceoG7tX/IL0yF8
         Ioo5jqIXUMjQyt4GbSvieGzjBf9kk8rRoFCgqVyjSs1zOPMi5phJ3LWUzGnhCqzinnYW
         eDDCqblfACi9dt9P3m0KpuINFqdreoZRlzY0z/nw6VbugoNgjL7YKAzHGoU3aV09+9nk
         I+mpm3Fop4CMKxbtXg8F9mBRRav0gq7kSc2uXsYMNsKHJD9mWRKNCEtJhJpILCZGMWsC
         8pTAEZS5Mb+azi+2Drv399X0xWw34CDasPQ2V0/rCqY0xKc6wXLha30RMiCinQVpmO5A
         TLvQ==
Received: by 10.220.154.139 with SMTP id o11mr15238256vcw.69.1349935064743;
 Wed, 10 Oct 2012 22:57:44 -0700 (PDT)
Received: by 10.220.220.196 with HTTP; Wed, 10 Oct 2012 22:51:28 -0700 (PDT)
In-Reply-To: <20121007222502.GA3263@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207465>

On Sat, Oct 6, 2012 at 12:07 PM, Jeff King <peff@peff.net> wrote:
> Are you sure?  Does "--only" mean "only the changes I am about to mark"
> or "only the paths I am about to tell you about"? Without partial hunk
> selection (i.e., "commit -p"), they were the same; a path you mention is
> a path which will be either be staged in its entirety or not. Specifying
> (or omitting) the path was sufficient to say what you wanted. But with
> "-p", I can see three useful possibilities:
>
>   1. Do not include F in the commit, even if changes are staged in the
>      index (i.e., take HEAD exactly).
>
>   2. Include F in the commit, and stage partial changes on top of what is
>      already staged.
>
>   3. Include F in the commit, and stage partial changes on top of HEAD.
>
> In cases 2 and 3, we are still taking "only the path" F. But we are
> not taking "only what is about to be staged" in 2. And I can see both
> being useful (2 because it is more convenient not to re-approve staged
> changes, and 3 because there is no way to unstage changes via "-p").

I think I didn't consider 2. as a viable alternative because
re-approving hunks is not a problem (there are typically very few
hunks per file, and you'll recognise them if you've already staged
them) but not being able to unstage is a big problem (as it restricts
what commits I can make with --patch without changing my index).

>
> But of course we're not specifying paths. So to me it is "include the
> changes I am about to stage via -p", as opposed to "--only use the
> changes I am about to stage via -p". I think the current behavior is
> morally equivalent to how --include works with paths (which includes the
> paths along with the current index, rather than only committing the
> paths).
>
> Or am I missing something about the distinction you're making? It seems
> to me that the end behavior of thinking about it either way would be the
> same.

The way I was thinking about it was to treat the index and the command
line as two orthogonal parts of the commit. --include and --only
control the inclusion/exclusion of the index; while the command line
arguments control which (currently unstaged) things are included. This
led me to the conclusion that "git commit --include" is equivalent to
"git commit", "git commit --include --all" is the same as "git commit
--all" which is why I tried to change the validation logic. (You are
correct that "--include --only" and "--interactive --all" still make
no sense).

Here's a re-roll of the patch with --only docs tweaked.

Conrad

----8<----

Clarify that --interactive/--patch add to the existing index to avoid
confusion like [1].

Make explicit that --only does not work with --interactive/--patch and
clean up wording around --only --amend.

[1] http://thread.gmane.org/gmane.comp.version-control.git/207108

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-commit.txt | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9594ac8..680d2bf 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -41,9 +41,9 @@ The content to be added can be specified in several ways:
    actual commit;

 5. by using the --interactive or --patch switches with the 'commit' command
-   to decide one by one which files or hunks should be part of the commit,
-   before finalizing the operation. See the ``Interactive Mode'' section of
-   linkgit:git-add[1] to learn how to operate these modes.
+   to add files or hunks to the current index before committing. See the
+   ``Interactive Mode'' section of linkgit:git-add[1] to learn how to
+   operate these modes.

 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
@@ -63,10 +63,14 @@ OPTIONS

 -p::
 --patch::
-	Use the interactive patch selection interface to chose
-	which changes to commit. See linkgit:git-add[1] for
+	Use the interactive patch selection interface to add hunks
+	to the index before committing. See linkgit:git-add[1] for
 	details.

+--interactive::
+	Use the ``Interactive mode'' of linkgit:git-add[1] to edit
+	the index before committing.
+
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
@@ -215,22 +219,17 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)

 -i::
 --include::
-	Before making a commit out of staged contents so far,
-	stage the contents of paths given on the command line
-	as well.  This is usually not what you want unless you
-	are concluding a conflicted merge.
+	In addition to the paths specified on the command line,
+	include the current contents of the index in the commit.

 -o::
 --only::
-	Make a commit only from the paths specified on the
-	command line, disregarding any contents that have been
-	staged so far. This is the default mode of operation of
-	'git commit' if any paths are given on the command line,
-	in which case this option can be omitted.
-	If this option is specified together with '--amend', then
-	no paths need to be specified, which can be used to amend
-	the last commit without committing changes that have
-	already been staged.
+	Only commit changes to the paths specified on the command line,
+	do not include the current contents of the index. This is
+	the default mode of operation when paths are specified.
+	If this option is specified with --amend it can be used
+	to reword the last commit without changing its contents.
+	This mode cannot be used with --patch or --interactive.

 -u[<mode>]::
 --untracked-files[=<mode>]::
-- 
1.7.12.289.g0ce9864

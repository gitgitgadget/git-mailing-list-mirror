From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Mon, 3 Dec 2007 11:03:39 +0700
Message-ID: <fcaeb9bf0712022003w4a3df0f0j21a5b23f3f073597@mail.gmail.com>
References: <20071128165837.GA5903@laptop>
	 <Pine.LNX.4.64.0711281703470.27959@racer.site>
	 <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	 <Pine.LNX.4.64.0711281717460.27959@racer.site>
	 <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
	 <Pine.LNX.4.64.0711281810410.27959@racer.site>
	 <7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
	 <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 05:04:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz2XL-0001HT-2n
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbXLCEDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXLCEDn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:03:43 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:3598 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbXLCEDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:03:42 -0500
Received: by mu-out-0910.google.com with SMTP id i10so514522mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 20:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N9M5mLBpJeV3JJfWkx07YIgY45Awfz9Szot/0EFsSgY=;
        b=OKi5UWUXZxBAhR/XhSmScTRAu7r5lhFfWHfQ+xA2Sd/1bZx3vGqjYKN7Yk6J/MEeQZpxw5rEfunqF6SLR5s15YL00ygyTYRequ0V6z8cHtwQ9hSamoaw0CrEh8iFdrxq6Uh1dOk1DBhZbUqpDVC7vtTO8b18kqh3sAHTyY6+Ozc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AdoT1WyRNGDW+EnuYtEQ+w3dHi3SjsiOCKdEUhU/QpbguYHJTeBah9ZJlo2ZFk4dZM7noS6obh2lSewTf1++BS8O4bevo1gA8W9LkM3tXuTF01c8ynDuHQkGnIWt8kWaO0ZdmqzdJ8piVtkESEI/mKzHdeGkyxndi8HNz5RuPz4=
Received: by 10.86.4.2 with SMTP id 2mr10167947fgd.1196654619232;
        Sun, 02 Dec 2007 20:03:39 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Sun, 2 Dec 2007 20:03:39 -0800 (PST)
In-Reply-To: <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66856>

On Dec 2, 2007 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On Dec 1, 2007 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Looks sensible, but can this be accompanied with a trivial test to
> >> demonstrate the existing breakage?
> >
> > How can I reliably check setup_git_directory_gently()? I can pick one
> > command that uses setup_git_directory_gently(). But commands change.
> > Once they turn to setup_git_directory(), the test will no longer be
> > valid.
>
> The commands' implementation may change but what I meant was to test the
> intent.
>
> What's the difference between commands that call "gently" kind and
> non-gently kind?  The former is "I do not _have_ to be in a git
> repository but if I am then I want to know about it and use some
> information from that repository", as opposed to "I need to be in a git
> repository and will find one otherwise I barf" which is the latter kind.
>
> The intent of the change, from reading your patch, is that currently the
> former kind of commands that take "an optional git repository" are happy
> if they find a directory that looks like a git repository and go ahead
> with their operation without checking the repository format version, and
> your patch addresses this issue by making sure that the git repository
> found via "gently" are also checked for the format version.
>
> Examples of commands that do not necessarily require a valid git
> repository are:
>
>  * apply: when being used as a "patch that is better than GNU", that is,
>    without --index, --cached, nor --check option.
>
>  * bundle: when verifying and listing the contained head of an existing
>    bundle file.
>
>  * config: without being in a git repository, you can still interact with
>    $HOME/.gitconfig and /etc/gitconfig [*1*].
>
>  * ls-remote: without being in a git repository, you can still list refs
>    from a remote repository.  If you are in a git repository, you can
>    use nicknames you have in your repositories' remote.$nickname.url
>    configuration.
>
> So what I would suggest would be:
>
>  * The directory your tests run in, t/trash, is a valid git repository.
>    Leave it as is.
>
>  * mkdir test inside t/trash, cd there, and run "git init" there to
>    initialize t/trash/test/.git (the shell function test_create_repo can
>    be used for this).
>
>  * corrupt this by updating the core.repositoryformatversion to a large
>    value, by doing something like:
>
>         V=$(git config core.repositoryformatversion)
>         (
>                 cd test
>                 N=$(( ${V:-0} + 99 ))
>                 git config core.repositoryformatversion $N
>         )
>
>  * make sure t/trash/test/.git/config file, and not t/trash/.git/config
>    file, got that change by doing something like:
>
>         GIT_CONFIG=.git/config git config core.repositoryformatversion
>         GIT_CONFIG=test/.git/config git config core.repositoryformatversion
>
>    The former would report the current version ($V above) while the
>    latter should error out.
>
> Up to this step is the "test setup".  The actual tests would be done in
> t/trash/test directory.
>
>  * Use a few commands that have the "we can run in git repository but we
>    do not have to" behaviour, in modes that _require_ git repository.
>    For example, "git apply --check" wants a valid repository to check
>    the patch against the index.  They should fail because the repository
>    format is too new for them to understand.
>
>  * Similarly, run a few commands in modes that do not require git
>    repository.  For example, "git apply --stat" of an existing patch
>    should be viewable no matter where you are (that is just a "better
>    diffstat" mode), so ideally it should not barf only because you
>    happen to be in a repository that is too new for you to understand.
>    I do not know offhand how your patch would handle this situation.
>
> Note that making sure the latter works is tricky to do right, for a few
> reasons.
>
>  (1) It is not absolutely clear what the right behaviour is.  It could
>      be argued that we should just barf saying we found a repository we
>      do not understand, refraining from doing any damange on it [*2*].
>
>  (2) If we choose not to barf on such a repository, it remains to be
>      decided what "gently" should do --- if it should still treat
>      t/trash/test (which has too new a version) as the found repository,
>      or ignore it and use t/trash (which we can understand) as the found
>      repository.  I think it should do the former.

The patch's behaviour is barf if the repository version is too new.
The list of files that use setup_git_directory_gently is not long. I
am going to have a look over the files before amending the patch again
to make it only barf if nongit_ok is NULL.
-- 
Duy

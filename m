From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn for vendor branches?
Date: Thu, 12 Jun 2008 16:48:49 -0400
Message-ID: <32541b130806121348u7a52841aicec1e31eaaec8014@mail.gmail.com>
References: <200806121459.12570.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tju-0002y7-Ro
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYFLUsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYFLUsw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:48:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:29563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbYFLUsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:48:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2601327fgg.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9t9qy19e6GiQpY1m8tyH4gNcW9g4kCTR4oSgOVo58UA=;
        b=joq5bNdQ01pT+E2srYI+IUIgyu7b5jyb1osWGHoahpHBviyJbEEeo77dy1W5myDkux
         M11FKZf3wGjB5kJSRmioUFLmGxmEjaMM0VJqRG1QBxOwhgT57Z/lOqOhLVgJbZ/or5ON
         w94dXfDzWAzXrY7zeajQtXre9tHttizbIuTXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N4X5w6oxH94pcyti8roQcg47VQYpGS2UWDqdFfOUFn0HxcX4msk7omXiarCmIF8fyS
         SNO2SDIWN/0hPcn5oI0Px26diczkRSsm4Q+yG9MutsDMGCVKDpiSxh0ibynG0kQaLj9D
         fYyL/d+ZVlrBTLy/vCejgbfwYWORg2u34b9W0=
Received: by 10.82.107.15 with SMTP id f15mr113682buc.30.1213303729348;
        Thu, 12 Jun 2008 13:48:49 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Thu, 12 Jun 2008 13:48:49 -0700 (PDT)
In-Reply-To: <200806121459.12570.greened@obbligato.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84794>

On 6/12/08, David A. Greene <greened@obbligato.org> wrote:
>  The problem really gets unsolvable with svn when you start looking at
>  merging from upstream *branches.*  In that case, what's in the branch/tag
>  is something that appears nowhere on the upstream trunk.  At some point
>  it was branched from trunk and stuff was cherry-picked into it from trunk as
>  bugs were fixed for release.  So one can't just do an svn_load_dirs from
>  trunk at the point of the branch/tag.  And one can't svn_load_dirs from a
>  release branch and then svn_load_dirs from trunk later because svn_load_dirs
>  by its very nature aggregates lots of individual revisions into one giant one.
>  There's no way to do the merge without a horrible number of conflicts, most
>  of which are spurious.

Although git-svn does have ways of supporting multiple repositories,
I'm not really sure git will help much here.  The confusion above
seems to be that fixes were cherry-picked from trunk into release
branches, and now you want to merge release branches together.
Neither git nor svn tracks cherry picks explicitly, and so they have
about the same problems and conflicts when attempting to merge in such
situations.

If I'm wrong about this, I'm sure other people on the list will enlighten me :)

>  We really do need to merge from a release branch into our local repository
>  and in the future do merges from later release branches or from trunk.

But the above is a bit easier.  It sounds from the above like most of
the cherry-picking difficulties are incurred by the *upstream*
maintainers, ie. not you.  Great!  That means someone is already
resolving those conflicts for you and producing pre-merged releases.

If I understand correctly, all you really want to do is have your
local repo contain "some upstream branch that you might want to switch
occasionally" + "my local changes".  This is quite elegant to do in
git with git-rebase (if your local repo switches to git), but it's not
even so hard to do in svn.

Basically, you just do an svn merge into your local branch of the
differences from (oldbranch@oldrevision) to (newbranch@newrevision).
In other words, let's say your current local version is:

    release_1 + local_patches

If you then apply the changes from release_1 to release_2, you then have:

   release_1 + local_patches + release_1..release_2
  = release_1 + release_1..release_2 + local_patches
  = release_2 + local_patches

This method works for any two svn versions release_1 and release_2.
You can bounce back and forth between the trunk and a release branch,
or downgrade from release_2 to release_1.  The only conflicts you
should get are the (unavoidable anyway) conflicts between your local
changes and the changes between the two remote branches.

You can either produce the diff between release_1 and release_2 using
"svn diff" on the remote repo and use plain "patch" to apply them to
the local copy, or else git_load_dirs the two revisions on your local
copy and "svn merge" (not "svnmerge") between the two.  The latter
makes it easier to resolve conflicts.

Have fun,

Avery

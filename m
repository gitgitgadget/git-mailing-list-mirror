From: Phil Pennock <phil-gitml@phil.spodhuis.org>
Subject: Re: .gitignore sub-dir exclusions not overriding '*'
Date: Wed, 19 Nov 2014 23:41:36 +0000
Message-ID: <20141119234136.GA53731@tower.spodhuis.org>
References: <20141119034010.GA18145@tower.spodhuis.org>
 <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrEsi-0006Ly-9t
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 00:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbaKSXlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 18:41:42 -0500
Received: from mx.spodhuis.org ([94.142.241.89]:44261 "EHLO mx.spodhuis.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551AbaKSXlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 18:41:42 -0500
Received: from authenticated user by smtp.spodhuis.org with esmtpa 
	id 1XrEsT-000EDs-Bk; Wed, 19 Nov 2014 23:41:37 +0000
Content-Disposition: inline
In-Reply-To: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
OpenPGP: url=https://www.security.spodhuis.org/PGP/keys/0x4D1E900E14C1CC04.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-19 at 16:48 +0700, Duy Nguyen wrote:
> On Wed, Nov 19, 2014 at 10:40 AM, Phil Pennock
> <phil-gitml@phil.spodhuis.org> wrote:
> > Expected to work as .gitignore in top-level of repo:
> >
> >     *
> >     !**/*.asc
> >     !.gitignore
> >
> 
> gitignore man page has this "It is not possible to re-include a file
> if a parent directory of that file is excluded". In this case,
> directory "foo" is ignored by "*". Although it makes sense for this
> particular case to re-include something in foo because we can clearly
> see there are rules to re-include. It's on my todo list, but I don't
> know when it will be implemented.

Thanks for this and the patches and discussion which follow.

I didn't cover it in my report, but one of the scenarios I tried was to
explicitly re-include directories, to make them candidates again, and
either use directory-matching patterns in the top-level .gitignore or to
use per-directory .gitignore to handle those directories.

Looking fresh today, I see that I failed to compare baseline behaviour
without a .gitignore when using `git status` as a baseline for
comparison.  So a .gitignore like this:

    *
    !*/
    !*.asc

appeared to not work; even within the `foo/` sub-directory, `git status`
shows no candidates for inclusion.  But this is true even without a
.gitignore.  *sigh*

In fact, it looks like the simple three lines above work, without any
.gitignore in sub-directories.

The behaviour which confused me between this simplified test-case and
the original was that `git status` shows files in the top-level
directory which are untracked, and in untracked files sub-directories
where some other file in that directory is already tracked, but if no
file in the sub-directory is already tracked, then `git status` does not
report the files for inclusion, even if the cwd is inside that
directory.

I tied myself in knots trying to avoid adding unencrypted files to the
repo.

Thanks,
-Phil

From: Carlos Pita <carlosjosepita@gmail.com>
Subject: Allow worktree in same path with different gitdir
Date: Sat, 23 Apr 2016 16:41:29 -0300
Message-ID: <CAELgYheYazk+O1a9DH2ZbR4FgcuOTwa+Y+h_gfRs8w+e58rWNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:41:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1au3RC-0008IC-CM
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbcDWTlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 15:41:50 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36169 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbcDWTlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 15:41:49 -0400
Received: by mail-ig0-f175.google.com with SMTP id f1so44457519igr.1
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=HRCit09T+qF9gxFJwuRV5tsEoYK1/JXSvlGGrerM2pE=;
        b=IwfXoOePHWqOU1QXZFlUTOCtA+CXM2yhmj4wjebncLJ03JQ9r7qZNJmNzCOpPZXI8U
         kCaz9ERok1N8wd5DTYocQRYw65FaieRaqsVPuJXqwju+gvnDnVYeXmA7faIVAcFPqWeF
         uuSFsCP38GlOiBhg/jZ8R2jRFJokZ9p/QnOXrYZ7UPStp/9ZamHShi38T9vl7x+4hZ7V
         dVeq8y6NFE/gBSNmlerMa3/wRaAzlrjmlBiAiFGT2M59LHOkeq74Fxzlxk/hOIFHsWGs
         3YTgd5RTm0K95csxU2M3n+YwU3vrrn/XKcZNFbfLMxx0j5H6omnRA7aG4uf/KcqOC9hr
         CHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HRCit09T+qF9gxFJwuRV5tsEoYK1/JXSvlGGrerM2pE=;
        b=hpjjzMUHgUzUZryn2xkpgjT6d6vM+zFpNKyf59/dvojQwVEB8wn0deCXZBa5MAuqeK
         5LehV4Q3ahNEgj6Ykzf29MJGkuWcPhzMH/0jHaT1PINaR+cQy7Yto4BgjX/fIRRMfxBi
         BKTO64PvTqhwJGS7zp+9qFBxD6S/s7ObRzREN5zX3QWfm80dpiS0eld8qlZcQOSp1Sjx
         kFAUgyIYGZBaQP2Z0U9ke74MPH4W0j5eAl8hCjsiHPCcSJjOm0+nRylRkU2Cz9IBkQPL
         dde3o0kTiNoBt6+EeySiom5EjG7Ykqasae0/+HqH8kdMIod3rueJjNWd0ElvzoUegTT9
         rypA==
X-Gm-Message-State: AOPr4FVbU3G99QroS3yGxB55B1aoqyR2z86/8Bq9hMVEmvpjPPzBycptVyRRZTCJQ0lKW3zTn404roKmm0unmg==
X-Received: by 10.50.17.67 with SMTP id m3mr4029576igd.95.1461440508618; Sat,
 23 Apr 2016 12:41:48 -0700 (PDT)
Received: by 10.36.43.145 with HTTP; Sat, 23 Apr 2016 12:41:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292307>

Hi all,

I usually keep my dotfiles, scripts, etc. in a git repo at ~, both as
a backup solution and as a way to sync config between my different
computers and remote servers in which I have to work. Some of these
computers require a small number of local configurations that I like
to keep in a repo too (mainly for backup purposes). These
modifications to the base repo may be made branches of the base
configuration but then keeping the common configurations in sync
between all branches becomes cumbersome and error prone, with a lot of
rebasing, cherry picking, stashing and whatnot. What I prefer is to
create an orphan branch for local files, create a worktree for this
branch, then move this worktree gitdir to something like ~/.gitlocal,
next to the main ~/.git, update .git/worktrees to avoid pruning and
define a handy alias like lgit='GIT_DIR=~/.gitlocal git'. This way I'm
able to keep some files below ~ in a specific branch and some others
in a shared master branch, all at the same time and in the same
directory. What I find a bit cumbersome about this workflow is the
inability to directly create the worktree at . specifying a gitdir
like .gitlocal. Is there any fundamental reason this is not allowed
for the worktree subcommand? If not, please consider this a feature
request.

Notice the same is valid for cloning the ~ repo, instead of just
creating a worktree from it. The clone subcommand will also reject a .
path and also doesn't provide a way to specify a different gitdir
(even --separate-git-dir requires a "fake" .git).

Cheers
--
Carlos

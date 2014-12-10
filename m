From: Jack Nagel <jacknagel@gmail.com>
Subject: local clone and submodules
Date: Wed, 10 Dec 2014 15:36:58 -0500
Message-ID: <CAMYxyaV3dvHFQJ1vfmZy7Hv=XHtSCSbi6s7FWdrUzdmyKWvntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 21:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyo0i-0002ta-N2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 21:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbaLJUhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 15:37:20 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:54245 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaLJUhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 15:37:19 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so3637438igi.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lWR3wbnqk+0G4HhOr1ObbyXOpwQziljMGcHNgIKcga0=;
        b=LJ9NtyPM6eVRy97f28rsFWICUG9ZpBs3itWi69IZvikinr36CCSpwJEWkCvJlwcnAX
         7Q5L6tdu/zZeWT08mr5staR9Rh83AdWXwLnUGYUz+D3cXcPB8Hf+8v/4AUJbxPSGUrJG
         hfddjuD1RooBVR6Ybw+TcSm75lxrsQkOqo8xjNgK/9C2X9lz2W9fUg71tvFziqX3oTvT
         4hgWN7+4qJX6m7VX7t20RaEqVTmTfRQwGL4rOGLRJxlVMleuo/txtGff082kCv66dgq2
         +sMprDGKLnkrNva7gwgT4VQUeMrYVrrgw6VWkrPYoP1/+6BAZmROWoFVDkGgRURe3tTi
         7IDA==
X-Received: by 10.43.52.197 with SMTP id vn5mr8361159icb.64.1418243838647;
 Wed, 10 Dec 2014 12:37:18 -0800 (PST)
Received: by 10.64.129.194 with HTTP; Wed, 10 Dec 2014 12:36:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261246>

Say I have a local repository with several submodules that point at
remote repositories. All submodules are up-to-date.

I want to clone everything to another location on disk, *without
hitting the network to fetch the submodules*. Obviously a simple "git
clone" will work for the superproject, but submodules will be
re-fetched from the remote if I pass --recurse-submodules.

Is there any way to do this offline? Reading through the
documentation, it doesn't seem easy, but perhaps it is possible to do
by recursing through the submodules manually.

In Homebrew, we allow building packages directly from a project's
source repository. Currently, the repositories are downloaded into a
local cache, then checked out into a build directory using "git
checkout-index" and "git submodule foreach". However, some projects
require access to the git repository to do things like compute a
version string.

We experimented with using GIT_DIR, but sometimes we are operating on
multiple git repositories, and saving and restoring its value in the
right places is tedious and error prone.

Our current solution is to symlink the .git directory into the build
directory, but I'd like to replace this manual checkout + symlink with
something cleaner. I could just copy the entire repository from the
cache into the build directory, but we deal with some fairly large
repositories so I would prefer to be able to use "git clone" or "git
clone --shared".

Thanks for any suggestions,
Jack

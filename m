From: Michael Darling <darlingm@gmail.com>
Subject: BUG: For first push to a bare repo, using "--tags" prevents creation
 of master branch
Date: Thu, 28 May 2015 20:10:42 -0400
Message-ID: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 02:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy7su-00076h-RC
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 02:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbbE2AKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 20:10:45 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33323 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbbE2AKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 20:10:43 -0400
Received: by wgez8 with SMTP id z8so49427910wge.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MyTkiFxBIFeRe6iypPli6weF+onZ1dxafHqFZ5g7cGE=;
        b=FE2brR7ZuxWlKHNl4t18MVejhvD61y3joGuTKwLFUYV5Gcxje/hU/IHXxsKczgD6KK
         o5EuajXm0CwXvgkvO95NlPkgj6Ro8uQmPP9GJh47nMTHLmf+rGKbIyYTpnmoXJZfiqmK
         c8tPmMwdlwMtyVGXPf8+0mfrhTKAeS6wdU7KbM0TDG9wQzrv7Xx2IEYJYUnoGff3KRWN
         5C4SymOfyqyyOLJ/6jq4vSuIyszLirKNiIBRxXNdhoOwS2UYze4EbkSMZU7n/vDXdoEw
         iNX6/eprAX21RZFYdXqIFppi28VYJ1xc87rwuBAIS1tKVfr2wix4dklFON7cLEke9O/U
         AKDg==
X-Received: by 10.194.3.35 with SMTP id 3mr9660044wjz.109.1432858242598; Thu,
 28 May 2015 17:10:42 -0700 (PDT)
Received: by 10.28.167.213 with HTTP; Thu, 28 May 2015 17:10:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270206>

Using git version 2.4.1.171.ga34f239, and gitolite v3.6.3 (b05c94ff).
I apologize I don't know enough about the client vs server functions,
during a git push, to know whether this is a git or gitolite issue.

After cloning the public glibc repo, and creating a new bare repo on
my local gitserver by adding it to gitolite.conf and pushing it:

$ git push --set-upstream origin
Counting objects: 339319, done.
Delta compression using up to 10 threads.
Compressing objects: 100% (55496/55496), done.
Writing objects: 100% (339319/339319), 99.28 MiB | 22.67 MiB/s, done.
Total 339319 (delta 283044), reused 331722 (delta 276505)
To gitserver:glibctest
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.

**After resetting to before the last push**: (removing and re-cloning
my clone of the public glibc repo, and resetting the repo on my local
gitserver back to a new bare repo (removing the repo from
gitolite.conf, pushing the conf, removing the repo directory in the
gitolite user, re-adding the repo to gitolite.conf, and pushing the
conf):

$ git push --tags --set-upstream origin
Counting objects: 382283, done.
Delta compression using up to 10 threads.
Compressing objects: 100% (62075/62075), done.
Writing objects: 100% (382283/382283), 101.16 MiB | 19.64 MiB/s, done.
Total 382283 (delta 316774), reused 376933 (delta 312407)
To gitserver:glibctest
 * [new tag]         cvs/ChangeLog -> cvs/ChangeLog
 * [new tag]         ... <a bunch more> ...
 * [new tag]         glibc-2.9 -> glibc-2.9

Note this time there is NO:

 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.

Hence, my local gitserver has no master branch.  If cloning in another
location, I get a "warning: remote HEAD refers to nonexistent ref,
unable to checkout." that I don't get if I do a "git push
--set-upstream origin && git push --tags" instead.

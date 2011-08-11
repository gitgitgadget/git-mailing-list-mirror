From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: cherry-pick cannot merge binary files? (also strategy does not work?)
Date: Thu, 11 Aug 2011 14:58:34 +0200
Message-ID: <CAA01CsoMbSQr1u1JarH==5BTOxuDALu8wAvzizW232JAWgyr8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 14:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrUqO-0002VP-Gp
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab1HKM6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 08:58:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44150 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab1HKM6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 08:58:35 -0400
Received: by gxk21 with SMTP id 21so1275232gxk.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=QYxGznp3zRngOHjVCLESpo2H+GJyGDY97I7SGp6GDPQ=;
        b=Mx/1sf092tjrI0LmH4zs9k6zfCSRIuvS04CZVywqXwU56Xy6i5AXrO4Qazmf5q7YeQ
         sMPDacKAuhN3K+vPoVvbJjzdUV9rQJXNb+vPCmwmpu4lg18nJerC5DFeLcTA6lvcF8j3
         0MsOvCrAyClfqdP+SkoE+35HBCjCcuKfG4CjE=
Received: by 10.151.60.17 with SMTP id n17mr557401ybk.338.1313067514459; Thu,
 11 Aug 2011 05:58:34 -0700 (PDT)
Received: by 10.150.230.15 with HTTP; Thu, 11 Aug 2011 05:58:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179110>

Hi,

It seems cherry-pick can't merge binary files. I suppose this can be
considered a bug or a feature. But I expected I could use "theirs"
merge strategy to overcome (auto-resolve) this - but it seems it's
either not working, or I'm doing something wrong. Any hints?


[t]$ git init
Initialized empty Git repository in /tmp/t/.git/
[t (master)]$ echo a > a.txt && gzip a.txt && git add a.txt.gz && git
commit -m base
[master (root-commit) 64587708] base
 1 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a.txt.gz
[t (master)]$ mv a.txt.gz a.txt && gzip a.txt && git add a.txt.gz &&
git commit -m 1
[master 7b73fea9] 1
 1 files changed, 0 insertions(+), 0 deletions(-)
[t (master)]$ git checkout -b two HEAD^
Switched to a new branch 'two'
[t (two)]$ mv a.txt.gz a.txt && echo b > a.txt && gzip a.txt && git
add a.txt.gz && git commit -m 2
[two 57723852] 2
 1 files changed, 0 insertions(+), 0 deletions(-)
[t (two)]$ git cherry-pick master
warning: Cannot merge binary files: a.txt.gz (HEAD vs. 7b73fea9... 1)

error: could not apply 7b73fea9... 1
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
[t (two|CHERRY-PICKING)]$ git reset
[t (two)]$ git cherry-pick --strategy=recursive --strategy-option=theirs master
warning: Cannot merge binary files: a.txt.gz (HEAD vs. 7b73fea9... 1)

error: could not apply 7b73fea9... 1
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'


Thanks,

-- 
Piotr Krukowiecki

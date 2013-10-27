From: Alexander Gladysh <agladysh@gmail.com>
Subject: git stash does not work when directory is replaced by a symlink to itself
Date: Sun, 27 Oct 2013 14:08:26 +0400
Message-ID: <CABZR_7BjHu7epdYhZeeLXPV=xk01MU_aM4dFuWynQHLOu1Q3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 11:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaNHJ-0002z2-S5
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 11:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab3J0KIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 06:08:48 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33888 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J0KIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 06:08:47 -0400
Received: by mail-lb0-f171.google.com with SMTP id x18so2013527lbi.30
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=p1qXjWEYXosRItXZRcugi+3dLCG3ZxcRqX7IWIUVqZM=;
        b=cx2JVHcBqEupSGI1Kvhp3Ou40suPh2B0jIH9JYFZp90TVk7BcxDJULDHUry5LbaAkW
         /uv1f7b34hFbh6QMWHUWA0OF9iMorY+OGsx3y7njXjnEEGKHQScw8+bpUVZWaJSVMHi1
         a0ZUD6yvk+hZ900HPwhEJ8eNIdXx96EYZSW359NnWssQEMN/pYY+1kzD3Z4D05AMteqa
         6cy1q/lzka3c7aWQhP0IrcgxtH90MZusC0JcWDNnaSq6zyPuOrpjTmEJLrh/YNjt269H
         ZARV7eMuu+OalQONoH4p96qXzpAzr+GycDA83gTNK5V8PG2J9PNnuz9qLj2cUO15Hc0p
         cYIA==
X-Received: by 10.112.210.197 with SMTP id mw5mr175077lbc.42.1382868526140;
 Sun, 27 Oct 2013 03:08:46 -0700 (PDT)
Received: by 10.112.17.163 with HTTP; Sun, 27 Oct 2013 03:08:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236798>

Hi, list!

See below.

Best,
Alexander.

agladysh@work-1:~/tmp/git$ git --version
git version 1.8.4.1

agladysh@work-1:~/tmp/git$ cat ./test.sh
#!/bin/bash

set -e

mkdir alpha
cd alpha
git init

mkdir beta
echo "gamma" > beta/gamma
git add beta/gamma
git commit -m "initial commit"

mv beta delta
ln -s delta beta
git stash

agladysh@work-1:~/tmp/git$ ./test.sh
Initialized empty Git repository in /home/agladysh/tmp/git/alpha/.git/
[master (root-commit) 9c6138f] initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 beta/gamma
error: 'beta/gamma' is beyond a symbolic link
fatal: Unable to process path beta/gamma
Cannot save the current worktree state

agladysh@work-1:~/tmp/git$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 12.10
Release: 12.10
Codename: quantal
agladysh@work-1:~/tmp/git$ uname -a
Linux work-1 3.5.0-34-generic #55-Ubuntu SMP Thu Jun 6 20:18:19 UTC
2013 x86_64 x86_64 x86_64 GNU/Linux

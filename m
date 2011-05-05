From: Daniele Segato <daniele.bilug@gmail.com>
Subject: ignored file can be deleted silently
Date: Thu, 5 May 2011 10:40:08 +0200
Message-ID: <BANLkTinEupQKfBofhH-qKD6gLGWyWRbGvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 10:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHu6a-0004YK-RC
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 10:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1EEIkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 04:40:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39844 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab1EEIkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 04:40:09 -0400
Received: by fxm17 with SMTP id 17so1369301fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4B2ySgKk1YffavNhA4sO0s+h0Tr4lV4dxPxDNh/LrEI=;
        b=FewzSHJPW2OCSW8QReQO7qpY02pCkE3m/32DOoegtws+F00++S7NIJAC2dlgCh3RnY
         dYSk/NSC4IaOj4cXEP/mF3aKwXzkgBrRBxi8Vjrhv++izyJNfsp6H2hhfWG0si6dLViB
         Fhride8OhbAtpN+3B7oUDLy8/QrYeIZrHqUV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KdNyrQyxEqP3uiedLpr0cYICiGY3wi7AFYYmSkwrv5cPg/BRlb9M/bFHxVaXUka28C
         GwNZgfxRRQHmszKlsEFjx/yw/8P3p5ZTMnOZ2403uXRloqypuTvjOGGFON86nOLCkjod
         ajonAUTKSBJkqTCU7c5POi2kr34D3i62z2txI=
Received: by 10.223.149.70 with SMTP id s6mr711081fav.66.1304584808375; Thu,
 05 May 2011 01:40:08 -0700 (PDT)
Received: by 10.223.108.20 with HTTP; Thu, 5 May 2011 01:40:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172818>

Hi,

I noticed that when i put a file in the git ignore If i switch to a
branch where the file is present and versioned git delete my local
ignored file replacing it with the content of the branch I switched
this is done silently and the file is gone forever if I don't have a
copy somewhere

this is a stupid testcase:

$ git init
$ echo 'content I dont care about' > testcase.txt
$ git add testcase.txt
$ git commit -m "content I don't care about"
$ git checkout -b test
$ echo 'testcase.txt' > .gitignore
$ git rm testcase.txt
$ echo 'content I do care a lot' > testcase.txt
$ git add .gitignore
$ git commit -m "ignored testcase.txt"
$ cat testcase.txt
content I do care a lot
$ git checkout master
$ cat testcase.txt
$ git checkout test
$ ls testcase.txt
ls: testcase.txt: No such file or directory


This may sound stupid (put a content you care about in an ignored
file) but think about environment configuration files

it is common to initially commit them (wrong) then copy them to a
template file adding the original to ignore
especially if you are migrating from subversion where it is really
common practice to have local modified file you never commit (and I
think git really miss a *feature* like this)
they can be very big and with a lot of environment options...

if for some reason I had to switch to an old commit where the file is
still not ignored to do some test and I forgot that commit do not
ignore my little environment file I can lose it...

I think git should warn me in some way and, at least, give me a backup
of the file

what do you think about it?

regards,
Daniele Segato

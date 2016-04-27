From: Jan Smets <jan@smets.cx>
Subject: using git-difftool -d when cherry-picking
Date: Wed, 27 Apr 2016 11:12:25 +0200
Message-ID: <CAH9ve7x3GSVX1M3yuAY1VmM-WoFX36o-vihFQ3Jw-_SZ4Bh_og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 11:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avLWN-0003hh-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 11:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcD0JMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 05:12:30 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35910 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcD0JM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 05:12:27 -0400
Received: by mail-ob0-f175.google.com with SMTP id j9so19601417obd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smets-cx.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=vtDY7Oi5km9hblH2jSRGZUk5OPD3saEh/Kb0MDWAyIo=;
        b=L4b6nYIjhnO+xQy8V8114pKiTGeEv9ZHSORtepDr0pdR9vrycsYTTPrK12fFegQCHs
         z/pYmP7fAzqTn57NZbtRfAt1EZJgEAQI4HTI4fPD4gcWJx+MGHKM1wm37RU1HTea8wX8
         djNMR6XTd91aYdVRcqwsCqpodkwnbZC2iwsZkDemdyoiZaaAzDbSCOsaEmSHZVPc767k
         n3MMkDaJB8nVchqHjBDbGatIPBa/Y1mJMnv+yIsIEcNEQ9nsfHZjBUaOpg1Mmeq5ZMzh
         jCCDW//3KMtRu7qkqOaWn2+Htl6ivJdduUUrRyP6QIz/Tf8R4/BMpXnlHKH/9KhfUuOE
         Z4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vtDY7Oi5km9hblH2jSRGZUk5OPD3saEh/Kb0MDWAyIo=;
        b=h22Ar9DlTkvpXzHXmZTD+4CDpWTE/EoJY5NlZI0P3Edo9Vp7xtx+B58iMWTMkXzJqY
         4lnGjGZ4hEPOrj6/tnpUJa9YCN43roPhssgn7NC1T/g59XeXKUmIpN7sLxpg875Pp49i
         qUQubBm4RSCDoxqPu9SPLyWTRY9/pBeqmbtorDUQgWHSjx1QJ64UGu+cxI2XrTntI/fd
         d9qpIfsMPbqzz5lwo1+2GQ4wq/ZcuUiQz0UeMVcBuXlqVGVVo9g7AUmVwJY3TjToJRD9
         gddcY6ivb3YWudHjoCsRtUcgVbz8Du9XtGZiD9x7IKRtnX5CucDcdlSqhIqOhEi5sAH3
         JoSg==
X-Gm-Message-State: AOPr4FW9cQAKjBlm4iDK7Eca6/GW+K+k4ytf+pgqak+tDgIrLeVpIGCill00joIb2uTWYu5FsKwtwqBtwXrSow==
X-Received: by 10.182.52.103 with SMTP id s7mr3161241obo.58.1461748345802;
 Wed, 27 Apr 2016 02:12:25 -0700 (PDT)
Received: by 10.60.138.167 with HTTP; Wed, 27 Apr 2016 02:12:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292716>

Hi

Please consider following example

#!/bin/bash
rm -rf /tmp/gittest
mkdir /tmp/gittest
cd /tmp/gittest

git init

echo $RANDOM > testfile
git add testfile
git commit -m test -a

git branch X
git checkout X
echo $RANDOM > testfile
git add testfile
git commit -m test -a

git checkout master
echo $RANDOM > testfile
git add testfile
git commit -m test -a

git cherry-pick X
git diff --raw
git difftool -d


This emulates a merge conflict when using git-cerry-pick.

$ git diff --raw
:000000 100644 0000000... 0000000... U  testfile
:100644 100644 a04e026... 0000000... M  testfile

When executing git difftool with the -d option :

/usr/lib/git-core/git-difftool line 260: File exists

A possible solution is to build an unique list in @working_tree

The purpose is to edit/resolve the conflict in the difftool.

Thanks!

-- 
Smets Jan
jan@smets.cx

From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: merge --squash detects a nonexistent error
Date: Wed, 14 Nov 2012 08:26:36 +0100
Message-ID: <CAB9Jk9ATdzQ5nSNDiKFMRMvyzKAOodC5n4Wan+AzSm_aDSLjRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 08:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYXN6-0003GN-26
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 08:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2KNH0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 02:26:38 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41299 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2KNH0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 02:26:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so112030pad.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 23:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tNQtRjSqXZA2ziJGkwDHJWZH/MCsozRvfH6xSgRVsaU=;
        b=O6+Y9R5I/OuxTXMEkMys/ZJAClg8W80O/2Rww0e9fw3y6BP8RwTQ0CJRgSRpIB0tY0
         R9oqoLh8k6R3DSVSka9DxbDKRwBot2ybAeRZ73uUnK6YF19FW80W9uhpxtTwW8fpvt0W
         cCVAdGpWRFCMGeeV+DBh5Sf6tGO9KGHeADV8OVs81S2Lr0Zr4yfRLmC6ZRStrqJ1Eo0L
         jBNemV0XQR9kb8ne8UbbR1EDggKKLxgxdnfHa3eYrq+EA1JZn8FKJ/chQEP/OI5M/Tiz
         8xwmdcbsRUWc9pI8/5oiKzX3BEe97XRZEpy0RFUaYzhsfFokt+ZZaqidjLC7y45/DNri
         Oo5A==
Received: by 10.66.73.102 with SMTP id k6mr4801911pav.22.1352877996888; Tue,
 13 Nov 2012 23:26:36 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Tue, 13 Nov 2012 23:26:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209700>

Hello,

I have got a case in which merge --squash issues an error that does
not exist. I hope I am wrong, though.
Consider the following example:

rm -rf public.git
rm -rf private
git init --bare public.git
git clone public.git private
cd private
touch f1; git add f1; git commit -m A
git checkout -b b1
touch f2; git add f2; git commit -m B
git checkout master
git checkout -b b2
touch f3; git add f3; git commit -m C
git checkout master
git checkout -b b3
touch f4; git add f4; git commit -m D

--- at this point we have

     A (f1)             master
      |--B (f1,f2)     b1
      |--C (f1,f3)     b2
      `--D (f1,f4)     *b3

git merge --squash b1
git merge --squash b2

The first merge adds f2 to the workspace, which then contains f1, f2 and f4.
The second merge should add f3, and instead it complains:

error: Your local changes to the following files would be overwritten by merge:
        f2
Please, commit your changes or stash them before you can merge.
Aborting

Why should it overwrite f2, and with what?

-Angelo Borsotti

From: Yang Yu <yang.yu.list@gmail.com>
Subject: git repository modified after migration
Date: Fri, 25 Dec 2015 14:49:40 -0600
Message-ID: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 21:50:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCZJz-00008H-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 25 Dec 2015 21:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbbLYUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2015 15:50:21 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34591 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbbLYUuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2015 15:50:21 -0500
Received: by mail-wm0-f41.google.com with SMTP id l126so208534618wml.1
        for <git@vger.kernel.org>; Fri, 25 Dec 2015 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=308grqjv/jk+rwoKY2nUsa66a0dGp1DDbtENVsHBVBQ=;
        b=ISD10m9GXRdyODJjwWn2pRDooCngMZwNZMVT1LxBjclBWIPPqyChJtP+heazkr0h0/
         28/vNESf17mCxl2dn05Xy4qMyUS7Nb59jLRbO2vUav9K7IaP3lx9AER8HidEQLlQ3OFJ
         3grx34OAPaItYEoVbaHgBdDFQwZSjw/duIb3MKDr6SKmgvFHdogb2f6pQyZO2c0KyI4R
         aiX4hF3BI1FVVThBqzOEqDlx0yruziqaPxYCuVg4gJE1iRvKkQMQuL6wuGKNp/IbjkG2
         pCjnvev/hmO/4VqYpkdwdXVe2CPlWXlwMRDQfeDT7z7CYUEH1J8EdEeobnGEXR2aJvS9
         ENng==
X-Received: by 10.28.221.85 with SMTP id u82mr36768661wmg.95.1451076620093;
 Fri, 25 Dec 2015 12:50:20 -0800 (PST)
Received: by 10.27.203.85 with HTTP; Fri, 25 Dec 2015 12:49:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282994>

I migrated a 11G git repository converted from svn on a host with
Debian 8.2, reiserfs, git 2.1.4 to a host with Ubuntu 12.04.5 LTS,
xfs, git 2.6.4. After the migration, `git status` showing a good
amount of files modified.

I did the transfer with
1) `rsync -azP`, after noticing the modified files I ran `rsync -avH
--delete` but it did not correct the problem
2) tar zcf, then on the destination download the tar.gz (served by
nginx) with wget

Both had the same result. But the original repository was still clean.

I did some comparison between "modified" and original files
a) same hash (md5sum, shasum)
b) same permission (-rw-r--r-- 1 )
c) same encoding and line termination (UTF-8 Unicode (with BOM) text,
with CRLF line terminators)
d) no git attributes for either


On the destination host, I ran `git checkout` on each of those
modified files. After one pass I got less modified files. Repeating
`git checkout` on remaining files for a few more times, finally I got
a clean repository on the destination host.

What could have caused git to consider those files as modified? And
why multiple `git checkout` again the same file was necessary?

Thanks.


Yang

From: demerphq <demerphq@gmail.com>
Subject: Rebase triggers "git diff header lacks filename information" on very
 large patch with binary files
Date: Tue, 14 Jan 2014 12:48:39 +0100
Message-ID: <CANgJU+V93Vu--hqikX0+dfZf4MnbcmVeE3OFW5J1THNkYiCL6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 12:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W32U9-0002ca-6W
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 12:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbaANLsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 06:48:41 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:43559 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbaANLsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 06:48:40 -0500
Received: by mail-pb0-f43.google.com with SMTP id up15so1935309pbc.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=oV62UEqjPIjZBySZIx4VRQXaQqy+05obs4oCA+YkJVM=;
        b=tSYBJfbmWdPpYtZqFDWY7ouY0AJ6aIL6iG23cV78dCosu5yUFt1kIqKxtNIv4xGECk
         LHz4cWpKOQqQZ149LfrP2r3z2W2h7cSyQphBH6WmcolHCEvP35KcYZ5R7aWwddUG9L1H
         XP03tTl8DnluZfiv7pd3Zjl3kX1lweE07R4FBIHrY+omIT1wesFgepb5c1WyCtVmUKhn
         nDoNWmLtk7J/X7vcBFUXL9ysRMWHUtwcjXnAlb7r/5mvyrkJqzi3HFyh7+OZf/a+1RIv
         6wLWU2d5l1Su8Oe/X0mwBE2AtMO2XlWa51MFEkaFeORG7/eQBlM36kCw5LxZD8CXNDy8
         skpQ==
X-Received: by 10.66.248.227 with SMTP id yp3mr1206740pac.116.1389700119719;
 Tue, 14 Jan 2014 03:48:39 -0800 (PST)
Received: by 10.70.1.162 with HTTP; Tue, 14 Jan 2014 03:48:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240396>

Hi,

I just did a rebase, and it throws an error like this:

Applying: comment1
Applying: comment2
Applying: comment3
Applying: comment4
Applying: patch_with_binary_files
fatal: git diff header lacks filename information when removing 1
leading pathname component (line 7330213)
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0005 patch_with_binary_files
The copy of the patch that failed is found in:
   /usr/local/git_tree/affiliate_data/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

The patch is very large, 882453899 bytes.

The patch also includes many binary files.

Extracting the content around and before line 7330213 and up to the
next diff header in the patch I see this:

perl -lne'print "$.\t$_" if 7330169 .. 7330213' .git/rebase-apply/patch
7330169 diff --git a/dir1/dir2/file.png b/dir1/dir2/file.png
7330170 new file mode 100644
7330171 index 0000000000000000000000000000000000000000..8a3219cb6545f23e3f7c61f058d82fc2c1bd9aac
7330172 GIT binary patch
7330173 literal 11301
7330174 zcmXYX1ymeO)Ai!+PH-nk@Zb{MHE3{$;O=gVh2Rd06MPp4?hxD|K!5<jEd=*(p7;Ov
[more lines of binary removed]
7330213 zznckDs-GVJg-A0uD|ONvCQWVX;j!JNnkQI9^=+zJ^SvLe1p-~c&7bmY5wu4C=(8F0
[more lines of binary removed]
7330393 literal 0
7330394 HcmV?d00001
7330395
7330396 diff --git a/dir1/dir2/file.css b/dir1/dir2/file.css
7330397 new file mode 100644
7330398 index 0000000000000000000000000000000000000000..75c8afc558424ea185c62b5a1c61ad6c32cddc21

I have munged the filenames.

It looks to me like git can't apply patches over a certain size.

Any suggestions on how to proceed here?

cheers,
Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 10:53:51 -0400
Message-ID: <1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 19 16:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0C57-0001yg-9z
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab3GSOyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 10:54:49 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:56862 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3GSOys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 10:54:48 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so2361854qab.15
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fGYwKd1bl2/mjfZ628e67TxYXw6lxCgVto1nZLs3yaI=;
        b=f7IHsCHi0gppAX4H+RHQQfnTGA7JirNFQ1zDq1524OYjgTQr3fhJgjfdD5K5p2lrJ5
         FcYQhRtdzrXsc/AreJ690o20znPvSI+8AuQXNz46lKZ3uTXY1wM1GsifGpLogb5Fp9V/
         cX/RYx3pOyoT9z24KVGb9+8+FjMi9+XRCksj5/mEmWyRky7Fp1xg8y38jbvirefVaVke
         9NkWjjGu5M4DlayHFrFz+sG28rv9s2iSZ4yzqnDmz3JCysmrmUl4DbKW5GxdZ1GDQSVo
         7P9iI4WTgW3MXuUJ6phZbfckC5sgqIBNEHnbyau/xu8I3eCXgqhp23uQByxTA7GIyBHs
         thOA==
X-Received: by 10.224.23.7 with SMTP id p7mr8823738qab.88.1374245688018;
        Fri, 19 Jul 2013 07:54:48 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id i1sm22997147qas.10.2013.07.19.07.54.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 07:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230811>

The supported Cygwin distribution on supported Windows versions provides
complete support for POSIX filemodes, so enable this by default. git as
distributed by the Cygwin project is configured this way.

This fixes one testsuite failure:
t3300 test 17 (diff-index -M -p with mode change quotes funny filename)

Historical notes: Cygwin version 1.7 supports Windows-XP and newer, thus 
dropped support for all OS variants that lack NTFS and/or the full win32 
api, and since late 1.5 development, Cygwin maps POSIX modes to NTFS ACLs 
by default.  Cygwin 1.5 supported OS variants that used FAT as the native 
file system, and had optional methods for providing POSIX file modes on 
top of FAT12/16 and NTFS, though not FAT32.  Also, support for POSIX modes 
on top of FAT were dropped later in 1.5.  Thus, POSIX filemode support 
could not be expected by default on a Cygwin 1.5 installation, but is 
expected by default on a 1.7 installation.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
Junio - The above notes are more accurate than in my previous commit message,
so if this commit survives into next/master, I would prefer this version as
opposed to the one now on pu (da875762)

Mark

 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 174703b..bf5db47 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -164,7 +164,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
-- 
1.8.3.2.0.13

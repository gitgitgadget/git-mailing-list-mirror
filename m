From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] Cygwin has trustable filemode
Date: Sun, 14 Jul 2013 12:13:10 -0400
Message-ID: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyOvf-0002D4-CG
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3GNQNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:13:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58197 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab3GNQNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:13:23 -0400
Received: by mail-qc0-f174.google.com with SMTP id m15so5807117qcq.19
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9HuM2nGspVY8aSCr+GoukMzXChja2+/O8nY0VBDeSqY=;
        b=n2v+PdOItjxBzAECNXqgd9sanXHPW/Rb7Pr9zPuQCppo5oSINw0kFCOfnwYqUvbY/X
         S9RJhJVoVf7vvji2NfVP5hlDqLhmwWoRUP5yrHj7w/hn1iOds2swQLh6aTtPPd4bQttv
         e84HyP4U0I1ggVXcOZ00jLnIN579aNAnHVtgdHssTym5l8wlJI/vfxRFda7E7wRsojfV
         wmoLRX+drxPQNGHtHz2ZB3cgzc/IhIaEJR+nmAyDYZXjd/u5aepdxVWEul9vGFHUOk7z
         BI68q+z1UGjFGD1QjoVm8Q8seXRPCwqTxdGh5oqq1PlYH72JpdC7YT7kJk7qdF52MleY
         qXHw==
X-Received: by 10.224.54.204 with SMTP id r12mr47162732qag.105.1373818402537;
        Sun, 14 Jul 2013 09:13:22 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id r2sm48900913qeh.7.2013.07.14.09.13.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:13:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230368>

The supported Cygwin distribution on supported Windows versions provides
complete support for POSIX filemodes, so enable this by default. git as
distributed by the Cygwin project is configured this way.

This fixes one testsuite failure:
t3300 test 17 (diff-index -M -p with mode change quotes funny filename)

Historical notes: Earlier versions of Cygwin (version 1.5 and prior) had 
various methods for supporting posix file modes on different file systems, 
often using extended attributes, and this support was optional.  Such 
versions of Cygwin are not available on any public mirror and are not 
supported by the Cygwin project. The currently available Cygwin supports 
POSIX file modes without exception - this is not an optional 
configuration. The support does depend upon the underlying file system 
(neither Linux nor Cygwin can set an execute bit on a FAT file system as 
FAT has no such support), but as this is no different than Linux, the
default should not treat Cygwin differently than Linux.  

Users who desire the non-POSIX mode of operation must explicitly set 
core.filemode=False, accepting non-interoperability with Linux.  

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 7ac541e..779d06a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -163,7 +163,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
-- 
1.8.3.2.0.13

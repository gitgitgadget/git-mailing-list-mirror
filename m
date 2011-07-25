From: Pascal Obry <pascal@obry.net>
Subject: [PATCH] On Cygwin support both UNIX and DOS style path-names
Date: Mon, 25 Jul 2011 19:27:24 +0200
Message-ID: <1311614844-4256-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 19:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlOx0-0003Ze-MU
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 19:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab1GYR2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 13:28:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56602 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab1GYR2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 13:28:06 -0400
Received: by wwe5 with SMTP id 5so4292732wwe.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 10:28:04 -0700 (PDT)
Received: by 10.227.24.18 with SMTP id t18mr4028528wbb.101.1311614884728;
        Mon, 25 Jul 2011 10:28:04 -0700 (PDT)
Received: from pascal.homeobry.net (AVelizy-154-1-6-251.w82-124.abo.wanadoo.fr [82.124.68.251])
        by mx.google.com with ESMTPS id fo2sm4493302wbb.48.2011.07.25.10.28.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 10:28:03 -0700 (PDT)
Received: from obry by pascal.homeobry.net with local (Exim 4.76)
	(envelope-from <obry@pascal.homeobry.net>)
	id 1QlOwj-00017L-98; Mon, 25 Jul 2011 19:28:01 +0200
X-Mailer: git-send-email 1.7.6.345.g5c2f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177802>

In fact Cygwin supports both, so make Git agree with this.
The failing case is when a file is committed in a sub-dir of the
repository using a log message from a file specified with a DOS
style path-name. To reproduce:

   $ cd src
   $ git commit -F c:\tmp\log.txt file.c
   fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
   or directory.

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 compat/cygwin.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..de9737c 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
 
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+
+#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
-- 
1.7.6.345.g5c2f8

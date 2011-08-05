From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri,  5 Aug 2011 18:10:14 +0200
Message-ID: <1312560614-20772-3-git-send-email-pascal@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 18:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpMzG-0003iL-N3
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 18:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab1HEQK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 12:10:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62604 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab1HEQK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 12:10:57 -0400
Received: by wwe5 with SMTP id 5so3077393wwe.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 09:10:56 -0700 (PDT)
Received: by 10.227.6.207 with SMTP id a15mr2061678wba.25.1312560656076;
        Fri, 05 Aug 2011 09:10:56 -0700 (PDT)
Received: from pascal.homeobry.net (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id gg16sm2406741wbb.17.2011.08.05.09.10.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 09:10:53 -0700 (PDT)
Received: from obry by pascal.homeobry.net with local (Exim 4.76)
	(envelope-from <obry@pascal.homeobry.net>)
	id 1QpMz5-0005Q2-Qf; Fri, 05 Aug 2011 18:10:51 +0200
X-Mailer: git-send-email 1.7.6.404.g5d2fc
In-Reply-To: <1312560614-20772-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178801>

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
1.7.6.404.g5d2fc

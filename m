From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 01/18] rev-parse: add --internal-cwd and --internal-git-dir for tests
Date: Sun, 24 Oct 2010 19:11:33 +0700
Message-ID: <1287922310-14678-2-git-send-email-pclouds@gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zR6-0008WA-7Q
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530Ab0JXMME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 08:12:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47687 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXMMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:12:03 -0400
Received: by pvb32 with SMTP id 32so423714pvb.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=vLU05ggq9ws22lO+gLRFgfRJPsL6hmW6lrsrT18mviw=;
        b=GYRgAHM5Sv+tg0A9S6MsyFohgyiWCWT5cmFyq6SNdFyOakXUyuargMAl9cA9PSv/pc
         9o9PPLUWjU4amCm2nVzMh7pLYBBwYMpR2as3RdWHux29uXc/kE5Cz5jCvMul7uWVDZ2t
         mz02Vy8A+FWDyH2o5FFhSpzlisvDlzqlxcbds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OnhrRegtdhNYcaCabdaZa9neNP22VG5J1+ex5ceFTCLkweKhtI7rjr/mjU9DD05UbL
         Rzzck3c0jKeMlnrmml/F97J8BckMp0ntxS29KTrdPdei3P8feXTgRQSepvq2EGNla2LY
         alOcRN8L6eBcBO2oDsSLyBfLdGbYsnLqh0NaI=
Received: by 10.142.125.18 with SMTP id x18mr3725161wfc.287.1287922323002;
        Sun, 24 Oct 2010 05:12:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm9128040wfh.0.2010.10.24.05.11.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:12:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:11:58 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159856>

--internal-cwd is obvious, no way else to expose it for testing.

--internal-git-dir is introduced because --git-dir prepares its output
suitable for scripting. For tests, it must be exactly what git stores.
---
 builtin/rev-parse.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..454a25c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -642,6 +642,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				putchar('\n');
 				continue;
 			}
+			if (!strcmp(arg, "--internal-cwd")) {
+				static char cwd[PATH_MAX];
+				if (!getcwd(cwd, PATH_MAX))
+					die_errno("unable to get current working directory");
+				puts(cwd);
+				continue;
+			}
+			if (!strcmp(arg, "--internal-git-dir")) {
+				puts(get_git_dir());
+				continue;
+			}
 			if (!strcmp(arg, "--git-dir")) {
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				static char cwd[PATH_MAX];
-- 
1.7.0.2.445.gcbdb3

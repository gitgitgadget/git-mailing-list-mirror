From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 55/83] builtin/apply: make parse_single_patch() return -1 on error
Date: Sun, 24 Apr 2016 15:33:55 +0200
Message-ID: <1461504863-15946-56-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEF-0000dP-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbcDXNhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:33 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37865 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbcDXNgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:04 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so90220785wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZKciOotvLTVKeuPJNQaLb/bGZNm4j2TOp7s6KqBLZrI=;
        b=PxJ8rGO/JcaAiidbpbMyDozMkiY7nXV4FJzYzyESr+8+DDTycTyOwIhEhIPnPoVgDS
         mijaN9+sEgAcUj+u/jW/qSOH+DmIXturMhcB/FasugKnv/CkWmw9crh09ak1wQaRrBsf
         nlCqqHxCww1zh/5CyNAeNCQHP42OnrpYnXwLobtV+DyflFsjtL805hvGOgUDi0ZbIVlY
         I783xDKsQvBW0KaD10HipMDxliKTQ/MIURD+O0bdhRi8tcJVyQH6uEGk7/UvHLRRmfOc
         RtgRsiBhHrGx0wElkSbHqchHefVxMwcqIYS+8CSqledHzemgGGBHERTc1S47l44YWASN
         0Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZKciOotvLTVKeuPJNQaLb/bGZNm4j2TOp7s6KqBLZrI=;
        b=F/Swu/KtFDBg80FFkEReHnG5QUdN/MJ1SNaiMNZ+YojvO8RF+GCBRgRjpqc+AVi1uv
         Hmo4WO1E9B0GBdPICjbknRlntdWerdaQi9DsHd/+rl29rUGT6ZSYy03iOMfwuxL/rERu
         pWNmj/JZwQ4lif3/MPwgirbUpX1pfuyz0xv2+Ogl5G+UTH9pxhsiP/d9nqKN62rklUnS
         JeTa26nssXWzY0qlVrcimANf628+avr1RR9X2cO6P5X9YIa4kibWvqxdtS2tTIcL6BQO
         UK+iYWFUPoM34y380ipprDkLPQgEqIE3v7d4gtW+8wP4jGrg2WBhZNdrfgWKHscXHhCc
         yq5w==
X-Gm-Message-State: AOPr4FWlaTu1OlmH7O3s4a+7mBGAfvr5AnNTD6MOcLTH3bqAQtQYra/5EK7vc5TqS9hPqw==
X-Received: by 10.28.210.10 with SMTP id j10mr6744540wmg.21.1461504963283;
        Sun, 24 Apr 2016 06:36:03 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292374>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c        | 17 +++++++++++++----
 t/t4012-diff-binary.sh |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e1d6c8b..de5c745 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1785,6 +1785,10 @@ static int parse_fragment(struct apply_state *state,
  *
  * The (fragment->patch, fragment->size) pair points into the memory given
  * by the caller, not a copy, when we return.
+ *
+ * Returns:
+ *   -1 in case of error,
+ *   the number of bytes in the patch otherwise.
  */
 static int parse_single_patch(struct apply_state *state,
 			      const char *line,
@@ -1802,8 +1806,10 @@ static int parse_single_patch(struct apply_state *state,
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = state->linenr;
 		len = parse_fragment(state, line, size, patch, fragment);
-		if (len <= 0)
-			die(_("corrupt patch at line %d"), state->linenr);
+		if (len <= 0) {
+			free(fragment);
+			return error(_("corrupt patch at line %d"), state->linenr);
+		}
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1839,9 +1845,9 @@ static int parse_single_patch(struct apply_state *state,
 		patch->is_delete = 0;
 
 	if (0 < patch->is_new && oldlines)
-		die(_("new file %s depends on old contents"), patch->new_name);
+		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
-		die(_("deleted file %s still has contents"), patch->old_name);
+		return error(_("deleted file %s still has contents"), patch->old_name);
 	if (!patch->is_delete && !newlines && context)
 		fprintf_ln(stderr,
 			   _("** warning: "
@@ -2143,6 +2149,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				       size - offset - hdrsize,
 				       patch);
 
+	if (patchsize < 0)
+		return -1;
+
 	if (!patchsize) {
 		static const char git_binary[] = "GIT binary patch\n";
 		int hd = hdrsize + offset;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 643d729..0a8af76 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
-- 
2.8.1.300.g5fed0c0

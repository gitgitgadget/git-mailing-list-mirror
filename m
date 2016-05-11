From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 55/94] builtin/apply: make parse_single_patch() return -1 on error
Date: Wed, 11 May 2016 15:17:06 +0200
Message-ID: <20160511131745.2914-56-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4W-0004Lj-Li
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbcEKNUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36376 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcEKNUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9351643wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVpJxHmv2o6yT/WbZ1IzPiLt+zr4hu3lyI33qMnLw5M=;
        b=ed4xaIdGr1EAl1dWvmz61wrXeqSpS4l/U2iHcbESmONCcVazlRHOQkxjX8EqlhMcGh
         rgOpNQCIq+mNFyirLwRnf2eiwXU3YbX5MS6G/yucjGy+J4Fc0AxQaYQOvQfX0dcjpXu3
         eH4b++44/wKe1tIylp41tnSEdhbR9/RK2zCG1gbAyo/9Iw8122rC8q24AA3I/XXTtUVa
         btV5ZDm8IM1tFzsNWuTgA94NgXeCqJAgWG4YU9xEaCD0pNezHWu7KkbutcwuXJ/CoZ6f
         NYtQur12WkedpVVXPXH7NvEnm6kutZg3mIk00ewx7izQEsNkRZ6lq6SDOJsRj1szfPtF
         PffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YVpJxHmv2o6yT/WbZ1IzPiLt+zr4hu3lyI33qMnLw5M=;
        b=XswA9MerLMZNEbv24ELKixzbi+lA/1QAOs60+o4S0r5zp8gWZg6v2YuHB3oFnWBRxP
         zG3XIMfJWLgLdLO5p8JzfilX8S56SLMY5iFQap03BJiWnrWaLvwGEXuS13Il9dnU7mpk
         iSpvKoZTxrzc8/bOJlHQRWoo7B9K0gJgbIm91c8Nk9yl9fxLhAt8ke8EhxLiWAHXMnN6
         YAEpzFp/NZ5/VcxOirQ3ec/kmey72Z9xFEF32+Xtm4zwVihTWCgMT/b0itoC4YvKnekP
         yl96DsxMxHus2/OvXrN/Po1iRs3OT9Tc0mv5Xsc+ULpDBXNcpkG88jfbm7RVb/zwYd4I
         056Q==
X-Gm-Message-State: AOPr4FXpHskBq2QHSLz/Rh6t74cpgp64jQjFeNvJZOMn9FgRaxhilVLceRlbwSKW2ypH8Q==
X-Received: by 10.194.38.67 with SMTP id e3mr3778670wjk.127.1462972819461;
        Wed, 11 May 2016 06:20:19 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:18 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294289>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_single_patch() should return -1 instead of
calling die().

Let's do that by using error() and let's adjust the related test
cases accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c        | 17 +++++++++++++----
 t/t4012-diff-binary.sh |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2380472..58bcfeb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1776,6 +1776,10 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1793,8 +1797,10 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -1830,9 +1836,9 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -2134,6 +2140,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
2.8.2.490.g3dabe57

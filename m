From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 06/40] builtin/apply: make parse_single_patch() return -1 on error
Date: Mon, 13 Jun 2016 18:09:08 +0200
Message-ID: <20160613160942.1806-7-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:12:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUT4-0004vN-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425011AbcFMQL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33281 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424770AbcFMQKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so16041596wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJVxUkBS6gBpmMZpXUEOi+KTT3Sl6bSUal9ILHciLos=;
        b=NNGID3yjQiT/7h9vjryccuwWWmdWQ7CPC5BrRPEKFIt0oBrcMeBFLxbqBQdSeDcMWN
         +a5qTCitmBnQOcmi8bQwb6Mm9ttn2e690gwXQKFS4tPL86AN5hoGqnphojYxQUZ20IdD
         0kioe1wT3TYou/VOG4VhPRz//ynkLEAUOvJfY8VKHuyrsud7ahUPCcJMayl7Ic4Y0LxU
         /NHa+hwCCaXaoul8JViNqOb51u6Dgolfo93JGh0rIZUdH2PZKiCc0BCGnDc0iZrV0BN7
         dx8lFD87VBbumtQkCtt3/wFVigElaIV7yYDLvr2QwcAfQAsPpdXtwvubILYt3A0rQdWe
         uEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJVxUkBS6gBpmMZpXUEOi+KTT3Sl6bSUal9ILHciLos=;
        b=V3A7NYQ+a48Njq5BNiZEytN8OwkucsA+XGqsw6Ee7WezZyjpRdZ8ZhEKcb3Abq3+LW
         YUnzmx69vrRm82nqrDhFxNlmZ/aNENFzrfmjWAiLXRH8NOds7djQT7no1+UplJZnewOf
         s1/H+MJKoMiliDEtqhUfrDVjkzaU0oRO62w+/PLL+uOpGq4nTO0B54M0syKF9JRjnTws
         eJJ1Ciyvs3qOAusrCuMRYIre+Uw/TXxvo8KCjkCaeyC4hf/+GwC/l5JbPLrTIwKGiEJ9
         YcjOKORCvOXoKzECeCyHEO69t6GTrqAsIFbfq1LClBXdWZ278/qBrqDrxEp8yiYfkVtC
         ZVQg==
X-Gm-Message-State: ALyK8tIyF6sSFgaerOJxDUTspnsoal0d9b2TK5EC5M4KdOkVnDW5E1IW0d+d25kjwN9AXQ==
X-Received: by 10.28.156.77 with SMTP id f74mr1983148wme.82.1465834205333;
        Mon, 13 Jun 2016 09:10:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:04 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297230>

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
index a160338..2671586 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1666,6 +1666,10 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1683,8 +1687,10 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -1720,9 +1726,9 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -2024,6 +2030,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
2.9.0.rc2.411.g3e2ca28

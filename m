From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git-compat-util.h: move extension stripping from handle_builtin()
Date: Sat, 20 Feb 2016 14:10:58 +0600
Message-ID: <1455955858-30081-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git @ vger . kernel . org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX2hF-0000ee-CV
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949950AbcBTIPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:15:14 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35660 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1949121AbcBTIPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:15:13 -0500
Received: by mail-lf0-f48.google.com with SMTP id l143so67340693lfe.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=98npem8b5WBRoovawzXcBfkClPCuNGQHF3S37RscPXY=;
        b=bSqxLvQveCMw9IvpF/JNPgIojtHF0KK9WZbbO+J3JYGesP/4LEKEI9/nzKP82Ko11U
         oLOV/9qOYcp+5QJaL/7guHOE3bnDFI3hYRwuhjC4fa/kVyjQk7FP62L2fmoTSqjoGzu2
         CGvuezzG9FpA5Nwgy06/WaVjsWaauZPhVpVdoBXldTUbdrwnggdxTcYS5OPWLJHFkoFn
         5b3g4le2sr5TrjD9mQqPxT0gLOepEtkogVT7HfB8+HF8nNCepR+Tn+cemN2dh5Kjx/sL
         wRfv5gbRRk6cRTsqtNxM0nPczYB/Lke0sX6ylTNfngBqXUu8CepYMSs2GOeYzGLc+yOV
         HjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=98npem8b5WBRoovawzXcBfkClPCuNGQHF3S37RscPXY=;
        b=XT0pZmkF4TOJOwRclWSSAGB+ide/dB2+vXXZPrJ6LUJjvE6T9xWujfH7oOmygWCPu/
         lDtdRWx9+BFZ5PJFX0d/ENPZXY1mOOZUqTtkhWAx6tnJqtAerkKMlm6HoOaCPv3/vUfX
         WoOAwYBzEP9NGoqd0CeweTeiTy6/KDBf68BUStey5uq7TdP7aB6+uUaUTHE9+OuqJAfw
         oH4ShayjVZOXJcsJM+L3+8RM86q5HIGc7Q14GvumHQAHGQVGx/zYkXyXA0YA1+I++ZWH
         8H1DcnPNRx3ZYA/qRbuuSuD3SQPbLbwkJBqP5PB8GkkGhbCCuAJhdmC6oM2OvQAnGU3a
         qWdQ==
X-Gm-Message-State: AG10YOR+MKTnrOAb47Xm3PJIdoBL9/Q4a8bb+UYUOlImQmhfQ7HMHiFdNubPRxdT9rusqA==
X-Received: by 10.25.149.68 with SMTP id x65mr6811742lfd.138.1455956111288;
        Sat, 20 Feb 2016 00:15:11 -0800 (PST)
Received: from localhost.localhost ([2.135.251.119])
        by smtp.gmail.com with ESMTPSA id am11sm441287lbd.34.2016.02.20.00.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 00:15:10 -0800 (PST)
X-Mailer: git-send-email 2.4.4.764.gf6c74eb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286768>

The handle_builtin() starts from striping of command extension if
STRIP_EXTENSION is enabled. As this is an OS dependent, let's move
to the git-compat-util.h as all similar functions to do handle_builtin()
more cleaner.
---
 git-compat-util.h | 18 ++++++++++++++++++
 git.c             | 13 +------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 658d03b..57f2fda 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -323,6 +323,24 @@ extern char *gitbasename(char *);
 
 #ifndef STRIP_EXTENSION
 #define STRIP_EXTENSION ""
+static inline const char *strip_extension(const char **argv)
+{
+	return argv[0];
+}
+#else
+static inline const char *strip_extension(const char **argv)
+{
+	static const char ext[] = STRIP_EXTENSION;
+	int ext_len = strlen(argv[0]) - strlen(ext);
+
+	if (ext_len > 0 && !strcmp(argv[0] + ext_len, ext)) {
+		char *argv0 = xstrdup(argv[0]);
+		argv[0] = argv0;
+		argv0[ext_len] = '\0';
+	}
+
+	return argv[0];
+}
 #endif
 
 #ifndef has_dos_drive_prefix
diff --git a/git.c b/git.c
index 8751ef0..a4d2a46 100644
--- a/git.c
+++ b/git.c
@@ -506,19 +506,8 @@ int is_builtin(const char *s)
 
 static void handle_builtin(int argc, const char **argv)
 {
-	const char *cmd = argv[0];
-	int i;
-	static const char ext[] = STRIP_EXTENSION;
 	struct cmd_struct *builtin;
-
-	if (sizeof(ext) > 1) {
-		i = strlen(argv[0]) - strlen(ext);
-		if (i > 0 && !strcmp(argv[0] + i, ext)) {
-			char *argv0 = xstrdup(argv[0]);
-			argv[0] = cmd = argv0;
-			argv0[i] = '\0';
-		}
-	}
+	const char *cmd = strip_extension(argv);
 
 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
-- 
2.4.4.764.gf6c74eb.dirty

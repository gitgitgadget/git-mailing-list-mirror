From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH] Trick to force setup of a specific configured E-Mail per repo
Date: Tue,  2 Feb 2016 21:54:21 +0200
Message-ID: <1454442861-4879-1-git-send-email-alonid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 20:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQh2M-0004DW-NA
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 20:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbcBBTyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 14:54:50 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34897 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcBBTyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 14:54:47 -0500
Received: by mail-wm0-f47.google.com with SMTP id r129so134408638wmr.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=4ceokGg9tJ6RQ6ej6ifp0ZIzLFz35qisIj4EwE0cz58=;
        b=Qd6b0YhPHRRde9jW2YTHJ0+vB2NJervLb1WByZ3bRWfxrTxAM40G3Jv+BnvpNeP+jF
         K0Nc4ZFo0bP4auR3TQwBhh0cGnyMNjG1gtzqT0nBEG4QUH+Z7JZ5u1sbAyafnDlR4mf6
         fL1dv/bb2iVyuP5c4zudAybnxOgmMMgcQzLYuQ5kFrM8AnO8zOiubCTRWEOyUn6L8P3p
         GIXa9wW7R4aVYy6jbDNEWH0b4/0xwSH4iWwjA4IyXAwo41iM0KShYtjcshKR26+GumfT
         tIf3ztQmTr5ZruGaKH95wSjBQc4il2cIK+kWydhRtqj/3Fq4KEpjLPPger0Yg38Xo0nm
         0CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4ceokGg9tJ6RQ6ej6ifp0ZIzLFz35qisIj4EwE0cz58=;
        b=TEhQ5gWaGx3ul5ej3OYwrPJJ2AkUfS2DGdDE/Y/2Dfu1jrsUbLva6eKtloUfbEgNC9
         ptoUYUNLqK391mJmBtRHOv06KvX7WtK0ZzDgncKhyuIWW8MT7dbJocO6jIoNtpnc9rOy
         MlnNidm91sGCWcTplzewqPYot03kTqL6fe/olgIxqWTvjPMp2VdfT2Q2nvPQ1TjA4Xzg
         4js/KPfOBmmja4xuCLKUc6QObm28BNKCHfc5l2kTGtum0uq7h64xXr07HG6jHDTEv+ay
         Y8sS60Iji0v1Ezaa0IdgsMZZlGou59QbinLLoRzAUUPZcRbD2MZ1YrhfP+oXEyA5z3yf
         73BQ==
X-Gm-Message-State: AG10YOSTUGW+4gpWSNjlAru+ycD0ZWWlXGTLCnkyOKBhlZVLL7ylnKYm3jTkaWEGenKpkQ==
X-Received: by 10.194.156.199 with SMTP id wg7mr35869333wjb.114.1454442885966;
        Tue, 02 Feb 2016 11:54:45 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id e198sm4457610wmd.0.2016.02.02.11.54.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 11:54:45 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285301>

Previously, before 5498c57cdd63, many people did the following:

   git config --global user.email "(none)"

This was helpful for people with more than one E-Mail address,
targeting different E-Mail addresses for different clones.
as it barred git from creating commit unless the user.email
config was set in the per-clone config to the correct E-Mail
address.

Now, since the original 'bug' was fixed, and practically every
string is acceptable for user.email and user.name, it is best
to reimplement the feature not as an exploit of a bug, but as
an actual feature.

Signed-off-by: Dan Aloni <alonid@gmail.com>
---
 Documentation/config.txt  |  3 +++
 ident.c                   |  5 +++++
 t/t9904-per-repo-email.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f61788668e89..f9712e7c7752 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2769,6 +2769,9 @@ user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and
 	'EMAIL' environment variables.  See linkgit:git-commit-tree[1].
+	For people who seek setting different E-Mail addresses depending
+	on the clone, set to '(per-repo)' on the global configuration,
+	and Git will prompt you to set the E-Mail address in the clone.
 
 user.name::
 	Your full name to be recorded in any newly created commits.
diff --git a/ident.c b/ident.c
index daf7e1ea8370..0e07d45f8ff3 100644
--- a/ident.c
+++ b/ident.c
@@ -373,6 +373,11 @@ const char *fmt_ident(const char *name, const char *email,
 		die("unable to auto-detect email address (got '%s')", email);
 	}
 
+	if (strict && email && !strcmp(email, "(per-repo)")) {
+		die("email is '(per-repo)', suggesting to set specific email "
+		    "for the current repo");
+	}
+
 	strbuf_reset(&ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(&ident, name);
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..c085ba671b85
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of E-Mail address'
+
+. ./test-lib.sh
+
+test_expect_failure 'fails commiting if clone email is not set' '
+	echo "Initial" >foo &&
+	git add foo &&
+	unset GIT_AUTHOR_EMAIL &&
+	git config --global user.email "(per-repo)" &&
+	EDITOR=: VISUAL=: git commit -a -m x
+'
+
+test_expect_success 'succeeds commiting if clone email is set' '
+	echo "Initial" >foo &&
+	git add foo &&
+	git config --global user.email "(per-repo)" &&
+	git config user.email "test@ok.com" &&
+	EDITOR=: VISUAL=: git commit -a -m x
+'
+
+test_done
-- 
2.5.0

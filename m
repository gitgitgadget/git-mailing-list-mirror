Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B61EC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A17C20731
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag8/5vxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEAFTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgEAFTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 01:19:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66CEC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 22:19:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so1158754pfd.4
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 22:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dahwI2F5b4p5ahHYaurEviGupUzSLHeQ9zvRVO+qi/Q=;
        b=Ag8/5vxd7lI87DVipluE4oW822ixn3FyV7HddTYdzJ0e4/7HbxRpe7RWbNuhXVVAEC
         fRseApFFfvz01/Usl8UP8IrUEpgMZuatWF2uUD1hbjR0vDoaS6QvRt5/BhftaNhR+Ism
         m2jOnlDvfEc6h5FrmP5KVFclWqhl/0AaQHAdLYdMhFeyQG0VPSdb41XS+Ue8tUDIZYiX
         qi1aenKhvDaJFhMZpDqRRrLWbLiz9eKdeKT0NQa6XEEvuVr2i/U1uQttD6TV2OM4VqnP
         DXiuUQLdz8gBz6mjCl97QlWq1vP9NVTH//srzZmTStZMI/mXtIi2/7KmK5SJfwYL9AEQ
         Cotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dahwI2F5b4p5ahHYaurEviGupUzSLHeQ9zvRVO+qi/Q=;
        b=M0OBhi8K5/xykAFq5Gsig0uz6YemsGIBPpZdM1BFwnf9qSYcUXzzRvcrBwlgP8MOPh
         HTcBkDaV2AmjoJuUW1H2nYpp1DAObuBdq425tdGSf8LpbLRz4vLlSQFaQvPwDAmjukqR
         QNgYgpJORndk0fR2tyAdsm7//pQUYShmSCYypcJYxp/KCLPOmUUFG/H2ulpfRwl5QkLE
         CG+o6xNsQiusEI71RVxfLtJX506Uy6X5ydO+Lru9sZXY2gVCmCT8GnSx9AJlyTk77ncg
         aNmAQc1tUBXsyEAjdIgQ3WIwuGTVIkIzTU3N0CRutJgU9jNwCVyhjptVjdZWC/U0+u2b
         bx7w==
X-Gm-Message-State: AGi0PuY8k7ojzMM7WxBJtsSavKsKWKbKHvf3JewcHZzkkK6lD+xJwirP
        lVyVjU0Kj2UaEDIb1HMjhdA=
X-Google-Smtp-Source: APiQypIIdf6TmjZHTAA103Tnin6q4LIeWvt/42/ix4NjjVmRUkEnqtu2+oT0odG7aHrHxTrJxFEm6w==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr2363788pfj.10.1588310341996;
        Thu, 30 Apr 2020 22:19:01 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h17sm1205555pfk.13.2020.04.30.22.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 22:19:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v10 2/1] credential-store: warn also for store and erase
Date:   Thu, 30 Apr 2020 22:18:47 -0700
Message-Id: <20200501051847.31803-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.3.g90bd2f7136
In-Reply-To: <20200501032152.12160-1-carenas@gmail.com>
References: <20200501032152.12160-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

done in a hacky way and only as a POC, but at least works, if we
are still thinking that warning should be at least comprehensive
for the first iteration.

didn't change the callback as you suggested but I think this
doesn't look that bad either.

squash for final v10 or ..?
---
 Documentation/git-credential-store.txt |  7 -------
 credential-store.c                     | 19 +++++++++----------
 t/t0302-credential-store.sh            | 20 +++++++++++++++++---
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 18ba8b6984..d5841cffad 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -105,13 +105,6 @@ like spaces, line wrapping or text encoding.
 An unparseable or otherwise invalid line is ignored, and a warning
 message points out the problematic file and line number it appears in.
 
-Note that because of deficiencies of the current implementation, these
-warnings will be only generated for the entries that were processed
-while reading the credential files during a get operation, and so they
-are not comprehensive, and will require you to use an editor (or
-better a sed/awk/perl one liner) to edit the credential file and remove
-them.
-
 When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
diff --git a/credential-store.c b/credential-store.c
index c2778eff8a..236df8e7bf 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -4,8 +4,6 @@
 #include "string-list.h"
 #include "parse-options.h"
 
-#define PARSE_VERBOSE 0x01
-
 static struct lock_file credential_lock;
 
 static int valid_credential(struct credential *entry)
@@ -17,7 +15,7 @@ static int valid_credential(struct credential *entry)
 
 static int parse_credential_file(const char *fn,
 				  struct credential *c,
-				  int flags,
+				  int initial_line,
 				  void (*match_cb)(struct credential *),
 				  void (*other_cb)(struct strbuf *))
 {
@@ -25,7 +23,7 @@ static int parse_credential_file(const char *fn,
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
 	int found_credential = 0;
-	int lineno = 0;
+	int lineno = initial_line;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
@@ -40,8 +38,7 @@ static int parse_credential_file(const char *fn,
 		if (strchr(line.buf, '\r') ||
 			credential_from_url_gently(&entry, line.buf, 1) ||
 			!valid_credential(&entry)) {
-			if (flags & PARSE_VERBOSE)
-				warning(_("%s:%d: ignoring invalid credential"),
+			warning(_("%s:%d: ignoring invalid credential"),
 					fn, lineno);
 		} else if (credential_match(c, &entry)) {
 			found_credential = 1;
@@ -77,11 +74,14 @@ static void print_line(struct strbuf *buf)
 static void rewrite_credential_file(const char *fn, struct credential *c,
 				    struct strbuf *extra)
 {
+	int initial_line = 0;
 	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
 		die_errno("unable to get credential storage lock");
-	if (extra)
+	if (extra) {
 		print_line(extra);
-	parse_credential_file(fn, c, 0, NULL, print_line);
+		initial_line++;
+	}
+	parse_credential_file(fn, c, initial_line, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
@@ -158,8 +158,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 	struct string_list_item *fn;
 
 	for_each_string_list_item(fn, fns)
-		if (parse_credential_file(fn->string, c, PARSE_VERBOSE,
-						 print_entry, NULL))
+		if (parse_credential_file(fn->string, c, 0, print_entry, NULL))
 			return; /* Found credential */
 }
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 00608e365a..78010590f4 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -218,13 +218,27 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
 	test_line_count = 3 stderr
 '
 
-test_expect_success 'store: store succeeds silently in corrupted file' '
+test_expect_success 'store: succeeds in corrupted file but correctly warn' '
 	echo "#comment" >"$HOME/.git-credentials" &&
-	check approve store <<-\EOF &&
+	test_config credential.helper store &&
+	git credential approve <<-\EOF &&
 	url=https://user:pass@example.com
 	EOF
 	grep "https://user:pass@example.com" "$HOME/.git-credentials" &&
-	test_must_be_empty stderr
+	test_i18ngrep "git-credentials:2: ignoring invalid credential" stderr
+'
+
+test_expect_success 'erase: succeeds in corrupted file but correctly warn' '
+	cat <<-\CONFIG >"$HOME/.git-credentials" &&
+	#comment
+	https://user:pass@example.com
+	CONFIG
+	test_config credential.helper store &&
+	git credential reject <<-\EOF &&
+	url=https://example.com
+	EOF
+	! grep "https://user:pass@example.com" "$HOME/.git-credentials" &&
+	test_i18ngrep "git-credentials:1: ignoring invalid credential" stderr
 '
 
 test_done
-- 
2.26.2.3.g90bd2f7136


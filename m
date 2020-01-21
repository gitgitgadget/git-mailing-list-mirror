Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBBAC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EED322522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ht0aaSbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAUJZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:25:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53837 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgAUJZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so2127391wmc.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6r8Oku3f9vgvGC9tn6SLGOrZM/v9LvijDT/aNyMvmo=;
        b=ht0aaSbxhv8n+y4CdrRTFKyUOO8YyW6kzgZCBUWQh2ASZWb9fEy96rcf6xdSh5gDsC
         /cOXkPRp6kowQLmTYgPpBswYa88Ay4xg6Nqjhgaxygd2SkM1AHaRah+5z4DoY9FfyLKk
         urNlSxAtIh775IxAR29mP5azRJohnoXt9QMP5L2HCnoF5yuPpMSkLmC6lkvce6+5uH2l
         x8OFlHi3adC2jS6d/nBPP4w8AIp2TP9cUgu38uPCE/faofHyBXI6qzF942mzapT6ZZov
         cvt5mQgEtn4WA4EDygY4531u+fSw02IVydehZ/WTO1scb6O8GHFxJFYpgJgsz214Fidp
         EOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6r8Oku3f9vgvGC9tn6SLGOrZM/v9LvijDT/aNyMvmo=;
        b=Xk5beDY9UjK1YEK3N4VG3GVFIiRSTMsVfidTYh72pS3K6M/syvDAq+0yXCjEbB6u1G
         7fY1iwtluy6HCiygTkNLDCuM/HuoNg0lkr5nQJLayUh17oZbU+M6wEQJpGgtSbtoAlhx
         KaW1NFIBeuddMmahWw8H9lP15ITFZEfi5tp8UWape0FiaD5PNjJVwNRqd3tAz7yvR6WA
         ReeZ4bpR4aREF9JSk9E7exi1uiloid/LUTuv9eajWw5Xw8DFH0reB4yBM+dTWHbKYzr6
         W6YVHVYV2RkXVsCMS/lndQ5eJbO/hmvaWDUlgGj7ARuzVUThhdfH7i1UUvHpUdPJHFqu
         UHXg==
X-Gm-Message-State: APjAAAUtktNNx931UmokSoKS27KZZr4Pwpwgwrj6cl+910cTJMekJgRc
        NYfDm+5IcmnG8RQxvo8=
X-Google-Smtp-Source: APXvYqxfD/RGMWd+nFzrgyTjBkKl8V+qUbejmrzMMqnv/P+bCBz3qMUQyWp7sflB+ue4nPi+JgFDoQ==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr3399432wmd.127.1579598704025;
        Tue, 21 Jan 2020 01:25:04 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id g25sm4007958wmh.3.2020.01.21.01.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:25:03 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [PATCH 7/7] remote rename: gently handle remote.pushDefault config
Date:   Tue, 21 Jan 2020 10:24:55 +0100
Message-Id: <d10d3049ce9824f6925dddeb12cc130627a8c478.1579598053.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When renaming a remote with

    git remote rename X Y

Git already renames any branch.<name>.remote and branch.<name>.pushRemote
values from X to Y.

However remote.pushDefault needs a more gentle approach, as this may be
set in a non-repo configuration file. In such a case only a warning is
printed, such as:

warning: The global configuration remote.pushDefault in:
	$HOME/.gitconfig:35
now names the non-existent remote 'origin'

It is changed to remote.pushDefault = Y when set in a repo configuration
though.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Matthew, you are in Cc because of your current work 'config: allow user to
know scope of config options'. I think I'm correct to assuming an ordering
of the enum config_scope.

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Matthew Rogers <mattr94@gmail.com>
---
 builtin/remote.c  | 43 ++++++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0cb930fe00..52172e523a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -611,6 +611,29 @@ static int migrate_file(struct remote *remote)
 	return 0;
 }
 
+struct push_default_info
+{
+	struct rename_info *rename;
+	enum config_scope scope;
+	struct strbuf* origin;
+	int linenr;
+};
+
+static int config_read_push_default(const char *key, const char *value,
+	void *cb)
+{
+	struct push_default_info* info = cb;
+	if (strcmp(key, "remote.pushdefault") || strcmp(value, info->rename->old_name))
+		return 0;
+
+	info->scope = current_config_scope();
+	strbuf_reset(info->origin);
+	strbuf_addstr(info->origin, current_config_name());
+	info->linenr = current_config_line();
+
+	return 0;
+}
+
 static int mv(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -746,6 +769,26 @@ static int mv(int argc, const char **argv)
 			die(_("creating '%s' failed"), buf.buf);
 	}
 	string_list_clear(&remote_branches, 1);
+
+	struct push_default_info push_default;
+	push_default.rename = &rename;
+	push_default.scope = CONFIG_SCOPE_UNKNOWN;
+	push_default.origin = &buf;
+	git_config(config_read_push_default, &push_default);
+	if (push_default.scope >= CONFIG_SCOPE_CMDLINE)
+		; /* pass */
+	else if (push_default.scope >= CONFIG_SCOPE_REPO) {
+		git_config_set("remote.pushDefault", rename.new_name);
+	} else if (push_default.scope >= CONFIG_SCOPE_SYSTEM) {
+		/* warn */
+		warning(_("The %s configuration remote.pushDefault in:\n"
+			  "\t%s:%d\n"
+			  "now names the non-existent remote '%s'"),
+			config_scope_name(push_default.scope),
+			push_default.origin->buf, push_default.linenr,
+			rename.old_name);
+	}
+
 	return 0;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 59a1681636..3b84c7bf9b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -737,6 +737,7 @@ test_expect_success 'rename a remote' '
 	git clone one four &&
 	(
 		cd four &&
+		test_config_global remote.pushDefault origin &&
 		git config branch.master.pushRemote origin &&
 		git remote rename origin upstream &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
@@ -744,7 +745,54 @@ test_expect_success 'rename a remote' '
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
 		test "$(git config branch.master.remote)" = "upstream" &&
-		test "$(git config branch.master.pushRemote)" = "upstream"
+		test "$(git config branch.master.pushRemote)" = "upstream" &&
+		test "$(git config --global remote.pushDefault)" = "origin"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault' '
+	git clone one four.1 &&
+	(
+		cd four.1 &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config remote.pushDefault)" = "upstream"
+	)
+'
+
+test_expect_success 'rename a remote keeps global remote.pushDefault' '
+	git clone one four.2 &&
+	(
+		cd four.2 &&
+		test_config_global remote.pushDefault origin &&
+		git config remote.pushDefault other &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test "$(git config remote.pushDefault)" = "other"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
+	git clone one four.3 &&
+	(
+		cd four.3 &&
+		test_config_global remote.pushDefault other &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "other" &&
+		test "$(git config remote.pushDefault)" = "upstream"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
+	git clone one four.4 &&
+	(
+		cd four.4 &&
+		test_config_global remote.pushDefault origin &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test "$(git config remote.pushDefault)" = "upstream"
 	)
 '
 
-- 
2.24.1.497.g9abd7b20b4.dirty


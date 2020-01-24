Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D14C32771
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0D620838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OGcIF6FB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgAXJZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgAXJZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so1089482wro.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXqzKYCM93B+OFfZqNOaYnQpMhd6zfOAEEX76utp1is=;
        b=OGcIF6FBgxZYoWS4hbmmS975dqoxbVC0OJN6TriYihq6wCCO2XMVsulpSnX1eMbvO/
         d1ke3KOfXgB8cyTvbTJ5YkM0fLtmSBgQ0a4zsOa+f44u8DHFrAGUgj5+hS1Yb/XWuYvf
         eybYVi2Jxghrn3qJQoMB1M+O93I8pCQvATs3iVeeAQmy8bzRxZaPx69mzW0lIWmQLJ7J
         RmAUDHCHkn0jjp+hZxTzDyew40GAcbAF3SDz1+TXtqmAxP7ZHLJML3R+U2hRqkhyVBgN
         KjiO2rcTc+D4vuO38f9iv1k+D7fmkH3JKvkZD0eh1ZF2TW4CASYjMJ0D/wm673LzN4e5
         J4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXqzKYCM93B+OFfZqNOaYnQpMhd6zfOAEEX76utp1is=;
        b=NvG7/3ZLJCPd4INCyhFgglV9J2hoFCcidUm/H1bbv/dR4BZAl3Hk5bPVfxEXQP/tPn
         6CNYdcPE/sFsCcBjKHN2zyPJpmShjgOUNxC/V3nBbg1AcXn9KcBa/1TceN1MMbnRYQo6
         1bz3NYfCoi0tsn23ZKujYQDaNgmJnuJHtZl2G/7+bz99PUrn7wjP5Om0EmSGQHiF4jK8
         6QqKhzCb2kA+YpOrwW/9CCP9Xhr+r/QtCR8YaS1sAGDoBsxvIUdSJF5OcoI+v9ER1XKV
         FCqTD0wToev3Z65HwQpiXMyrBw78zxvIpVW7Wc9O/5JZwvM1ClcBM1TTL7wLa6TptYwn
         to0Q==
X-Gm-Message-State: APjAAAWa3elaAw85k6LN4z84UHcy84sYYodB42Q7FNKqGc/kFey093zN
        Djnfj9bRPPmMEjbxS3A=
X-Google-Smtp-Source: APXvYqwTKqhJUNYpbtb2uLKzxeVtOoAdHzsloTf9NhGRZtHM6MN8t2biCGilr+9fSBaC4B92WxCH2g==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr3105448wrs.420.1579857936613;
        Fri, 24 Jan 2020 01:25:36 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id f207sm7220789wme.9.2020.01.24.01.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:36 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [PATCH v2 7/7] remote rename/remove: gently handle remote.pushDefault config
Date:   Fri, 24 Jan 2020 10:25:27 +0100
Message-Id: <d4ea770237167779172d103af0b4032f47e373cb.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When renaming a remote with

    git remote rename X Y
    git remote remove X

Git already renames or removes any branch.<name>.remote and
branch.<name>.pushRemote configurations if their value is X.

However remote.pushDefault needs a more gentle approach, as this may be
set in a non-repo configuration file. In such a case only a warning is
printed, such as:

warning: The global configuration remote.pushDefault in:
	$HOME/.gitconfig:35
now names the non-existent remote origin

It is changed to remote.pushDefault = Y or removed when set in a repo
configuration though.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Matthew, you are in Cc because of your current work 'config: allow user to
know scope of config options'. I think I'm correct to assuming an ordering
of the enum config_scope.

Changes since v1:
 * handle also 'git remote remove'

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Matthew Rogers <mattr94@gmail.com>
---
 builtin/remote.c  | 54 +++++++++++++++++++++++++++++++++
 t/t5505-remote.sh | 76 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index a2379a14bf..7404e50c13 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -615,6 +615,55 @@ static int migrate_file(struct remote *remote)
 	return 0;
 }
 
+struct push_default_info
+{
+	const char *old_name;
+	enum config_scope scope;
+	struct strbuf origin;
+	int linenr;
+};
+
+static int config_read_push_default(const char *key, const char *value,
+	void *cb)
+{
+	struct push_default_info* info = cb;
+	if (strcmp(key, "remote.pushdefault") || strcmp(value, info->old_name))
+		return 0;
+
+	info->scope = current_config_scope();
+	strbuf_reset(&info->origin);
+	strbuf_addstr(&info->origin, current_config_name());
+	info->linenr = current_config_line();
+
+	return 0;
+}
+
+static void handle_push_default(const char* old_name, const char* new_name)
+{
+	struct push_default_info push_default = {
+		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
+	git_config(config_read_push_default, &push_default);
+	if (push_default.scope >= CONFIG_SCOPE_CMDLINE)
+		; /* pass */
+	else if (push_default.scope >= CONFIG_SCOPE_REPO) {
+		int result = git_config_set_gently("remote.pushDefault",
+						   new_name);
+		if (new_name && result && result != CONFIG_NOTHING_SET)
+			die(_("could not set '%s'"), "remote.pushDefault");
+		else if (!new_name && result && result != CONFIG_NOTHING_SET)
+			die(_("could not unset '%s'"), "remote.pushDefault");
+	} else if (push_default.scope >= CONFIG_SCOPE_SYSTEM) {
+		/* warn */
+		warning(_("The %s configuration remote.pushDefault in:\n"
+			  "\t%s:%d\n"
+			  "now names the non-existent remote '%s'"),
+			config_scope_name(push_default.scope),
+			push_default.origin.buf, push_default.linenr,
+			old_name);
+	}
+}
+
+
 static int mv(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -750,6 +799,9 @@ static int mv(int argc, const char **argv)
 			die(_("creating '%s' failed"), buf.buf);
 	}
 	string_list_clear(&remote_branches, 1);
+
+	handle_push_default(rename.old_name, rename.new_name);
+
 	return 0;
 }
 
@@ -835,6 +887,8 @@ static int rm(int argc, const char **argv)
 		strbuf_addf(&buf, "remote.%s", remote->name);
 		if (git_config_rename_section(buf.buf, NULL) < 1)
 			return error(_("Could not remove config section '%s'"), buf.buf);
+
+		handle_push_default(remote->name, NULL);
 	}
 
 	return result;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 082042b05a..bbff8c5770 100755
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
@@ -744,7 +745,42 @@ test_expect_success 'rename a remote' '
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
+		test "$(git config --local remote.pushDefault)" = "upstream"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
+	git clone one four.2 &&
+	(
+		cd four.2 &&
+		test_config_global remote.pushDefault other &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "other" &&
+		test "$(git config --local remote.pushDefault)" = "upstream"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
+	git clone one four.3 &&
+	(
+		cd four.3 &&
+		test_config_global remote.pushDefault origin &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test "$(git config --local remote.pushDefault)" = "upstream"
 	)
 '
 
@@ -790,11 +826,47 @@ test_expect_success 'remove a remote' '
 	git clone one four.five &&
 	(
 		cd four.five &&
+		test_config_global remote.pushDefault origin &&
 		git config branch.master.pushRemote origin &&
 		git remote remove origin &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test_must_fail git config branch.master.remote &&
-		test_must_fail git config branch.master.pushRemote
+		test_must_fail git config branch.master.pushRemote &&
+		test "$(git config --global remote.pushDefault)" = "origin"
+	)
+'
+
+test_expect_success 'remove a remote removes repo remote.pushDefault' '
+	git clone one four.five.1 &&
+	(
+		cd four.five.1 &&
+		git config remote.pushDefault origin &&
+		git remote remove origin &&
+		test_must_fail git config --local remote.pushDefault
+	)
+'
+
+test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
+	git clone one four.five.2 &&
+	(
+		cd four.five.2 &&
+		test_config_global remote.pushDefault other &&
+		git config remote.pushDefault origin &&
+		git remote remove origin &&
+		test "$(git config --global remote.pushDefault)" = "other" &&
+		test_must_fail git config --local remote.pushDefault
+	)
+'
+
+test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
+	git clone one four.five.3 &&
+	(
+		cd four.five.3 &&
+		test_config_global remote.pushDefault origin &&
+		git config remote.pushDefault origin &&
+		git remote remove origin &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test_must_fail git config --local remote.pushDefault
 	)
 '
 
-- 
2.24.1.497.g9abd7b20b4.dirty


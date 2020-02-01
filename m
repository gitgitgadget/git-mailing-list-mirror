Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ACBC33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 09:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C6A206E3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 09:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tIf1BQdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgBAJeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 04:34:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52506 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBAJeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 04:34:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so10630076wmc.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaoSQltLAgMyCNr7l7jF6vG8+ATV+pcTtZo2hjzPccI=;
        b=tIf1BQdx4ZU1VZF2qoGKWVvu7be89Tr9EqV+mqATBR2JybBt5Qm+n25Uya///Z3Qeo
         S13rKsVUbpMkIaNKdtnbRGeTs6ourr4mt8GqCJoD8ZAAsiNOUuzx8UbOz3nx48K4ofib
         x/y7bg74kyO7kmO83MtlBUQR4DFQkWaqmTTNwnR4oDKkmsyYM6EhWKijHoOrdS7eUWWA
         D/vkgBhfcLyqibixX447yxL4+6WkBYD3rVGXRy2U0BEGLHexp/spiBAfmSZcL6I11r10
         7igPNYZdW3TfU+cTVkx0J1fw3QEeFfhL9h0XLnSge7XffktVlr5COlbGrPuYKMYpzQ5M
         vQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaoSQltLAgMyCNr7l7jF6vG8+ATV+pcTtZo2hjzPccI=;
        b=GDFbVotYEvFSFAN42iaXQoD9hMk9r9HfgGG8zOOhKjgGeyJbSe/R3qncAvl6FW5Dhd
         S5Uptk9Tj9kfke/aXs9mOBS8kK3eepxacd/8lihP/UvuEmr3iYa9lmavww/fnyD0lZrL
         chz8h+THHFq+zflR7siqUsRXa9XLtICbjcGkciLJy0iCrHmAdTpCybG9qJrp1qy/Eb2p
         Dol4LW4BE063LuWAUkJglFx5LRvLrBNG3CpcHWu90b2qYKVDL0/0ydZXmCKqIgtSYJr/
         gfCUe0bBtQO73qYzhyFp8HqZWcEqmaLEtOH+DpCQwwMAPoFD+ahO4uwj72bIH7aCBBru
         gbsg==
X-Gm-Message-State: APjAAAW/4Y7kOqtfvX+lDGk7b/sgyJ4E/WsoVMGZJH1H5HmRL+fHpR/C
        Hsfat+g1PkUR2KJesNY=
X-Google-Smtp-Source: APXvYqxnjLha8sAHjb9eP2/+ISbqKRiy/50yzoKb2kiWmD6BCAWe5y58KnIvnTrLApfFQcLE5vR5IQ==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr17842995wmf.142.1580549651316;
        Sat, 01 Feb 2020 01:34:11 -0800 (PST)
Received: from localhost (ip-109-41-131-23.web.vodafone.de. [109.41.131.23])
        by smtp.gmail.com with ESMTPSA id e22sm10015650wme.45.2020.02.01.01.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Feb 2020 01:34:10 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [PATCH v4] remote rename/remove: gently handle remote.pushDefault config
Date:   Sat,  1 Feb 2020 10:34:09 +0100
Message-Id: <04a8673c3cb80802ee20fa4376872cb5ee464264.1580549512.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.25.0.30.g00ce2e43d4
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

Changes since v3:
 * do not use `test_config_global` in a subshell

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
index a2379a14bf..5af06b74a7 100644
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
+	if (push_default.scope >= CONFIG_SCOPE_COMMAND)
+		; /* pass */
+	else if (push_default.scope >= CONFIG_SCOPE_LOCAL) {
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
index 082042b05a..dda81b7d07 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -734,6 +734,7 @@ test_expect_success 'reject adding remote with an invalid name' '
 # the last two ones check if the config is updated.
 
 test_expect_success 'rename a remote' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four &&
 	(
 		cd four &&
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
+	test_config_global remote.pushDefault other &&
+	git clone one four.2 &&
+	(
+		cd four.2 &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "other" &&
+		test "$(git config --local remote.pushDefault)" = "upstream"
+	)
+'
+
+test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
+	test_config_global remote.pushDefault origin &&
+	git clone one four.3 &&
+	(
+		cd four.3 &&
+		git config remote.pushDefault origin &&
+		git remote rename origin upstream &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test "$(git config --local remote.pushDefault)" = "upstream"
 	)
 '
 
@@ -787,6 +823,7 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 '
 
 test_expect_success 'remove a remote' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four.five &&
 	(
 		cd four.five &&
@@ -794,7 +831,42 @@ test_expect_success 'remove a remote' '
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
+	test_config_global remote.pushDefault other &&
+	git clone one four.five.2 &&
+	(
+		cd four.five.2 &&
+		git config remote.pushDefault origin &&
+		git remote remove origin &&
+		test "$(git config --global remote.pushDefault)" = "other" &&
+		test_must_fail git config --local remote.pushDefault
+	)
+'
+
+test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
+	test_config_global remote.pushDefault origin &&
+	git clone one four.five.3 &&
+	(
+		cd four.five.3 &&
+		git config remote.pushDefault origin &&
+		git remote remove origin &&
+		test "$(git config --global remote.pushDefault)" = "origin" &&
+		test_must_fail git config --local remote.pushDefault
 	)
 '
 
-- 
2.25.0.30.g00ce2e43d4


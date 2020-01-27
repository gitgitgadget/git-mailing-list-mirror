Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EDC35242
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E2C21569
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DkwCu2sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgA0HEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgA0HEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so5804311wmb.0
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXqzKYCM93B+OFfZqNOaYnQpMhd6zfOAEEX76utp1is=;
        b=DkwCu2smse048nA4ABeLCiwGIaVRekuQCH0B1vzWT/R6+0+L9whSqgpC7TfEUP5sp7
         tz9Cj3ilpF/vH2nBn5O8GWoh0dMmpjea6B3Uq/XN07iB+KiwqMRgU9JHhWSltMYxDzAl
         ImQPpPTruIMYBRNEZFI2sBhJkZLTkgUmBKOU/bN3IY4bYGP8S9AUDcfECSsk7ZnpGg3u
         a3PWFMpzrTBVauK/aRUSgCrjy2KNgvTrV4NRgpLwLy9JUWCCv3tKCkbqooUs+hjtuXI7
         De2fGmB/y20luXNzXhDS/pqD7jDvvQfe7saM0Y4wKUoh14dCoiHepaqZQgKkSmEEaN/z
         m6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXqzKYCM93B+OFfZqNOaYnQpMhd6zfOAEEX76utp1is=;
        b=E2NoLrsTtaViHlc9mocUOYdfnEi8MQV6MzvLgT4NZhvuHTD7S34Z/yzyE6tATgm446
         NJtutubF43kP1R8jP/l214Pc+fTfO1+ZiSIoVR+fRVOuxAyAR20cZBX5OmWDQxB54gZL
         XbnKHFEThpHKlxmPjZ9BkCckUTXakVl6dZd0xr+ynfDfP3EL4/j07889nZMKb+URPWLv
         Ih2auUvUUwhMX0u7Gx+vyW/s/rvlgbzxARceUR8IMVkMGbT9NCi6Lfkx/UPG9E1jUDmo
         d4gY2vlNvzPqU9fTqabjhTHBvAlDuqPX9/eKHSLoa9hRS1hScErTtgcvVfnjzz1ycd/d
         a9nQ==
X-Gm-Message-State: APjAAAXU5ncKvRPzxy8H7rDNK0N5uwbqGIYrJXYXBxuKSqa44duNpyMW
        7IUkzXgfTqa8G/BKny0=
X-Google-Smtp-Source: APXvYqzhirEOGHkacuTCp/UBX5T1D7Q56XDp712TxGKZryLeOu5QPLWx4PBhuZppzCM/Y8cplsZMsA==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr12334749wma.139.1580108680472;
        Sun, 26 Jan 2020 23:04:40 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id t1sm18282701wma.43.2020.01.26.23.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:40 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [PATCH v2 6/6] remote rename/remove: gently handle remote.pushDefault config
Date:   Mon, 27 Jan 2020 08:04:32 +0100
Message-Id: <029dd071038db1daf590d5224076c089cfd060bc.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
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


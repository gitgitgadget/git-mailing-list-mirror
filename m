Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E1C55178
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250C4217A0
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXzrK3ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781946AbgJZOsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 10:48:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43867 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781912AbgJZOsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 10:48:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so12917210wrp.10
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2k/+gsqm9Q/0lApXw0OETXkWpBpfTzHtG+oeGupXbI=;
        b=rXzrK3ct2sSUvdLPY1phCEQnMzM7QBfcYyWJ9CHT0Bccj1/bxXSuAe1Ypq42eNOnVx
         fSBLl1Po1ac9jWEvUkYNBzPvmYDuYUWhx2uPLlEwjC6ud9kdYuKQiyDeKZR+clRItDP2
         gk2zwgOODcTOh8c/vsOvSDGNT75SV6hexoYxb43U+iJuWh/vChJCQiK+kWC3BPkTglj2
         1hjFKd/UtLJ0dvMw73NcGBTlpuKc00+puq2uSzlbnG95V/b/ygFdcM6JV57+6XK1183x
         VlTFatoFuvOK787PwyZHWlUFE8jRvssjLp57lY4UtHvFPoeZPCiInIxiCebw3QmAxf+W
         oSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2k/+gsqm9Q/0lApXw0OETXkWpBpfTzHtG+oeGupXbI=;
        b=XU+pbQTurE5sff0Zf8v1ATXxTXa4nV1DMCoMFvIKgxQ4I1TEQBxRqh+Qq4vigf+xCi
         e5wwts/a+9sVPpz/wxYEyKcPebpG6yytz+LZgKxYASQwI4RT3+3mEgAMPXGcyknQC3om
         SRDcqVsW2zd6jfGY+IndzEJ62tlsDHJFa5iRjuFUlX+4/P2QzsPkysfr3hZd1ItY3Nue
         vW2//t28rQ7g2pkOBwNy6FILdLstgDBE5xg+HEP5ywOPlC3F0aqHEIR73QvzVTePtTjb
         qXG6L9lAvKnvvf418mtbX9pNY5vd9x9y797u9mwhVkc5xKOjefrORlphPbMxGBrknLjk
         CeeA==
X-Gm-Message-State: AOAM533orNsMPInjn7yRClJ4C9eaqwDCni92cMLMqXOwSXl/k1efpnr4
        ZlIFfqyzyQclID2dOgOWi/248+geCyY=
X-Google-Smtp-Source: ABdhPJzXyY6PswR63uuW/vEssKk3/MwnqfTqOZYewKlzgHgYTFqfCXvbIQHCeaBumc5fPkpQmAEdoQ==
X-Received: by 2002:adf:c443:: with SMTP id a3mr11921063wrg.143.1603723717789;
        Mon, 26 Oct 2020 07:48:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m8sm22208147wrw.17.2020.10.26.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:48:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] remote: add meaningful exit code on missing/existing
Date:   Mon, 26 Oct 2020 15:48:25 +0100
Message-Id: <20201026144825.26537-1-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the exit code for the likes of "git remote add/rename" to exit
with 2 if the remote in question doesn't exist, and 3 if it
does. Before we'd just die() and exit with the general 128 exit code.

This changes the output message from e.g.:

    fatal: remote origin already exists.

To:

    error: remote origin already exists.

Which I believe is a feature, since we generally use "fatal" for the
generic errors, and "error" for the more specific ones with a custom
exit code, but this part of the change may break code that already
relies on stderr parsing (not that we ever supported that...).

The motivation for this is a discussion around some code in GitLab's
gitaly which wanted to check this, and had to parse stderr to do so:
https://gitlab.com/gitlab-org/gitaly/-/merge_requests/2695

It's worth noting as an aside that a method of checking this that
doesn't rely on that is to check with "git config" whether the value
in question does or doesn't exist. That introduces a TOCTOU race
condition, but on the other hand this code (e.g. "git remote add")
already has a TOCTOU race.

We go through the config.lock for the actual setting of the config,
but the pseudocode logic is:

    read_config();
    check_config_and_arg_sanity();
    save_config();

So e.g. if a sleep() is added right after the remote_is_configured()
check in add() we'll clobber rermote.NAME.url, and add
another (usually duplicate) remote.NAME.fetch entry (and other values,
depending on invocation).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-remote.txt | 11 ++++++++++
 builtin/remote.c             | 42 ++++++++++++++++++++++++------------
 t/t5505-remote.sh            | 16 +++++++-------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9659abbf8e..c1f1355f52 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -203,6 +203,17 @@ The remote configuration is achieved using the `remote.origin.url` and
 `remote.origin.fetch` configuration variables.  (See
 linkgit:git-config[1]).
 
+EXIT STATUS
+-----------
+
+On success, the exit status is `0`.
+
+When subcommands such as 'add', 'rename' and 'remove' can't find the
+remote in question the exit status is `2`, when the remote already
+exists the exit status is `3`.
+
+On any other error, the exit status may be any other non-zero value.
+
 EXAMPLES
 --------
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 64b4b551eb..c1828ca7d2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -191,8 +191,10 @@ static int add(int argc, const char **argv)
 	url = argv[1];
 
 	remote = remote_get(name);
-	if (remote_is_configured(remote, 1))
-		die(_("remote %s already exists."), name);
+	if (remote_is_configured(remote, 1)) {
+		error(_("remote %s already exists."), name);
+		exit(3);
+	}
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 	if (!valid_fetch_refspec(buf2.buf))
@@ -686,15 +688,19 @@ static int mv(int argc, const char **argv)
 	rename.remote_branches = &remote_branches;
 
 	oldremote = remote_get(rename.old_name);
-	if (!remote_is_configured(oldremote, 1))
-		die(_("No such remote: '%s'"), rename.old_name);
+	if (!remote_is_configured(oldremote, 1)) {
+		error(_("No such remote: '%s'"), rename.old_name);
+		exit(2);
+	}
 
 	if (!strcmp(rename.old_name, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new_name);
-	if (remote_is_configured(newremote, 1))
-		die(_("remote %s already exists."), rename.new_name);
+	if (remote_is_configured(newremote, 1)) {
+		error(_("remote %s already exists."), rename.new_name);
+		exit(3);
+	}
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new_name);
 	if (!valid_fetch_refspec(buf.buf))
@@ -829,8 +835,10 @@ static int rm(int argc, const char **argv)
 		usage_with_options(builtin_remote_rm_usage, options);
 
 	remote = remote_get(argv[1]);
-	if (!remote_is_configured(remote, 1))
-		die(_("No such remote: '%s'"), argv[1]);
+	if (!remote_is_configured(remote, 1)) {
+		error(_("No such remote: '%s'"), argv[1]);
+		exit(2);
+	}
 
 	known_remotes.to_delete = remote;
 	for_each_remote(add_known_remote, &known_remotes);
@@ -1511,8 +1519,10 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	strbuf_addf(&key, "remote.%s.fetch", remotename);
 
 	remote = remote_get(remotename);
-	if (!remote_is_configured(remote, 1))
-		die(_("No such remote '%s'"), remotename);
+	if (!remote_is_configured(remote, 1)) {
+		error(_("No such remote '%s'"), remotename);
+		exit(2);
+	}
 
 	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
 		strbuf_release(&key);
@@ -1565,8 +1575,10 @@ static int get_url(int argc, const char **argv)
 	remotename = argv[0];
 
 	remote = remote_get(remotename);
-	if (!remote_is_configured(remote, 1))
-		die(_("No such remote '%s'"), remotename);
+	if (!remote_is_configured(remote, 1)) {
+		error(_("No such remote '%s'"), remotename);
+		exit(2);
+	}
 
 	url_nr = 0;
 	if (push_mode) {
@@ -1633,8 +1645,10 @@ static int set_url(int argc, const char **argv)
 		oldurl = newurl;
 
 	remote = remote_get(remotename);
-	if (!remote_is_configured(remote, 1))
-		die(_("No such remote '%s'"), remotename);
+	if (!remote_is_configured(remote, 1)) {
+		error(_("No such remote '%s'"), remotename);
+		exit(2);
+	}
 
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8d62edd98b..c99659d39e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -145,8 +145,8 @@ test_expect_success 'remove remote protects local branches' '
 test_expect_success 'remove errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: '\''foo'\''" >expect &&
-		test_must_fail git remote rm foo 2>actual &&
+		echo "error: No such remote: '\''foo'\''" >expect &&
+		test_expect_code 2 git remote rm foo 2>actual &&
 		test_i18ncmp expect actual
 	)
 '
@@ -173,24 +173,24 @@ test_expect_success 'remove remote with a branch without configured merge' '
 test_expect_success 'rename errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: '\''foo'\''" >expect &&
-		test_must_fail git remote rename foo bar 2>actual &&
+		echo "error: No such remote: '\''foo'\''" >expect &&
+		test_expect_code 2 git remote rename foo bar 2>actual &&
 		test_i18ncmp expect actual
 	)
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.foo.vcs bar &&
-	echo "fatal: remote foo already exists." >expect &&
-	test_must_fail git remote add foo bar 2>actual &&
+	echo "error: remote foo already exists." >expect &&
+	test_expect_code 3 git remote add foo bar 2>actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.foo.vcs bar &&
 	test_config remote.bar.vcs bar &&
-	echo "fatal: remote bar already exists." >expect &&
-	test_must_fail git remote rename foo bar 2>actual &&
+	echo "error: remote bar already exists." >expect &&
+	test_expect_code 3 git remote rename foo bar 2>actual &&
 	test_i18ncmp expect actual
 '
 
-- 
2.28.0.297.g1956fa8f8d


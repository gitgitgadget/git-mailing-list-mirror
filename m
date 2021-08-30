Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A6EC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A256023E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhH3OmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhH3OmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:42:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12771C061760
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:41:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso151143wmi.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykuOVRMTejJR5cZ6c0ASyp6GkftqO7dCpWmq8XOyd3w=;
        b=j3U2/pQwppaCYKc0BtM5OePEPt5w/lk4WHPRFgJsid3IK3M9Fuy6YnYHdRLPeWuqhv
         fTzYr55fmt0DaOhoziVK9BmUnNbffhxxKINmNJmZ1FMiwV1PHXzK+miZ/3aeRZlsWInd
         ltktQozLRBa9TcK1mGhGFsJuFOU/yjbieQeGx/rmclJVEwsfd5UGtfOLQk7jwHmda/Rk
         Ede58ExuhKy68knD5vWKCCy2dfuW4cb8egfVuIHlWoiSPZEx5IN3XNTBgG0jZM+34Q03
         YcisOYJNEMs3H07fGPtrhCummU3fRE/gw5avuqLVpsRYLJR6l/qQEslWUZ7tAIc2y8sM
         swGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykuOVRMTejJR5cZ6c0ASyp6GkftqO7dCpWmq8XOyd3w=;
        b=NdSWrE4Ynrrwq52A1c1bB9SqlGrNG3lhIWkUukbdLTZqhIwTkgURJv1K+GdLrtHdOy
         W4HimgTe15boc0S9iwp/QCs5UBMY9kX29QSusY5kY0r9bX0hqCe1u57klzXTXkcyB0kB
         WwxrITb4JantQvNuAMJIbBOxp0cGY1Bd1y51iXiwAd5VonWwnK+kK8AaL2TKzc6NNSY+
         UuCc95+1XsJaJJ/KaywfddbEKBCM+BSCAygbm+ZzMsf3aC3NtypdrdX5FMkL0oWlc/5k
         JIx4k1n8Txu34siVlXfY7wPc1DsAESEKZg0ahpYz4AlycO+J5qZmrKHlp4HDlNMi5lok
         0nNg==
X-Gm-Message-State: AOAM530Nr9VIHzVBhEZgZzolNIMvf8wNj67AJS3WUyzEsZ3JI0VkBl1X
        zF+lC4ElYi78XK0xALiWnlnnEQQ6WTUTcUtf
X-Google-Smtp-Source: ABdhPJwY2sgd5oFEgI8WhL8NhiVT1ovkP5O89gxDljQhwGZ2C8iKeXFgl+9gB8zgUAKR/nxElHPoCg==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr20683397wmj.82.1630334482365;
        Mon, 30 Aug 2021 07:41:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm15706299wrs.60.2021.08.30.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:41:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        =?UTF-8?q?Jan=20Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] pull, fetch: fix segfault in --set-upstream option
Date:   Mon, 30 Aug 2021 16:41:18 +0200
Message-Id: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.741.g4db85f1eb27
In-Reply-To: <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
References: <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --set-upstream option added in
24bc1a12926 (pull, fetch: add --set-upstream option, 2019-08-19) added
in v2.24.0.

The code added there did not do the same checking we do for "git
branch" itself since 8efb8899cfe (branch: segfault fixes and
validation, 2013-02-23), which in turn fixed the same sort of segfault
I'm fixing now in "git branch --set-upstream-to", see
6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).

The warning message I'm adding here is an amalgamation of the error
added for "git branch" in 8efb8899cfe, and the error output
install_branch_config() itself emits, i.e. it trims "refs/heads/" from
the name and says "branch X on remote", not "branch refs/heads/X on
remote".

I think it would make more sense to simply die() here, but in the
other checks for --set-upstream added in 24bc1a12926 we issue a
warning() instead. Let's do the same here for consistency for now.

There was an earlier submitted alternate way of fixing this in [1],
due to that patch breaking threading with the original report at [2] I
didn't notice it before authoring this version. I think the more
detailed warning message here is better, and we should also have tests
for this behavior.

1. https://lore.kernel.org/git/20210706162238.575988-1-clemens@endorphin.org/
2. https://lore.kernel.org/git/CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com/

Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
Reported-by: Jan Pokorný <poki@fnusa.cz>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A v3 that functionally behaves the same way, but uses a more idiomatic
way of calling skip_prefix() to strip the "refs/heads/*" prefix, if
present.

Range-diff against v2:
1:  9e846b76959 ! 1:  68899471206 pull, fetch: fix segfault in --set-upstream option
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		}
      		if (source_ref) {
     +			if (!branch) {
    -+				const char *shortname = NULL;
    -+				if (!skip_prefix(source_ref->name,
    -+						 "refs/heads/", &shortname))
    -+					shortname = source_ref->name;
    ++				const char *shortname = source_ref->name;
    ++				skip_prefix(shortname, "refs/heads/", &shortname);
    ++
     +				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
     +					  "it does not point to any branch."),
     +					shortname, transport->remote->name);

 builtin/fetch.c         | 10 ++++++++++
 t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbdc..28fa168133a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1625,6 +1625,16 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 		if (source_ref) {
+			if (!branch) {
+				const char *shortname = source_ref->name;
+				skip_prefix(shortname, "refs/heads/", &shortname);
+
+				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
+					  "it does not point to any branch."),
+					shortname, transport->remote->name);
+				goto skip;
+			}
+
 			if (!strcmp(source_ref->name, "HEAD") ||
 			    starts_with(source_ref->name, "refs/heads/"))
 				install_branch_config(0,
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index b1d614ce18c..7d12ceff702 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -91,6 +91,17 @@ test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	check_config_missing other2
 '
 
+test_expect_success 'fetch --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git fetch --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 # tests for pull --set-upstream
 
 test_expect_success 'setup bare parent pull' '
@@ -178,4 +189,15 @@ test_expect_success 'pull --set-upstream with valid URL and branch sets branch'
 	check_config_missing other2
 '
 
+test_expect_success 'pull --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	git pull --set-upstream upstream main 2>actual.raw &&
+	grep ^warning: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.741.g4db85f1eb27


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC8C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E64613B3
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhHWM5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhHWM5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:57:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5060C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:56:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f10so10486774wml.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8g51h9XeJRoYEGVdOhezq1jZph3mtk7q9wR7ZTMmLA=;
        b=ngESB51pOkVvl4+8p3CB9sLs/HpKwIvhBN+xXmkLMlcsYy3rb4vzZPKeV18OC8WqNw
         W5mueA09ZyAjAjkHLySnywYNM0nFjJGMn2hzYG+GFmksXa9Uy3PZQrzmCum7eo+zYYb5
         XBBwo2qwvaBzHG9wytnLoyK4gOFhVwK4pD+PX7CggYoXW0Lb7ga7V3ifC/0l3iHVA80N
         1qha8E1GRInm+wPPPoIa4MNolMVUvIfZxTLFu807U7N1MsGKt7aBameteSoXdJocJlCq
         5IDJL60YXDWpkywU9UtzDQgP+kiwA/eLuoiuaPkVvMEHYU8RiwjrHoicw+OV6dmupeFl
         XVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8g51h9XeJRoYEGVdOhezq1jZph3mtk7q9wR7ZTMmLA=;
        b=W80INOkBTTRhgBemJ0ZS5dUu1SiMshmoOeNntfPsxZ8CwJbHNEEQlg3lM3QtIYHoVL
         F002MrUyjpBf4lDw4sfsLjYm8LdvdQfzAum1vEcsrCU1tLPYGM187vPWz1ChfrpNfC4z
         XriefP9AgJToGePtg/1VTCXwMOLXO4MkNVLYC7cQpRZIjMM9+oVzTS9fQIC8N8gOoKRo
         39bKRdMAzIpzRlgA2G9OSO+62dF/1NCoq2SoguSRk8eyH/Z2gkFYhoLUvbA+IFEifOX2
         xtrggfjhxE4bF7oFdoeCQVFox4n5idnMCN7CPmsZuzJUAC6qXRijVeUpnzIKba1+0Hsl
         yT3w==
X-Gm-Message-State: AOAM530ZbuNspgJTm/jjMVgiiDEng7xaj+yPDJt3ko3ts/80uWV0GfcD
        rrBfRhaBhFVFCSaDj+MHp2CH1l8fcsjoJLUY
X-Google-Smtp-Source: ABdhPJx6v1/nxjnhwM5NOE95/4mAmoa16RBkELNm9ogd8NAXJMUpSJeArwT0ctdCNK3G+3m7KKN3lw==
X-Received: by 2002:a05:600c:6c5:: with SMTP id b5mr6228701wmn.70.1629723399182;
        Mon, 23 Aug 2021 05:56:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm12347091wms.33.2021.08.23.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:56:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        =?UTF-8?q?Jan=20Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] pull, fetch: fix segfault in --set-upstream option
Date:   Mon, 23 Aug 2021 14:56:32 +0200
Message-Id: <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
References: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
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

A proposed replacement of cf/fetch-set-upstream-while-detached which
as noted in What's Cooking has been languishing for a while. I changed
the die() in my version to a warning() as suggested by Junio & updated
the test and commit message accordingly.

Range-diff against v1:
1:  2d8f3e59e1f ! 1:  9e846b76959 pull, fetch: fix segfault in --set-upstream option
    @@ Commit message
         I'm fixing now in "git branch --set-upstream-to", see
         6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).
     
    -    The error message I'm adding here is an amalgamation of the error
    +    The warning message I'm adding here is an amalgamation of the error
         added for "git branch" in 8efb8899cfe, and the error output
         install_branch_config() itself emits, i.e. it trims "refs/heads/" from
         the name and says "branch X on remote", not "branch refs/heads/X on
         remote".
     
    +    I think it would make more sense to simply die() here, but in the
    +    other checks for --set-upstream added in 24bc1a12926 we issue a
    +    warning() instead. Let's do the same here for consistency for now.
    +
    +    There was an earlier submitted alternate way of fixing this in [1],
    +    due to that patch breaking threading with the original report at [2] I
    +    didn't notice it before authoring this version. I think the more
    +    detailed warning message here is better, and we should also have tests
    +    for this behavior.
    +
    +    1. https://lore.kernel.org/git/20210706162238.575988-1-clemens@endorphin.org/
    +    2. https://lore.kernel.org/git/CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com/
    +
         Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
         Reported-by: Jan Pokorný <poki@fnusa.cz>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +				if (!skip_prefix(source_ref->name,
     +						 "refs/heads/", &shortname))
     +					shortname = source_ref->name;
    -+				    
    -+				die(_("could not set upstream of HEAD to '%s' from '%s' when "
    -+				      "it does not point to any branch."),
    -+				    shortname, transport->remote->name);
    ++				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
    ++					  "it does not point to any branch."),
    ++					shortname, transport->remote->name);
    ++				goto skip;
     +			}
     +
      			if (!strcmp(source_ref->name, "HEAD") ||
    @@ t/t5553-set-upstream.sh: test_expect_success 'fetch --set-upstream with valid UR
     +	git checkout HEAD^0 &&
     +	test_when_finished "git checkout -" &&
     +	cat >expect <<-\EOF &&
    -+	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
    ++	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
     +	EOF
    -+	test_must_fail git fetch --set-upstream upstream main 2>actual.raw &&
    -+	grep ^fatal: actual.raw >actual &&
    ++	git fetch --set-upstream upstream main 2>actual.raw &&
    ++	grep ^warning: actual.raw >actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t5553-set-upstream.sh: test_expect_success 'pull --set-upstream with valid URL
     +	git checkout HEAD^0 &&
     +	test_when_finished "git checkout -" &&
     +	cat >expect <<-\EOF &&
    -+	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
    ++	warning: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
     +	EOF
    -+	test_must_fail git pull --set-upstream upstream main 2>actual.raw &&
    -+	grep ^fatal: actual.raw >actual &&
    ++	git pull --set-upstream upstream main 2>actual.raw &&
    ++	grep ^warning: actual.raw >actual &&
     +	test_cmp expect actual
     +'
     +

 builtin/fetch.c         | 11 +++++++++++
 t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df1..ca487edd805 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1623,6 +1623,17 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 		if (source_ref) {
+			if (!branch) {
+				const char *shortname = NULL;
+				if (!skip_prefix(source_ref->name,
+						 "refs/heads/", &shortname))
+					shortname = source_ref->name;
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
2.33.0.662.gbc81f8cbdca


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E14C43219
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05C123142
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404842AbhASOv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393002AbhASNAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 08:00:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B7C0613CF
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c128so1870184wme.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+MVtPk2arwvhNzUei69PICMUC2xYvgIOhPdbgPEhrDo=;
        b=UAUo1tWo9F8smEG7KVI83GLUK7Sb9Ww2Q1uCIMNV5QihcpVQOmsvyWsL+O+X7nO50v
         IE4Hs9x3jxY3Jdy1xF58Ph3XmCGAKe1pPbByRIRCRfp1Gm7NLyGQswO5uPEUm1b2FHFD
         byQmYd3AmChYmz+XRnQyDyYCnN/rnmALvgnfkRnaxUTcqXjOjsYiikamS+HVyw4a94r2
         kL3bCTJ3LS7hkcvChJXmxGipFpkfL8C9lQ9lqboNp4vJATTH4aCrNYXVFyHiAxuWUPXd
         gXR1rnm3wG4pgsYGFixLji8yI4IWODb7zCvqbsO6PdQyqqvG1UvEW2p4FbN6sk3Jdy8m
         TRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+MVtPk2arwvhNzUei69PICMUC2xYvgIOhPdbgPEhrDo=;
        b=YIEkUiW3NzPdTEx/fb48xMrV68SDRNbDODQzB8Dgs/6cZkAt78m9iezmkH+eqnh/bb
         mPIDdoa29ASzv6PbL1cIvE1OXRNg0/eFi7JeMbfirEiB27S2bKJQO2s1XhHRm9k0ekI6
         XIS4jZtyFdR+iRW4ioSUeVzn5GgxFO9/H3vo4+yQ3HtLTuuPChZI41lwfyhfE0sr50Pp
         2VtIPoQXNcFhs69lhIpdmrFiXCUPN2K4tox9fg8GEDXCQH272GGL6FHYDXRTC0k7akmH
         BBwHLl6dKO3F5noEXblDnTPralGbnrEdC8DOC/B0x64M+C7nsI5/5Bbx0H2Iyoq566Fd
         d4gA==
X-Gm-Message-State: AOAM533hfk623SgdqsbUOBuxLsSsdaxWkth4FMCxwnnMfYKo/2ReC3Bh
        lzFZZpmTkOawt4MNyVRv4smZjUxfohI=
X-Google-Smtp-Source: ABdhPJzQw2gWxzokCNKI8+6sZAPVEKpMh2qhOSNQJC8d+SMJyW2tj4GHuWsWG5UlDVd5vZhl0nlmZQ==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr2724204wmd.121.1611060727006;
        Tue, 19 Jan 2021 04:52:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm4161447wmq.3.2021.01.19.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:52:06 -0800 (PST)
Message-Id: <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1611060724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
        <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 12:52:03 +0000
Subject: [PATCH v2 1/2] maintenance: set log.excludeDecoration durin prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'prefetch' task fetches refs from all remotes and places them in the
refs/prefetch/<remote>/ refspace. As this task is intended to run in the
background, this allows users to keep their local data very close to the
remote servers' data while not updating the users' understanding of the
remote refs in refs/remotes/<remote>/.

However, this can clutter 'git log' decorations with copies of the refs
with the full name 'refs/prefetch/<remote>/<branch>'.

The log.excludeDecoration config option was added in a6be5e67 (log: add
log.excludeDecoration config option, 2020-05-16) for exactly this
purpose.

Ensure we set this only for users that would benefit from it by
assigning it at the beginning of the prefetch task. Other alternatives
would be during 'git maintenance register' or 'git maintenance start',
but those might assign the config even when the prefetch task is
disabled by existing config. Further, users could run 'git maintenance
run --task=prefetch' using their own scripting or scheduling. This
provides the best coverage to automatically update the config when
valuable.

It is improbable, but possible, that users might want to run the
prefetch task _and_ see these refs in their log decorations. This seems
incredibly unlikely to me, but users can always opt-in on a
command-by-command basis using --decorate-refs=refs/prefetch/.

Test that this works in a few cases. In particular, ensure that our
assignment of log.excludeDecoration=refs/prefetch/ is additive to other
existing exclusions. Further, ensure we do not add multiple copies in
multiple runs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b315b2ad588..54bae7f0c4c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -897,6 +897,12 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 	struct string_list_item *item;
 	struct string_list remotes = STRING_LIST_INIT_DUP;
 
+	git_config_set_multivar_gently("log.excludedecoration",
+					"refs/prefetch/",
+					"refs/prefetch/",
+					CONFIG_FLAGS_FIXED_VALUE |
+					CONFIG_FLAGS_MULTI_REPLACE);
+
 	if (for_each_remote(append_remote, &remotes)) {
 		error(_("failed to fill remotes"));
 		result = 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1074009cc05..f9031cbb44b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -149,7 +149,31 @@ test_expect_success 'prefetch multiple remotes' '
 	git log prefetch/remote2/two &&
 	git fetch --all &&
 	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
-	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
+	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
+
+	test_cmp_config refs/prefetch/ log.excludedecoration &&
+	git log --oneline --decorate --all >log &&
+	! grep "prefetch" log
+'
+
+test_expect_success 'prefetch and existing log.excludeDecoration values' '
+	git config --unset-all log.excludeDecoration &&
+	git config log.excludeDecoration refs/remotes/remote1/ &&
+	git maintenance run --task=prefetch &&
+
+	git config --get-all log.excludeDecoration >out &&
+	grep refs/remotes/remote1/ out &&
+	grep refs/prefetch/ out &&
+
+	git log --oneline --decorate --all >log &&
+	! grep "prefetch" log &&
+	! grep "remote1" log &&
+	grep "remote2" log &&
+
+	# a second run does not change the config
+	git maintenance run --task=prefetch &&
+	git log --oneline --decorate --all >log2 &&
+	test_cmp log log2
 '
 
 test_expect_success 'loose-objects task' '
-- 
gitgitgadget


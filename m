Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89606C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356298AbiBULVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356247AbiBULUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956FEB2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o34so9305190wms.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2SYDa+rcqivkvUif5+HUoX5QbBb/oga7GCGFMYTLewY=;
        b=ZjzGkz3rPo+wcUv/AP3HcP8GjTCpUalIc886j2eaVIUemkRrTNS6e1/feTw6BqPpTz
         ZcX3JYCHTCwLQvHM7fCWnFbY3KSvSFvClzQwS3GHOwfrviDa1rQvvj0zvkJS3K6QL28m
         dPFk3b3sO+04dcDgaiPrlP8zjKIPJPWnkw8eH99ML4yhqCnDrnMbv6b3dXKLusaivGtN
         ctbFmpeKZqNyZPvQyyRlYgwuvCdm0YvSKJraXT0xJ5SVMSHNHxSfruTe2zIxeogG8n/t
         U+k9wN1Sim83IWQhcHKv+6W1Chs6ScQNetBrqEEdkm41d87mC81SFiz+JJ6fwZEVHSNn
         ZMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2SYDa+rcqivkvUif5+HUoX5QbBb/oga7GCGFMYTLewY=;
        b=N3E4SNl5dZrfRkvk1yEeWfRPG8AsvWMmVWhx9/HrQj4zHT+DHRzU0NgTmx/ndRbKS2
         VolwehYy4+Fhl13p4MZ93bje6BusxSflCCeiJGi3wQcheCvHNuToPWdRlISPoQjLNKvs
         dXqiSZWdLSs6nm7kU6wONq8awy5okvojqSbGXEPsnl4wpwXGIh56o7x8xNM1pEuJZhYk
         3Cik+nBeAS/ukjk01lhC1fxln5mP81CBNSHpzINPQBRIXmTrIQOFzLlbjjySSXYJy7+5
         ZxVbmyHE4BOYAo89fP8VU3gE3ECgLEjecS5hmjdHGq7Rlnv3GM9ltQQZ/s+PovBADTvM
         5qFA==
X-Gm-Message-State: AOAM533vj/gttF8ed+m3ggchLzTrN1GwXsaqFCUI0PpugpBMgDPbXhWx
        Umsgwb+cIQIHb2KiBBTXbMpUMZQ3lvo=
X-Google-Smtp-Source: ABdhPJw4C6g0R0LLihTGmqclA2fEHEom60bEB+f76JlDkSN2q2iUUeJL+GlwMnHki63idvDk+PRcCg==
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id h24-20020a7bc938000000b0037bfdaa2749mr20975127wml.88.1645441860025;
        Mon, 21 Feb 2022 03:11:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b0037c32873258sm7204329wmi.2.2022.02.21.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:59 -0800 (PST)
Message-Id: <1c3ec1654225ff090c194fa646f974082bd9c944.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:52 +0000
Subject: [PATCH 5/7] rebase --apply: make reflog messages match rebase --merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The apply backend creates slightly different reflog messages to the
merge backend when starting and finishing a rebase and when picking
commits. The choice of backend is really an implementation detail so
it is confusing to have the same command create different messages
depending on which backend is selected. Change the apply backend so
the reflog messages from the two backends match as closely as
possible. Note that there is still a difference when committing a
conflict resolution - the merge backend will use "(continue)" rather
than "(pick)" in that case as it does not know which command created
the conflict that it is committing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 9 +++++----
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e50361fc2a9..678339c7bf7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -580,10 +580,10 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
@@ -613,7 +613,8 @@ static int run_am(struct rebase_options *opts)
 
 	am.git_cmd = 1;
 	strvec_push(&am.args, "am");
-
+	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
+		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
 	if (opts->action && !strcmp("continue", opts->action)) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1763,7 +1764,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s: checkout %s",
+	strbuf_addf(&msg, "%s (start): checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head,
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index bb2a4949abc..5c6cd9af3bc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/(finish)/finished/; s/ ([^)]*)//'
+		sed 's/(continue)/(pick)/'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget


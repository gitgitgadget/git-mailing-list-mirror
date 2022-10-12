Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F5C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJLJC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJLJCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35BB7EF4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so25216982wrp.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FipWHUdK7Qq0SoGArMNe6aQYQGaFlVLkfb6pHN+PQak=;
        b=SaN+nhgublg0lEanDpdvZyhV679tQMjcn6+MrCAySULfkBWoPrbQDcKVz1zSxA9bwY
         fmHwyMo0elz4q2vdVbW6AUffBInXaHedF9nXtK3Nr0tspsC1A1fz4qJLubdY11L09nGK
         UMdkY3f8MNAIGWbkr03jhHUf/vCIF79AXfcAY6ibg4ucVyDfxavD0NSsGHRDSP18Y9dI
         LaH4yKWICOFUTjEqOp19Y/AutsIZpti5pIJBdC6fFuQRrv9GhmJFRBqiaM6cvx7vcbUi
         yzJQutnY4HzOIEAZFvXYESE3/wvTAerV0x9b2+xsCjMwMF3dW/gfLYFT5Xv2MeHMuJSx
         BOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FipWHUdK7Qq0SoGArMNe6aQYQGaFlVLkfb6pHN+PQak=;
        b=7SW6xt1THOC9xGuZgfrwbr8u+h/Ah5ppmv301jl0mCxnwnkBXT0lsfeq11CIMbCCv9
         1S4hxf32nF1iMi2Bq5n+bBwqa39cCdFFJdNgjVvbJOz7m+8KSJKSSDc+ALBCQWMYi2bY
         d7N/JuXQtWsUppOQ1YW6zS7VTBU+O4ha1353IIUhyb5PLxuRpyU9ZoV10ZGXG/zVRVkA
         ZsvpEHsHYhtS1JykQlT3sDTbtOdL1+q2IK0gMYoIejCuR/O68K0XuhvDZ5gQUKNXFt+M
         DSqGU3+d7U1v2+Z/q2/y8sUWjW6bDjx++Z7G+dHMN01UmUtXWo6PeZJLjgzw5lBdkTW2
         2p0g==
X-Gm-Message-State: ACrzQf0XFbphcHllkIL1tfEk9bx/HhkxEEu+9a/5++0BQeBIl+ZGDFqJ
        QXABAm2i7gMFB8lb0/g+jdUjDfYbUH092w==
X-Google-Smtp-Source: AMsMyM625zStDEjHIKLNlVE3akVgL9m5TgS1hFTx3+2U6S0KEmN7/7dSApUxpvO27Wcq+qwfyico/w==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr18384896wri.36.1665565306579;
        Wed, 12 Oct 2022 02:01:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/22] run-command.c: use C99 "for (TYPE VAR = ..." syntax where useful
Date:   Wed, 12 Oct 2022 11:01:16 +0200
Message-Id: <patch-v2-08.22-279b0430c5d-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code in run-command.c where the "i" iteration variable is
being compared to an unsigned type, or where it's being shadowed.

In a subsequent commit the type of the "n" variable will be changed,
this also helps to avoid some of the warnings we've had under
"DEVOPTS=extra-all" since 8d133a4653a (strvec: use size_t to store nr
and alloc, 2021-09-11).

Per the thread ending at [1] we already have this C99 syntax in the
v2.38.0 release, per 6563706568b (CodingGuidelines: give deadline for
"for (int i = 0; ...", 2022-03-30) we should re-visit the wider use of
this syntax for November 2022, meaning within the window of v2.39.0.

As of writing it's earlier than that deadline and per [1] we want to
"avoid open[ing] the floodgate and deliberately add more [this C99
syntax]". But in this case the use of the syntax solves a real problem
of conflating types, which we'd otherwise need to avoid by using
differently named iteration variables (and the associated larger
refactoring).

1. https://lore.kernel.org/git/xmqqy1wgwkbj.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index bd45828fe2c..7b27e4de78d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -443,7 +443,6 @@ static char **prep_childenv(const char *const *deltaenv)
 	struct string_list env = STRING_LIST_INIT_DUP;
 	struct strbuf key = STRBUF_INIT;
 	const char *const *p;
-	int i;
 
 	/* Construct a sorted string list consisting of the current environ */
 	for (p = (const char *const *) environ; p && *p; p++) {
@@ -476,7 +475,7 @@ static char **prep_childenv(const char *const *deltaenv)
 
 	/* Create an array of 'char *' to be used as the childenv */
 	ALLOC_ARRAY(childenv, env.nr + 1);
-	for (i = 0; i < env.nr; i++)
+	for (size_t i = 0; i < env.nr; i++)
 		childenv[i] = env.items[i].util;
 	childenv[env.nr] = NULL;
 
@@ -581,7 +580,6 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 {
 	struct string_list envs = STRING_LIST_INIT_DUP;
 	const char *const *e;
-	int i;
 	int printed_unset = 0;
 
 	/* Last one wins, see run-command.c:prep_childenv() for context */
@@ -599,7 +597,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 	}
 
 	/* "unset X Y...;" */
-	for (i = 0; i < envs.nr; i++) {
+	for (size_t i = 0; i < envs.nr; i++) {
 		const char *var = envs.items[i].string;
 		const char *val = envs.items[i].util;
 
@@ -616,7 +614,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 		strbuf_addch(dst, ';');
 
 	/* ... followed by "A=B C=D ..." */
-	for (i = 0; i < envs.nr; i++) {
+	for (size_t i = 0; i < envs.nr; i++) {
 		const char *var = envs.items[i].string;
 		const char *val = envs.items[i].util;
 		const char *oldval;
@@ -1789,7 +1787,7 @@ void run_processes_parallel(int n,
 			    task_finished_fn task_finished,
 			    void *pp_cb)
 {
-	int i, code;
+	int code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	int ungroup = run_processes_parallel_ungroup;
@@ -1801,7 +1799,7 @@ void run_processes_parallel(int n,
 	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
 		ungroup);
 	while (1) {
-		for (i = 0;
+		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
 		    pp.nr_processes < pp.max_processes;
 		    i++) {
-- 
2.38.0.971.ge79ff6d20e7


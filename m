Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLVEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJLVDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42C1F9EA
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so27972289wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk22E+xafbfAv9PII0Hbn8O45XXGlAeR5o5RzT+CbaA=;
        b=lWzEj7ZCK4MisbBK7FErhvRAeRCBPTyKw21JXwaW7HCwp6OmEEvXiKT4P2xYo585A/
         woX82ZRvdqD9h2FLJ8aeHaUKfxMamp3ruxZOxc8YILs6dst5z5BKZACoPtivqoQT6KOk
         619vVtTdgAyI3FPI93KRoEkD2dpIEMdD7mscEUYkeXQxNclOpt4XjcSNf9z+DSYH7Bfg
         /7XMXQk7D0+1d16dgPJj6ECwTov/uSYpLlrt38F/sgSen9hSBjxCVh723FVcooPjeaoR
         6wAlUz29jbZGd5Jc7GpeC1EizkooEn3LWLnz8MzoxKJgfxNu7SaAKhzNpipXjPWrBXFv
         4Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk22E+xafbfAv9PII0Hbn8O45XXGlAeR5o5RzT+CbaA=;
        b=aa15lz+YHk0a/kU0hULBZRnVjQOME3uWFts70/OHm3feZ/6lx6QloRSLaPG2NkXfQT
         afKgDrbTmh2BLq8piv2y9he10LxE+EcIsIJOy2AtD3V2GjNvUuIE4cmoDn8ihKCL+jpP
         Rkw000Cjxpte2l+sAvx58CgPUBy/bJXl6ZkwGDIZwoh1zVtxDbdVYaisEm10ysbkUFg0
         9sMikM9kU+nwaQdylhhciYkZ5hphqSAnS9naifbWfv7ZQiJUXGoE8DX1Ws3mZNOUku5x
         H28euCs1pXlmWHEoO+4FuoIi7MZkYZpiPTRdky2ZbuLEf0P+v2s4HUAc2Fpw71vyt2d9
         UktQ==
X-Gm-Message-State: ACrzQf0L63pTiFz7ByDKoOkYa6Hm0u+oeZmhdj/hv4t2M4DRLBzg2nAh
        7vrAC/DaYj7Fe2bO9LnNGmLFA0V6R4GUvA==
X-Google-Smtp-Source: AMsMyM6rNV7lDZyUtck3JGPHyMvLuJnyrtvKzMsNbeEONUWa2XsoDRVnG9bUApv6psGsiGT3Vd+1xg==
X-Received: by 2002:a5d:6508:0:b0:22e:1af4:57f9 with SMTP id x8-20020a5d6508000000b0022e1af457f9mr19097920wru.539.1665608608794;
        Wed, 12 Oct 2022 14:03:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/15] run-command.c: use designated init for pp_init(), add "const"
Date:   Wed, 12 Oct 2022 23:02:25 +0200
Message-Id: <patch-v3-06.15-df2ca5dd097-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a designated initializer to initialize those parts of pp_init()
that don't need any conditionals for their initialization, this sets
us on a path to pp_init() itself into mostly a validation and
allocation function.

Since we're doing that we can add "const" to some of the members of
the "struct parallel_processes", which helps to clarify and
self-document this code. E.g. we never alter the "data" pointer we
pass t user callbacks, nor (after the preceding change to stop
invoking online_cpus()) do we change "max_processes", the same goes
for the "ungroup" option.

We can also do away with a call to strbuf_init() in favor of macro
initialization, and to rely on other fields being NULL'd or zero'd.

Making members of a struct "const" rather that the pointer to the
struct itself is usually painful, as e.g. it precludes us from
incrementally setting up the structure. In this case we only set it up
with the assignment in run_process_parallel() and pp_init(), and don't
pass the struct pointer around as "const", so making individual
members "const" is worth the potential hassle for extra safety.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/run-command.c b/run-command.c
index 14ea409375a..b69deb1cc53 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1498,9 +1498,9 @@ enum child_state {
 
 int run_processes_parallel_ungroup;
 struct parallel_processes {
-	void *data;
+	void *const data;
 
-	size_t max_processes;
+	const size_t max_processes;
 	size_t nr_processes;
 
 	get_next_task_fn get_next_task;
@@ -1520,7 +1520,7 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	unsigned ungroup : 1;
+	const unsigned ungroup : 1;
 
 	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1558,21 +1558,18 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    size_t n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
-		    task_finished_fn task_finished,
-		    void *data, int ungroup)
+		    task_finished_fn task_finished)
 {
+	const size_t n = pp->max_processes;
+
 	if (!n)
 		BUG("you must provide a non-zero number of processes!");
 
-	pp->max_processes = n;
-
 	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
 		     (uintmax_t)n);
 
-	pp->data = data;
 	if (!get_next_task)
 		BUG("you need to specify a get_next_task function");
 	pp->get_next_task = get_next_task;
@@ -1580,16 +1577,9 @@ static void pp_init(struct parallel_processes *pp,
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
-	pp->nr_processes = 0;
-	pp->output_owner = 0;
-	pp->shutdown = 0;
-	pp->ungroup = ungroup;
 	CALLOC_ARRAY(pp->children, n);
-	if (pp->ungroup)
-		pp->pfd = NULL;
-	else
+	if (!pp->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
-	strbuf_init(&pp->buffered_output, 0);
 
 	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1789,13 +1779,17 @@ void run_processes_parallel(size_t n,
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	int ungroup = run_processes_parallel_ungroup;
-	struct parallel_processes pp;
+	struct parallel_processes pp = {
+		.max_processes = n,
+		.data = pp_cb,
+		.buffered_output = STRBUF_INIT,
+		.ungroup = ungroup,
+	};
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
-		ungroup);
+	pp_init(&pp, get_next_task, start_failure, task_finished);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
-- 
2.38.0.971.ge79ff6d20e7


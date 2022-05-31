Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1105C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbiEaRfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346600AbiEaRdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:33:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1FF972B3
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:33:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so19665009wrc.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLTf0iVqno38kf8saKgzPpsTE1dJDhFli51C1T7NWLQ=;
        b=dJTkesI71JpRqr2zl8n5vMy+mA7W4fPWXnjYwMddnY90xL72OIwu9zpqS77Gu3gNCK
         gXmwd4ByrlmzmyEYMKJMcx4AiSliMcPt5ooS26bgTjf+zhjOoxg0sdIqd/Oz2a/IOIib
         NEbMXm8oA2Tpjpb5zAobffJ7VXwPLYnl9AkjCx+WtZrtjeVSWsNdTb14cRVsuVK7hpB7
         VxUBPEob18ihSgz/cM0VmYuDR3r+spUVSNufDCtEGIzuHtwKGo9lHG2XMCmtTYclk9g/
         jWNwXB7WvZz2FHQDRARY1mjOOnTdM+px00FlwAcGWPVUNyZxTw2YJFLrBEaqgW92Ng6+
         jdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLTf0iVqno38kf8saKgzPpsTE1dJDhFli51C1T7NWLQ=;
        b=q7LYcJg7E62ghN+FrGFU36IeetgNIEW++cjI7cjmb8vbSrhw6Hr6/3lSopcEDqHZD5
         wZ0GWEGfoR/R93/p7laRDlW+hjUeHmGcE8Z8NgwJ0gymHR+g4TbrBAZrhHmKY2LnCPfk
         bWExQ92rFq0IzYC0jQD2RxN7wD6dP2YBPY6zbXyWeI1MnWYgsXlPxODKXbmpt2UMZks5
         tpjrrGUsCe1jEpz/IAmzl5Nz51Rccs+I3QoVc67JWGb4ZDfoimQS5YqBXuP17y6fRcyN
         lEM+v3CgAvC2PGcn1v/Mhh//NorHZjbfUkjbHtkn95txnbGZ5vjIL7A4VKidNRxE0beY
         EK2A==
X-Gm-Message-State: AOAM533c16rXA/pOZDM+TjXOHtMHsci7YloKk2GB+kcTo2JrS4nR65QO
        8BbxO/8ZYPTTAKKJ/KDH6M/8Icq85/8Fsw==
X-Google-Smtp-Source: ABdhPJz99y/uVNWS3cu0SR0dxUDyQCDebFZEu9FlpmnrCcQowOvbYm1W/UT3PuTFA8lD9jvr2lh0jQ==
X-Received: by 2002:a5d:5281:0:b0:20c:d5be:331c with SMTP id c1-20020a5d5281000000b0020cd5be331cmr50271351wrv.9.1654018385472;
        Tue, 31 May 2022 10:33:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003973e8a227dsm2637941wml.46.2022.05.31.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:33:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Tue, 31 May 2022 19:32:57 +0200
Message-Id: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of [1] fixing issues pointed out by Junio in the last re-roll:

 * A minor whitespace parameter fix.

 * Clear up confusion about GIT_CP_WAIT_CLEANUP, and remove the
   duplicate "mark ungroup children as GIT_CP_WAIT_CLEANUP" code.

 * Droped a conditional strbuf_write() on an always-empty string under
   "ungroup".

 * Correct "err" parameter name to "out" in the new API docs.

 * Replace assert() with BUG().

 * Address other minor issues noted by Junio.

Ævar Arnfjörð Bjarmason (2):
  run-command: add an "ungroup" option to run_process_parallel()
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 hook.c                      |  1 +
 run-command.c               | 83 +++++++++++++++++++++++++++++--------
 run-command.h               | 30 ++++++++++----
 t/helper/test-run-command.c | 19 +++++++--
 t/t0061-run-command.sh      | 35 ++++++++++++++++
 t/t1800-hook.sh             | 37 +++++++++++++++++
 6 files changed, 177 insertions(+), 28 deletions(-)

Range-diff against v3:
1:  aabd99de680 ! 1:  f1170b02553 run-command: add an "ungroup" option to run_process_parallel()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## run-command.c ##
    -@@ run-command.c: int pipe_command(struct child_process *cmd,
    - enum child_state {
    - 	GIT_CP_FREE,
    - 	GIT_CP_WORKING,
    --	GIT_CP_WAIT_CLEANUP,
    -+	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
    +@@ run-command.c: enum child_state {
    + 	GIT_CP_WAIT_CLEANUP,
      };
      
     +int run_processes_parallel_ungroup;
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      		    start_failure_fn start_failure,
      		    task_finished_fn task_finished,
     -		    void *data)
    -+		    void *data,  const int ungroup)
    ++		    void *data, const int ungroup)
      {
      	int i;
      
    @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      		pp->pfd[i].events = POLLIN | POLLHUP;
      		pp->pfd[i].fd = -1;
      	}
    -@@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
    - 	 * When get_next_task added messages to the buffer in its last
    - 	 * iteration, the buffered output is non empty.
    - 	 */
    --	strbuf_write(&pp->buffered_output, stderr);
    -+	if (!pp->ungroup)
    -+		strbuf_write(&pp->buffered_output, stderr);
    - 	strbuf_release(&pp->buffered_output);
    - 
    - 	sigchain_pop_common();
     @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
       */
      static int pp_start_one(struct parallel_processes *pp)
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
      	return 0;
      }
      
    -+static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
    ++static void pp_mark_ungrouped_for_cleanup(struct parallel_processes *pp)
     +{
     +	int i;
     +
    ++	if (!pp->ungroup)
    ++		BUG("only reachable if 'ungrouped'");
    ++
     +	for (i = 0; i < pp->max_processes; i++)
    -+		if (pp->children[i].state == GIT_CP_WORKING)
    -+			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
    ++		pp->children[i].state = GIT_CP_WAIT_CLEANUP;
     +}
     +
      static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
      {
      	int i;
      
    -+	assert(!pp->ungroup);
    ++	if (pp->ungroup)
    ++		BUG("unreachable with 'ungrouped'");
     +
      	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
      		if (errno == EINTR)
    @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp, int o
      {
      	int i = pp->output_owner;
     +
    -+	assert(!pp->ungroup);
    ++	if (pp->ungroup)
    ++		BUG("unreachable with 'ungrouped'");
     +
      	if (pp->children[i].state == GIT_CP_WORKING &&
      	    pp->children[i].err.len) {
    @@ run-command.c: static void pp_output(struct parallel_processes *pp)
      	int i, code;
      	int n = pp->max_processes;
      	int result = 0;
    - 
    -+	if (ungroup)
    -+		for (i = 0; i < pp->max_processes; i++)
    -+			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
    -+
    - 	while (pp->nr_processes > 0) {
    - 		for (i = 0; i < pp->max_processes; i++)
    - 			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
     @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
      		code = finish_command(&pp->children[i].process);
      
    @@ run-command.c: int run_processes_parallel(int n,
     -		pp_buffer_stderr(&pp, output_timeout);
     -		pp_output(&pp);
     +		if (ungroup) {
    -+			pp_mark_working_for_cleanup(&pp);
    ++			pp_mark_ungrouped_for_cleanup(&pp);
     +		} else {
     +			pp_buffer_stderr(&pp, output_timeout);
     +			pp_output(&pp);
    @@ run-command.h: void check_pipe(int err);
       * pp_cb is the callback cookie as passed to run_processes_parallel.
       * You can store a child process specific callback cookie in pp_task_cb.
       *
    -+ * The "struct strbuf *err" parameter is either a pointer to a string
    -+ * to write errors to, or NULL if the "ungroup" option was
    -+ * provided. See run_processes_parallel() below.
    ++ * See run_processes_parallel() below for a discussion of the "struct
    ++ * strbuf *out" parameter.
     + *
       * Even after returning 0 to indicate that there are no more processes,
       * this function will be called again until there are no more running
    @@ run-command.h: typedef int (*get_next_task_fn)(struct child_process *cp,
     - * You must not write to stdout or stderr in this function. Add your
     - * message to the strbuf out instead, which will be printed without
     - * messing up the output of the other parallel processes.
    -+ * The "struct strbuf *err" parameter is either a pointer to a string
    -+ * to write errors to, or NULL if the "ungroup" option was
    -+ * provided. See run_processes_parallel() below.
    ++ * See run_processes_parallel() below for a discussion of the "struct
    ++ * strbuf *out" parameter.
       *
       * pp_cb is the callback cookie as passed into run_processes_parallel,
       * pp_task_cb is the callback cookie as passed into get_next_task_fn.
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
     - * You must not write to stdout or stderr in this function. Add your
     - * message to the strbuf out instead, which will be printed without
     - * messing up the output of the other parallel processes.
    -+ * The "struct strbuf *err" parameter is either a pointer to a string
    -+ * to write errors to, or NULL if the "ungroup" option was
    -+ * provided. See run_processes_parallel() below.
    ++ * See run_processes_parallel() below for a discussion of the "struct
    ++ * strbuf *out" parameter.
       *
       * pp_cb is the callback cookie as passed into run_processes_parallel,
       * pp_task_cb is the callback cookie as passed into get_next_task_fn.
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
       * The children started via this function run in parallel. Their output
       * (both stdout and stderr) is routed to stderr in a manner that output
     - * from different tasks does not interleave.
    -+ * from different tasks does not interleave (but see "ungroup" above).
    ++ * from different tasks does not interleave (but see "ungroup" below).
       *
       * start_failure_fn and task_finished_fn can be NULL to omit any
       * special handling.
     + *
    -+ * If the "ungroup" option isn't specified the callbacks will get a
    -+ * pointer to a "struct strbuf *out", and must not write to stdout or
    ++ * If the "ungroup" option isn't specified, the API will set the
    ++ * "stdout_to_stderr" parameter in "struct child_process" and provide
    ++ * the callbacks with a "struct strbuf *out" parameter to write output
    ++ * to. In this case the callbacks must not write to stdout or
     + * stderr as such output will mess up the output of the other parallel
     + * processes. If "ungroup" option is specified callbacks will get a
     + * NULL "struct strbuf *out" parameter, and are responsible for
2:  ec27e3906e1 = 2:  8ab09f28729 hook API: fix v2.36.0 regression: hooks should be connected to a TTY
-- 
2.36.1.1103.g036c05811b0


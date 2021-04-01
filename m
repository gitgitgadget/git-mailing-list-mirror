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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7867C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EAD60234
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhDARsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhDARqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:46:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14DC02D541
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so3065893wmd.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A48rjjmi3yLdIeRpj2+x6awEGfsdEaz2VsqzaND5D1I=;
        b=Ckbmd/NS2vRFWi/umYmnlO2dKtSmJQk4XgqQT8DgaU8/WCdFl1xwbIsNzurU68B9Zh
         +n2JWqzlupH3EjKLb8P7o5thi0tvl8Y29C0LY+5Gs9ohvVce0J1+30cmkOF7sPc29T9c
         /2fLEGC9U1WuQjDTd9wXw9y23iu+WmmOK89taJxLfmPbEYK6v7y4A4AH0M8bIl5pQgkT
         lAZ+Ttrzqq2kJ9wtSVf+srtAAU6UVmyJt3zBKKR8vndq2guxEpiJEYJlLEUyz4197bSR
         TxfiNn4i9EKyVei7ftKQjiv4GqEdnMrqpHMNtj2mBlm3fqqbSuM2jIm+84vJ/IwSG+ix
         /SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A48rjjmi3yLdIeRpj2+x6awEGfsdEaz2VsqzaND5D1I=;
        b=iNV8BJlgl7E3IB9fnfJYTUYbzr4EMlaL78IcaKjLumeJt7K6bqQWsop7ZFe+BGWnKe
         NdTGXIOUCRz8d8Kzg3crCjAD2UROI7BhvHxB2y25DcAvuufg+Tc8sqxLWuQq3fodapAv
         Z2TowpRvbTyF0qej+IGSHVdEAiKo37pv2m0XpaSmXbLzlEvS/8y0/uJ0zRwDzx5/vy84
         UItjkGpzFXhpetR35QSvpC9fwi674KatjE+7lZWxApR84rtfqoqJclOksrBjcpKwEbUH
         zIFOkd2pIv2MzXJNn5KauwyGqYfsWRyluNQF7TYEE8zqsAQsXJUqnk4H9A4K1jYyMxR4
         lnRg==
X-Gm-Message-State: AOAM530PoGoCVk9DG/gzpgP7FEvAcncuFaNCUe9WZqXXkMDZfN/kJiWl
        ZjuZvWr3DuWMkbK7jUukEhV4tNx47I4=
X-Google-Smtp-Source: ABdhPJznvEfZYdyhOgE0n5uoRNF6OV5V9vCU1pdlaTUeuXJf/x79lZ0OgTRJRf1tVmq67U28ThiImQ==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr8846002wma.68.1617291675041;
        Thu, 01 Apr 2021 08:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm13538513wrj.63.2021.04.01.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:14 -0700 (PDT)
Message-Id: <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:53 +0000
Subject: [PATCH 11/23] fsmonitor--daemon: define token-ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to create token-ids and define the
overall token naming scheme.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 108 +++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 16252487240a..2d25e36601fe 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -149,6 +149,112 @@ static int do_as_client__send_flush(void)
 	return 0;
 }
 
+/*
+ * Requests to and from a FSMonitor Protocol V2 provider use an opaque
+ * "token" as a virtual timestamp.  Clients can request a summary of all
+ * created/deleted/modified files relative to a token.  In the response,
+ * clients receive a new token for the next (relative) request.
+ *
+ *
+ * Token Format
+ * ============
+ *
+ * The contents of the token are private and provider-specific.
+ *
+ * For the built-in fsmonitor--daemon, we define a token as follows:
+ *
+ *     "builtin" ":" <token_id> ":" <sequence_nr>
+ *
+ * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
+ * UUID, or {timestamp,pid}.  It is used to group all filesystem
+ * events that happened while the daemon was monitoring (and in-sync
+ * with the filesystem).
+ *
+ *     Unlike FSMonitor Protocol V1, it is not defined as a timestamp
+ *     and does not define less-than/greater-than relationships.
+ *     (There are too many race conditions to rely on file system
+ *     event timestamps.)
+ *
+ * The <sequence_nr> is a simple integer incremented for each event
+ * received.  When a new <token_id> is created, the <sequence_nr> is
+ * reset to zero.
+ *
+ *
+ * About Token Ids
+ * ===============
+ *
+ * A new token_id is created:
+ *
+ * [1] each time the daemon is started.
+ *
+ * [2] any time that the daemon must re-sync with the filesystem
+ *     (such as when the kernel drops or we miss events on a very
+ *     active volume).
+ *
+ * [3] in response to a client "flush" command (for dropped event
+ *     testing).
+ *
+ * [4] MAYBE We might want to change the token_id after very complex
+ *     filesystem operations are performed, such as a directory move
+ *     sequence that affects many files within.  It might be simpler
+ *     to just give up and fake a re-sync (and let the client do a
+ *     full scan) than try to enumerate the effects of such a change.
+ *
+ * When a new token_id is created, the daemon is free to discard all
+ * cached filesystem events associated with any previous token_ids.
+ * Events associated with a non-current token_id will never be sent
+ * to a client.  A token_id change implicitly means that the daemon
+ * has gap in its event history.
+ *
+ * Therefore, clients that present a token with a stale (non-current)
+ * token_id will always be given a trivial response.
+ */
+struct fsmonitor_token_data {
+	struct strbuf token_id;
+	struct fsmonitor_batch *batch_head;
+	struct fsmonitor_batch *batch_tail;
+	uint64_t client_ref_count;
+};
+
+static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
+{
+	static int test_env_value = -1;
+	static uint64_t flush_count = 0;
+	struct fsmonitor_token_data *token;
+
+	token = (struct fsmonitor_token_data *)xcalloc(1, sizeof(*token));
+
+	strbuf_init(&token->token_id, 0);
+	token->batch_head = NULL;
+	token->batch_tail = NULL;
+	token->client_ref_count = 0;
+
+	if (test_env_value < 0)
+		test_env_value = git_env_bool("GIT_TEST_FSMONITOR_TOKEN", 0);
+
+	if (!test_env_value) {
+		struct timeval tv;
+		struct tm tm;
+		time_t secs;
+
+		gettimeofday(&tv, NULL);
+		secs = tv.tv_sec;
+		gmtime_r(&secs, &tm);
+
+		strbuf_addf(&token->token_id,
+			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
+			    flush_count++,
+			    getpid(),
+			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			    tm.tm_hour, tm.tm_min, tm.tm_sec,
+			    (long)tv.tv_usec);
+	} else {
+		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
+	}
+
+	return token;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data, const char *command,
@@ -330,7 +436,7 @@ static int fsmonitor_run_daemon(void)
 
 	pthread_mutex_init(&state.main_lock, NULL);
 	state.error_code = 0;
-	state.current_token_data = NULL;
+	state.current_token_data = fsmonitor_new_token_data();
 	state.test_client_delay_ms = 0;
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
-- 
gitgitgadget


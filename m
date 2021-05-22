Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5847AC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3186561164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhEVN7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhEVN6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F756C0613ED
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so23718469wrs.4
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5qY1y9CfNbyDb71UAUZBNInayWHSRyciKICzyYlGNc=;
        b=a7zIEy6p/mp+ncB6ECyifJ36s/YJC0+LOY7pwgFf3xm82nOUiFolImRqFMsV4bTDuJ
         lnzM2+lO0Y+W64nwajljg/+nbpz5vzZUqlQJ8quCnfCxMfhkLvLU2EDPuC7uucBOOr+P
         kdp6jq37scWOyuU3GjIXZXyUGKHtpABTaKAAaG8D1U43nlNAECXzL3CyXkFv4XpuZF6c
         Dqm1eZANuwyalDgwKwObRUXlWo/rEcQm1VUemOrVHl3msK29o22/TZ4eNK56+nD6/S+6
         Tz0S7MIeZLGCmru2nNw/lDngix0o+sMOz6BOZ9z77dVc3NoXa+CUsTQ8OQY4Z2rO+wDy
         srhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5qY1y9CfNbyDb71UAUZBNInayWHSRyciKICzyYlGNc=;
        b=oKUUQnFho8UCeCHOfUW+n5Xkjyi4KRDnxP4xdsM6hMabyyGjrcfCNGcdqLzi+6RZS7
         Jh4DdnCzHSMhkKyZTHn3FLAXUx/9e7K1l3ZV3iyU2h0RB4+NkkquV090a1ac25O0wcjr
         O0WyfPZanv86oBaCAdQnBYb89/2qatvGGErV22tx6pb0900OmMjaPLD9vooh3tpod82S
         PO8149saKpMeENTlwaqCi3pWVdBV0wXs0hRlGsMKWMP8FjgY9GFV8GONpC+NHUmbi1nc
         ZIofMZhBIU7KXlzT1Li29L/DrfuZK+1GLtgvCrN4uS8rnz1iRpq0i+MnztptRAjRP3wF
         Xd9Q==
X-Gm-Message-State: AOAM531PW58YBzbqP/rG4VJyYNAqt0S3YyiTL8vhSJH52caCUcOmNVvL
        mBG18aQSCxGUiKjDjIqrKDC7zahhsX4=
X-Google-Smtp-Source: ABdhPJys8ICuRvCxUDSGV0hmEv8wTEeLk0TBZWGD6gLiU2Yi+63WqTn+ro5e/dLhXKKLAe/XBSCd1Q==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr14544923wrr.159.1621691840062;
        Sat, 22 May 2021 06:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm5420587wrt.67.2021.05.22.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:19 -0700 (PDT)
Message-Id: <c092cdf2c8b749768a3ec9c9998dd0d2842d748f.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:54 +0000
Subject: [PATCH v2 15/28] fsmonitor--daemon: define token-ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to create token-ids and define the
overall token naming scheme.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 116 +++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index d6e35ded9f68..ecd456dc9284 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -91,6 +91,120 @@ static int do_as_client__status(void)
 	}
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
+ * The "builtin" prefix is used as a namespace to avoid conflicts
+ * with other providers (such as Watchman).
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
+ * The <sequence_nr> is a simple integer incremented whenever the
+ * daemon needs to make its state public.  For example, if 1000 file
+ * system events come in, but no clients have requested the data,
+ * the daemon can continue to accumulate file changes in the same
+ * bin and does not need to advance the sequence number.  However,
+ * as soon as a client does arrive, the daemon needs to start a new
+ * bin and increment the sequence number.
+ *
+ *     The sequence number serves as the boundary between 2 sets
+ *     of bins -- the older ones that the client has already seen
+ *     and the newer ones that it hasn't.
+ *
+ * When a new <token_id> is created, the <sequence_nr> is reset to
+ * zero.
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
+	CALLOC_ARRAY(token, 1);
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
 
 static int handle_client(void *data,
@@ -281,7 +395,7 @@ static int fsmonitor_run_daemon(void)
 
 	pthread_mutex_init(&state.main_lock, NULL);
 	state.error_code = 0;
-	state.current_token_data = NULL;
+	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-- 
gitgitgadget


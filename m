Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F243E1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 10:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKDKDm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 05:03:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37367 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfKDKDm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 05:03:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id p13so7372463pll.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89DERGHtWEUJ+XnvopDDL7euwdAyd7sQ/zGkkKgJ9EE=;
        b=sxW5Xc4SSj7IKLMJps18JUYyMPPxjHbcd9cdiDhU6c8ZQkz2PvRhwFqsNBXawpSKIY
         /TqLlL7+qROuxUOUWEa7PjTVdt1y/pWBzijb4mwLoDP7Ly+k5gAQu5hjt9yyuCHoIrqL
         L5L/D/+eeFtv63f9RWInDfmyc2SHhZUnB93AcYM0EqCK2QnyXlv9LWZoeWfEzr3CZIM/
         /tW+eGWKARShJRG7b3LLzRRb2DikEvv1xWMV15z9xLyr6+cKD+OM3lSxHg3YIHoA1DOo
         d4IS7GlEAmZNpVIZwCJf34T7VBFGnyuTpUVHypyXqI5y/Lj6T6zfr33z7Xf1lmNBIiX+
         EEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89DERGHtWEUJ+XnvopDDL7euwdAyd7sQ/zGkkKgJ9EE=;
        b=CBJ1by4Q6lx0bKzWuxWyn57RkEE5xGL0f1Stg7xLc8ufj/VaMgm3vis8XVBjp05jyh
         Eb/Mn+s6v4STQSWAsjeQTlsPrcWfZUdyEzhwU6nzwF5tIXrilAeWf7UDjmyLzotwoR6e
         NjGH/TwzpWTRxToaO0ayd4uuD1UKvA5xGqRxsOwiCkpV1QrGHALGrd6AEpTnzPSqYkvL
         t2LzOHrlXu/lOdIQHw1GqUbcOXi9CElDgE5XIMOvmDzCYqm1WQxWGKLoJ0mMgZ9gtUt7
         K/jXGWZ7rQbX64Fa3VT9fhVwln8SukGeteAdWgBFecbmDRz1LdXP9Z8HJ5qy2tFxL1+O
         ttuw==
X-Gm-Message-State: APjAAAXE7PrOoS0oBiREZCMV6IxuHQ0v3bJPIFCiREL6+87TnnGbGcIi
        rQhW21IJaG209KVq0pMOj+Z9bvAC/2c=
X-Google-Smtp-Source: APXvYqxQNTSQSafkVmQdjePYSf7W1QYlUa6a/vDAR0Nad+6Z2rmNd+VP8zyqVfhgpB3SMoLjBdJvhQ==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14mr19330221plr.115.1572861820743;
        Mon, 04 Nov 2019 02:03:40 -0800 (PST)
Received: from localhost.localdomain ([125.252.103.164])
        by smtp.gmail.com with ESMTPSA id x2sm18438745pfj.90.2019.11.04.02.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 02:03:39 -0800 (PST)
From:   "Eric N. Vander Weele" <ericvw@gmail.com>
To:     git@vger.kernel.org
Cc:     "Eric N. Vander Weele" <ericvw@gmail.com>
Subject: [PATCH] status: teach "status --short" to respect "--show-stash"
Date:   Mon,  4 Nov 2019 18:03:34 +0800
Message-Id: <20191104100334.60537-1-ericvw@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable printing the entries currently stashed away in the short format.
This prints the stash information after the path status to be symmetric
with "status --long --show-stash".

Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
---
 Documentation/git-status.txt |  4 ++++
 wt-status.c                  | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f07..c1afc3282c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -244,6 +244,10 @@ If -b is used the short-format status is preceded by a line
 
     ## branchname tracking info
 
+If --show-stash is used the short-format status is followed by a line
+
+    ## stash: <n> (entry|entries)
+
 Porcelain Format Version 1
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/wt-status.c b/wt-status.c
index cc6f94504d..c6d112081b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1956,6 +1956,20 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
+static void wt_shortstatus_print_stash(struct wt_status *s)
+{
+	int stash_count = 0;
+
+	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
+	if (stash_count > 0) {
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
+		status_printf_ln(s, GIT_COLOR_NORMAL,
+				 Q_("stash: %d entry",
+				    "stash: %d entries", stash_count),
+				 stash_count);
+	}
+}
+
 static void wt_shortstatus_print(struct wt_status *s)
 {
 	struct string_list_item *it;
@@ -1976,6 +1990,9 @@ static void wt_shortstatus_print(struct wt_status *s)
 
 	for_each_string_list_item(it, &s->ignored)
 		wt_shortstatus_other(it, s, "!!");
+
+	if (s->show_stash)
+		wt_shortstatus_print_stash(s);
 }
 
 static void wt_porcelain_print(struct wt_status *s)
-- 
2.24.0


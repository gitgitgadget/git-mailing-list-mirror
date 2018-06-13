Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3251F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936022AbeFMXGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:38 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:57262 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:36 -0400
Received: by mail-yw0-f201.google.com with SMTP id l136-v6so3245585ywb.23
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=docOv1vGSK2dcgSsXJXsTYpRz14u+69e797GYwpnlHQ=;
        b=Wac7rJf5Y88TpNDsq18EttCkE3zdf8GprtJf6FtZOKVPNeHHI/Bz/+GhhBs638xA35
         jAEdCy0qBzRQWLmKNkpOJOLXcRH2+7cF8JNTwzfN0a//RmebTovUWqRBKvHL2GBiS8eL
         iG7Fzy4Z1jEHh9kWHxpyO6AB9HyEYlZP+HbjTx82Qqz2mKfoB+yVJx5XM/w0tEeyiqhq
         iEsJvJ0WV3uGM0L984YcYiApXeOUurardh4x3zz6IEq4MWST4aawaKuUlH1ntSNEHYmW
         CQm+6WQGakeqJzA9lfUv47N7sade+brSdlaC4R4OUZp6fy4TJ2Qa5/Y8IujGf1AANo7e
         NtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=docOv1vGSK2dcgSsXJXsTYpRz14u+69e797GYwpnlHQ=;
        b=lgSe2CXlKZnI0RckOWb/rvYA9/UClkRmP80KY8DQy/bxNJ2h09CCoHtip2+T4tueUp
         12ksFU1SfAqFwYofcfX4CJgr3Jw3pU0+n9yP0wqVUHDoV4KPElqqQUKlUyXm+xiqp/it
         ejHQcrlD/wrKl7js/aRBQK7e2xu3onqaE3ssQreDX48MZRLzCFcuP+FOjCx3MP9TmJb8
         I2BJlveP+3iWTJNcBiVCyy2iXjyHz9ivFZvin5X5p44Q2Wtmfmtsjlr5bs9k2W/Mws49
         oYldyTNpOXqZhx8NWfpbARMty4RdMypyV+2v/W8ckICnlxWorDBl1x5MR5w28L5X4b8a
         TEGw==
X-Gm-Message-State: APt69E1OSeAtoKx7VWc1VLVyWcTyjqSPaUW2n9g/QoJDDffTXewdwbm2
        G4UxwPGT/wp3E9140VY4pVJcMMh+bFxPexizXc7P6czgdzOuqgMr/VZ5fUdMYYnZIRi3KWqOqiZ
        XVnKudgJOBqGetcX7fH3+Il5p87oHa7CbrCTbaFThNNmtWZ//uICqz8BjITDF
X-Google-Smtp-Source: ADUXVKJp1zUqT2rHgLXNiLWw2ZCmJOLFWejdANS6U2LYoZx85wcSQaY258LXw7mEulWKk4mnxqo8WcYPLz11
MIME-Version: 1.0
X-Received: by 2002:a25:b206:: with SMTP id i6-v6mr44308ybj.69.1528931195638;
 Wed, 13 Jun 2018 16:06:35 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:17 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-27-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 26/31] commit.c: allow get_cached_commit_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 44d1a38187a..7ee55f6b8f0 100644
--- a/commit.c
+++ b/commit.c
@@ -270,10 +270,10 @@ void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!v) {
 		if (sizep)
 			*sizep = 0;
diff --git a/commit.h b/commit.h
index 3e883787855..c7bb01ffe4b 100644
--- a/commit.h
+++ b/commit.h
@@ -93,8 +93,7 @@ void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsi
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
-const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *, const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
-- 
2.18.0.rc1.244.gcf134e6275-goog


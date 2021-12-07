Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA7C4332F
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhLGRtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbhLGRtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A0C061756
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so36378wmc.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=cYtGNmqb3bs3omc8lLO/fQe6rGR1BrzOqAdARb2HYxVXBVUXTztvbyM/QoFedjcdSI
         9Cu/N66SQ2LnFjG9k5edRH2BFSZLAyB8gflaOmjN7Kq4U/XdTr56uR6Xv0oaK+SIVRL5
         yWbBf6uyklnOSZBIxY+dBVbTBtZ33TU2WOvyy2AYFdOYDJdWJYZMPOhywYj/ldHU+Ulz
         p47OVQN5roGIMR0OL5XRBvxQeNEi+KvOzpCqMCoTiU6g7fQnPrfyi5I/sif963C8E3y4
         rmF8pP4P2Z7pHj6J64yKsdYxS1Mol1BBwlUdmjVbaIgct/SQs1e1slz27SRg8dxBcGGh
         WhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=RuKD9k5l1ec+TlnmUlnXNNB78mVkqpv3q6zAMotr56QBtwPYeHeobSxbL3msNI+Ahe
         uHcbs4F1rWj/PVPgzEooCKtO8BgCTzvmwIhBd595Tm3TUHlM0DTlwT/AWw9MSHZZmHc1
         wobriszRMocgAcstkded3mheIBjPvCStGmuGfubFjXj480kNd3kPWjfmbG9BS+iLiOGJ
         MdCWFmMDBmgnqcLMvn++9vtsJwYKJNotqGj3MslVhBZaGWl1/5NbN5DAgM6Tc0As+ebW
         v3AXmXf0AnR/WkyShPAn7FllxlxDZrWw7pZdCIPYB0PoU2OczxZFUgrvyZVbY/3xQ6ke
         6FZg==
X-Gm-Message-State: AOAM531VtQDzDej/eCUMm4LsCgji6o/s3yOVYBrAm0GVqU/WXNjg4+uP
        j96OyVncbJQnHbVnfv8TxGTViH+Mh2Y=
X-Google-Smtp-Source: ABdhPJzCEjrDOY5fd3GAOrv2a52UZWRdQS7wIjeWqygICqZ3owkHfEJfZ1olo3i/vy7x/3Hh0yIemg==
X-Received: by 2002:a1c:4d3:: with SMTP id 202mr8750534wme.174.1638899130252;
        Tue, 07 Dec 2021 09:45:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm364720wrr.47.2021.12.07.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:29 -0800 (PST)
Message-Id: <eab71ab008e690ddb06d8ec5c27257b90ef26d2a.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:20 +0000
Subject: [PATCH 06/10] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and the next
available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..10dfd370e8e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -877,7 +877,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -911,7 +911,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -932,7 +932,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 		sublock_file_fd = open(subtab_lock.buf,
 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -1013,7 +1013,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1050,9 +1050,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget


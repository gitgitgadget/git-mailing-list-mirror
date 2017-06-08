Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FCA1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdFHXmg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:36 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35320 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbdFHXlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:40 -0400
Received: by mail-pg0-f41.google.com with SMTP id k71so20707377pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ag8YeZaxL6E+AycWFVi3ND2YbX1//QoyThiaBrpCnek=;
        b=q1UZT77dLmRf0BFmzUC8uvB/QvSPxRgq4zK38a8x1p0isppGF884ppgUgV12lLKfb1
         roqvoGji7IK1lloqRhPxEDLWb1wEHzRdqYUQn+9idbDgspvu0Nrasr2mXAH1TFHYCrLg
         umf1dVDRLoJs5KOf3SgX6/jxvRh+UIOfaJPwkyxhJ4wAwaeV47X2PvOd2GFAMsM0xc85
         +YVcayCcsLdEf2O58QvXrTnALg1WhFgSbDrByBaK8jTH31JMxHnPGzUQKx6hEtHzi0Sk
         wBrLcg+/2XQTXqI0PmnbidvBEzwwgVnD50Gue5WorWHm3tos2YsGU/KpTqYy7pU3p6Mo
         DfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ag8YeZaxL6E+AycWFVi3ND2YbX1//QoyThiaBrpCnek=;
        b=XuxOfIltZ+5Pe7qdh66eAKs9QrrhuvUJyJsVQauw5xWh5JuhfnHVBrOqZQBd1qYNMr
         lH436UYGSSyv6a0+lQm88U+6PvPL4xvIjEBId+9WGmMpjqFdH8tsyI7RG97lh2LnJSqU
         zaj6XI2oj+AcM4tI7PyVlvXH2le71SkeB85G0omjRxsxT5x0FwpQn3i/Uj9V8VixC7mX
         Ki3PyM5l6EcAO4pkx5iAcsgH3/6ERjys1gox/S6BswLbWM7n1uM1Skc6UKFuIUuxK90A
         sYHQ4EgTVds5mxJvV+VHIuxMVgbTBCFQ8wcTAF2bJO62iLEVp26lWH/iRDpdZLlyIGQd
         mtow==
X-Gm-Message-State: AODbwcDAjv7JASknxmh5/HdM9WNtiqVPA0hXxYQP1qiW6JdG3ZHuPKXp
        /a1+Ob3UPnyj1zwoy+7wRQ==
X-Received: by 10.99.114.66 with SMTP id c2mr41022467pgn.130.1496965293395;
        Thu, 08 Jun 2017 16:41:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 12/32] repository: add index_state to struct repo
Date:   Thu,  8 Jun 2017 16:40:40 -0700
Message-Id: <20170608234100.188529-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 16 ++++++++++++++++
 repository.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/repository.c b/repository.c
index fd53d6bf7..21719d0a6 100644
--- a/repository.c
+++ b/repository.c
@@ -186,5 +186,21 @@ void repo_clear(struct repository *repo)
 		repo->config = NULL;
 	}
 
+	if (repo->index) {
+		discard_index(repo->index);
+		free(repo->index);
+		repo->index = NULL;
+	}
+
 	memset(repo, 0, sizeof(*repo));
 }
+
+int repo_read_index(struct repository *repo)
+{
+	if (!repo->index)
+		repo->index = xcalloc(1, sizeof(struct index_state));
+	else
+		discard_index(repo->index);
+
+	return read_index_from(repo->index, repo->index_file);
+}
diff --git a/repository.h b/repository.h
index 2b757df25..9515cc631 100644
--- a/repository.h
+++ b/repository.h
@@ -2,6 +2,7 @@
 #define REPOSITORY_H
 
 struct config_set;
+struct index_state;
 
 struct repository {
 	/* Environment */
@@ -20,6 +21,7 @@ struct repository {
 	 * ~/.gitconfig, XDG config file and the global /etc/gitconfig)
 	 */
 	struct config_set *config;
+	struct index_state *index;
 
 	/* Configurations */
 	unsigned ignore_env:1;
@@ -35,4 +37,6 @@ extern char *repo_worktree_path(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *path);
 extern void repo_clear(struct repository *repo);
 
+extern int repo_read_index(struct repository *repo);
+
 #endif /* REPOSITORY_H */
-- 
2.13.1.508.gb3defc5cc-goog


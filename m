Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107EC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C7B60F46
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhGaCZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbhGaCZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:25:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40472C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c18so11325975qke.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rQP9MRWJwdeY/LionWrHXhwSAyeW9ABk5vViBSGO28=;
        b=cDyZWyeFkO1S+1HIAd+SSnRs+z9SxjbZoxbH234rkURQcotcuq10O05rPH9P4SjXgU
         fFXbfnNh6U1bdEP9w4Hq8oP/NwH4D8fVSFuW7BfiIIE8BkFVFdpxqg/MoWb1v6ajo6W2
         12fzGWGYoYftrH2on2QJpdrxhCW0X6wzi7uB5vx+toEEQRoIzc/XJ2hs7D2OXICbPM+E
         Ts1mTiqAK7N0ceNvMOvZ9NDe9V/1PxeRBOol/X/z2TCACJznJE3yfeT0SySwA5Qe3cNB
         DiC9aPG8aKhGWiE03Fd4YV9DPIa8fo68EtLIqknkM3+Hdp1q7rSkbMqDTs42Bdjqug6R
         Vffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rQP9MRWJwdeY/LionWrHXhwSAyeW9ABk5vViBSGO28=;
        b=BGVqVjqIgOQ5UQsbCE64j9J1JwOVvrWtG5bO0kA5KyQqQRB8LAKcF1ZNxEfWRowvI+
         0qbuuFpL61h4sOZ66K7DiQDlWp+VcTTfLF+pC+jcExW6XX3yCZyv67QA/UqIjRhHyTnf
         EVEboCMJ0Zzplhyp9K7pznbBdLfQPUdwyIeLcw/EeN6zxSUXMNHdVhH6fLSageBOEgYU
         O7guCN3jD0rZvuTXPxb3U6gQZh/PtQBCsILQW/CRiOOnOVefUdDazKdaCCW9LfstpaQy
         Trz/2dhWIuqSYXU7urOlKi3J3jAFJME5o2uZB+H2YCL83QKh6VAoDdL+Suj0TmZJBoei
         ezAA==
X-Gm-Message-State: AOAM531CNFse+HNzAg2JiPntUjWTeadjI/evXRaecbTW1mu4dK6sCWkm
        p8hZmWrzDIQsClUdKTnqfTsg8WyDHRUG0g==
X-Google-Smtp-Source: ABdhPJxWzAPwabAn5tbiPFt2osdixlK2SBwFTjJG0Id+LAgbrz3rH+YfA8kkEnEurwd5T4UNpJUEuQ==
X-Received: by 2002:a37:7141:: with SMTP id m62mr5256149qkc.496.1627698314356;
        Fri, 30 Jul 2021 19:25:14 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id v6sm2012576qkp.117.2021.07.30.19.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:25:13 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 2/4] advice: add enum variants for missing advice variables
Date:   Fri, 30 Jul 2021 22:25:02 -0400
Message-Id: <20210731022504.1912702-3-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731022504.1912702-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were missed in their addition in 887a0fd573 (add: change advice
config variables used by the add API, 2020-02-06). All other global
variable settings have entries already.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c | 2 ++
 advice.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/advice.c b/advice.c
index fd58631dc1..fd9634aa4f 100644
--- a/advice.c
+++ b/advice.c
@@ -106,6 +106,8 @@ static struct {
 	int enabled;
 } advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
+	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
diff --git a/advice.h b/advice.h
index 74425a9f1a..101c4054b7 100644
--- a/advice.h
+++ b/advice.h
@@ -45,6 +45,8 @@ extern int advice_add_empty_pathspec;
  */
  enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_ADD_EMPTY_PATHSPEC,
+	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
-- 
2.31.1


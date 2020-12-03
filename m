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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A5C0007A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D721C207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgLCQA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbgLCQA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2363C08C5F2
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:58 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so2402188wrn.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ak+BRQLBQOT/BOTqNcUsFX79zLWvFGBTJU8wm3Epus0=;
        b=Y0qkcXRZoVq0nrOdiYq5ZvCl2wmL4+9LiNNRPi4zW7GFpM8eMKgboynp2ZNPeXR9Vl
         K866fTIRts1AWTCpi0dlX8Gyz3nbhPSIKnFfORCeAlUdRXFB3MdlDJ0DynPSIJ4IfRz5
         FKj/d2Kl2DIIAYLXLsb5OPYw5m0AKAFMsMkdZmhpNvbh5c8vzgTv+JM0UezawW1DnDVI
         a6rJQJlvktRVLrEfQNRsbTRAAvIRZgykvGKXUDJUzWYV9k9ehMN4tp6GruIUF4OgCNWG
         D8HPWrFIDx1iUBrzr4x+LA0uN1smhFsPpQRpmgPS3PA/Bt80HbGvqn2loJRKQMBv6Rql
         oIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ak+BRQLBQOT/BOTqNcUsFX79zLWvFGBTJU8wm3Epus0=;
        b=O9KGZN4jWyBl498br0qZsE3OTImJ8d44e2gE/oTrjs+fVu4kR2qJsL2bB/yTm7xEjD
         d7qHPpB3+BYIQqy1grxe5XZXzo+7+hC/Je/jwaMYhbgurqqa0XOrLQCjyQm+X9WQgkp+
         qz5XJ6Nsqezx5RXiqQm3DraYWf+ZHaS/C2fUMqy7nE3rYNT9lvxCLmW+DlYbFbzJ1T+S
         LuQoqEpHjtrT/t3qcRe6dFjHwPzTxpAMY3jg4yVEWZ1W3fjM2xjvs6v6hDhpgWnaHuBA
         55BJgYzTztNjUurOzFwH/13VniEI7fhTF8y3U1KkotqB/C3GUNS7OLEm9uuvKHkIKO94
         AMPg==
X-Gm-Message-State: AOAM532l7TWlkxuHMbQ4T4s1jQXnPUbMayIpCc66YGHfuipHinP2marA
        IcmOSy82kmlap72Njc9YfbcxT7LfscE=
X-Google-Smtp-Source: ABdhPJwwKlTU13TPO89GEeDhdYmZGLcTWD0faq00qK2XuIHDqv1vEpeMh9k8ZWTYEgw+VQNlEhKtqA==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr4453988wrr.205.1607011197456;
        Thu, 03 Dec 2020 07:59:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm2704611wrb.39.2020.12.03.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:57 -0800 (PST)
Message-Id: <9f1ac20e31886ad7cd56ff582c58cce4ee743fa1.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:45 +0000
Subject: [PATCH 6/7] merge-ort: add die-not-implemented stub
 handle_content_merge() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This simplistic and weird-looking patch is here to facilitate future
patch submissions.  Adding this stub allows rename detection code to
reference it in one patch series, while a separate patch series can
define the implementation, and then both series can merge cleanly and
work nicely together at that point.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e653ba35ea..e7220cbbb4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -523,6 +523,18 @@ static int collect_merge_info(struct merge_options *opt,
 
 /*** Function Grouping: functions related to threeway content merges ***/
 
+static int handle_content_merge(struct merge_options *opt,
+				const char *path,
+				const struct version_info *o,
+				const struct version_info *a,
+				const struct version_info *b,
+				const char *pathnames[3],
+				const int extra_marker_size,
+				struct version_info *result)
+{
+	die("Not yet implemented");
+}
+
 /*** Function Grouping: functions related to detect_and_process_renames(), ***
  *** which are split into directory and regular rename detection sections. ***/
 
@@ -919,6 +931,8 @@ static void process_entry(struct merge_options *opt,
 		ci->merged.clean = 0;
 		ci->merged.result.mode = ci->stages[1].mode;
 		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+		/* When we fix above, we'll call handle_content_merge() */
+		(void)handle_content_merge;
 	} else if (ci->filemask == 3 || ci->filemask == 5) {
 		/* Modify/delete */
 		die("Not yet implemented.");
-- 
gitgitgadget


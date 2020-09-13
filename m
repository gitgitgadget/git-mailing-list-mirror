Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95580C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589252151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+/wbIU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgIMOzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIMOyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149AC06178A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so3273892plz.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+i+i4q5k/IPo3h8/ve0PJSQQ/ooncupVnqoZavTeuM=;
        b=M+/wbIU59kkBq32vpjVKTwQpOmWkMfZIA8kNUEVN9NuYI1rNORZAPkP0kRSkHRjZwj
         8hGGGon0JjzgnO2sjQRwFAKjbmjd+KjHYr4Z4aU4CiLcxhVyb9Mv8MYVXM88TS7zn6BU
         7mVPfjWmxz6jG3WscvZfPv+UYeRFQyGG0r4JM8UAfnw+2D2g7hDdcHk2fgCWwptgzoHN
         uB0k8dsJwLQQdJkzOZkibJvifCDhcsT+S1KHik9DX+ZjzGJU/BpHig9pIMabuvSY6FeG
         MQmiVMZG/F84cfWxKytp/LvX0GEVqFo6ROGxcmXarfiI9IGKoMaRYmz7ariWezPRca9Z
         1F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+i+i4q5k/IPo3h8/ve0PJSQQ/ooncupVnqoZavTeuM=;
        b=AEHaPTcQpeaMGGeojL8iM970/Q3ZB3D7DAQV3XjAnXhkAipVTZGSMh16O1cFLzZwFF
         B+KMr7KTFaxFSJf9LtSoX21IzC7kw65ozTW74DkZfNR+7stxg2Mll7FIs0irLBKLTA48
         /Hn4LhYdBOfyjtw7IGBaoxz44h0S+lzGdLqRn8GSw6hqMTMjSb4YXR3N3KzymYrIGf2X
         amk4yoALiTCkbKlXtn0YS6aCCkzPReU6YbmT1svmYXYDlaOdY7c5Donv/x4WzWiRIJl5
         3Jo6k+J7/O8z2jwY+7AY9kJgmH5jjuvX3cSn6kybaY7ypTC236MENvWP1/iTy4C1ksJH
         Vynw==
X-Gm-Message-State: AOAM533oCLoBRkziVCHxUxaTqffERveZ6kkwHooPEVFfF9utgL16LPwQ
        RZDX04wzOQeBTxzJHdxlJi0PSCCJOqUfWQ9/qG0=
X-Google-Smtp-Source: ABdhPJyMFd/M0LIftXIYrosRNmkKLIC7y4m9xPG9NwGT3wDrRjPt4VR3gVitjG8VgtcDCPAaoE+P0Q==
X-Received: by 2002:a17:902:8a98:: with SMTP id p24mr10360661plo.58.1600008877153;
        Sun, 13 Sep 2020 07:54:37 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:36 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 4/7] transport-helper: update ref status for "force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:10 +0530
Message-Id: <20200913145413.18351-5-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update "push_update_refs_status" to map the string equivalent
of the ref status "REF_STATUS_REJECT_REMOTE_UPDATED" when set
if a `git-push` fails for "--force-if-includes".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 transport-helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index c52c99d829..e547e21199 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -779,6 +779,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			status = REF_STATUS_REJECT_STALE;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "remote ref updated since checkout")) {
+			status = REF_STATUS_REJECT_REMOTE_UPDATED;
+			FREE_AND_NULL(msg);
+		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
 			FREE_AND_NULL(msg);
@@ -897,6 +901,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
-- 
2.28.0


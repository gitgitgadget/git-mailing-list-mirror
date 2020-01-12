Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E1C3F68F
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74B3214D8
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSMYzYrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbgALEPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 23:15:36 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53955 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbgALEPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 23:15:36 -0500
Received: by mail-qk1-f202.google.com with SMTP id 12so3950068qkf.20
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 20:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VnQaPM0Mad1A+V1BPIrdiY9f3LDHQ45Vq0GKp0+1A3o=;
        b=qSMYzYrXD1Ow6LyyQ9ZKHQ6XpKaHAiau5JBvIJSJpxIhVwhPr3vLepoDo+Pg7hHJxG
         NrsizbjGzn77tqOQgzUpuCNILQW0+3g4KwtC11pXiJVRhHFlyyuJzzcdzzGJtP0M0s/5
         4wYDMOuMhb+PSAoiZsftBfjfD3+5ZD0a0j1VUS67viX1RQcRZtZ/1WYn2LPoKvbYP7QR
         dz5B59Buv8pb9hg0azqnuyPMB3+ZOMEcpoK8NvD4Yu77/1bMI1Oo4xUGsriiJlcVAX+8
         fEmEsayth86Dy1uOIl48wMC2Kie2fLp9567yzPVPnmXKHmbN6IQVR2y6/WPjk+kd7fzQ
         Qa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VnQaPM0Mad1A+V1BPIrdiY9f3LDHQ45Vq0GKp0+1A3o=;
        b=BXZzBrgK756RucgTxKsAxwvEzC5Sd4DklwaOARSLuUsUb3T5XC9ZuWqyljPqqwC0tg
         P5ZkGk41kL/EZT0JpgOMwS6D7dYtfpbR17PFgLyjykl5xa8QgeWFtdL1geKggHG3IdIx
         0CqEX28ZIAG0IDOFbmhYnXY+4nj3qTmidQg4KsHoa5v8eVDf8bxAtIG0a0hobb+sfDCr
         UMoHhFczaaIxohWJinnsAYwLwaCaQ9JhvwAIi277msXZFGwWbFcLwtMGUP2vrnBMDcRJ
         DukhOEiE04jaRyEVg5InbD8afqvyKjSA7OEVZGj53p16Dw0WXG0MMdyvGvPPXW+9xSDo
         9tkg==
X-Gm-Message-State: APjAAAXA/i9gwU06VnKace+fWDEPft27fl9JADQs5cXIAS3//LlAr5oH
        lXTuf+u+QHDCnou8z5G/kYZKufvPpPT3hAxLqwntFGwYjJ1tR1bCko/xTYqlsWhD1fVpt0P+wXf
        MDpHFjfMVeAkrZ4RTheC6fsoSDph9MLgKJKf+myamxvsLhNeV0j6zh7G+jvr1BuHX2wGs2BNbMo
        ht
X-Google-Smtp-Source: APXvYqzU2C1ohNrvnKmsNRL1mUf2LSpXZ8XSju4MV3rERLJ6t/ZGA8FOrzBqNvVSuu0OBbkgFIIFylYVKDIUyR0V0T1o
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr6048190qvo.91.1578802535279;
 Sat, 11 Jan 2020 20:15:35 -0800 (PST)
Date:   Sat, 11 Jan 2020 20:15:25 -0800
In-Reply-To: <cover.1578802317.git.jonathantanmy@google.com>
Message-Id: <be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1578802317.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 2/2] fetch: forgo full connectivity check if --filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a filter is specified, we do not need a full connectivity check on
the contents of the packfile we just fetched; we only need to check that
the objects referenced are promisor objects.

This significantly speeds up fetches into repositories that have many
promisor objects, because during the connectivity check, all promisor
objects are enumerated (to mark them UNINTERESTING), and that takes a
significant amount of time.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
For example, a local fetch was sped up from 6.63s to 3.39s. The bulk of
the remaining time is spent in yet another connectivity check
(fetch_refs -> check_exist_and_connected) prior to the fetch - that will
hopefully be done in a subsequent patch.
---
 builtin/fetch.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b4c6d921d0..6fb50320eb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -906,8 +906,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	if (!connectivity_checked) {
+		struct check_connected_options opt = CHECK_CONNECTED_INIT;
+
+		if (filter_options.choice)
+			/*
+			 * Since a filter is specified, objects indirectly
+			 * referenced by refs are allowed to be absent.
+			 */
+			opt.check_refs_are_promisor_objects_only = 1;
+
 		rm = ref_map;
-		if (check_connected(iterate_ref_map, &rm, NULL)) {
+		if (check_connected(iterate_ref_map, &rm, &opt)) {
 			rc = error(_("%s did not send all necessary objects\n"), url);
 			goto abort;
 		}
-- 
2.25.0.rc1.283.g88dfdc4193-goog


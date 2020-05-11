Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB27C54E8E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB97E206D6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYCW8tm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgEKRnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKRnP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 13:43:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C9C061A0E
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g17so12523405ybk.4
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXvnFw5DSynKaqJB4JyX+C4cj+Wzy+yU2qOfv+2H8HQ=;
        b=MYCW8tm8kRJ2DBmAXirlfMqUU4hZycDSxUQWTHEyjyAGPvIvOqOSCptKLTcIuKLUib
         VIKoAZp3KlYoisETVEqWS5p9ZSuqUc3vKt1Kozj/1tLXngdKlPSRqb8/cm62mY1Sy00V
         ZrRe8gMGC4bWkVHMmZyga56Dzfe6rU+Rae7ZXU0MpDkJHFmmqWCdQV57hQyWzXerl2nQ
         S0cNlQsF8NsxLOpUe6M2uYyyKRh2lOV5J2EgW65CZ9PnWCBtpd7D+LstREo06O8S1LcC
         JNZzDhrjh3iemaA7Y0wb5LbiTubBhDm8FugKH42Rbs/QHr7w38jCGa0pcoL+RP58X6T7
         UzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXvnFw5DSynKaqJB4JyX+C4cj+Wzy+yU2qOfv+2H8HQ=;
        b=nTR53LpmMs48naDI6oWuF30l51xkTsLfs36afQYaHY0Q2KJe9Zb2EH+RPN9Jio5oTt
         Z+LaFHpW1kLBHBe/Mgkvttxb4ZELcLIVeqjbU2PwnfJdl/3a3eOkyfutqEScwkYHXNq3
         LMlwUrENKvcbcqt8WhDFM8oKHRs8whJpMWuAjWaeBiEgqvZG+6s5HVCZuKs9QgJh8Fag
         TTGD602ySHukGv664//l6pGxlglGBQzfSAVJiqOtSwr9yfm1yvckdhXrquNPtPEqsph1
         ZxA91u/eXt0QGEb2XF3eSV8yFDkhyIht1J+NDRLYIdhuB4zR7y2gz+k/KOgLwCjdzrHR
         QavA==
X-Gm-Message-State: AOAM531J0HeI3i0KqJu1FJZK3wcUy8BqUk3jxRGQOTf/eLbp3Rv4FJkM
        wRRdK6lHGj3nd2QRzbp4p2XP0sj1hr2q2Pch9EX/nNPjIyYO5C2GLBQel9/w/VWYLBnvhrkIJ9H
        I9EaNdENR5epr9dRl2Fglq/4Q5WnXg6YFn5hAM04MK1HHuAW6YZD/WMvSGXCEmWe1oJf+uxZd2X
        aw
X-Google-Smtp-Source: ABdhPJwYk6wizewIJwsi5COXnDZVcOqU+Xnifnky6BA2VAXOQyBYFd0Wgn7DIZuI2YYXj8Ejk5C1hIz0BXYEQefe/7Cb
X-Received: by 2002:a25:dccb:: with SMTP id y194mr4946491ybe.384.1589218994648;
 Mon, 11 May 2020 10:43:14 -0700 (PDT)
Date:   Mon, 11 May 2020 10:43:09 -0700
In-Reply-To: <cover.1589218693.git.jonathantanmy@google.com>
Message-Id: <bee4fc7241596a6b4206fa8b52dfdaea88180f37.1589218693.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 1/2] t5551: test that GIT_TRACE_CURL redacts password
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Verify that when GIT_TRACE_CURL is set, Git prints out "Authorization:
Basic <redacted>" instead of the base64-encoded authorization details.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6788aeface..acc8473a72 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -185,6 +185,18 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
+test_expect_success 'GIT_TRACE_CURL redacts auth details' '
+	rm -rf redact-auth trace &&
+	set_askpass user@host pass@host &&
+	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
+	expect_askpass both user@host &&
+
+	# Ensure that there is no "Basic" followed by a base64 string, but that
+	# the auth details are redacted
+	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	grep "Authorization: Basic <redacted>" trace
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
-- 
2.26.2.645.ge9eca65c58-goog


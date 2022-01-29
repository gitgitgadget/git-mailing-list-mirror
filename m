Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB3C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiA2AFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351896AbiA2AFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:05:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39317C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:10 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id i8-20020a17090a718800b001b35ee7ac29so4690897pjk.3
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PYaOlH62NZLlsBDr+BRhxyK9q4TStg2MqzBUJ7WeDl0=;
        b=jNdJ5RCEL8johM4kDeh9ioEtjyCSt6mi0b9DT5IpO8/MTmskyBSX5fphpnUxMuMKqn
         RY+7F+q4FHZ8fSfl3Mp51iD+MeEtNvkksWInIvHNQeUSnkmqgDN+FsQjIKRWg/XUPDWj
         AnRQ41wm+AwX4/VzDPf51DI5KHlKdVpOGqmzT0Q1/oPv6QOYT/xGna6t0xg52i5ARpkM
         te3vyCqEKgVXKgj/OTzp/1sQudAdaJZT4FJd6I2VpVrOcgatnLPnShWMQ0QhxX6b/xo0
         6ydMVZCHefPXJh7OVx/7p+49AzZkBc6yTW8Uah6xnPgY/S9Af9l22x5Vu38kTKjZLVRP
         H1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PYaOlH62NZLlsBDr+BRhxyK9q4TStg2MqzBUJ7WeDl0=;
        b=Z3shHZXwTMmLIDlHKC4adFZ81twZ5T5vGMD4AEqaQztqgsmppgDLtLCp01b49jHYwe
         GauxIrR2Yj1nxRgWrlxtwuyP0ja/C7UlscLNcAlz/n1pAVlsOUPlCcOwgonmgQm2GT6k
         r3VnE39Wkp5emkGU/60LwtH+MG0drPhMWHVtwHRTuME6RvRXv5J2PEyOTueqkUeFCmBi
         KoBDVt9PkiQ1Qas+zEdKgOgdJLeOI9WA9LaRK3ZGcMUms47MQnfzlXa0i+GYUDohlbck
         xwmAnd+6mbuuWfRWrbudF1E1fg95HSFHxGlvogKkAfYGaGO1F7d2vVdDUnqb7ye0EiB5
         LftQ==
X-Gm-Message-State: AOAM530pGEnsR9BiRU3t0lCjI5IOFFWA0O81tpKAVPjVnLXO+ci0jmIe
        Q7mP6C0ZLZjDyxKny+oTMckNnQxgphQ2hxzDUSmpsrMkGUBzxg/1sv0Tmjw85Xto6x8MyN43Q+Q
        kRpKF9Ye+YXMXSm0GZJEgY4U8Tc+tBsj2OhUqoJNFHbKm0S3+Ly2kOiUlsd9fZt0=
X-Google-Smtp-Source: ABdhPJyHIMD9xzT+TLmpc1Wn6lW+lFzK+OuurPa/q1p/M9aUZHDPevPPTCG+n9TV24N/sQz0lSqfOTrQgP7/aA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1d06:: with SMTP id
 on6mr22566147pjb.6.1643414709619; Fri, 28 Jan 2022 16:05:09 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:46 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220129000446.99261-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 6/6] branch.c: use 'goto cleanup' in setup_tracking() to
 fix memory leaks
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 70026b3c79..47251669e1 100644
--- a/branch.c
+++ b/branch.c
@@ -239,7 +239,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	if (track != BRANCH_TRACK_INHERIT)
 		for_each_remote(find_tracked_branch, &tracking);
 	else if (inherit_tracking(&tracking, orig_ref))
-		return;
+		goto cleanup;
 
 	if (!tracking.matches)
 		switch (track) {
@@ -249,7 +249,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		case BRANCH_TRACK_INHERIT:
 			break;
 		default:
-			return;
+			goto cleanup;
 		}
 
 	if (tracking.matches > 1)
@@ -262,7 +262,8 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 				tracking.remote, tracking.srcs) < 0)
 		exit(-1);
 
-	string_list_clear(tracking.srcs, 0);
+cleanup:
+	string_list_clear(&tracking_srcs, 0);
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
-- 
2.33.GIT


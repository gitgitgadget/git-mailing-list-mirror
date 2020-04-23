Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A26BC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3402087E
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBJYZTTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgDWNsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgDWNsJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43FC08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so2903835pgs.9
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Svij7AqIu1IfO1+ocfAXfydIcw/vut33rQEygmYm5k=;
        b=QBJYZTThdgXDehoE8lxtFJYikuoex0WCTS8diwZ01hvUUZpkol+pvK4Duefs1JdkbH
         kp5W+h2rp9PhMg+wGs5o4Dp57sjIoT7fB27OsOhayq5QPD/E2kzX+PivhRjaaaiP8WLd
         CCY20hN5h7Q8QGqtfxl1SQMW31C4W3E13oJ88xth6tj+aIHTC/zlVmTr9/b5uSnYIkqw
         mwzNPb39OYqVLmppoTTinKQV+nMmFjCdjfqrd2dHEw+MtSWM/TQcBxW2iZUv9d9nVAed
         mivcSCHxHAAQ/nsWw4DCZQV3i64C4X9PuR32ko9yqGMrk1AIiw3Tamru1uxX9L+8PH5W
         7glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Svij7AqIu1IfO1+ocfAXfydIcw/vut33rQEygmYm5k=;
        b=X61lseXy5lVdhgOZFeMYfU//YaVUxs1gg7q0O2/wuXFl4cN2YelzPn9SEkTb2TU+4P
         qj6wfNnC2AWeTNvDLBYFmfiz0zam9N6R/eOa++wVseCHEaJsiFthkuRErNuhVKCgtqU9
         XPYjUEGCyMLFB9LnMba1SzdY6jJC71zEOzZ110FrbsT2P6w2BL4VQQhMYlSG+wtbG7q/
         /eLicv+CF2Dnbp8hSRHWTxPKokyoecXLMHZqUUcakiEb2FAqPwhUOSNJwWETIpRtbQn1
         wrWghmcHoX2TFLSIA656WvqCeBZDI1Y02EiRTr3Oh4nAaACrjlLQA48NjW0jsQB028Z/
         YWbQ==
X-Gm-Message-State: AGi0PuZmIPQj6LL+kujxHVkJ/bipwIITGuw7GBGsMaivzpvX5hKy8nq4
        YEyRYcCo4VFmQT5oKiLeE1ByF/ik
X-Google-Smtp-Source: APiQypJLkTjRfatBZVPvQ4Bxy7m404mWc6uuNI0tl8LltZHProp7ouyn/6aN+QiPrgiL3dbM0bHBig==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr3833764pgh.394.1587649689201;
        Thu, 23 Apr 2020 06:48:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/4] graph.c: limit linkage of internal variable
Date:   Thu, 23 Apr 2020 20:47:55 +0700
Message-Id: <5bd7b929107c277e10a697bc874b702b85691558.1587648870.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 4fb25ad464..4cd9915075 100644
--- a/graph.c
+++ b/graph.c
@@ -1055,7 +1055,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-const char merge_chars[] = {'/', '|', '\\'};
+static const char merge_chars[] = {'/', '|', '\\'};
 
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
-- 
2.26.2.384.g435bf60bd5


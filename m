Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0AC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01CD61176
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhHYCXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhHYCX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA0C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b9so9046306plx.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LGz2nbArDUtEP+kmAKLGRouLOLkJB3+JfDDtW4q7Sk=;
        b=NklSq3rmHvbRKRKDYP1rnvoVsfA+c10nwmX99detj8qKE/nv/5h0wG1pMMZw88Oe3u
         tSmdChMigvL25jCCvfJ1abXhhxMnC5czUTm1oB1/G5gRQAJ53im1Li9HGb06hSIiSMRw
         pyPnrpS82rfV1t02ggD8URhKBL7p0c5lyUb0IHeP+it9Z3+qfel2EAia4xPSosLGauBb
         BRBToSJM1HAXf29WJjSJxUDkuZ+pGXYY2P4B5VvSoK7MAs6fE9RtpG5ejjfe2/VN9F1d
         n/M5NTTnSSKjFzin/84vWFLDUtMUSoJp13LPBU7EZdzstPlpsadE9wBQGyzHc+lmc2RY
         Tvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LGz2nbArDUtEP+kmAKLGRouLOLkJB3+JfDDtW4q7Sk=;
        b=KzSuGOb+GtJcBkMuEJegNrNMD7wLwCO47jato3JUe7IYIcLNoR4NpravVXwX/UJWG/
         PR0B6NRJ6N7zHp886hVQRJjFuhm0aF2LF1KZxgBo0VDscU6JZ2Hsur3bD8fXbTWGzhIz
         Bo+rd0ox3obJEUBnfH29qyThY4mAoQLn4ERI53l6z3PZryQv92NYP/9kzrMu747+bx3s
         WKF4KtyRkv/hPghxMXw7oN99PfzWTvpg0CACZlFm9EYQMoEJwxGtCQMNh+UYVTD0LTjD
         WhZO+NyZmjevMXwfGR9o+uHTzcrFriRNx72I+A8Fxev3TBTyaP4/hVKHsR8FzLQK+fnt
         dpUw==
X-Gm-Message-State: AOAM530z0nw/WuhbBWOU2+YHBWvGLOIlFXpD3xF187slL0tpSpPqG0AB
        nF+RB632U1g/mpHfp0ItNwJsh9fyuTl9mcfI
X-Google-Smtp-Source: ABdhPJyNQ/nmIH7rjg9TErKRT79nWRdEmnpBWac37Ffzr0muJRyaum5RNYJSr2AwKnvfas3QX+xEUQ==
X-Received: by 2002:a17:90a:4a95:: with SMTP id f21mr8001271pjh.122.1629858161063;
        Tue, 24 Aug 2021 19:22:41 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:40 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 13/14] t5702: add tag exclusion test case
Date:   Wed, 25 Aug 2021 10:21:57 +0800
Message-Id: <29a52b7a0d8a2169d19aabed3a48e59dd9ae3d34.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5ad52e0cee..09683ebfdc 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1142,6 +1142,24 @@ test_expect_success 'commit-exclusion: part of packfile response provided as URI
 		http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 4 filelist
 '
+test_expect_success 'tag-exclusion: part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log" &&
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+	git -C "$P" tag -a -m "annotated_tag" tagA &&
+	tagObj=$(git -C "$P" rev-parse tagA) &&
+	configure_exclusion tag "$P" "$tagObj" >h2 &&
+	git init http_child &&
+	GIT_TRACE=1 GIT_TRACE_PACKET=`pwd`/log GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child \
+		-c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch --tags "$HTTPD_URL/smart/http_parent"
+'
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-- 
2.31.1.456.gec51e24953


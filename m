Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C23F1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbfKGC4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfKGC4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so394557plt.13
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkL25oIYIv+X92y2cOsIq1B0f91wLMG/AdaNOfxWBsE=;
        b=IZpFW3sUDILSvUeLjE8urkCrii6JpPfqWpvRaW6C3S5Wj1WRtaI4sSDAtKUSgc2zvg
         RJ6sl/B0Fcmm82a+S9hqH6N2NyBhDVVBXKi1ITw2hCW20TiM2Lkug+htARKOF7vA6xIK
         EygotJAPdsUwei9e0cNuVviKDFwXL7Dht8h6pIQGmPRgxDfJPA+MlW6nCvxzee3/KMgu
         AZwECZTr7X+is0eACIm6ex9mnFdaGRuPSYf2TMN9cUI/okU5pSYKwFVbenqa/mgaLoCH
         F0hKCv5TxbFqxDhu4+JbuX2nV5KV+UUZRM7SzqKAYmtZreeWzeq3sC18yPZ8ixlmtXlw
         z2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkL25oIYIv+X92y2cOsIq1B0f91wLMG/AdaNOfxWBsE=;
        b=mk33r0S70CoKPwuuyvY2CWftelQtyaGPZu4NTyHxHyRiVLFbEQ2NKoQWDbupIO19zS
         RvET5LoF72WATqy/nRssb87PY6FGiMEXlnmOASlpEnWFum6G4HSkY/7NNs88c1Xgp1qu
         fYDwDE6ctDG0G9rBmWL7+x5GKtiOVJ2gf+Hte/pP1FlRqJ0LjDlaOpPQ4fzBXQFwaC+b
         4wqwg5gScxdtcTEisa/4B6bvOfI9cobG41WOoeLQORFitz/c45vXuANAv1iYPSyTDFQu
         ZnSO/7E2+U27QPpXx6A/zZ4KW2YbvzErQZlX5eBxveEKV4dbCcf+I+z+S3JmKgyv++jI
         +2dA==
X-Gm-Message-State: APjAAAV+b0Ih0mHHB5Vae0eQtLCYtzipq6/cwWXost3R1hJajz9obPaC
        rSV+WyThKlH2O+m/KrcNFGdXlGNc
X-Google-Smtp-Source: APXvYqxJcmh6UixLlsr06a7KPb09rmm1KI9vUXMx3RxG6BaCah4q1aVlPJ8xkdssX6HWyyoUWIJ7Xw==
X-Received: by 2002:a17:902:758a:: with SMTP id j10mr1182649pll.29.1573095402061;
        Wed, 06 Nov 2019 18:56:42 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:41 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 8/8] sequencer: reencode commit message for am/rebase --show-current-patch
Date:   Thu,  7 Nov 2019 09:56:19 +0700
Message-Id: <36796e2b679cd8b2d341058e775db401f9abcef7.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message file will be used as commit message for the
git-{am,rebase} --continue.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d735d09f98..4d12ad3cc6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2972,7 +2972,8 @@ static int make_patch(struct repository *r,
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
 		unuse_commit_buffer(commit, commit_buffer);
-- 
2.24.0.8.g36796e2b67


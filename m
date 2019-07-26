Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0A31F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfGZPx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36398 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZPx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so24931130plt.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qztoah4mGPIon6k+tdJoMNxVI8q3qQtItB2s1j6xz+M=;
        b=CX/XIzkQYG9X8lt/BZKFe9/PpfHaOQF/6PnRjrOnrWxkb+Zwfq56YDUwyePyqM2CG7
         k2iCIog5aGHDRLQoebnP3O1+X7MCSD9e6nwt1l+rK6tSnhnv845Qp0HwMuJNuWJEdvBB
         IIu0elf2QJv5OlWLJrJ2VNsHv7TZEmLAjpFQLIZZK0Op/ng3vsX8hEIHyyMiaF7xfptd
         L/XXLzYnkkupffAACF34uTujIgdkBSM9ZgfGy35O0g3GcIXUXmn/ohUpcozFpOng3l3C
         ALjNpHNjrFyAtL4wPtEpljk4KGW/dO14+5U/+HX5YIm7c2ZUoHvX4FpqJvy6jQagJtr2
         cCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qztoah4mGPIon6k+tdJoMNxVI8q3qQtItB2s1j6xz+M=;
        b=fu1Oyuhcvl/ral1Rp4djr+GBeL9+9WfjxAmCdmdYfPF3apsO6T0+DszmQcYYGhxNA5
         e/1Zf6Qj6D5irmU4+ibHmmmqlMrNZ9wDZ6m7cqMypFzGKxR9obPyz+AxKB1C0dRtv2gu
         oa4s/J7KqnHLZaSKcoT97dswqxwgZKbfCE590iliW0UM6msFMDsWhz74gcKnPVQ9gFCo
         c3S27nqehVeIJGh/6KhwaWc3AKZMvHihVm+Ej6Wy9n3Zr6I6P46/xKR0stfSK4M1md0L
         izA1a7dLFhi/NLF44TA6tINf4gopcAZD/Ns5VKDqcvmZ8ZXKB18OKv3naF/RBjVHOCV/
         Yzew==
X-Gm-Message-State: APjAAAUomQ/wH4p2VHlLPmdNL80YI/DIQZEuH5+LzOd+WgaBsuYfLcDV
        UXilu768jSkPZxRRewD3OZDYO6Zm
X-Google-Smtp-Source: APXvYqyR4FDNAiPmqksg0fpC5Ju1Ppmwi8+rQh/9bGEq7pwIdG69hVBIhX0HSr6Fhfqnu+7V/cvppA==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10mr22952213plr.69.1564156406157;
        Fri, 26 Jul 2019 08:53:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 19/20] merge-recursive: be consistent with assert
Date:   Fri, 26 Jul 2019 08:52:57 -0700
Message-Id: <20190726155258.28561-20-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), an assertion on a->path && b->path
was added for code readability to document that these both needed to be
non-NULL at this point in the code.  However, the subsequent lines also
read o->path, so it should be included in the assert.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 49eb50c17b..f1e2658457 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1058,7 +1058,7 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path);
+	assert(a->path && b->path && o->path);
 	if (strcmp(a->path, b->path) ||
 	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
-- 
2.22.0.550.g71c37a0928.dirty


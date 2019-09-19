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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5F31F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404900AbfISVra (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404758AbfISVr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so4713887wrs.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2NywZg190sBMlIfdAdjM7U+vNWYMaSqu2GAQJsAFtc=;
        b=Lu7l/mHxeVMCb1E8EU/vdy+oySbSyudFvVdqnLWxStYZ1Gv1RdqxWvAuXp7JbJ0OAd
         km7mT5l27Niz0bTSxsERIfTQPNdVa4gHBSm+oIj+djhSXt8mPnrP9QFrJ1+ZYQGj1RVP
         1fVOnFz3jsLbPvSKpyi/xmzKnmZ6Br2Mivb7L+lH4HLV/lp5g+EzzXIGlTd5tlYz8EFJ
         vgMaU03odjKEgZ5fv/66wWnaghckMYSUlArFj5psBD91mUUiB9WMGMbRZQAnVcdm3nzN
         W+8QGrAgu0XxNTMekeRxgHi8NDnjV+rM234ACKBrwUn+fZYSm4gIUjIP7ZwFRVrdUZur
         hIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2NywZg190sBMlIfdAdjM7U+vNWYMaSqu2GAQJsAFtc=;
        b=q0/411gZJPvLnlXKf8Aec8yMlH/QjUVFlSyTy7PlNh5Y23J4ymuIc5/HpLQDcknBGS
         VySFxbKdGOdmpmx2IgQSQMTQoe2bzTcgmkLkYE4wUfrB66q3urvAItn4bCKXC9RtydAt
         hyK7Gou5NSSPGxLgPbJxgA68ZUCfou/OUJCmpDOaWOsn6hrGAzkOsNTvSi4dALoO4EDm
         ZvUGCaeBs2N04Lw5NaItDuBarUBllLfp2XBhL2E0U3MkTeU7jtspZqIN3O4+hm5L9D5J
         tbLTqQ5tfihDfxFDVOucTiTB/0Qe3ABRYsn0IerGMnZFkw3S3ItIM7XcgyH+jAQvxEox
         i5Nw==
X-Gm-Message-State: APjAAAWNxEGpep32rgQggsKRxoRaKSQFa88Ocz1luYaW6h7YQwyNg1l1
        j4m9tcZUKcQqBzjSTvCXULo=
X-Google-Smtp-Source: APXvYqxIJgTsKQtVsI7N8TQDVxcbjPDiNuJ9T+xg1/9E4fs+cJ57GLLadObGkY+Y3Yldbq07mIHySA==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr9346250wrr.334.1568929644548;
        Thu, 19 Sep 2019 14:47:24 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/15] name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
Date:   Thu, 19 Sep 2019 23:47:00 +0200
Message-Id: <20190919214712.7348-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e406ff8e17..dec2228cc7 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -98,7 +98,7 @@ static void name_rev(struct commit *commit,
 	}
 
 	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
+		name = xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-- 
2.23.0.331.g4e51dcdf11


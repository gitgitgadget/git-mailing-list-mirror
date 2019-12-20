Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC131C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1F2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR8e8x/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfLTSOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35577 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLTSOp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so4437440plt.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kc3R5dRmMVYqjFAiyQAts3Ju9CV9qoOxk1oAWYwbw3c=;
        b=fR8e8x/iushdVobNfwZ7ZBVo1vWfMFlA5/bu0B5pEe9JHRehopVkYDCLcBBGsO/0Dq
         FKjGNgxL4YobJduh9kF7XqqzO5poVMfGRDrZhdeq1H4MaVZm9xmbFqJzmKGtDUtnKgvL
         J5YLphXPsOvxIAruT8hvUQI9FZVTIPY30pXaXrbb039kzoEHJT0BWgV1wwKbX4ZMT0II
         fxd4JEhYvHEF/TL0qzcTOeHRiJGzzUbE+j2U7xD3wbOyYh9girkWJ6urDUFiXk8t7hqL
         j07QPkYKnXi9IbPPUXDfSVv88HLv+2eS2K4j1Nkkag97ykGIBHyHRBf3RoaJYDUH4tNa
         r+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kc3R5dRmMVYqjFAiyQAts3Ju9CV9qoOxk1oAWYwbw3c=;
        b=Ic8UGkJw+To46JgGHF0QCvBSc7q2WvMAijPJG3KhFz5JfyO/1i+73QMn3cWtnfrM3F
         YQ15qioaSvLU/mSKsCl/hnEm6nUMUD+ZTFmkKvvIFQIK/kA/WzEOWYsn8TU1Zyf0S1Dh
         HbL96b/wNiSV+rR+WWI+cStRimpO5LNG4+FQPdtrb4QVkcZnOZRN1noESIh/D4wRm1gD
         Ka5H6zpi83W/M7GVlYXI2UCxous2LdafhVS2nrEa1+fH6C1PyI88yPb6HdmOKGAKcWzM
         m+2pZxdJM3JOaHdbXSaQDlskkvpDiIGmnhKbzqk7+w08ROpV2mYDvI620Fi9K/TzPeGr
         LCJw==
X-Gm-Message-State: APjAAAVN/Ofpcbl1VeQ4hcKtXP3y2nyjnd06M9GdTJvuSQsGej8pFZQW
        nns/gx7jRmXPljIJh5vB2RqXIy3Z
X-Google-Smtp-Source: APXvYqyGppinx82WIqeenteLccf4FWyMVftU5ggCzxfFga5KOK3m0qTI/A1oy85PYfBAFWMJEZxf1g==
X-Received: by 2002:a17:902:67:: with SMTP id 94mr16934336pla.241.1576865684414;
        Fri, 20 Dec 2019 10:14:44 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/15] t1501: remove use of `test_might_fail cp`
Date:   Fri, 20 Dec 2019 10:15:59 -0800
Message-Id: <fddd2242259ccd8ec76954942901177b4f063a90.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
a compound command wrapping the old cp invocation that always returns 0.

The `test_might_fail cp` line was introduced in 466e8d5d66 (t1501: fix
test with split index, 2015-03-24). It is necessary because there might
exist some index files in `repo.git/sharedindex.*` and, if they exist,
we want to copy them over. However, if they don't exist, we don't want
to error out because we expect that possibility. As a result, we want to
keep the "might fail" semantics so we always return 0, even if the
underlying cp errors out.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1501-work-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 3498d3d55e..b75558040f 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
 	mkdir work &&
 	mkdir -p repo.git/repos/foo &&
 	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
-	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
+	{ cp repo.git/sharedindex.* repo.git/repos/foo || :; } &&
 	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
 '
 
-- 
2.24.1.703.g2f499f1283


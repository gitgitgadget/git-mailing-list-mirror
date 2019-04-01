Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D2020248
	for <e@80x24.org>; Mon,  1 Apr 2019 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfDAUwC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:52:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34343 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDAUwB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:52:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so5087517plt.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xW00cASk1Oe66ISAgQGokK/mMcbXitwScnZIEDwxwo4=;
        b=EwvJuohsYGt4kE3/+7SMJNnVuWETx40/totWh+2y7B7RdkxiXYnn25VG5mUmndgJLI
         smGI4IiWgd3pFMMDiDFenN87tA+XhXIi2sH+g/akMQwMFeP6eKJ30ryRjyM36doTVBh2
         FydjYVJtQXuG15rQ4qjP4064GSr11yNFav41T/9/QOa0poVzfceiCFmszR6vymIxUfX+
         J3NTnkGOhELzJc0Vnh4AalFoVPzm5bnAYmM+tY2k/eDfpsq8/M91GIlPlLtX9UTdNBH5
         JU2qJu+KfdgsY9S2w6tPLLCXn7tDm6pDGhd3TqWArlNiJ9mxi+7PrimZllWGwnJUw5b2
         u71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xW00cASk1Oe66ISAgQGokK/mMcbXitwScnZIEDwxwo4=;
        b=h1QsIOUaVRJjaOLigx8/k2r/41+LCfi83ayq2y4/nAhj5glP/KBtWZBaN96bzsjIFQ
         asDmfRs07MDhZjK++iBZYDAruZMRu/yLMHzGLcuesBIiHWM2F6OtianaIsklk5hEurR+
         jRdIk4TzdKgJvO+EukrW2JWhtMUWuN42BnhW//Xr2+W4F3FCuW6i7YRfCghNRYyBkxk7
         KxJhYB5NaVwaMC24fA7OmQc2PmoNGG0+NU80SzELU20RKurxbnApLDXVwhuLHrRbFqlw
         /9AweX6h15n9RJAU7lliV7Nl4WNfELeUMzZn+Hu105CnikcB35o6PtKVvt3Q3zE5AGGA
         Fpcg==
X-Gm-Message-State: APjAAAXm0byCZTExwy55y52mAXSSz3ctKqjL9c+RMNl8UBdLw04M83O1
        PeKLRpQ7WHtwXzQTOE51n74PcRS5
X-Google-Smtp-Source: APXvYqyOo+/AKLHe+yqoQGpaP25ubOISN5OaYQ7aZ2AwJVRV2RKX9YqW1aLDlqHoGbQTx0uRikkabw==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr26310103plb.309.1554151920651;
        Mon, 01 Apr 2019 13:52:00 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id f125sm20023797pfc.91.2019.04.01.13.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:52:00 -0700 (PDT)
Date:   Mon, 1 Apr 2019 13:51:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/4] t3432: test rebase fast-forward behavior
Message-ID: <4da2fe9b0429e10821e1cb96b79500c749fc31be.1554151449.git.liu.denton@gmail.com>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebase is run on a branch that can be fast-forwarded, this should
automatically be done. Create test to ensure this behavior happens.

There is one case that currently does not pass. In the case where a
feature and master have diverged, running "git rebase master... master"
causes a full rebase to happen even though a fast-forward should happen.
Mark this case as failure so we can fix it later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/t3432-rebase-fast-forward.sh

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
new file mode 100755
index 0000000000..3e6362dd9c
--- /dev/null
+++ b/t/t3432-rebase-fast-forward.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='ensure rebase fast-forwards commits when possible'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	test_commit D &&
+	git checkout -t -b side
+'
+
+test_rebase_same_head() {
+	status="$1" &&
+	shift &&
+	test_expect_$status "git rebase $@ with $changes is no-op" "
+		oldhead=\$(git rev-parse HEAD) &&
+		test_when_finished 'git reset --hard \$oldhead' &&
+		git rebase $@ &&
+		newhead=\$(git rev-parse HEAD) &&
+		test_cmp_rev \$oldhead \$newhead
+	"
+}
+
+changes='no changes'
+test_rebase_same_head success ''
+test_rebase_same_head success 'master'
+test_rebase_same_head success '--onto B B'
+test_rebase_same_head success '--onto B... B'
+test_rebase_same_head success '--onto master... master'
+
+test_expect_success 'add work to side' '
+	test_commit E
+'
+
+changes='our changes'
+test_rebase_same_head success ''
+test_rebase_same_head success 'master'
+test_rebase_same_head success '--onto B B'
+test_rebase_same_head success '--onto B... B'
+test_rebase_same_head success '--onto master... master'
+
+test_expect_success 'add work to upstream' '
+	git checkout master &&
+	test_commit F &&
+	git checkout side
+'
+
+changes='our and their changes'
+test_rebase_same_head success '--onto B B'
+test_rebase_same_head success '--onto B... B'
+test_rebase_same_head failure '--onto master... master'
+
+test_done
-- 
2.21.0.695.gaf8658f249


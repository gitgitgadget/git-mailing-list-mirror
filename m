Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5A21F404
	for <e@80x24.org>; Thu, 13 Sep 2018 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeINDuI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:50:08 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36587 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeINDuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:50:08 -0400
Received: by mail-wm1-f49.google.com with SMTP id j192-v6so65587wmj.1
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nk50ULICIAi4qHwFIQxSjBzd+T9Je4Oq8QuK21/01VQ=;
        b=UGeto/QmSN40A+P9X6yDaQShHSmcpglLNy8eny9hQmzK+poodLfyvao1dKkfsyHOi6
         grnc80vKUUC2rwkxoteoDQeSBVUNyP0P97iTE8bSCOi3MAUVf02uvYB3hT98kKgv4T+M
         FLuRei390yBWi73endtwAowOpJtqTIsZ8BNf0p2+p96wJhqXadJfRRcvEdiXNYttzZuX
         hGIxLanIrWeymJbONqTH/PTlIrPv5KFPmzj9tIJSQ/BFYm/7dBsEzqe3IBaME4WzZGWC
         QGqgUOZQfDhPbfkIAJQTJAOBtwJDH513va3cT7Og21vmYpTwD25l1qFUysIgTmry91aA
         wxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nk50ULICIAi4qHwFIQxSjBzd+T9Je4Oq8QuK21/01VQ=;
        b=UXneP5Aw8Y6yyRDlOlGZMgzGegIfdkHxdYk6VLPN4uW1eoLSRZeETXDlAsOg0gocqe
         RHWvZrU+gFCjYDRVG4OtTTM/qtkg2EWUFJkY3hy6ZndWJYDAXXeUPtVM8/yAVshtTeml
         wjZGbEKNw4t9YkR1h7B8Tijr0lvoyIKqRDQK/sUxIhIkkWs383rjbRSHpiK05eMoSQgZ
         ebOEUtfyDLiv3qxNU/sXVjOCE7GEDLXLLnIr7ZNV3SvaygoSAJLS7gRywrLjIOcLwNbt
         dV1IwYN89fWyrOQBVNzBg67B+Gl9FktYLEALDi4M7im0Gh45yqUwU02YXXvjSbAYCLx1
         py5Q==
X-Gm-Message-State: APzg51Cv/vMe4TKZspilRpt8EVb+NAsbkRNW7lvUJWVPK+RGk+aU2Sl9
        8IwBvTxR49EeMLOMqjaX5d77LhXf
X-Google-Smtp-Source: ANB0VdYhZkRJhwcDc5e/0p+s+FW7mGKeOoyvDjIKy1I4Br97+i37OLnGNeHklUGdKFUbMfbiZ6ODPg==
X-Received: by 2002:a1c:66d5:: with SMTP id a204-v6mr85444wmc.159.1536878316246;
        Thu, 13 Sep 2018 15:38:36 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id w10-v6sm7458241wrp.31.2018.09.13.15.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 15:38:35 -0700 (PDT)
Date:   Thu, 13 Sep 2018 23:38:34 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     ryenus <ryenus@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] linear-assignment: fix potential out of bounds memory
 access
Message-ID: <20180913223834.GF1719@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com>
 <20180912190108.GE4865@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912190108.GE4865@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'compute_assignment()' function may read memory out
of bounds, even if used correctly.  Namely this happens when we only
have one column.  In that case we try to calculate the initial
minimum cost using '!j1' as column in the reduction transfer code.
That in turn causes us to try and get the cost from column 1 in the
cost matrix, which does not exist, and thus results in an out of
bounds memory read.

In the original paper [1], the example code initializes that minimum
cost to "infinite".  We could emulate something similar by setting the
minimum cost to INT_MAX, which would result in the same minimum cost
as the current algorithm, as we'd always go into the if condition at
least once, except when we only have one column, and column_count thus
equals 1.

If column_count does equal 1, the condition in the loop would always
be false, and we'd end up with a minimum of INT_MAX, which may lead to
integer overflows later in the algorithm.

For a column count of 1, we however do not even really need to go
through the whole algorithm.  A column count of 1 means that there's
no possible assignments, and we can just zero out the column2row and
row2column arrays, and return early from the function, while keeping
the reduction transfer part of the function the same as it is
currently.

Another solution would be to just not call the 'compute_assignment()'
function from the range diff code in this case, however it's better to
make the compute_assignment function more robust, so future callers
don't run into this potential problem.

Note that the test only fails under valgrind on Linux, but the same
command has been reported to segfault on Mac OS.

[1]: Jonker, R., & Volgenant, A. (1987). A shortest augmenting path
     algorithm for dense and sparse linear assignment
     problems. Computing, 38(4), 325–340.

Reported-by: ryenus <ryenus@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 linear-assignment.c   | 6 ++++++
 t/t3206-range-diff.sh | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/linear-assignment.c b/linear-assignment.c
index 9b3e56e283..ecffc09be6 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -19,6 +19,12 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	int *free_row, free_count = 0, saved_free_count, *pred, *col;
 	int i, j, phase;
 
+	if (column_count < 2) {
+		memset(column2row, 0, sizeof(int) * column_count);
+		memset(row2column, 0, sizeof(int) * row_count);
+		return;
+	}
+
 	memset(column2row, -1, sizeof(int) * column_count);
 	memset(row2column, -1, sizeof(int) * row_count);
 	ALLOC_ARRAY(v, column_count);
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..fb4c13a84a 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,9 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'no commits on one side' '
+	git commit --amend -m "new message" &&
+	git range-diff master HEAD@{1} HEAD
+'
+
 test_done
-- 
2.19.0.397.gdd90340f6a


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B572049B
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbcLZKXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:04 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35012 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755685AbcLZKW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:57 -0500
Received: by mail-wj0-f196.google.com with SMTP id hb5so14857297wjc.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDf/2SXkkLhrjEQ89RiCa+SmO5zzp0tonCG4EeDWR1k=;
        b=vf8bHLy1nAzEXab43uL+AuFZREGGpEavl7z8u9GWQhzzZOz1TCexHWgF/nf3C/XYmw
         WS4K0ApIFIQYudJovHIMF6joq8GRhw5KPalNxRQKVmjPWg1i6kq7T5pq5R+/zVLCtriI
         wPVIUxI457q6/UlshYvoDXGZ+lI3jI6yVyw7JD2lQvd2lZIXxNUPymWRgO8PObH2XcMA
         lJQZWHIVwCF9ygspZXB1JnzmKrdKilDUrA6E54gD8OangvYxx6bYR4u4wdtxXrChT7Ww
         PCd71ctk3QuMwTRqCSHI6Ff4iKtZzxgRbTvkxwHVcUckrRmskOmpNeaQxnmxVN4LCWzG
         LYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDf/2SXkkLhrjEQ89RiCa+SmO5zzp0tonCG4EeDWR1k=;
        b=XhJmERhsN63hvW7w8fQrNAXI5Jp6c5S6lflZ/mPT7CMOn6W/k2nU5LUnlfmlb7/qrr
         4jyxB32JRiaK69fn7b9/54+nSjGNf2j92hBySE3FP7Ys/HKQUpUaPH17mxO671eF2kni
         /GkW1yxZNd7mGvfi6yZFWUAhsCVg6RvcdH7Hvw0V3aPEQdfNqhclNuk1sQdZvi8Z1gtp
         D4dOqI6SAh9XhPHSuNv52p69NKi7JCEAIOYmJqgAwiVRYSpwjKujZlL1IsGDRPMynbSc
         nNO4KbwOnb1SxJNcD2JNLPcolMMKT9jOvTCFdadu1WUUSTR9iDnDnnHyUgMRynRmjnko
         WV6A==
X-Gm-Message-State: AIkVDXIJnfNr8i0LGwLEwpuTvb5mSTzyKD50E5LpwI0aXoLapRIAhTLv0r9HxmD6Y+kXwg==
X-Received: by 10.194.169.227 with SMTP id ah3mr22965867wjc.2.1482747775458;
        Mon, 26 Dec 2016 02:22:55 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:54 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 19/21] read-cache: use freshen_shared_index() in read_index_from()
Date:   Mon, 26 Dec 2016 11:22:20 +0100
Message-Id: <20161226102222.17150-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way a share index file will not be garbage collected if
we still read from an index it is based from.

As we need to read the current index before creating a new
one, the tests have to be adjusted, so that we don't expect
an old shared index file to be deleted right away when we
create a new one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c           |  1 +
 t/t1700-split-index.sh | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 98ef1323d6..bf0ac1ce61 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1727,6 +1727,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
 
+	freshen_shared_index(base_sha1_hex);
 	merge_base_index(istate);
 	post_read_index_from(istate);
 	return ret;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f448fc13cd..800f84a593 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -313,17 +313,17 @@ EOF
 test_expect_success 'shared index files expire after 7 days by default' '
 	: >ten &&
 	git update-index --add ten &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_under_7_days_ago=$((1-7*86400)) &&
 	test-chmtime =$just_under_7_days_ago .git/sharedindex.* &&
 	: >eleven &&
 	git update-index --add eleven &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_7_days_ago=$((-1-7*86400)) &&
 	test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
 	: >twelve &&
 	git update-index --add twelve &&
-	test $(ls .git/sharedindex.* | wc -l) = 1
+	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
 test_expect_success 'check splitIndex.sharedIndexExpire set to 8 days' '
@@ -331,12 +331,12 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to 8 days' '
 	test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
 	: >thirteen &&
 	git update-index --add thirteen &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_8_days_ago=$((-1-8*86400)) &&
 	test-chmtime =$just_over_8_days_ago .git/sharedindex.* &&
 	: >fourteen &&
 	git update-index --add fourteen &&
-	test $(ls .git/sharedindex.* | wc -l) = 1
+	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
 test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"' '
@@ -345,13 +345,13 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test-chmtime =$just_10_years_ago .git/sharedindex.* &&
 	: >fifteen &&
 	git update-index --add fifteen &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	git config splitIndex.sharedIndexExpire now &&
 	just_1_second_ago=-1 &&
 	test-chmtime =$just_1_second_ago .git/sharedindex.* &&
 	: >sixteen &&
 	git update-index --add sixteen &&
-	test $(ls .git/sharedindex.* | wc -l) = 1
+	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
 test_done
-- 
2.11.0.209.gda91e66374.dirty


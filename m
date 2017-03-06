Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670111FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbdCFJvb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:31 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34816 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so10565045wmg.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2cLKu/E6yzDdaiaUWU820r/4/0T45RQq1Va4L/j7ttQ=;
        b=PXnBnjYNTo2F1Q+dsq1/9RxIQPJv5a/RtPid+Tnt/dveBN8ii7qhKnasovAuwLpb49
         toWx9zh0Yi5u8/W7KIoQT3Aw9vp8hEG+135XzdpVEEccWcE8uwqwVs5in8np3b8ENkme
         vdjRXmBkkx21trxNyAHpcdtyvPeJ0hJkpqmAuzA9W8f2n+UKUSq2mXM1/aG4kra1puVZ
         BsidFGUrZmcIB1cTN7vAZj05iSCtsEOcqX5Axgbd/NrY5smZKa9wgfBLIqcDylIcZUcQ
         ZHiu0QbyaNA8S2q9szyA/0UkfTQ59hVJIl8BF0LVg7Mv+sH+2FVhIi/xhXdReNFvXy0+
         USEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2cLKu/E6yzDdaiaUWU820r/4/0T45RQq1Va4L/j7ttQ=;
        b=ercpfCIklsbFIPRDhPoG6XJmpxGfg/1ggaAKBSal9Tl0JmmzV5AHdlUC3lv8u0ljH0
         +iXqVqyrYGocBjVgbGwT59fkSe3I53hbB5BQ9zS/DdddH7d9rBNX3mXsWIA+lWCQwIh2
         juDPGl35cdFi9F6JBl6SabjhLK8J6M99tIfEDAXAP8NeEYtQlA5QvkDZ8lxqv7O0ZAIe
         XLGp778hmqpgut3xKmclLKhR1wR0upcsS4Rz6UWSNko0H4Rc82iIy98ST6b6ZvFN6kHe
         pBDN2NqQ7fouY6/m+WgE+QJMVjdySolnQlylIxpKAcEh3Kr9crwG6lE+WC9GWApW7oTd
         1Rtw==
X-Gm-Message-State: AMke39kFjY4NTIsAElX8PfxBpP7yjm5lmyevwJ+hS5dPqb0eiHoduyleoX6LN5u1v9Pirw==
X-Received: by 10.28.209.75 with SMTP id i72mr11927364wmg.31.1488793364934;
        Mon, 06 Mar 2017 01:42:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:44 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 20/22] read-cache: use freshen_shared_index() in read_index_from()
Date:   Mon,  6 Mar 2017 10:42:01 +0100
Message-Id: <20170306094203.28250-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
index 89c95d59b3..e447751823 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1719,6 +1719,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
 
+	freshen_shared_index(base_sha1_hex, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
 	return ret;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f5a95a6c28..af3ec0da5a 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -329,17 +329,17 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 test_expect_success 'shared index files expire after 2 weeks by default' '
 	: >ten &&
 	git update-index --add ten &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_under_2_weeks_ago=$((5-14*86400)) &&
 	test-chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
 	: >eleven &&
 	git update-index --add eleven &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_2_weeks_ago=$((-1-14*86400)) &&
 	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
 	: >twelve &&
 	git update-index --add twelve &&
-	test $(ls .git/sharedindex.* | wc -l) = 1
+	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
 test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
@@ -347,12 +347,12 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
 	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
 	: >thirteen &&
 	git update-index --add thirteen &&
-	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_16_days_ago=$((-1-16*86400)) &&
 	test-chmtime =$just_over_16_days_ago .git/sharedindex.* &&
 	: >fourteen &&
 	git update-index --add fourteen &&
-	test $(ls .git/sharedindex.* | wc -l) = 1
+	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
 test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"' '
@@ -361,13 +361,13 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
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
2.12.0.206.g74921e51d6.dirty


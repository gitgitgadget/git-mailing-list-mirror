Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5211F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdB0SLY (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:11:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34285 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdB0SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:11:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id m70so14655639wma.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DO2L1T9M4xcTYjyDiH8DsgyT13NttrMFY7dYeGNGvS4=;
        b=MQ9UUJtKuqVeWDTQZO0RTtB4ZYQmDxdqt1WK2NLcOLTYTp6vvSZ3EzLI6FbWfAKksk
         oVpp+eJpPmofaoOe5FTVQAtCxO8KqKcmNe0kpY/0Fa1dG3Eumb0UIM6CT9rXWO0f1+2v
         XQBrfiKb/A2XmAz3QC7IB4AeimoLQaYOdOyKkkHq8gBARrOfk9AQj1KZ+TBPxtsogsSp
         ide59NBu/KDdWyoRlDU/S/DD9LLtqqB5AnPy8Wtm2UItvL/GLnArsdF78Eu98R8Wl2eJ
         N4H4IoIaL4XcZj4plD1OFh0ii+GAjJI8NROR0vKIOo2NST5MQxzwwyCkxvLs2B41iw0r
         Ohig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DO2L1T9M4xcTYjyDiH8DsgyT13NttrMFY7dYeGNGvS4=;
        b=VFlVen5TcJSuB/jZ9OyUgsuhq5Szv0WyhK26I/GUE4GEO0iOAj28S6K30+ixFj9VdK
         uUyCZfNueCBO5cZIceG/zScF78tJ/OSf2sOGH+wrZG6PN0olpxNjyFZ60fHOC3ZU/uvF
         1njHkB02kiizDI4iBr8WhDr/T6cjCjWx/hzMeYW6NUz9JGABoFvLApVsdHH2Vh0HU6xj
         qa7mVbutqCHSFjThWtaBQ+hy8KWPH0Mu5biVq8bRgPfxL6/AGQlZlgY6pMPAfOQ0YHAg
         GX95Y3ZXENYGhfsuct5FAXYwrDWLGGG6C98uveLfI+MJ9HnvHQdiHUxFa2NVI1W7YcYm
         LKIA==
X-Gm-Message-State: AMke39kKZKyksngqw1IdR+P9Rjwv4cbcFgBMXB9CI6YIEoCKGdOeeueOUx86febPOIi0Zw==
X-Received: by 10.28.142.73 with SMTP id q70mr15419319wmd.3.1488218464496;
        Mon, 27 Feb 2017 10:01:04 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:01:03 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 20/22] read-cache: use freshen_shared_index() in read_index_from()
Date:   Mon, 27 Feb 2017 19:00:17 +0100
Message-Id: <20170227180019.18666-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
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
index 3ea20701a3..d1152161f6 100644
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
index 480d3a8dc3..ea1aeacff0 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -313,17 +313,17 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
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
@@ -331,12 +331,12 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
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
2.12.0.22.g0672473d40


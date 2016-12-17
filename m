Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E87203EA
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758203AbcLQO42 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:28 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33841 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758072AbcLQO41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:27 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so17992415wjc.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rMPYrGU2SP8t/xg5x/8HtQrXr6sYVC2brqp7bfb5110=;
        b=iN06AGaAMKMk4KwOnCZnAcLkiAoalejanVdHMXJnh0lWYU+wsBkw1VLAFXUgdwXA0j
         T5a6rq3BzR4hDC0hb0rSb0QZimFzgNhjFgYZcpBm+VOTvQzW3oSLtMK6ukHagHqeQ7wj
         44h5FqI+TlMNi7+Fl5+cs+AZfDBTRuljAu2oiqGFZb9KjBtQ4wLtGb/UVy3b9KOYXxss
         si0ah9E9+oOUGvpZdHcBBDbBQzjXGbb2AzD6Gz/SAJeEqjzQKy9Rr+2aBzMOGHde9kG3
         FAHZOX23ulFFxDBEFzBgm2X0phRRP57btrWsn0xC10QLJksJB9TfcCBd2lxIaRn4Dk9d
         TL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rMPYrGU2SP8t/xg5x/8HtQrXr6sYVC2brqp7bfb5110=;
        b=hoHiuprjNiZhWHqJhDTAqYXEHcSP0svToO9821gFx+Sn7TA9R6gnQSHL8p9t6VhA2H
         mKH1ONnzsqC3sVxE3ds/E2XkINJXQLktxde5/olHlemIAWUjUY55dkwHUEB7sGySiQX+
         dASsv5YzGfGSEELubIKZSuOJx6oOAre73pq+RubrdvdD5NsRWn9Q2GxCIjwiU1H8houq
         qiae9GlNM3fMWX6oeVbzgiGIsP2/p30gzLK3UEZf59TYTr/T/PlHOl0B1Qd+RsuwMVSh
         qR51YVFP6Nk1sRMtqw0jwWdbmTL/j+kxlgw6VjiQkcK3RepMAd966hiNMxmNtvNbNuVa
         Qm6Q==
X-Gm-Message-State: AKaTC00U+AvjGqVQIFMk0RUpfc72m+iD/JSlx1ixUh79Cic9cIEpHgHJIf8+Ou4UdEsTmw==
X-Received: by 10.194.221.131 with SMTP id qe3mr8138647wjc.133.1481986585530;
        Sat, 17 Dec 2016 06:56:25 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 19/21] read-cache: use freshen_shared_index() in read_index_from()
Date:   Sat, 17 Dec 2016 15:55:45 +0100
Message-Id: <20161217145547.11748-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index 96e097e341..35377f0a3e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1730,6 +1730,7 @@ int read_index_from(struct index_state *istate, const char *path)
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
2.11.0.49.g2414764.dirty


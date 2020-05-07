Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B951C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B883C2082E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="YBXiEIMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEGXvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:51:08 -0400
Received: from avasout04.plus.net ([212.159.14.19]:38571 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGXvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:51:08 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id WqIBjPiHGrXCcWqICj8L5W; Fri, 08 May 2020 00:51:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1588895466; bh=uirAlf0f9ajHniHLLfHM7EXCHA261ziOWu//oo/g2GQ=;
        h=To:Cc:From:Subject:Date;
        b=YBXiEIMRkRM9q6G4BThPZodjAw0DlflE9BJXXl2giy1+4XGfPN5+ZaozDvrQc6pY0
         wCSmZ/IFbhR4dBPgtfCZEeuYCBvuG7n97vpaikVyfOxUu/T05yhHTXc/LnF852WuLR
         HUL9Y2o/BYjg6Inx1bNTihI+9b+82bvLc2BzLv5dliivh5KKM5Hb5kVof2pdXiSKSX
         UvO+ByQv4+1HcgRgANiVgkVT1mlz/uEMsO15WehhZyKQSjm7BRxw0b7ZbKvU80QeQt
         nqIpIR7W5fJbHANTJOMab096G4Tf/0f71En8RTVnIcZxOS1YL/xFDGlDrzWbLCBaBQ
         mS40lDvO1Wa0g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8
 a=PKzvZo6CAAAA:8 a=xRRwe7KqCvuvnv0fuIEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=AjGcO6oz07-iQ99wixmX:22 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH] bloom: fix `make sparse` warning
Message-ID: <01ff8217-bd38-e7e4-58b1-81645ba9282a@ramsayjones.plus.com>
Date:   Fri, 8 May 2020 00:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN9FIRFqdm6r3cRemwhnY8PUmqNboWpqp5lpJSeOkFwRlychu8ENrd8g0N/KdScoJRBjNANDyl3HDjuD4NGHFHl3mvFDXzZ2Ch98xJRaAlMqGVcARWi7
 Io2R3HGYP15+WYiL4a7XqXPcdpADZ6Gbyd8XnFXuO7RlfUSkWSOcQ6+VpHmMwwgT9Qvf6foCzWD6UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>

* We need a `final_new_line` to make our source code as text file, per
  POSIX and C specification.
* `bloom_filters` should be limited to interal linkage only

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This patch by Danh seems to have slipped through the cracks, so I decided
to pass it along. The original version of this patch (which I don't seem
to be able to find) clashed with one of Jeff's series [1], because they
both fixed up a 'No newline at end of file' issue with test-bloom.c.
Also as Danh points out [2], the original patch didn't fix up the test
files.

Anyway, this fixes up some 8 sparse warnings on 'master' and 'next':

  $ diff sp-out sp-out1
  17d16
  < bloom.h:90:6: warning: no newline at end of file
  20,22d18
  < bloom.c:276:1: warning: no newline at end of file
  < bloom.h:90:6: warning: no newline at end of file
  < bloom.c:12:26: warning: symbol 'bloom_filters' was not declared. Should it be static?
  33d28
  < bloom.h:90:6: warning: no newline at end of file
  163d157
  < bloom.h:90:6: warning: no newline at end of file
  366,367d359
  < ./bloom.h:90:6: warning: no newline at end of file
  < t/helper/test-bloom.c:6:30: warning: symbol 'settings' was not declared. Should it be static?
  $ 
  
... along with a further warning on 'pu', due to the 'ds/line-log-on-bloom'
branch adding another '#include "bloom.h"'.


[1] https://lore.kernel.org/git/20200423205851.GA1633985@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20200424010047.GD1949@danh.dev/

ATB,
Ramsay Jones

 bloom.c               | 4 ++--
 bloom.h               | 2 +-
 t/helper/test-bloom.c | 2 +-
 t/t0095-bloom.sh      | 2 +-
 t/t4216-log-bloom.sh  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bloom.c b/bloom.c
index dd9bab9bbd..ee025e0c61 100644
--- a/bloom.c
+++ b/bloom.c
@@ -9,7 +9,7 @@
 
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
-struct bloom_filter_slab bloom_filters;
+static struct bloom_filter_slab bloom_filters;
 
 struct pathmap_hash_entry {
     struct hashmap_entry entry;
@@ -273,4 +273,4 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 	}
 
 	return 1;
-}
\ No newline at end of file
+}
diff --git a/bloom.h b/bloom.h
index b935186425..e0e59e0754 100644
--- a/bloom.h
+++ b/bloom.h
@@ -87,4 +87,4 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
-#endif
\ No newline at end of file
+#endif
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 77eb27adac..456f5ea7f9 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "commit.h"
 
-struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 8f9eef116d..809ec7b0b8 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -114,4 +114,4 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
 	test_cmp expect actual
 '
 
-test_done
\ No newline at end of file
+test_done
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c7011f33e2..21b68dd6c8 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -152,4 +152,4 @@ test_expect_success 'Use Bloom filters if they exist in the latest but not all c
 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
 '
 
-test_done
\ No newline at end of file
+test_done
-- 
2.26.2

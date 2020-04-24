Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1226C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891BE2074F
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj+lxtj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgDXBAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgDXBAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 21:00:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA556C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:00:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so3946319pfx.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AbrymeVD88nlMAhdHGzfCeDT9V9tL7Fcg6jDh1M+odA=;
        b=aj+lxtj5bozdAn+7ephAyPWKPYL4l4PC5oILSFi2/QpO8fm7WbXDlPuH1RM6P/q73M
         GMpTecmqjNKhpJWZgbtj7hqRIXeerXz2WXCLJFXFD+AlNhM8m/0NaYvn2gu5z7Zpg0Ft
         Wr7AaSn09V2XVjoc4hd9Q3zR2Y17BcLM/Kik/NYrUbOnhAC5C/zO5PH1mKM9ZOvV/W3y
         j0CDSWMs9NmggXpVgdrKxgKn6S8HI8jQhnUhry5faOG/IZ8WqPbfKI0lL5W6lWe00ngo
         g1p8rfkmgEJtqa40SQtFtLB+h7jwJ6Rez+j41/HAkgFRWXsEavqx+wK1U2atQMSQrDXZ
         EjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AbrymeVD88nlMAhdHGzfCeDT9V9tL7Fcg6jDh1M+odA=;
        b=CfVVOpkWJjycxxZXHOHmAZbbSlpekcjpo5SGuo9pKZcuvTghX0cK24D1eQiaexhALS
         p6Ga2C3zBhfAUN03GdVCwF62/ZkgWfhG47lHaPIV5bSk/0IQbmhqTmxWcdv+W612dBNg
         S/y5HHgxFjebFh1aMl+a5UsBshDL9fx8yzsdU5GiLfdpjB4BDxCLeyFu9ZvbROw5lJNF
         jK9zSfK+Mv/ECk9+6io1vMPIudnlyd+q6e4FX/jfKMAfoCp5kr73bN4K9waPZrGbeEy8
         HvLJKywMmfRompVM8EMXs5bw3uJ6yLpFbNzneN+r2RwPuYs+tuBqN5VkoA0CnJvzxvDf
         k/lg==
X-Gm-Message-State: AGi0Pub8kpV7tZmKH7DeWe0jav6LsouMING0Cq/xGp14ooCyU06EliJz
        5izk2u6bj+LU1ak70QqEFf8=
X-Google-Smtp-Source: APiQypL/Lt5ZYKxOQYhxEJjCWB0DsbpCXY0R7UW5a1I110y65zMxlHXUeOxdEUuoYlfOYbm4H37yFg==
X-Received: by 2002:a65:5947:: with SMTP id g7mr6539960pgu.258.1587690050184;
        Thu, 23 Apr 2020 18:00:50 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id q19sm3800243pfh.34.2020.04.23.18.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:00:49 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:00:47 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
Message-ID: <20200424010047.GD1949@danh.dev>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423205851.GA1633985@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-23 16:58:51-0400, Jeff King <peff@peff.net> wrote:
> These are just a few bits I noticed in the test-tool helper when the
> topic hit next (my -Wunused-parameter patch complained that we never
> looked at argc).

I think I'll add this one to those few bits.
Old version of this change was sent here:
<20200423133937.GA1984@danh.dev>

But that version doesn't have the fixup for sh script.

Garima Singh: Could you please change your editor to add final new line?

I've take another look into bloom.h.

I think we should drop BITS_PER_WORD definition and use CHAR_BIT
instead. It's a standard definition.

To me, a WORD is an `int`, at least I was told that when I was still
in university and study about computer science.

-----------------8<---------------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Thu, 23 Apr 2020 20:24:50 +0700
Subject: [PATCH] bloom: fix `make sparse` warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* We need a `final_new_line` to make our source code as text file, per
  POSIX and C specification.
* `bloom_filters` should be limited to interal linkage only


Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
Feel free to fix up to current series
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
2.26.2.384.g435bf60bd5


-- 
Danh

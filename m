Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290FC55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A3F20724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQdXQS5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgDWNjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728427AbgDWNjm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:39:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFAC08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:39:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so2891632pgs.9
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CWiXfy61yq/AwHWA1clGuBsTz8vzkf/xnzo/7taZyxI=;
        b=tQdXQS5NS6vnBkYslMIAdLIlE201jvzPq0INHESyHgCtP+E+mrP16hc0bF4F4dPSh3
         9bH/WUqE0IpLM+y6/79jla3csRZgLKusjEzdOtS+bKzhVP2pfw+8nvVfeRDtZbKavF+/
         +N36ph+rhFk0o1YY/Mh0MKNAZxwem1oeTq48SaNPAaWQ9d86Oif1YuPfDbzsDSIFG0Pg
         LNejLuVDf3kiVnZc6gsY79bRjTdvRns37/Hx3B44VbqpwU286HjE2IW8lhQMGCAuxRTG
         S8WJeDmvllaFP05sCJU/tmO9LUmlDfU9798EMf5TzZlJhi+PVdFcvSy9Q5WxTqq7SSS2
         kKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CWiXfy61yq/AwHWA1clGuBsTz8vzkf/xnzo/7taZyxI=;
        b=oED6vVGr/i4KkFtnbQeYfkHXK8G5K63hKbCi/ETyhA5iZsNrXQLsQU8OoQ9lS67xJ6
         XAxDAJwW1C4itDNtqXoA1GL32Qvy2T4px7N+OzQ0JiVesMxWCOzML8McDjhRSBVIRgPI
         wPg+oGVMm1I91kXEqhcreh1GaDSLyqsIx07ky7duUZ+chdY98aTszjihCpdMZgYTwSXI
         c4ecWkFnhDxB7MjZb9DWytDRjHIF71mYJPDKeyTRoF5LS/cqmo28EWNLXLX5veree7o8
         0juaxqwKAscYsB5YFURZeUjcEJDTo5Y7AfKij2c1XAtA1OcnsJqrYlIxxWQtRoMc4uHz
         FloQ==
X-Gm-Message-State: AGi0PuZT50u6FgYLHYpwkRyi+4p9fFv9z4kJItVNkUiMYdK+91mXtKvJ
        8NDcEXu46bd368H+54C7AQU=
X-Google-Smtp-Source: APiQypIdZ2vgPmuvn3vm04BZ0xG/S9/hXgXU4gSa0DBLonn4dIl+KuA+BF2+64ZUTNwDWHbMMlrV5A==
X-Received: by 2002:a65:580a:: with SMTP id g10mr4041527pgr.269.1587649180688;
        Thu, 23 Apr 2020 06:39:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id d29sm1789696pgm.83.2020.04.23.06.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:39:40 -0700 (PDT)
Date:   Thu, 23 Apr 2020 20:39:37 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #02; Mon, 20)
Message-ID: <20200423133937.GA1984@danh.dev>
References: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-20 18:57:14-0700, Junio C Hamano <gitster@pobox.com> wrote:
> * ds/blame-on-bloom (2020-04-16) 3 commits
>  - blame: use changed-path Bloom filters
>  - tests: write commit-graph with Bloom filters
>  - revision: complicated pathspecs disable filters
>  (this branch uses gs/commit-graph-path-filter.)
> 
>  "git blame" learns to take advantage of the "changed-paths" Bloom
>  filter stored in the commit-graph file.
> 
>  Will merge to 'next'.

Please apply this patch on top of ds/blame-on-bloom
to fix `make sparse`.

POSIX and (IIRC, C) requires final newline.

Feel free to fix up to current series
------------------8<-----------------------
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

Feel free to fix up to current series

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 bloom.c               | 4 ++--
 bloom.h               | 2 +-
 t/helper/test-bloom.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index ce412664ba..ce5a0af5ae 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "commit.h"
 
-struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
@@ -78,4 +78,4 @@ int cmd__bloom(int argc, const char **argv)
 	}
 
 	return 0;
-}
\ No newline at end of file
+}
-- 
2.26.2.384.g435bf60bd5
Danh

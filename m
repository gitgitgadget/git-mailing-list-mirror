Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DDC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiEZAbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbiEZAba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:31:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6099EB44
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x12so230882wrg.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mpKEVvLmgHSUq91yM2BRcT1IBolnzwwZhpc2uQqXX4=;
        b=H2aIIX+21PqXCxSjc+RNXn8Zp4HxnqLLdksaVbIJIl+XcVn7iJlRrj5t3c9KHaYE9V
         K77uJyuO/J4aZmybvwawNqp6Qf8/leW9Z7IFpyBE4dY8HkRiadmpnzlJ2FMpurmNOBht
         3jv5eGi+sdgP4L0i7bZTEYjbt81eWR8KyB2ya03P50GJ/qlelrFrE4FTnj18IS3nvnhq
         bj53J/7+R2GuzBN7PWkQB/2rbL6pYzdMdpdnvI+xFgoMuwM6D2D23EJiu0Yovr1JYi/Z
         pfhWZEUbRYq8qnFq4YTGPA+LeHHIl/dMpLqmcNpWyNgAcDt0/aTZJay+LxtYrXWGKS0X
         47MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mpKEVvLmgHSUq91yM2BRcT1IBolnzwwZhpc2uQqXX4=;
        b=5m1fqxmSKj+DtEo/OVugiqYk4IkiOXky30cG+IYxDs9gUbSJGJTM7Q//k2OJS+1Q4W
         Hflgx61twIjqPkpOPEl03V9qTwi9uPpCWPsShsO/aixWA+uB2R6M2bs9Y1oRxbqCrf+/
         fQFR75cQuxn0x1NThwG+pxGFtJwg0r5g4wWRMWenktb1eQwLsIM6fLsBpTJ4SIP6kAvV
         6kdwg2rGvW0yy1v1WU9o7cuTv1tS/3nT2ryAzgMqvPbQeK06GCQJDDFfVP/QrzmF6e5+
         ulVy24LFcyVerCkKNZoCx/+ifJSxeJyE20Ajh4hExlKFAeLzBWnTuqxBjXnNUGlYua3u
         /85Q==
X-Gm-Message-State: AOAM531sopmgoduuwzu5pnnhI3Q8mNVMhLLT/OsTkZYm2gJmMI21VnQf
        2Lf2JnY/Nc/jrZ+E2oHQiEHVvXpFbm/p+g==
X-Google-Smtp-Source: ABdhPJwbHIfdr7b3wRPntVYXPYZqcMQ2vrwguBAm/d0BaJ0v1jhws5UroJJoJ9T5iFAMR3oVWSipJQ==
X-Received: by 2002:a5d:6daa:0:b0:20f:d270:361a with SMTP id u10-20020a5d6daa000000b0020fd270361amr17110359wrs.249.1653525088033;
        Wed, 25 May 2022 17:31:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003973c54bd69sm3138968wmb.1.2022.05.25.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:31:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/3] refs API: rename "abort" callback to avoid macro clash
Date:   Thu, 26 May 2022 02:30:43 +0200
Message-Id: <RFC-patch-2.3-6d21c43a4a9-20220525T234908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit we'll add an abort() macro to wrap the abort(3)
function, unfortunately due to C syntax semantics having such a macro
would be a compilation error as long as we're invoking callbacks named
"abort()".

So let's rename the callback "abort" callback added in
3bc581b9406 (refs: introduce an iterator interface, 2016-06-18) to
"end", which is the alternate naming that commit itself discusses,
i.e. it says:

    * ref_iterator_advance(): move to the next reference in the iteration
    * ref_iterator_abort(): end the iteration before it is exhausted
    * ref_iterator_peel(): peel the reference currently being looked at

Just as "peel=peel we can change that "abort=end" pair to be
"end=end", let's leave "advance=move".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c          | 4 ++--
 refs/files-backend.c  | 4 ++--
 refs/iterator.c       | 8 ++++----
 refs/packed-backend.c | 2 +-
 refs/ref-cache.c      | 2 +-
 refs/refs-internal.h  | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index eed8bc94b04..3364a7fb261 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -214,7 +214,7 @@ static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->abort(diter->iter);
+	int res = diter->iter->vtable->end(diter->iter);
 	trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
 	return res;
 }
@@ -222,7 +222,7 @@ static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
 	.peel = debug_ref_iterator_peel,
-	.abort = debug_ref_iterator_abort,
+	.end = debug_ref_iterator_abort,
 };
 
 static struct ref_iterator *
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aacb..3f0dde4ae10 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -824,7 +824,7 @@ static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
 	.peel = files_ref_iterator_peel,
-	.abort = files_ref_iterator_abort,
+	.end = files_ref_iterator_abort,
 };
 
 static struct ref_iterator *files_ref_iterator_begin(
@@ -2224,7 +2224,7 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
 	.peel = files_reflog_iterator_peel,
-	.abort = files_reflog_iterator_abort,
+	.end = files_reflog_iterator_abort,
 };
 
 static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
diff --git a/refs/iterator.c b/refs/iterator.c
index b2e56bae1c6..f4a9546adb6 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -21,7 +21,7 @@ int ref_iterator_peel(struct ref_iterator *ref_iterator,
 
 int ref_iterator_abort(struct ref_iterator *ref_iterator)
 {
-	return ref_iterator->vtable->abort(ref_iterator);
+	return ref_iterator->vtable->end(ref_iterator);
 }
 
 void base_ref_iterator_init(struct ref_iterator *iter,
@@ -66,7 +66,7 @@ static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
 	.peel = empty_ref_iterator_peel,
-	.abort = empty_ref_iterator_abort,
+	.end = empty_ref_iterator_abort,
 };
 
 struct ref_iterator *empty_ref_iterator_begin(void)
@@ -203,7 +203,7 @@ static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
 	.peel = merge_ref_iterator_peel,
-	.abort = merge_ref_iterator_abort,
+	.end = merge_ref_iterator_abort,
 };
 
 struct ref_iterator *merge_ref_iterator_begin(
@@ -380,7 +380,7 @@ static int prefix_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
 	.peel = prefix_ref_iterator_peel,
-	.abort = prefix_ref_iterator_abort,
+	.end = prefix_ref_iterator_abort,
 };
 
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b68377673..ad23f734b0f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -913,7 +913,7 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.advance = packed_ref_iterator_advance,
 	.peel = packed_ref_iterator_peel,
-	.abort = packed_ref_iterator_abort
+	.end = packed_ref_iterator_abort
 };
 
 static struct ref_iterator *packed_ref_iterator_begin(
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 32afd8a40b0..b4acaac2fb5 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -458,7 +458,7 @@ static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	.advance = cache_ref_iterator_advance,
 	.peel = cache_ref_iterator_peel,
-	.abort = cache_ref_iterator_abort
+	.end = cache_ref_iterator_abort
 };
 
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69f93b0e2ac..7f462273fba 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -478,7 +478,7 @@ typedef int ref_iterator_abort_fn(struct ref_iterator *ref_iterator);
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
 	ref_iterator_peel_fn *peel;
-	ref_iterator_abort_fn *abort;
+	ref_iterator_abort_fn *end;
 };
 
 /*
-- 
2.36.1.1046.g586767a6996


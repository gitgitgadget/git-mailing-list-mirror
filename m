Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE14C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352350AbiCaBsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352376AbiCaBsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348248E4C
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r7so13340215wmq.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6e0RZckFJ6CCnBrDsYo638jjSYOLc3ytVm6lVwB/vE=;
        b=X6273xGTufw0o0HeAsjKeH0hn7bMCK0NVOfLWxUYCBPJ0o9F92Sgd3snIxdUCdZTyn
         2+xBkw/doNA7ZEzydOfZZ0jS8ci1hEYs8gDPD5TYdl5NJiAAF27nuu1f9WjJ8iI5rY0R
         hyXZ7fH7kXtXs9iwXJnSeu33RJKWWZq4nbVBhfbK/Va7P3fRvsBQj16ft37sIdFKHie/
         1aRLpAfvqYVKfZPPa5UjWD2nDtwV6jnZWd6r2FtXI/beaL7stoIhn1P7d0leqFLXfFQG
         WbFRjcXDLArUOS2T+C+xvNvCts723DqoKXmWfXDj5c6QT29UxRHQ+BZEfIABWywoHn9n
         losA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6e0RZckFJ6CCnBrDsYo638jjSYOLc3ytVm6lVwB/vE=;
        b=7gTlEcCuXVEUvwFQ5T/qhcKbVIGVoqxosJIgiQannhe+CaW4ncLyusNegwg5QrzaeF
         b8KW+6jbGZDP9CHWL1M2h8fRv15MgZcmTPOFHlVlcH3NJwYe1dPzNhPc8EXB6NrHB3Wm
         bcH08xGjX9gOYaz7hwAtBxevmrkTo38bwsxnPxI+TTZkCT2IrWx5HTpFGVL2qjeVTVxA
         7c+tqgru8oqFAeNcasgHLUde014QdfVdcI9yT3exMnLft94uY40LWFq/alkQnLAS+ySK
         xJUm78yG5jghPsbanZENf2lmyLSJapHo1RUVPM9BMFGMlyGfoxUCCzbEN/wZQFwC7K2S
         1mYA==
X-Gm-Message-State: AOAM532o//VjP62qEK0h54CsrJXxFAKRg8v3MVzepxRJO20EJDezb8/V
        f7SWEZNZDf38+W5Kj2MLUsbvHPoZelLJyQ==
X-Google-Smtp-Source: ABdhPJwYAoen81qlaEPVglUj+lyeWkGTzXg8MB1taHofzkn2uOKuRCxO7o1zCI9OjhrYuFYBKfTUCQ==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr2479489wml.51.1648691175031;
        Wed, 30 Mar 2022 18:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] alloc.[ch]: remove alloc_report() function
Date:   Thu, 31 Mar 2022 03:45:55 +0200
Message-Id: <patch-v4-6.6-f477389c275-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alloc_report() function has been orphaned since its introduction
in 855419f764a (Add specialized object allocator, 2006-06-19), it
appears to have been used for demonstration purposes in that commit
message.

These might be handy to manually use in a debugger, but keeping them
and the "count" member of "alloc_state" just for that doesn't seem
worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alloc.c | 21 ---------------------
 alloc.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af3626..27f697e4c87 100644
--- a/alloc.c
+++ b/alloc.c
@@ -27,7 +27,6 @@ union any_object {
 };
 
 struct alloc_state {
-	int count; /* total number of nodes allocated */
 	int nr;    /* number of nodes left in current allocation */
 	void *p;   /* first free node in current allocation */
 
@@ -63,7 +62,6 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 		s->slabs[s->slab_nr++] = s->p;
 	}
 	s->nr--;
-	s->count++;
 	ret = s->p;
 	s->p = (char *)s->p + node_size;
 	memset(ret, 0, node_size);
@@ -122,22 +120,3 @@ void *alloc_commit_node(struct repository *r)
 	init_commit_node(c);
 	return c;
 }
-
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
-
-void alloc_report(struct repository *r)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
diff --git a/alloc.h b/alloc.h
index 371d388b552..3f4a0ad310a 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
-void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
-- 
2.35.1.1561.ge8eddc63765


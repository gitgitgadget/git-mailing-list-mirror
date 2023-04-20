Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0FC7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 20:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjDTUyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjDTUyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 16:54:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604CC40E5
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:54:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so99688866b.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682024056; x=1684616056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOe6Xj+oVILRXCurliWkdKisXs6s5Gln4RVk+1XsX0w=;
        b=NOEk34iV52xj1khwOh8ZWUaRiHsNBPHlDpNWcvmnwW2ED1se04jiMBitakhcq25Amm
         Wok8s68BhUcwlFgXPecOBmK7HMCCxv7CjDKmUkqodMuA/9XELz2aGUzgE6kQpTiwMBXh
         7qbhcPpVAu/Yj2v0OjU3Bj4xTjDFnNQ6Qof7y0ZLbZr73iDwCh4WvhDhL2e6Bhjydrww
         jLxa6M3wF12BoD5M1ZEajFbEI3IGA0wokijVs7IEaBC9TTsIlSdQh++T/3b5UfefhDEd
         I8Ad+LsmSSZ0LK31nzwQMnA+t5HNz5fvP8sfKCcGVl/Lqs/PoXSIjS/qjHXrI8sfTbP3
         zoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682024056; x=1684616056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOe6Xj+oVILRXCurliWkdKisXs6s5Gln4RVk+1XsX0w=;
        b=I5eAjZmRjznKdnMrDl4PO+9jhV5nwqVAfpC392ydAjqF/Ze512AAkAQ0O46c9NuQiq
         tcwpEI9n4Exks9mFf776iFaYjW4f+2aWzV0G7fGn6T+j04g1d5F437hQEavdOtsCrO5I
         Q87rTNl6X55D1P10q9Z6T8WWNgqbrXZbFOrQUyaM3FH5ozGYaC1+R/L/+xpDGQXkyJZQ
         eMvc0/6cbheG60CeIjyyhqX/5bHd6phxXp+xg8ocH9zgItI1KNRptiVMNzTnIsGTJ7PG
         vmZLY9I480cIL0JqS5G+PEqAMdhuwmm/ARgxDMBJQExBM2fzcSpqm0J+F/djYP2CZbwU
         M9Mw==
X-Gm-Message-State: AAQBX9eBa7zNQxyYgnigaOCVt7CntHCBtRjVIy5ipXToSmpNyEoV9qM6
        ulw2WPI80gzFtN6hfKiKITu9BWqZ9os=
X-Google-Smtp-Source: AKy350YGBaTXu7fq5DBUOpVK5LEH5RJgW9b145yP292NOMeGr4GSka9Znk7f72d02WF6H7Rk1XToXg==
X-Received: by 2002:a17:906:128f:b0:94e:de35:79c5 with SMTP id k15-20020a170906128f00b0094ede3579c5mr179219ejb.70.1682024055666;
        Thu, 20 Apr 2023 13:54:15 -0700 (PDT)
Received: from localhost (92-249-246-116.pool.digikabel.hu. [92.249.246.116])
        by smtp.gmail.com with ESMTPSA id ml24-20020a170906cc1800b0094e6a9c1d24sm1188196ejb.12.2023.04.20.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:54:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] cocci: remove 'unused.cocci'
Date:   Thu, 20 Apr 2023 22:53:50 +0200
Message-ID: <20230420205350.600760-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.573.g2c27013916
In-Reply-To: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'unused.cocci' was added in 4f40f6cb73 (cocci: add and apply a
rule to find "unused" strbufs, 2022-07-05) it found three unused
strbufs, and when it was generalized in the next commit it managed to
find an unused string_list as well.  That's four unused variables in
over 17 years, so apparently we rarely make this mistake.

Unfortunately, applying 'unused.cocci' is quite expensive, e.g. it
increases the from-scratch runtime of 'make coccicheck' by over 5:30
minutes or over 160%:

  $ make -s cocciclean
  $ time make -s coccicheck
      * new spatch flags

  real    8m56.201s
  user    0m0.420s
  sys     0m0.406s
  $ rm contrib/coccinelle/unused.cocci contrib/coccinelle/tests/unused.*
  $ make -s cocciclean
  $ time make -s coccicheck
      * new spatch flags

  real    3m23.893s
  user    0m0.228s
  sys     0m0.247s

That's a lot of runtime spent for not much in return, and arguably an
unused struct instance sneaking in is not that big of a deal to
justify the significantly increased runtime.

Remove 'unused.cocci', because we are not getting our CPU cycles'
worth.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/coccinelle/tests/unused.c   | 82 -----------------------------
 contrib/coccinelle/tests/unused.res | 45 ----------------
 contrib/coccinelle/unused.cocci     | 43 ---------------
 3 files changed, 170 deletions(-)
 delete mode 100644 contrib/coccinelle/tests/unused.c
 delete mode 100644 contrib/coccinelle/tests/unused.res
 delete mode 100644 contrib/coccinelle/unused.cocci

diff --git a/contrib/coccinelle/tests/unused.c b/contrib/coccinelle/tests/unused.c
deleted file mode 100644
index 8294d734ba..0000000000
--- a/contrib/coccinelle/tests/unused.c
+++ /dev/null
@@ -1,82 +0,0 @@
-void test_strbuf(void)
-{
-	struct strbuf sb1 = STRBUF_INIT;
-	struct strbuf sb2 = STRBUF_INIT;
-	struct strbuf sb3 = STRBUF_INIT;
-	struct strbuf sb4 = STRBUF_INIT;
-	struct strbuf sb5;
-	struct strbuf sb6 = { 0 };
-	struct strbuf sb7 = STRBUF_INIT;
-	struct strbuf sb8 = STRBUF_INIT;
-	struct strbuf *sp1;
-	struct strbuf *sp2;
-	struct strbuf *sp3;
-	struct strbuf *sp4 = xmalloc(sizeof(struct strbuf));
-	struct strbuf *sp5 = xmalloc(sizeof(struct strbuf));
-	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
-	struct strbuf *sp7;
-
-	strbuf_init(&sb5, 0);
-	strbuf_init(sp1, 0);
-	strbuf_init(sp2, 0);
-	strbuf_init(sp3, 0);
-	strbuf_init(sp4, 0);
-	strbuf_init(sp5, 0);
-	strbuf_init(sp6, 0);
-	strbuf_init(sp7, 0);
-	sp7 = xmalloc(sizeof(struct strbuf));
-
-	use_before(&sb3);
-	use_as_str("%s", sb7.buf);
-	use_as_str("%s", sp1->buf);
-	use_as_str("%s", sp6->buf);
-	pass_pp(&sp3);
-
-	strbuf_release(&sb1);
-	strbuf_reset(&sb2);
-	strbuf_release(&sb3);
-	strbuf_release(&sb4);
-	strbuf_release(&sb5);
-	strbuf_release(&sb6);
-	strbuf_release(&sb7);
-	strbuf_release(sp1);
-	strbuf_release(sp2);
-	strbuf_release(sp3);
-	strbuf_release(sp4);
-	strbuf_release(sp5);
-	strbuf_release(sp6);
-	strbuf_release(sp7);
-
-	use_after(&sb4);
-
-	if (when_strict())
-		return;
-	strbuf_release(&sb8);
-}
-
-void test_other(void)
-{
-	struct string_list l = STRING_LIST_INIT_DUP;
-	struct strbuf sb = STRBUF_INIT;
-
-	string_list_clear(&l, 0);
-	string_list_clear(&sb, 0);
-}
-
-void test_worktrees(void)
-{
-	struct worktree **w1 = get_worktrees();
-	struct worktree **w2 = get_worktrees();
-	struct worktree **w3;
-	struct worktree **w4;
-
-	w3 = get_worktrees();
-	w4 = get_worktrees();
-
-	use_it(w4);
-
-	free_worktrees(w1);
-	free_worktrees(w2);
-	free_worktrees(w3);
-	free_worktrees(w4);
-}
diff --git a/contrib/coccinelle/tests/unused.res b/contrib/coccinelle/tests/unused.res
deleted file mode 100644
index 6d3e745683..0000000000
--- a/contrib/coccinelle/tests/unused.res
+++ /dev/null
@@ -1,45 +0,0 @@
-void test_strbuf(void)
-{
-	struct strbuf sb3 = STRBUF_INIT;
-	struct strbuf sb4 = STRBUF_INIT;
-	struct strbuf sb7 = STRBUF_INIT;
-	struct strbuf *sp1;
-	struct strbuf *sp3;
-	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
-	strbuf_init(sp1, 0);
-	strbuf_init(sp3, 0);
-	strbuf_init(sp6, 0);
-
-	use_before(&sb3);
-	use_as_str("%s", sb7.buf);
-	use_as_str("%s", sp1->buf);
-	use_as_str("%s", sp6->buf);
-	pass_pp(&sp3);
-
-	strbuf_release(&sb3);
-	strbuf_release(&sb4);
-	strbuf_release(&sb7);
-	strbuf_release(sp1);
-	strbuf_release(sp3);
-	strbuf_release(sp6);
-
-	use_after(&sb4);
-
-	if (when_strict())
-		return;
-}
-
-void test_other(void)
-{
-}
-
-void test_worktrees(void)
-{
-	struct worktree **w4;
-
-	w4 = get_worktrees();
-
-	use_it(w4);
-
-	free_worktrees(w4);
-}
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
deleted file mode 100644
index d84046f82e..0000000000
--- a/contrib/coccinelle/unused.cocci
+++ /dev/null
@@ -1,43 +0,0 @@
-// This rule finds sequences of "unused" declerations and uses of a
-// variable, where "unused" is defined to include only calling the
-// equivalent of alloc, init & free functions on the variable.
-@@
-type T;
-identifier I;
-// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
-constant INIT_MACRO =~ "_INIT";
-identifier MALLOC1 =~ "^x?[mc]alloc$";
-identifier INIT_ASSIGN1 =~ "^get_worktrees$";
-identifier INIT_CALL1 =~ "^[a-z_]*_init$";
-identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
-identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
-@@
-
-(
-- T I;
-|
-- T I = { 0 };
-|
-- T I = INIT_MACRO;
-|
-- T I = MALLOC1(...);
-|
-- T I = INIT_ASSIGN1(...);
-)
-
-<... when != \( I \| &I \)
-(
-- \( INIT_CALL1 \)( \( I \| &I \), ...);
-|
-- I = \( INIT_ASSIGN1 \)(...);
-|
-- I = MALLOC1(...);
-)
-...>
-
-(
-- \( REL1 \| REL2 \)( \( I \| &I \), ...);
-|
-- \( REL1 \| REL2 \)( \( &I \| I \) );
-)
-  ... when != \( I \| &I \)
-- 
2.40.0.573.g2c27013916


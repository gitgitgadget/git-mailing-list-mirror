Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D691E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQH2v (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:51 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:57045 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:50 -0400
Received: by mail-yb1-f202.google.com with SMTP id y12-v6so13663440ybg.23
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eskJwk4pnUYO394rRuJy3bhhNNUW4Dxfs+Q24LiF+Ic=;
        b=g/FwXom73CDqsipdlfoiq3vLTO/8TJubcj5YcK0M7tjiO8zLD0+MmJKMg2gq0UvpO8
         ish3LS/8hpNO5MEUqPz6HaEhLXI30rInxx654LWKQPEqWgt8AMzHJeZ5OqjCNvH4FHLL
         A5QV3sAW9C2WlDoEq9giqhr24V/5mb7UoKSIjdzBQ7bBtgHYRMZPybo09HOmEEH+Yih5
         41/gTHEyQ+/CuQ2GxH+7yVkU6OeXSOpPpdMScdIMMXVfG/F6AzUhBei9CvVfaszHWgvm
         xpT+dj46c4dKWH88bZzvnWf+h3o+SquCwifFxMFWpWp/YUMzl52z3pEQMsMqaJYPtlHE
         iw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eskJwk4pnUYO394rRuJy3bhhNNUW4Dxfs+Q24LiF+Ic=;
        b=eBdGdi0ssV9mY/fcnXPqjcO6MKT0TjSESJy80wGxdqFvnTp4J6h3c6kq08N1mHHgWv
         7ZGNh1+SdF9mTeCY9QXpliLF2+HE9lIPPazyHUrSDhKS9JMJ8Jd/C+PyuazsuLBbPlkW
         uPsmODuMfv1uj4uuZMKnyURsoS6xAxXDDyFLf+lDecCgeKK2w03rL5CyyQi50ENSMOU9
         QdXyjk7lSuQN/qWAoVc5v9BV3B+U/Xon7JUZcf7Uc6029iak10GgzqOeBP9y3VFVV3k9
         m7+i8N4lgj3QwDMfKXxs+Mm/+YKlgNp1QWIlMFHAxfIsOjkpw8KKFqLvzp/k2qzy3mIE
         Rl0A==
X-Gm-Message-State: ABuFfohTFgbZ925DKQSghDhqgCAxN4C7I6aE42BzUaGiMzW9uIlzC1aO
        hTXDuZ94CtM4Z3mVASxfdyTaIvlN984ipK+PiJ40V7dko4aXi2GwC8XsgE4yhBUTto8oWa+cfps
        +vzirKaE/j/B7Xtt3sz6PvcsviVsRWcJ+ILaXqhghFsxEg0Xnj7mld18owgq7
X-Google-Smtp-Source: ACcGV62x2FmUc6GTXRuXkoAhpzgZBKXCvSjg9iI8XVvnzbpNK49KuKy4vyxNVALbX58GiHC9Z94ZrPDGw+MM
X-Received: by 2002:a25:5f4b:: with SMTP id h11-v6mr2802364ybm.67.1539732965257;
 Tue, 16 Oct 2018 16:36:05 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:35 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 04/19] object-store: prepare read_object_file to deal with
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As read_object_file is a widely used function (which is also regularly used
in new code in flight between master..pu), changing its signature is painful
is hard, as other series in flight rely on the original signature. It would
burden the maintainer if we'd just change the signature.

Introduce repo_read_object_file which takes the repository argument, and
hide the original read_object_file as a macro behind
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, similar to
e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)

Add a coccinelle patch to convert existing callers, but do not apply
the resulting patch from 'make coccicheck' to keep the diff of this
patch small.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/the_repository.cocci | 13 +++++++++++++
 object-store.h                          | 10 ++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci

diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
new file mode 100644
index 0000000000..3c7fa70502
--- /dev/null
+++ b/contrib/coccinelle/the_repository.cocci
@@ -0,0 +1,13 @@
+// This file is used for the ongoing refactoring of
+// bringing the index or repository struct in all of
+// our code base.
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- read_object_file(
++ repo_read_object_file(the_repository,
+  E, F, G)
+
diff --git a/object-store.h b/object-store.h
index 6bb0ccbf05..41ceebca48 100644
--- a/object-store.h
+++ b/object-store.h
@@ -150,10 +150,16 @@ extern void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
-static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static inline void *repo_read_object_file(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size)
 {
-	return read_object_file_extended(the_repository, oid, type, size, 1);
+	return read_object_file_extended(r, oid, type, size, 1);
 }
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
+#endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-- 
2.19.0


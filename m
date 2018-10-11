Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38F01F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJLErM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:12 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52402 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:12 -0400
Received: by mail-qk1-f202.google.com with SMTP id 17-v6so9702307qkj.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=umgBTvwMnUjpWiVyhoBw62KfXXSxT6/FuuGkq2vDQ8o=;
        b=L2yZ9WMm7fBRXorRHokgU2EKDzAePU2P8ckfmDKEr6O5C/jv1cbFsig5TD307yjsOL
         YCcQUqHOZoS2M6cpqrQERtwnDQdUqJKQGMKmUY9+hR416Gd79cBZNxk2SR0Q1HIVQSKJ
         U1vE2bYaHLuxF8O2pwZDc8xXCjivI3uSTi0+JlcdDFkue/Kdd0yxC9c5a2vls47Ot6aM
         cCYqtudum9DZvj6wxSTAlsCphSpa65islVshEOg3DD4xCh5AuF4zhBRnp6HjsynvX8Ed
         NXoWeWnQwD1aqzOEtj6X0Key1ocF7PqzYqgxh7iK0JSVHyUF4aRI+OZulMVKY6Cc6obf
         ARYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=umgBTvwMnUjpWiVyhoBw62KfXXSxT6/FuuGkq2vDQ8o=;
        b=b0wvRkkB4lUF0qUbeYi7JzA0Udv8iP3+umFDMfGf/sP7QWBsAJspN0oJa82RunXAcE
         3fMhpvGjmFmfPkgPK9lAnofvGrrkn6PV82MJa72a0o7yFTmKL047zy7b6dHnWNRWyL7U
         J4Sg/t+Kz4SQQ6kEn4XHIgyTacMhwC+KMPIJMWx3wTmxzTbcQAHjLg1DMUKBM8Jtpkhu
         2dcfCeua9tUdVc/CpRCRfJptWdAzDp9tNQXY5uyvb7MY1xosNDKI0Tfg16+Ramr/PZaO
         YR8UqJkkYhakOlnaUw0pcnGbU2EgRVF/codmiSu7jLhJokTVbi+1B903OhIsy9jFAR8w
         qGyg==
X-Gm-Message-State: ABuFfojcXwciVj75WCHG+dXiQdUTtqVeQBmusqpHR+QlWNg+obFpzYph
        ag6gj3TZVHmUfrf6zULZ9zKOOdHnkif+aOU7lQQau4bELkkQ9T0rR4GpY5K4bwo0oDYQkFRb3J0
        tJyyt+oHrr3qCesslV/s5d8Y7NRoeyoBWg1y+HPaMa/8RfjRTeXozO4Pu6jTU
X-Google-Smtp-Source: ACcGV62IHlpV9CbypdB1DxRRzoEBvG+CoPIUZprvcG+FpwzdswtGbZayGjb03UL1iMccyDzoXtlapCU3aHBq
X-Received: by 2002:ac8:227a:: with SMTP id p55-v6mr2821695qtp.19.1539292687429;
 Thu, 11 Oct 2018 14:18:07 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:39 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 04/19] object-store: prepare read_object_file to deal with
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
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
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, which we planned for in
e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)

Add a coccinelle patch to convert existing callers, but do not apply
the resulting patch from 'make coccicheck' to keep the diff of this
patch small.

Signed-off-by: Stefan Beller <sbeller@google.com>
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


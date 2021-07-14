Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B795C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45813613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhGNLqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhGNLqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4DC061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so2816938wro.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzdfuGTizJaNsXsyvvstyfrSpqOtyPsRtXj/6+GcsOo=;
        b=L1qEmtR+8NxC114h1fHEFMe19nwWMsSGVobOmwud1ByWBKGCpC5z1RiO9JgY70Rl95
         M7YxOAF+2fn6MMoJUToXpJCDY+kXVMgrxMkyS0C4n444xcp8/EhNHF80AHvgiO1TAcFX
         7ns5ri7D+aM3aXYxzehLFdWItFumwOjT+pEp9PbwsyhTW2gnW7yY5soAjNCf9BN1g7TJ
         yda6q3y11WfvPyuCILnDnaz6UaiOyJ2CmQcIyv+66Pqtk7C26C1qLKLYtHiFHr5GY3QD
         szzvWF6cbTTe/0HWinExs0CFvv9Dhztu0C0agj17YmM5ZsVPZ8NAJv8QxRFMOdqUIo8o
         APyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzdfuGTizJaNsXsyvvstyfrSpqOtyPsRtXj/6+GcsOo=;
        b=uOgtRNOlUcFQoUGFcYJkLYxJe3eiuiu93+x/ugiSEqQD50qjx22S545FrhSsDnPjw6
         QPAqSbDvShnH7UdOI43VrTWmsWcC3V7MgfcUBun7lbbI3OMTNwVowuvVLvZz0qAkZ8kB
         FLHW5kRYt+i6IoGsS9oQzCz2yXGH/dyHpZbalud40IQEFnz6gao/C5xKHehgXKn3d1Nz
         XwqH+J9OQkRuj0kyk6vcTB+D+GD8iefFADq6ru4FuWpCSg7uhpoEF/4viXpTETkchvFr
         unBoRtLBI5dmTcyFPKzyS+L9+iFu0fVJ8qH1DwnILBQ8rZDFK2pMnqERYpUKINaIfLJM
         dFeA==
X-Gm-Message-State: AOAM533uo4Z+G7+7C/n1Ujm5PgFa2zRsULBZeGkyxxnR5MORMZ5xjDh1
        tMFWd5etrttetgEfxXWJfnJkRsPxT7m/7X/W
X-Google-Smtp-Source: ABdhPJyOB97IUqbPYIVGE1QlkSQxaooKNIcX3BgNCN36N2dEY53og5PuYXTDxbn/0wazRrwaCLiztw==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr12354769wrt.46.1626263022723;
        Wed, 14 Jul 2021 04:43:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 6/6] refs: make errno output explicit for refs_resolve_ref_unsafe
Date:   Wed, 14 Jul 2021 13:43:34 +0200
Message-Id: <patch-6.6-5d4b1b4ddf-20210714T114301Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
In-Reply-To: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects of this refactoring.

lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
that needs error information to make logic decisions, so update that caller

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               |  2 +-
 refs.h               | 11 +++++++++++
 refs/files-backend.c | 13 +++++++------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index af01a692cb..1dacb5fe27 100644
--- a/refs.c
+++ b/refs.c
@@ -1687,7 +1687,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 					       const char *refname,
 					       int resolve_flags,
 					       struct object_id *oid,
diff --git a/refs.h b/refs.h
index 48970dfc7e..344a3c51a8 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,17 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags);
+/**
+ * refs_resolve_ref_unsafe_with_errno() is like
+ * refs_resolve_ref_unsafe(), but provide access to errno code that
+ * lead to a failure. We guarantee that errno is set to a meaningful
+ * value on non-zero return.
+ */
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno);
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e6b1cd9ff7..5acd636ba9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -935,6 +935,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -947,19 +948,19 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-					     refname, resolve_flags,
-					     &lock->old_oid, type);
+	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
+							resolve_flags,
+							&lock->old_oid, type,
+							&resolve_errno);
 	if (!resolved &&
-	    (errno != ENOTDIR ||
+	    (resolve_errno != ENOTDIR ||
 	     /* in case of D/F conflict, try to generate a better error
 	      * message. If that fails, fall back to strerror(ENOTDIR).
 	      */
 	     !refs_verify_refname_available(&refs->base, refname, extras,
 					    skip, err))) {
 		strbuf_addf(err, "unable to resolve reference '%s': %s",
-			    refname, strerror(errno));
-
+			    refname, strerror(resolve_errno));
 		goto error_return;
 	}
 
-- 
2.32.0.851.g0fc62a9785


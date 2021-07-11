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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1868CC07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007D761178
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhGKQdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhGKQdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CFDC0613E9
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8621498wmc.1
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJB4h/BPmsQfEf0oxTBZeyv4+54xSoIbq0oBAmPjj3I=;
        b=PRSQWEzdeY8ZRZuq2tI6Wj/PcKO/7pOaxitbXznFW+bMGvpj2d9RiVLVwxvXfqazX7
         swetODGCfB0+pucmdrh9ezu5og1+DtNml4TuI4KqRxMF16tnBkGBqd+wQHORU+ifm5v4
         wcTkAytWqgJ3hc4F0xO50urwLhcVnF0ev5g/ABwVUmzFVeyMzofViuFe2HVHkI5UIxPT
         yArlS6uuGojGOwjCz64b03oQbpu4HHTvp9dUm8w0Bz9BcCUZaNnXlnCKkfJ9CW1SjrUt
         yPGMDCmWE7HoVRiKhEghinz5nAaso9a144sbbCupm1RmaPwIU7/KdWKgWYOpsgAMuC57
         G4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJB4h/BPmsQfEf0oxTBZeyv4+54xSoIbq0oBAmPjj3I=;
        b=ujNHJTuBr0u8p9BEmVvdEZlA2rSTHjHsSr5ONcBPlFqrAn5VFp6CxOrwbED6JeZ/vS
         HLIxvDPMOdtBsCJekNlKZqQniWtJlYVkSdmNhw4oE8Xutn1EwPFBvlZPQmEMDkQEh4hU
         t4o8wbc/C/+H52KefW4mGOGd46CUjRG/AbaPeqcjt4ELf5gGOpW2yIS0B4w282MKTbyw
         zZ14grArFhKHdSvSb4zv8j0F2+GASceL1UhJEc9d0ZRMiPUxlekQTudWrg3Xtq8v+JNC
         9rPo5El5SKnOjjEo9YkXCYnF68+vWnWwuyUeaYrVKHbi3pv4raPWhhW8XCULszeSi60z
         IsKQ==
X-Gm-Message-State: AOAM532ZpzLf/iHSc+v/T5/XtZi93QI760byJibmBKOBLbCX7AnAIsyV
        Atx0196BerVcHdAbzv1icc5MOoHmTCqTOA==
X-Google-Smtp-Source: ABdhPJyD901QIs6ZFy9Mu2e/hLe0MqlGEBCctmc0TrRmIsIuceUgM30r6kGEZGsjnj68GPCnzOaSpw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr211057wmc.111.1626021057785;
        Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 15/17] refs API: make resolve_ref_unsafe() not set errno
Date:   Sun, 11 Jul 2021 18:30:39 +0200
Message-Id: <patch-15.17-446b50280be-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the resolve_ref_unsafe() wrapper function to use
refs_resolve_ref_unsafe_with_errno() directly.

From a reading of the callers I determined that the only one who cared
about errno was a sequencer.c caller added in e47c6cafcb5 (commit:
move print_commit_summary() to libgit, 2017-11-24), I'm migrating it
to using refs_resolve_ref_unsafe_with_errno() directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c      |  7 +++++--
 sequencer.c | 10 ++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0364b68f8fa..1d44027497e 100644
--- a/refs.c
+++ b/refs.c
@@ -1811,8 +1811,11 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
-				       resolve_flags, oid, flags);
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	int ignore_errno;
+
+	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						  oid, flags, &ignore_errno);
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..c4772413b86 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1267,6 +1267,8 @@ void print_commit_summary(struct repository *r,
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
+	struct ref_store *refs;
+	int resolve_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1316,9 +1318,13 @@ void print_commit_summary(struct repository *r,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!head)
+	refs = get_main_ref_store(the_repository);
+	head = refs_resolve_ref_unsafe_with_errno(refs, "HEAD", 0, NULL, NULL,
+						  &resolve_errno);
+	if (!head) {
+		errno = resolve_errno;
 		die_errno(_("unable to resolve HEAD after creating commit"));
+	}
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
-- 
2.32.0-dev


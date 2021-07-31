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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13FC43214
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FCC60F48
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhGaCmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhGaCml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB9C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z24so11324226qkz.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SOG30/d0ZGikAwj+Wg7HmIq6SgvCz4L9If8obMIjD8=;
        b=K5YazMMSfKCZJQWEAJZuN9QnIzor2+ZKQZl6D7wQAQK6OqnpKZuM9S74rhMME1QTML
         lhuuooyDQYOjByWrmHfc3hT3RERBjFmD+fSy1OoW7JW3TWRg3uzx3fdV3XE61iyI8DSJ
         Nw0smBzzc6uU/d6w88qmxObAwtQRMVEmgj+Wpmv1CtG4tC3OHFWC5b3lXOZeOWbkSwj3
         B4p4784TavirUbOjbWl0tQ4/dpsPNdZeoPvG5Qk27fIlxFGDJbPCXI27resKAccByZCN
         BDpB5KknndYz90fuzsGQbjzQh20GqAOZ84uUZXj+Fno06IS8BnuYFetLfO6JIfbupPeM
         8QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SOG30/d0ZGikAwj+Wg7HmIq6SgvCz4L9If8obMIjD8=;
        b=i4nK58fYN3SlDR5VUXGGr0wXm4peYU1Gajc0CK7SyoiwsxcUrEtBMzb2nZw47KpCz+
         i2TqfUeG9a9Zc2jinHmsKP183toixKllhSOFQw4e26D+38p79Mutaka3gdBJIRdhLruJ
         LIpI5hXKwaf3cvZKwh2kghDSIMVtmve5SY46wf6lIjqZ6NRd2EDFjTPILfxqtj4SoJeb
         8Bka2wrTXyMHPrQGzvbKt0296fuc+KhhbYSNxiWW3qKcnzZfKAYiC108UXEJ7Hecydhs
         jNUIG4E9lT1q8BYAlyd8m+CxCddd6CrbxXunDbwpfrM5LW50S7R08AdF7T6dAcYAndXf
         NeTA==
X-Gm-Message-State: AOAM531C72rT8tOLhF5fr3zrH0W7u+1RlA3bSXqVo2ZcUkxWnjnRnYhU
        wm7YGsobn/m0kw7ASL4c454URSbG1p2mXQ==
X-Google-Smtp-Source: ABdhPJxg7uSgF/5qIhxfevH3zFo7K7ALPELLpEhDgKgthSHoP7wALz2apWL6/i3OAOeV0nTBnc5qbQ==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr5211508qka.416.1627699354411;
        Fri, 30 Jul 2021 19:42:34 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id m14sm1841807qka.62.2021.07.30.19.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:34 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 5/6] refs/debug: declare file-local variable to be static
Date:   Fri, 30 Jul 2021 22:42:20 -0400
Message-Id: <20210731024221.2113906-6-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declaring a variable in a source file as `extern` and then defining it
later is not very useful. It can instead be declared as `static`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 refs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc3..f5609408f3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -9,7 +9,7 @@ struct debug_ref_store {
 	struct ref_store *refs;
 };
 
-extern struct ref_storage_be refs_be_debug;
+static struct ref_storage_be refs_be_debug;
 
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store)
 {
@@ -413,7 +413,7 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
-struct ref_storage_be refs_be_debug = {
+static struct ref_storage_be refs_be_debug = {
 	NULL,
 	"debug",
 	NULL,
-- 
2.31.1


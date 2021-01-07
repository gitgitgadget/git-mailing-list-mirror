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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C8C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A3B20575
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAGJxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbhAGJw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:52:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F81C0612F9
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c5so4987848wrp.6
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4kKohiPHgksLchqKmp+rvPhtqKF4+ydKTTxzgogV7U=;
        b=nxNs4FMOR95hz2/xwoeOxLdtIZVg96A7m4z8HipRNCsStwSKmie5RbkYhh8502U2zJ
         v8F3cq2NbmQWhFNbjgKW/nvgF8jFsvUYFp+vYZOrDcgURD/DguB0h9jrNp6UYHiKtX5o
         mNP1xP+OvaSb9w0k4wOVFKWmGLT6CSvSz1/xsv2Ukl+MWSGB0qSKNPCSgkBE1doGtz38
         XiMQe7qZOyO6bj8vh/CtVOGp9Rk+Pdxcz029GWcXkrbTnPyzY+OGy33e7jL05vMMvha6
         8wifaLNoZ0Uw0vLNycp7nOBAkZQho6hxJn81ryGvkVOB541GELH54cLLgij4iWT4ZjzG
         tkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4kKohiPHgksLchqKmp+rvPhtqKF4+ydKTTxzgogV7U=;
        b=IIhAng4LjakG91sVXi8gs2fx+LPcoSzwp7W9h5PN95mc/CcyJv56ztUC8BMlntB+0/
         IANEbLsPdwfAacro3+Ru1n+zCNfLdIhV2c0aQb5bIScmRd6mLNMzVuDb3WUuvqXpYJKU
         P3kaZ6riDrEOpHH5i7zOp5K2dUXtQXdqbMXKY6vQQOlDpjrCtBZgYBALS6d2D06+aEdu
         zvAayykYUwnGcmLq/99cePXQxBiwPbfUp8lAt3li7/xC5tAaQ1TMBWfaOqq5gJlWRRO0
         IyPH4nbiKKRKTKy1RKSRg+/8OoG3ppCtDjVfZiD0ASXrDvLAKI/erN4K1m+XwW1TWY+y
         4r+w==
X-Gm-Message-State: AOAM530n6ZRwwWKk1wG/bpbtyNuWRFp7ep/7F4O7WjAm6gNGR0EfTDJw
        B9XUzko+cHja29ugGgWVONodMUn86zVgmg==
X-Google-Smtp-Source: ABdhPJx3Yf+gUfVAC1XqUj9+qJj/UBbLqaCL0v4kBnLNdyCH1Gb/5XUHAQAgogIPd14wPNhPNSu8Ew==
X-Received: by 2002:adf:f684:: with SMTP id v4mr8295405wrp.387.1610013136092;
        Thu, 07 Jan 2021 01:52:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] ref-filter: move "cmp_fn" assignment into "else if" arm
Date:   Thu,  7 Jan 2021 10:51:50 +0100
Message-Id: <20210107095153.4753-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Further amend code changed in 7c5045fc180 (ref-filter: apply fallback
refname sort only after all user sorts, 2020-05-03) to move an
assignment only used in the "else if" arm to happen there. Before that
commit the cmp_fn would be used outside of it.

We could also just skip the "cmp_fn" assignment and use
strcasecmp/strcmp directly in a ternary statement here, but this is
probably more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e4c162a8c34..8882128cd3e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2355,7 +2355,6 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	struct atom_value *va, *vb;
 	int cmp;
 	cmp_type cmp_type = used_atom[s->atom].type;
-	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err = STRBUF_INIT;
 
 	if (get_ref_atom_value(a, s->atom, &va, &err))
@@ -2363,10 +2362,11 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
-	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
 	if (s->version) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
+		int (*cmp_fn)(const char *, const char *);
+		cmp_fn = s->ignore_case ? strcasecmp : strcmp;
 		cmp = cmp_fn(va->s, vb->s);
 	} else {
 		if (va->value < vb->value)
-- 
2.29.2.222.g5d2a92d10f8


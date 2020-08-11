Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67765C433E1
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4173F2075D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2VQv7dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgHKLuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgHKLuF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 07:50:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A14C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so6607323pgb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nin5JkmNoEBKhu4cp1gDKFRLkFkoHS4XH803ldzy2co=;
        b=C2VQv7dQoTfCxqHcKe52EbksIAzSOTHQcKNEJssEqhZCwuH74UnUyfm+PEp/H84xFL
         ZOcHEtX19h/KxBCQtxD8k03o847Jmp5Oa5IOpBP65s7SH4FJTyYs8mJ2cQmbl2qK4qoH
         LVFtXKo/gjq4cAB84H8exP0xK/X9yM5uCxqIRGLcLcOR92yq0TIlCEIYFoo1JTD55bxH
         Woe6x37fnWu00ilckiLJCh4rsp27qcOCgkDOVrmrPDtwiVqhJ/DQhQHTb43VGx1uKAy3
         BiQPnj/F0i24DOqzvIe4Uw9zBvazx9ECV9Ko209vde+RYWACzaT31Jslc0pJjQshSi1r
         MfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nin5JkmNoEBKhu4cp1gDKFRLkFkoHS4XH803ldzy2co=;
        b=ba3bf756vegLoAT5qptQzsA8xnq/iOLfSIhND/pYRFhmYdLZoNnMd08hoyDjpIvGGK
         GfDv1VYGAFnhiFe8YrAoQ53F7nsoUCya+VSfHqnSsc/TVinFB92MI2GsT4Nl8yAgIHho
         388KouVA+tVAaMv8OofdaONjyXkX0KsbW5JJaEZkLae/NAqB3FnWU/au222Uyib3X7JV
         w5mwlhBkr5cW8EfNR/R8EDcspHbvSI755kpYJdst5omt7/Y4MyeUcOMQUsIZEpvwT3OM
         pz1/rhVBaYl/E1JyrYtKjwHzc4kSBCyZ6sCG0zHBdklbrtRJZhMkL5PUYkF8YLpPjx0A
         kHVQ==
X-Gm-Message-State: AOAM532IT0uY6CmL+c4F1oRjEMnD+QzMn/p9MVRNdMKeqc9A0ywY0Vgs
        p8H0CydyBqJk7rV9OL6IkiMJSLMs
X-Google-Smtp-Source: ABdhPJyK7uWzcEyw4Tkr0pJ/C/CdJ9r9WhJCO2+ZJ6bnfzzcG0uZyctQ06J69wFhXY8UvkmaeWTz/Q==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr5570195pfu.164.1597146604762;
        Tue, 11 Aug 2020 04:50:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id q73sm3019220pjc.11.2020.08.11.04.50.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:50:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/2] revision: differentiate if --no-abbrev asked explicitly
Date:   Tue, 11 Aug 2020 18:49:56 +0700
Message-Id: <9daef7445c09d355d4801f64e427c27dd6c44afb.1597146478.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1597146478.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1597146478.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see `--no-abbrev' in command's arguments, we reset `abbrev' of
`diff_options` to 0, thus, on a later stage, the object id won't
be shortened (by not set object_id[abbrev] to '\0').

While not doing anything is very effective way to show full object id,
we couldn't differentiate if --no-abbrev or not.

In a later change, we want to extend --abbrev support to diff-patch
format.

Let's ask for full object id if we see --no-abbrev instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 3dcf689341..24027b1af3 100644
--- a/revision.c
+++ b/revision.c
@@ -2430,7 +2430,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--always")) {
 		revs->always_show_header = 1;
 	} else if (!strcmp(arg, "--no-abbrev")) {
-		revs->abbrev = 0;
+		revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
-- 
2.28.0.215.g32ffa52ee0


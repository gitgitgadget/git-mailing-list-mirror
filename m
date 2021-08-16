Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8358EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA060F55
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHPUSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhHPUSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AFC06122F
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v4so18156036wro.12
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=EaOeRVOAmOOh7P1s9dMeMQUtUF146L/mgcHqbtgo32va0wKNLNp8UG4X5aLNRmZfmU
         Wse+nDJK2q90TO+kMGieYVmjj10ZNV9glo++/0xyG+0S0VmCavnUByYsHg/LvsBYytE5
         AbxSGduUW/Uf1bnZdi7bO9gp/5tAEBnTmKhxPFwXuo640dIyy+bPrcc4yQuJbLec14k9
         +JTrNpDFtQbC44V+V77cT6LfhoKNDNaSI2bYhjWoiGk/GSRolSh6i55cb7xk6i/lVkVb
         /qFB3HhY7eWDMIz+mln/QTC/ip1j98qxMa0uuknxs+CifDr2HVsnAQ1F+rf0eaqideH6
         eu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=NkGDxzB8nbG9KMSazj+ZDdQZvoRUyB0SLwxRKkCu6VI0YX7ViggTYmKXgAKDC5pZMg
         GxGIYAAkSQHRoyE+gelHmAQKwSrFPPJhzOF04UY2JHgo7Tzg//jBrEDT5cDqZ9Sn+Ng8
         MYMhBgmjUZ+3T7L3+fFBuD81HVF5eLjupFuZuSWuISdK7SXZZUAmxr9dTVq35QZBBq0m
         BTvMoVqcr3p66iugqQirFjzuNTekanemw0n9TrbViMUSONVvkfnQ4f0bwx0RuflmdEas
         n0xId5hHIO8fPubhPQwy/pVJyCUxC8EsvP5kdVG3eo6igoxBN6afLlK8wFwKirJToeFW
         0YXQ==
X-Gm-Message-State: AOAM533EK/9Dx/sHyBk3eyRPVEnW0jEonKI8BKlsB1psUz4Dyv34PFly
        RJkH5q2TfsTJGP7CYx7vLTtNfAMkh08=
X-Google-Smtp-Source: ABdhPJzpFNPBYFoo1KG1spHiQCXkbx9SVIDj92mnvqKKZ0LORohQpSpA8s8D3gd3ifcxJOFGnfQdTA==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr205281wro.399.1629145061797;
        Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h126sm200275wmh.1.2021.08.16.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
Message-Id: <c248b69c6e3ac90008b000f915b93877f349d769.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:15 +0000
Subject: [PATCH v2 24/25] t1401,t2011: parameterize HEAD.lock for REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh          | 11 +++++++++--
 t/t2011-checkout-invalid-head.sh | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 132a1b885ac..1b51013aded 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -102,9 +102,16 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git symbolic-ref HEAD refs/heads/whatever
 '
 
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index e52022e1522..a56f7af442c 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -22,9 +22,16 @@ test_expect_success 'checkout main from invalid HEAD' '
 	git checkout main --
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'checkout notices failure to lock HEAD' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git checkout -b other
 '
 
-- 
gitgitgadget


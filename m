Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D27C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F1860EE0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhHQNnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D9C06124A
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so9721855wrn.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=oPFjYgttdb1j4dWsO0NbrELwkQ1ASo+TS8Lu1+tmd6ErE020MNf0bERaw8AKLQW+Kc
         0XvuuJxAFmXLcQScHtjeYfdZXokW6tgjd5F65+ZixXTma6tTCTupNSsJUHaDwsF9gEnX
         ewrcrRI5YVdmlcPZkwEECjB702m9bNd6ufivq5kFuw9iEGOT6DpLbBLRszDyHEJMLevw
         vLSxpY13hT2HawRVKC13wH9g8/EC926VbYGv5Bt/tLoUtk0JFTZW69aWcw4eHn8kvIJL
         29Ln2RPJLQYDk6WBETLENmNMpWwZFoDYivlUbnKn9eNuyAnktSOMwnVLfxzEjZduynTU
         SADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=a1YIz5Iz6bHFSPyim97Q30BY/sT7pxMQfzCUVrUzRTUIy26pANtmTrWe4WC7+UsH3T
         okRGPGsXMMccy9UgzsiSzYYJk3LFQMyl/E4yhCSYGyupXSaDOgScghw8HF64G1qNmsSI
         UY4ES9t8LqqwnRpF6Xau+qfWgOaFaxFboTucL4wJSfwzgn+vMM/kWlBbfmVjvjBo6E60
         7U4MhKQvMLK42nEizpeStEGawPOmVXmGIA+J1p0P8JsaLHcOCnp0ggdRsa/pGkrKCJ3B
         7g05yJZ5oWUj0buB+IrS9wVTQRhfUhXVD8PzhrQD+fCDDOJq4IofDx1T+fMslyjv+otv
         BtQg==
X-Gm-Message-State: AOAM532mXSOCRvaTmV9bh+XHEHfSQ0UFIH91YpI1S8LMLNu3cHyk7sLp
        hEEHam8RVBu38avRVSszESfYHZNunJA=
X-Google-Smtp-Source: ABdhPJx9vJ+n+clrTJJ4COk2+4AhrBxyh9HenUJ/6bww9capWtSn9uzK1HNcTL5RySzWENOK1auiHA==
X-Received: by 2002:a5d:6cb1:: with SMTP id a17mr4137231wra.48.1629207650562;
        Tue, 17 Aug 2021 06:40:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm2644607wrv.65.2021.08.17.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:50 -0700 (PDT)
Message-Id: <f0b7b1e2380b549ff3fdf65d0208723977d7597d.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:06 +0000
Subject: [PATCH v3 24/25] t1401,t2011: parameterize HEAD.lock for REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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


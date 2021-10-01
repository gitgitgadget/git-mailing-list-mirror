Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024BAC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D1861A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352900AbhJAJSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJAJSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DFEC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so14399700wra.8
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHaDeAFOWlryM+y8A4xm4T8eqObGfMQL7CAiFUpT13Y=;
        b=M6u+e1DIb5kL0LxveOhTBFp84bqc+sgn6hqcfjnxmNP2d3sytUZr1jaaP51ujHJcJk
         6Qf5A+Xt/u8C8qqZHQs83h5ElnaNjMkSOkC694C0Kynkxaetj1Jt47tvlh8PmAAqpGEt
         2zfXsKhDFu84F+RXfAHq4ruM74E3JNVFi44Tr+CPMK3iEjSxRqeIbxnf2c4q/MQ/KAA4
         eMOElwaBpDsI7hhjvbRYEM8F2U7+TroxsAO6Mks0osmkYe4dx3CaAOgE0lSrMa/nH2FI
         uYj73E+krAo1G9muyc6ttg6JO1OHwTV5ldJ5X+3cNtztov6X4h9KvS1MVyqP9zywE7C1
         jTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHaDeAFOWlryM+y8A4xm4T8eqObGfMQL7CAiFUpT13Y=;
        b=EBlvPn8o4dQkesc360ef/Ouao/fk4xdh9lcHbnMo1lYbc61kWMeF3nndKnatvJu+zR
         TG9CE8aqx2rTLmNRVNjsDBk7NOVC86JB9xWnBbJwt0lxXMfcrC68f1jJnCVToW2OtPyC
         L5jP6rsTuOYCmUfiFqS7klLAElWsoWJPAZO/CPqazSaVFDm6yoxxvhSEdqa3oQzTdcaN
         V9FM/GEBhwQpYuY9gSPfSQlouG/XsnTq5u57tWx9Pj3mqxrGpr/VBpuTKv53Aj5lUdmQ
         hOQEDM2TSzsPh4xFw8lNJak7k0GZw0tVHn/LtNW3ZHOmycOsvqzmrwKkYktc11EN729L
         A1uA==
X-Gm-Message-State: AOAM532lchK/RM/P7qqrv2e+0OigHFXbKOrpz7OZehm+OLCbCuBjPKiF
        0/Elqb1xttDVhAEcFS9PHHukMKvbAOc9tQ==
X-Google-Smtp-Source: ABdhPJzR/2dxXHqwYONOulmXbA7oAA5itdPuWb+IbFUM9Sz89rAPJnqYBQ90uNfREr7KuR5v6/ro0g==
X-Received: by 2002:a5d:63c6:: with SMTP id c6mr11228917wrw.186.1633079818395;
        Fri, 01 Oct 2021 02:16:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:16:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 01/17] fsck tests: add test for fsck-ing an unknown type
Date:   Fri,  1 Oct 2021 11:16:37 +0200
Message-Id: <patch-v10-01.17-00936435423-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..beb233e91b1 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -865,4 +865,20 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	(
+		cd garbage-type &&
+
+		git hash-object --stdin -w -t garbage --literally </dev/null &&
+
+		cat >err.expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck >out 2>err &&
+		test_cmp err.expect err &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.33.0.1375.g5eed55aa1b5


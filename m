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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D263C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583976127A
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhD0Kjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhD0KjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8562C061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so58956045wrr.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V6jTDUBCqmms0JZXureui5VPFraR3msoRfft4DttAE0=;
        b=Pk88fopcmrMMryMWCbu8vIf1TP/ggIfrSwn1HQvsw3Df9ffNIcwM4P1/GridP6hHcs
         cQqJxe6S7OKKpFS8M86UerPGP1j8YUxdSWruD8TxfGwPKrsuajmaWtA0sqa9a14cDREo
         RlxVF8TOJGZtA0+I+SoYVz7LB8J59dHTSL6YgCvpRUrSJ/SDu79Zv8+4To5oVx0Ou8Zo
         LIEL8ncltl78GZnH6U2JGw75eYln8S0+h2lPCtsuwzwICp4n8Ymz/Ru0zUrSB+MzOu9B
         EBZ3DbInXprt1eYi1LdkaxZcpFB6VMHmjPsAV+4oto4RmFkalWv/AhNb+57pWBgqqPml
         T3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V6jTDUBCqmms0JZXureui5VPFraR3msoRfft4DttAE0=;
        b=DPX6SXzZ6mIDR5VHWEmYYanTRRtk3gzvD0Z17LPF3j9U2cVxzA5eyY+Fanw0AfkLHP
         s0AVVhhE1rtor8C4HJKycUM7BErii0m5JA5TcbjuNN/nVSSwEzvDGlpBBP7aidihHqK4
         7HmcSmRoAnlUpd3bOGldkaXVoFkt4KZRSHnKj0M59UVJa5IkRiPmSgb+Gm1G5M3pel3b
         BYSPcNrqLVIDSpW4lFhQVOIRAfcmh3kfuUSC0IxtjAhi6NtT5qnqqzBPLj1BnIO5qd5d
         5uCxlmnG5FA6QWK4hvzJLY2vs15eO9JYiI7gY1IPNqPsSXHyOJYOqAmi3296vVmoe7hk
         39xw==
X-Gm-Message-State: AOAM530efogIueG725nqHuQMa1++yutCHZhpGiCElwZsXgiyQbvOIzuf
        +ZR8Shnk4F21ZdJXyTh2pIFG9pUz9pA=
X-Google-Smtp-Source: ABdhPJwD3Ea4zBw4O/LWGRp+PiHG6ldh7r0nbyMCbU0hTShnUgzIvW7G5p+YcBWL6azmizon6zIyjw==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr28860573wri.237.1619519905556;
        Tue, 27 Apr 2021 03:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm3486425wrt.13.2021.04.27.03.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:25 -0700 (PDT)
Message-Id: <8ad4a35cda706b1bfcd8ddcf1b1c2e1d8f692c70.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:02 +0000
Subject: [PATCH v2 01/21] t4202: split testcase for invalid HEAD symref and
 HEAD hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Reftable will prohibit invalid hashes at the storage level, but
git-symbolic-ref can still create branches ending in ".lock".

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t4202-log.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa35936a..a8c5a00d012d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,14 +1834,18 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD' '
+test_expect_success 'log diagnoses bogus HEAD hash' '
 	git init empty &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
 	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr &&
-	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
+	test_i18ngrep broken stderr'
+
+test_expect_success 'log diagnoses bogus HEAD symref' '
+	rm -rf empty &&
+	git init empty &&
+	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10291C43331
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E969C22573
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbhAPRO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbhAPRKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB3C0617BC
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 06:41:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so12144141wrn.1
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8lha6dhJWtv4daq4GPD1LevZTXz3l654gts8VNMCnS0=;
        b=tRfZA7EH61BnQuxHowkbqJNwY6wYOPPN6Rd+k5W06W5EiHZ8zwu93YgGOC0NrCkdXA
         ha6iclGNv5PTzESBUoBnOnca5pu5N34NQhGW/REQVAel7y+ChJDZmjNdg6/JhQSphCXG
         bvWy6mtEkoh09Qbmb2rzGqRUVoL+vW9bAl94NEWNDAwt5oAkUPwsrBwtsw9Mgw+yurDq
         C2+1Ysk9O2TAbCzRXb4cyrFEybF2GC9vQJeyMvATQuia5xdLcX60KpeHQZD3nMtgq6pX
         olidq3W0RK3EWFGe671whmRetRWDG5FP1dFMSWrg5gNRSVyqTBOT4txfP8tDOVmfeaoA
         iDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lha6dhJWtv4daq4GPD1LevZTXz3l654gts8VNMCnS0=;
        b=idv+Vkm4CPor1rA1p/cHLtpFqaecKG18NDyvNjhBsPo5GeO17cpKT+sEqVXvyWB4Wb
         gnx4y8/HQ/OdbIZFDYwpPUDO5dhgglM5R5rjEll7NN00fpDp64R4+zZD1qw95hbfdIzV
         C+ebmVgPw5JlcoXY4wIjyXlMx0uKUT2fMEBE1/y8kmCsyLWkAgym59F+QHuUvS+zOCM+
         IaqCUCAKU0IPN+NRGnr+J/EruMXsJIIfk44Neubm1wvMnCjf4PWwulyOcZtM+PpD50mB
         +TFId9fjwRVVyJcf5aY+oUkgz7CkT2GZ+yeUimk67xviD53IATW/b9jaeU2jnSv20kzZ
         KYjg==
X-Gm-Message-State: AOAM533s6Q1umSmxZ0hDXrH54oedhC6cQtB09c2NUzoIgGqJ9djAM3hp
        1YFNsfM0QYiEsxumTLpsPh7EvMsMA4scew==
X-Google-Smtp-Source: ABdhPJy1TNFzAFbwpgORw04pI2J5XrT6YEX2AUIwmsx+iupMpfD2eFJCCueUB3PWjsyNvaLma3K/Sg==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr17943637wrx.7.1610808110859;
        Sat, 16 Jan 2021 06:41:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s1sm19535063wrv.97.2021.01.16.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 06:41:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: add tests for test_might_fail
Date:   Sat, 16 Jan 2021 15:41:47 +0100
Message-Id: <20210116144147.14036-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <YAFiFW7D1qD7ZJ8I@coredump.intra.peff.net>
References: <YAFiFW7D1qD7ZJ8I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This trivial sibling command of test_must_fail added in
fdf1bc48ca (t7006: guard cleanup with test_expect_success, 2010-04-14)
didn't have any tests. Let's add at least a basic one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, Jan 15 2021, Jeff King wrote:

> On Fri, Jan 15, 2021 at 12:35:10AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> +test_expect_success 'test_might_fail is like test_must_fail ok=' '
>> +    ! test_must_fail git version &&
>> +    ! test_must_fail ok= git version &&
>> +    test_might_fail git version
>> +'
>
> The title confuses me. Isn't might_fail like "must_fail ok=success"?
>
> And certainly the code here shows us expecting the _opposite_ of what
> "Must_fail ok=" does.

Yes, this made no sense. Here's a sensibe test.

Junio: This is a stand-alone patch now. I'm splitting this off from my
WIP v2 of the "set -o pipefail" series.

 t/t0000-basic.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..efaf7ec4d9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1326,4 +1326,9 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
+test_expect_success 'test_might_fail is like test_must_fail ok=success' '
+	test_must_fail ok=success git version &&
+	test_might_fail git version
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF50C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200C2613C2
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhFNRaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhFNRap (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B6C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g8so17952701ejx.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/sk61rbrk6133hsGYlmXqMPCCfa9G54VO1zs4G13Xw=;
        b=dZcv368sm3j98AlVsB27MN1AUIhvHrKIG7YYW3f6/R9ICgB3jc+qX1RXoPwbsoix8m
         3aSA63puRDCgt9SB9/x1I/GDAntoSEFwXxQgxcVm6O/aDQJzWsjAWD/wzY+coRcLezdA
         /Lh8Ysf1/u6IzAmUWvs1CQ1cKR+F9mqrQCvALqUtHvWnBQnegddzcTvwIPwpwvkDkDzr
         +CD/8ZTAF+B1L9mB8+Gz1ee+hpqad9EgkkikFXMmiGg2a2cNLcEr38JPH+sa5XGZa+kr
         FI2JvJzMz0ic2/yPqsFT8VA1pYuOSFrK+vi4PkCadKCItvYQvC5M83tJaN38jKNxbNZo
         k0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/sk61rbrk6133hsGYlmXqMPCCfa9G54VO1zs4G13Xw=;
        b=gaYrBh3wuavnr0UN0ghmsPoQyyBccDRkZjvgdfJczw+lmfMdjNE1oEEN9Dx31URqDS
         ufeI8rwSnfvSxJpOx9eoo9kopP0UytQpSRrU/L2e/x0ZVjxF5Z1OhniRmtxe0mXfx2Kd
         qDyrR+fpqhCwLV1VOj0GqkJAl18Q36BTGCp90cjwkmQC1bFZJtsrsC/Q5S9SPD1+/tGn
         YPV9pmE0QkxhLyuZ3KHoIDrqpADlaqKv84UiIt4hTeC+xUqL28FqgfWRMho090BUPnX2
         xoqlyzKqm30kAkIN7bYq08phhv0+jYvP07NXsvlcK0vGXZufs4kuL2oUgvH/c0FXve6T
         RVBA==
X-Gm-Message-State: AOAM53333plK0BYgTD9eS8D4A4MMxUk0ff/+8RXz9aPYDM+4D6KUYJjH
        iLXKsCPGCwDHUvjYciTDwguxU1gqHLkmSA==
X-Google-Smtp-Source: ABdhPJyZzh0EVc/94XMw0u3VMLXZ2Bbam1tgBBDDdzJwO2WjTvWNYgrY1oa0uraJnuSCkUE/OI3CAw==
X-Received: by 2002:a17:906:8056:: with SMTP id x22mr15814394ejw.298.1623691707656;
        Mon, 14 Jun 2021 10:28:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] mktag tests: invert --no-strict test
Date:   Mon, 14 Jun 2021 19:28:19 +0200
Message-Id: <patch-2.6-550dcedfcb8-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mktag --no-strict test to actually test success under
--no-strict, that test was added in 06ce79152be (mktag: add a
--[no-]strict option, 2021-01-06).

It doesn't make sense to check that we have the same failure except
when we want --no-strict, by doing that we're assuming that the
behavior will be different under --no-strict, bun nothing was testing
for that.

We should instead assert that --strict is the same as --no-strict,
except in the cases where we've declared that it's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e9008744e3d..951e6d39c2a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -33,6 +33,8 @@ check_verify_failure () {
 		then
 			test_must_fail git mktag <tag.sig 2>err2 &&
 			test_cmp err err2
+		else
+			git mktag --no-strict <tag.sig
 		fi
 	'
 }
-- 
2.32.0.555.g0268d380f7b


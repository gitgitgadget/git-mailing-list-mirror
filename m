Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DAC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAECB20878
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRhNJbZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439997AbgJRAXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439985AbgJRAXy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 20:23:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F437C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so7504323wrl.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x1mvKEZhb/jKEZ09DeJFivtpoSAi3ueZrbjVrv5jpf8=;
        b=dRhNJbZAmWeR4F7wdCAAJ3+YsfhhRfE5HrY4ufBKcBnyiVx0fSZVCj9E9AiJXfLEUo
         R+T8ihSub2EmDyJWlRpi+pxWn0sO+PV0rrFdhxPlB4LqWCs3smzVoR8UBu9jDAuUIleA
         tmP3r2Kd9XaIgmcO8Fky7ZuhL0ta/gc0Ba4+tw1p8017bl7HMd/ayEgFGc8dIcWU+U8g
         ZebgTKAAVcmYZh193DwN+rZi5W/eTz5+3OFr8+o8WNHwufEsyn70TkhN77+QNx9v1sBV
         /mDhVg/CcyQLlsVDliV1Kj2LR7U1JkRQLzzmNjtbQB0QWIRNZZBZbUUNG7VsPpWLpmo1
         uk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x1mvKEZhb/jKEZ09DeJFivtpoSAi3ueZrbjVrv5jpf8=;
        b=gBj1EtgKDielOpVTxKJpqJ/9GQlSjXutENsHI96YXZkesEBA9Wb3dRDU2kBaCZsWpN
         NLHN3JHTouJVo/Sh3zqylIDXrj02a35/oTuGma6mTRAEM9J6uyMeJSjasuSZNVNPfVZa
         Gz+vBbDqGumILRfcs0QUCjsU42ydtOPQdnoLYz75/lDX1X95VEKFB2Dqb9wimIPtM59O
         OFKJdcAmpPMep8dYPtc93UR4VIGgy0POIG354cEoyipJtzmc2Iloe2Jvreb+lig+K/ZS
         OSAr3FzFeZusGbHJvEYqfwiRLIFsQr/Cut044SzhhM4U2PWI5nVZzDIXkL8QzC3v5++x
         +KaQ==
X-Gm-Message-State: AOAM530nZJLGi0Qy0M1l4uc3ywpqA5YaCFTyyH8JdVKbdSf1BYZswsy1
        5mneL4Yv5lUnCfbhrwwGhkKyg0ORcdM=
X-Google-Smtp-Source: ABdhPJxjDIfGLiklIvizcz9HABXf8eouWPughOnirj0yTvXKZlKZJvhHhElBescVOWQYEuMBsiUc2w==
X-Received: by 2002:adf:f210:: with SMTP id p16mr7283511wro.40.1602980632020;
        Sat, 17 Oct 2020 17:23:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10sm9260335wmf.46.2020.10.17.17.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 17:23:51 -0700 (PDT)
Message-Id: <0af783548744dc5e2a0e92040f166f80ea0500bf.1602980628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v6.git.git.1602980628.gitgitgadget@gmail.com>
References: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
        <pull.878.v6.git.git.1602980628.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 00:23:47 +0000
Subject: [PATCH v6 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
(in addition to the TAP output line) adds up to hundreds or thousands of
lines of irrelevant output that make it very hard to fish out the
relevant results you were looking for.  Simplify the output for skipped
tests to remove this extra output, leaving only the TAP output line
(i.e. the line reading "ok <number> # skip <test-description>", which
already mentions that the test was "skip"ped).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 72b88dffa1..f68bca745a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,7 +1062,6 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget

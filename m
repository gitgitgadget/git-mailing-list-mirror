Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73BC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiAXTch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352137AbiAXT3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0BC029822
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r22so7845452wra.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zdzjp5OSTkr13zGSSSD1ncEu7unm1sp1sVMxlp9/SYY=;
        b=bZsxT6yMLEmvjlg02ixw/z555DzPxmKBcXWSxLmgnmvuyB/UFD1YG2XyfzOqTPkf9K
         zpdrmm23RGgHoTb6Qi/nA0BZt+yw6rx2RbHHZcfRyptbKqNhXMn3pV2BiX/IZf1Ja7QQ
         24NTK3wwtpdgzbE/RgDS1lhyBgkgVDUyCDFl8BIy/TghVnll9WbHpc5NFOebV+KUiM2B
         +cHdMyWcYcMsM9NrLt2TMIR6wbQMdDeFmIJdeA6Sgh/y5jYTKQ+fwOvNF/A2k1xVAEpK
         YtXDd7mBT71Yq0kxkJgcB5AX8aDb7mOsur4EEqGz7l0KR89suAcN6gyI0ATdQBXCbFZW
         uOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zdzjp5OSTkr13zGSSSD1ncEu7unm1sp1sVMxlp9/SYY=;
        b=rZ5ssmPUjcFXXAcBhkXFMaUPihPTliA+JIAiQwXvuUF0eGGRvIPIahr/lELB3HeCTA
         KquZhydz1yTAM/az6p9FeTw6Ww2nEkBA22LtEdWQpTCyEQy7B6540KrtT0KmKo0sDlZs
         9PpqZ4p6XLDuNagHlXIO549RthF1EzAJKfzoMSD1+7pL0b8FlVI1xdeqUMqGqhbqvS6y
         kxLegQPoDrZ1HTW4rSiaZ0d41dlwoudxGloA42iwgDGWu0a4pBNtFAlvR1/A51m0raqU
         OJxEW4Z0CaTZPQD/7ogCFM/KnZxjifldjwvtHFqLTYUtIzhur0/lTAHUGubVRdacLOT5
         JA5g==
X-Gm-Message-State: AOAM532DcWYTooGkRLF601vIQoDmizaoJ1gADfMAsgKsWITU9pEys85t
        QIlLFq8za50QpFu6ZsoCRiBiPGXP25RoKg==
X-Google-Smtp-Source: ABdhPJw3VCC07YOdNqzccAL36wcrI3PXE95ktB7arTDL0eRcRtgUmcwqRG7/ii0NfmCMSBM3jssOcg==
X-Received: by 2002:adf:f68e:: with SMTP id v14mr16271949wrp.585.1643051629089;
        Mon, 24 Jan 2022 11:13:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm14783702wrq.11.2022.01.24.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:48 -0800 (PST)
Message-Id: <b0bffb6e29d2d060c7698cd3e84918f14ad8a3e3.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:32 +0000
Subject: [PATCH v7 04/16] reftable: check reftable_stack_auto_compact() return
 value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If compaction consistently errors out, we would accumulate reftables,
and the follow-on EXPECT would start failing, but catching errors
early helps debugging.

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index f4c743db80c..e84f50d27ff 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -839,6 +839,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget


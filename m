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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7EC4332E
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3184F64DF0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhBOQTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhBOPrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28127C061225
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h67so4917888wmh.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snka9FRyVUkX2ZLdX2RTj00bki6EE96cxrtxrdD2870=;
        b=UG1FImOZEGpYBz9v37fvaflNjCh5JJ2OLzifzh2deS6RTjXI2GdyDUk9gze+9UEo1p
         xjxB+6znb+EbDwfmkt6dGxPo0DPwXHbhXsa7vQrpIV4DZmsTibJKo3MtpiuSj8mqyH2l
         wQGNNHiDsQkYozIJPQQ7s3/zq65OPC28PgMI4E3TypJp4P62Ex1AC4PTW9c5WwGWpqNF
         PJRNbUEc7XivM4Nkx/0d6e13tKmyoI4J7jzfrMjOQPedFvOOHT1Ix1JcE+aIKmzoTiWo
         g3jBIz9PmD7DlA71HHJAOlE05pGQ7vDcFyZiUqbOyYsDlHdSbVXU+kXf60VwRzQ8nTeW
         Itww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snka9FRyVUkX2ZLdX2RTj00bki6EE96cxrtxrdD2870=;
        b=r8d/zsfL2V4Zo7XCQ3dIe93pPVIHIOt1TuQzsk7MSTtsTnkI629JVNEAeVodkur91q
         wqv8tgOcZBfraNsxX3dK9sk1VZ3TrGISSFSn4OKGe6O9LvjCiztJ4VtLNnSfmwpch5wy
         x5tApzsbil6nrqBmDwCQTlVkV1RKe3hhYtWJgjTyr0QsBhkVPnDp6BXbx8NGk5Pc3Rge
         C4FoSaTihZV2tWLZh407FCUXXxpXYaGJa6HtavL9opV6MMjHPj9GF/wpKqofkVFx9zSV
         viQZZS/BAEJ/troIsmEPrqz+bRlDsdDgOZgijUjPMHkPSs7DHp9V5XmMvhj+SVIrXAZ8
         H4Mg==
X-Gm-Message-State: AOAM5331nKA4Yt1EixI47kJ/evA0aMvh5CJfRtnxXP5I1zzgZBZUYhc6
        8ojCT2rJexwC3n9ycOAdBK3yHGy58OCPgw==
X-Google-Smtp-Source: ABdhPJzv44DmLgBL8gMRDjYrDo1tSuSGoHmx1ez6YyWlD3o+ctQjAHM+/SzW5wUtxFfc9ChdRS++BA==
X-Received: by 2002:a05:600c:33a7:: with SMTP id o39mr14916051wmp.10.1613403898660;
        Mon, 15 Feb 2021 07:44:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/27] userdiff tests: remove hack for "RIGHT" token
Date:   Mon, 15 Feb 2021 16:44:15 +0100
Message-Id: <20210215154427.32693-16-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the "RIGHT" token isn't how we select the desired hunk header
line in the test anymore we can revert a hack added in
f1b75fbaf1 (t4018: convert custom pattern test to the new
infrastructure, 2014-03-21) and go back to the regular expression we
were testing before that change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 59d855c01c..b208a771d2 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -33,14 +33,14 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup match to end of line' '
-	git config diff.custom.funcname "......Beer\$"
+	git config diff.custom.funcname "Beer\$"
 '
 
 test_diff_funcname 'custom: match to end of line' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-RIGHT_Beer
+Beer
 EOF_HUNK
-public class RIGHT_Beer
+public class Beer
 {
 	int special;
 	public static void main(String args[])
-- 
2.30.0.284.gd98b1dd5eaa7


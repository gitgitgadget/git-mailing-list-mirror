Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA7C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiA0L4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiA0L4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DEC061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c23so4315025wrb.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTfRkno8sCLReMHVLRaVWrnXn3pfrxveyOB4k6/Y7GA=;
        b=NlmY29V66S6n2EmezaFjpsX11K68xqfnMpYnBBRVQCYIRrgd+Byd52mnOKqEz9rE06
         FfDX4FIn6Tufd5usVpy80Pljt0ceMvRVmC3ijoG3mpQ7QCuP358ZRljfvsvDjcuEFerY
         DVINH/j8ao/5jXEBah+RMMwnXzCTfdreYfiWNXSaDjIEAv5NeGm+Hi3d4vgThXRa+2LQ
         Tx/0dSKr5zBkEH0DlHg+CWPB01fdUHe8KJYkDZinf0ocrHuXbxNV/sSx7KNidsh+uUhX
         S3OSsaBl+JT773Jj7BP9AGulbzGXPYCjywZaKmr6Lr1wxzwEYbMonjmqCaHvJKvPVH6D
         mZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTfRkno8sCLReMHVLRaVWrnXn3pfrxveyOB4k6/Y7GA=;
        b=prNrkikPFA4HeTkJNn+5srTGpn4xpwPAnTlQTw0PG9r/XZr7PQ8W3ljJmERTBrxAXT
         M4MmSWiwGxa7aUcEb76sSby2btZsaVb+nOXGPmaZl+mcHgT5XDskZUhGPEvBIaJXeDjj
         NN0KgUng9JOchV7pZe+SOhEYAAdkVqk7HSUIs6pje8Y7lwEVGP9lk18yQC/H93uSAKSu
         A+YQtECPqRwrTUFp4GGSA3Wa9vCoI+wMse+qkaSozUngcMgtePVS9EpwknLHwaOSvA3t
         eqLGlzaETg3fqJbCk3oysty4Ryb383e8UGTQSkgWiVhYBIzlgEThhVVXEcReyRHYc3wV
         7lmA==
X-Gm-Message-State: AOAM5317YAPkaumXo8vwMuK7E8t+qgVMHJ1lNPsrAe/RajuvS7triKcp
        6iZ8vsNOhvW04mgCztLSCis//TGNViSQSw==
X-Google-Smtp-Source: ABdhPJzoq2NutktsfFFYjFqFKT7khqjJU/e2GE/GnBRNgk+KajPXiUwnetXvhuccU4AYPhAW18iixg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr2713892wrr.586.1643284596392;
        Thu, 27 Jan 2022 03:56:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 1/9] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Thu, 27 Jan 2022 12:56:23 +0100
Message-Id: <patch-v9-1.9-b9372cde017-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 6a1f0ab0172..400172676a1 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.35.0.894.g563b84683b9


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6328EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiJNPcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJNPbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881611D2F5B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w18so8120860wro.7
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD8xRBw9YOj6NbUOLtIRD7AfmY+vNrx4gJNIXPJPBDQ=;
        b=igP13j2v02gWGDAUiNn13/cuhEggXSF8gVdt4RKPD7VfLob0dHhSevgMbDsIDXg+qW
         FCq6HmO5QUoO2KC3MiTdgKMp2B9MPxCFT71h5Bk6uJukyOPfm6Q5M2+CvuI4zC5oxOCH
         WXVcdTZfGvql5flGranT6dAmOALRBFBZLbKlpG/fn/trFGzRUork+RbixMkulXcJ4A6I
         M/7AYzIxSIsR2YfMySvYj5TV+GE4SATOBVwKAyrKMuoJ7BfskawFyIXLyTHXY8wOFY9G
         RBc2rU3YILU3799yGBPLvzCQNmq4M+hvN3j8UnnrC6pnz5m2X/vT2sdsNECjCa+gvDxw
         zjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD8xRBw9YOj6NbUOLtIRD7AfmY+vNrx4gJNIXPJPBDQ=;
        b=PHzSEIhXRy3coqB+d60T5MpWZZm392W/u4rqtWVzGyHUr7hLa8UTvGkllKSgyxWirN
         vCIEhZwviUE/RjA9JN0qaitOefGGBc+6Kp+WFhfJpInB4jpc71tesY0O7USNKIij61Jj
         YXld7zSs0LmviA6ck+MVy43t3zemSYKOEUi03enBZeHb7ggOcyxyhsNpyh/DGA3x56Ch
         SPpHVFZ0AVtBV5P6iwCHJS/wmkLXkuEPVkZ2CANxhxGP7emKi1Sc0LH88HGp7EGwt4MR
         NChTOGAw26ml5oMsSRqKt1Orkk3WJ8nxDEnZ10A4fUif4uXE/Yr4RDmbyINZkq3P3ipr
         f/iA==
X-Gm-Message-State: ACrzQf2HF54qWgNr8or3WfKEIpGsR+H7ZmE+ATkZNBnHmUJuHYhiLYEE
        XLA13FX/mjYHC2kh326Mls8RFc0e8Gy7ag==
X-Google-Smtp-Source: AMsMyM7taBj7edjhG04PmANs0+zK8EOFu5SBFuSGopcTXezSqmkippU/ckaj+Jj7gULuvAv8ZPPZXA==
X-Received: by 2002:a5d:4748:0:b0:22e:32c1:d11e with SMTP id o8-20020a5d4748000000b0022e32c1d11emr3863389wrs.672.1665761493902;
        Fri, 14 Oct 2022 08:31:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/11] cocci rules: remove unused "F" metavariable from pending rule
Date:   Fri, 14 Oct 2022 17:31:18 +0200
Message-Id: <patch-v3-02.11-8219b1b12f2-20221014T152552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with a rule added in 9b45f499818 (object-store: prepare
has_{sha1, object}_file to handle any repo, 2018-11-13). We've been
spewing out this warning into our $@.log since that rule was added:

	warning: rule starting on line 21: metavariable F not used in the - or context code

We should do a better job of scouring our coccinelle log files for
such issues, but for now let's fix this as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 072ea0d9228..747d382ff5f 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;
 
 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
-- 
2.38.0.1092.g8c0298861b0


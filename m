Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB9C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKAWg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKAWgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA6201BB
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f27so40782442eje.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEsGcDbioj3TrSYABwZLxNQdhqiyZAxuNg/HCrBStho=;
        b=oGAOKJVXUbzuu1Q3b9gF7p/P/j7M5lGQNXgpMEvzEksih0Rgmw7t2HXhGZrapjd1LA
         iU9K8wwRxBlSzqrRAUDkWqh6YF1pem7tlJG/lVcdi4t+oMFYJnnIdC9y4W+8SGgtQUGR
         f0H1KdmZ3VMm826cRcP8QK1SrvQuH5pQ50qWw2dZEmgutPFdCAST9tcpe7821EtbsBSb
         fOLbeSkxyMcwwjUVNGhPuQ4enOwOBTvgUXuJPW85VWAk+mFBlCKH8Ry/98F8vLwnyTmc
         3TtgLm2ejsqJRmSX+W8mghyxNv9Qtr5dW4BZ3cjClMVk7mNFtWDmHfZUhYyb6WT2MM8+
         3eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEsGcDbioj3TrSYABwZLxNQdhqiyZAxuNg/HCrBStho=;
        b=5+fFi4m2Jpu1Gx8PaPAjz1zp133S2OKHOBuDKCE/eRxE+vUDYDx1C3C6JJklWhXARj
         bEF6VIebbIpnuxPDxdQi1DYoTlALADLExJbxRBNHxlCXViZxYTzhO/PXsRzFKMFUqJUN
         PTKjtZiW3aLvtJ6JjyfFER1Cy7omgYNQcmjQXJWs2ueDdj6jFlTbDhylUrkQuMRhFgB9
         VmabeHf3nkkkCu2/f4V7zH+0R7BmgKQQTcIbHqE/vme3ZMyIrYpkpwvU51VZOL1gx7ap
         /GxhNthzkzoiUEaz4r7kdJ+BrLgzGy8KmhkOWzX00HCYNmqpwc3Lo7EYmNK3zLBJjooZ
         Q5NQ==
X-Gm-Message-State: ACrzQf0rCzNacDIK7JkIiFumjdK6/R8yeERi3He8wQwF4baw5avdM7OC
        BQCV3Rb/9xE5VluTBCd9Xr1dHkuCC1/qzg==
X-Google-Smtp-Source: AMsMyM7Yo8J0AqXk8Fn0HT/Ffo+Hpb+2xid+SRQQfYiBCwQErBWTq3wLF/1giAwY+r3Sb7c6eas13A==
X-Received: by 2002:a17:906:8a6f:b0:780:96b4:d19e with SMTP id hy15-20020a1709068a6f00b0078096b4d19emr20317058ejc.624.1667342162571;
        Tue, 01 Nov 2022 15:36:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/13] cocci rules: remove unused "F" metavariable from pending rule
Date:   Tue,  1 Nov 2022 23:35:44 +0100
Message-Id: <patch-v5-02.13-d8556f94cb4-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
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
2.38.0.1280.g8136eb6fab2


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38954C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiGSUr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiGSUri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D0564FE
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z13so3773579wro.13
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeM6KYAauPJLgI0odAy4PS+MsiTwdnnudoJOv2YporQ=;
        b=RKdXA/WVk9IEuLAzIW1Dlln9I82gO75z722qPDYb7oRUQGOvXfnHPvilmCTes7jszu
         XYhNzskF7PXaTf4zS9CXGLIrHbMn3xY7rPuYkU2PibJhvuVWsWUjTHhmEeYxhA2x67Zb
         Qb1tC3ILvtTx3bQ6dMSfzxegI+agql20l5qJqvDhKB2hy8qzb7dKQA38clMLKWovbzu6
         uJLzgQGWtnqHH36/MAYfiWnn2QVJdlL7NbjivoOQo/LcK95Avegpfa0lGhDW4/NgHrRe
         HmLTrP1KKIin0eIwoDGY4iZ1Nz/lH/pAyW3a1nWuEoqG3gSaHXjxXp37E7E3KoPRs+ay
         i2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeM6KYAauPJLgI0odAy4PS+MsiTwdnnudoJOv2YporQ=;
        b=l3M89+yPO77VJuERBddscGrWJA4bRDWeCCD8yvpVmLYlQmXrJDwOazjicC7kit8IIo
         243ZT7jYezWfz52A7jEJ1BhgeSlbFZ775bFmOEyD7ujMMPTYfJ662gpRcrCVqgDRfFOL
         D8VBkxHH3Xrvd+uuaKhISAO+jIn5VYRGEBFT1d6hwtCJIM7ZV3rjq3G1NeSu/erjSQ/D
         6LxfRpNC4FL3Lt7CL63wmDrmTFUJlfrRPYOmiePOjaGzUYWNYqqowi/1mYihLcvgpVa3
         V+TGXghl0mrpjbmxy9SM01uT3q/RqJ+4+msLtEVfEoSFDpSRaiQh2vgKCqFkaXaXudx1
         MtVA==
X-Gm-Message-State: AJIora/JB5L9CUyIlTyto4E5qe58GpbW9ZouE1L2jAsonm3ziFiATqBO
        UdX989zDOh+XW5Ya/qDApi78M6sE9UOyEg==
X-Google-Smtp-Source: AGRyM1vmKNncyUkBZly+WHfUZ/Q1Iu6BQ6EjXvev15T+C+NtlRrUN8C8HzkVvXcp+hLcgv5ZM0eGcw==
X-Received: by 2002:a5d:5984:0:b0:21d:7f3a:a153 with SMTP id n4-20020a5d5984000000b0021d7f3aa153mr27726456wri.568.1658263654510;
        Tue, 19 Jul 2022 13:47:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/24] submodule--helper: fix "errmsg_str" memory leak
Date:   Tue, 19 Jul 2022 22:47:01 +0200
Message-Id: <patch-v2-10.24-c81a4f69179-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13), we sometimes append
to the "errmsg", and need to free the "struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5127c1d50e..e51640d020c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1052,6 +1052,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.1.1062.g385eac7fccf


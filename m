Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86FAC32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHUOCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHUOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CA23169
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so2368085wms.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LVC5cofUeXtZES+NgnlhH/Nmpqjj6zYFGpUPJI3R0JE=;
        b=B9foQtRZPoOClKlbinBdKo5GHw2OpHvvLbYA063mpSydJLvrQniEMqQA36i7o9XWNH
         nryynYHrwP7QM9PZo4qpezmty+LnBj6vB9Ds9EWOwvZCnIEDKYDFtrZ8qiyFnpCHnMTT
         VApXOywbvRy/xETJoKkybUZFtlR6CFZB46KC5EDvichKKtzL+rWyDJkxMdRa3wP434Yo
         rFZQpkaKPXxV14rE4KXIgJGcY/tqz1E5mn9HJg42gXkDHaKqENy9mQviDwf2163vC3Je
         C/CnCCcj0pOx5caol15hv4bbEDDTW1wjTHc71LvRx83+YIsUC6jxPswmWmxeg3OPQnOG
         dvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LVC5cofUeXtZES+NgnlhH/Nmpqjj6zYFGpUPJI3R0JE=;
        b=2W9p+M06NgFhPCyQ9B1LouM3J2o9TPyKkFoD0/KeFIndHZQxU77VxANuaRn1EdqUjq
         VlqB0vgUjyCQhPP5DoioPyulE1r8z3UldBraul6YEVV2F9YxQw8pV+0psN6JMePc1+nW
         xvIo3vr3NKBGKL1guaAjBpJxYwx3jlCXJhv9GybucuKu9SSGBbNGfkdm2GUquW5jZQf0
         ui1K39NqI3bAnLTb1XdToIH5jY1kcV4QfWZX1XqriWimqT6lt8zyPc/dcnAM4QUhsnJj
         EEJUDRFwE8zgwL357sSt9q/QXpzxIzIipyCo/YlZDckmqCx0m/529LNbOx1yGzrLqE1O
         5zDA==
X-Gm-Message-State: ACgBeo1dmCTR4eP5O9ZPq6ZWkCOKetNrTdCrDbmxxTrso8tEJ3/BHhCM
        PYwiP6/N53/0ReEwFfz9ajCV0FIvLf3n5GQu
X-Google-Smtp-Source: AA6agR76GTRHxQqSz8CnkhrbxwdREgujI4WlXDwXLeCln/SxOV8cwDWPNHqtUlC+8S+zwKBlO+eCYw==
X-Received: by 2002:a05:600c:3844:b0:3a6:123:5ac5 with SMTP id s4-20020a05600c384400b003a601235ac5mr12696003wmr.102.1661090469361;
        Sun, 21 Aug 2022 07:01:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/17] submodule--helper: fix "errmsg_str" memory leak
Date:   Sun, 21 Aug 2022 15:59:31 +0200
Message-Id: <patch-v6-07.17-cd394814370-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index fa320eb2edf..42ec6127024 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -973,6 +973,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.2.1279.g64dec4e13cf


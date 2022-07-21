Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E17C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiGUTOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiGUTOE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344968D5FB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so3606659wrp.6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zE1HgMGbiQDnfhMoAXXCiKpHt1WDVAQ/nr4jIU8Mpgg=;
        b=IB3nF3rXEQtfQ55A+eyb1MuyJ0XrkEtzrtc/Ri7exyauntlv/9DsYv1SzPzc5+Abse
         LpkuRoSj5NFS3mlm1lz6lqq1/9wrLqU+ZRdQ+3agmDbIy0NrmDSglZWVkg923Evxrp2d
         IbuMbxjuEVT6xviCsSaaWco60Uc8QG5M+WOxRKrD8YxZnQgLF1m41HfIqYVIAmtiRLjN
         MEfCANNSHpsUF+YEaEc9KOXl8Kp4KjSHJZjRG5eS+vexmFzWtpGy36Gw/B4DkWL7kPFf
         HIabeevXGRfd3708SvWaXAUp7zE3leSF8FBsJ5El2fZi5pxgV21XfCxapNoK+AljqjYB
         IXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zE1HgMGbiQDnfhMoAXXCiKpHt1WDVAQ/nr4jIU8Mpgg=;
        b=EyLFjWHiLNmRYrpmXbbGu61hdrHZxb9QJJHhAlSdZxcUCBn/Uixwhkb5r1JV57MIjy
         X8XhbxiW4NvGCdbiSwTiWdztXTWvyPfp+oUOE0CPlBS+7AVkV8fhnCUDXvjID0AOoNwY
         +rhkZ3lHPBIBR8FgpevztV6p7nMqJKyjJ9LijiFT1UPxuTO2Y+YmPo30sNVsjGC3cy98
         Flyq4zA+W70Gu3tg5lxeRoXehHN+nhFQw+kcPbQPSWZsO98O6Ck23or7nsVNdb0Pp5mi
         fQpgz3o9RmTW26+YV9bPLeYo65VD/E0MolJOJa/Y5d/56A+lLHcV8ThqycxlScm+Lou1
         eqhQ==
X-Gm-Message-State: AJIora8oyDxd4CSuKQ8tMkf4NQzPMsLFvP4PQ075b7N6lLxF8RTA58/x
        0BvFR4VOgrcfC6pO8SXf7Qfn4eUvxlFWVQ==
X-Google-Smtp-Source: AGRyM1ujlN6OOlYwfmDdn6uADiYmadoA0t/df11zVQojblLbwjE1S3i0dmzVS0MY2q/r/r3b8QLYxw==
X-Received: by 2002:a5d:6d0a:0:b0:21d:6f28:5ead with SMTP id e10-20020a5d6d0a000000b0021d6f285eadmr34951196wrq.95.1658430836456;
        Thu, 21 Jul 2022 12:13:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/26] submodule--helper: fix "errmsg_str" memory leak
Date:   Thu, 21 Jul 2022 21:13:08 +0200
Message-Id: <patch-v3-12.26-d368db73de7-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index f794d2b588b..ad11ff20022 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1044,6 +1044,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.1.1095.g0bd6f54ba8a


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD618C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiKHSSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiKHSR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:17:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24FBB2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so40763945ejb.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71z28zPnHfrTH+/3EUK2rlOLk10a07xdHV1yDEEzveI=;
        b=VQslNfAe54ITWuctNj2xIxtYSqVvL3MC9LSn5uzQG5my0WY7yqBaeu66AR5F+mhuQb
         +AGozBuUh+Lqd3iRk9YUeDv3ZqEPKt2W2d1Ni9Xjzf2pUXZClkeKUUEs4NgT6hzf8W2m
         AnbbEkcFIygaZEzaQByaBmU7Rc5BXSe10fPIT4dMicl/4BsfeIzbGl7U9pl4Bqd/ss1f
         qYG14O/B4x6X8irbyzsjIFMRHLaVivfLrUJvU3yjtAfPqOk47jH7QDU/czt915qcoysu
         tQkrPoLWfY8X8MAp2a23yheHQLlwI6kirlH/8iV0PDQQlSvztsbxhdbYvu7yH17RXk32
         LTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71z28zPnHfrTH+/3EUK2rlOLk10a07xdHV1yDEEzveI=;
        b=kRh4xp/HqKrhDi4pMh+f25VAwhvhmmcJ4t+im8O7heVyRxfiGspc8zDa5jnhiB4FXW
         gacx4v4tKGsxAKGfcXSEdaA6oevihaSGI4/XMLizOODtHA60szBdkrAkO7o7WZBcdRyt
         sLKoURrv3DKar0wDr6HKdaSnxmC4uOOyWhj4dpGFBeQGUETmfPBLLitOYLxwTHGWdXyu
         zPTyjYrXmQ4SN76i3dU0c+Dog7Va2ZmW/49liB+7Oixtgh2bfJnX7h0XNT6vfPCsyh/U
         7vxdUMFWoTEdU20cfENGyvq+MUr8CVMNWvnMv5kCmZZGrn/ssY48p05Ah2uGmD8gy3lp
         Xxbg==
X-Gm-Message-State: ACrzQf1xbyOEJELLsiojcoxMkSOvEw+r7BJuLkPq8PmrS/lMbIuPwdSS
        tGYX9NyTxuJUYgkThsN75LmbShd7JnaSzA==
X-Google-Smtp-Source: AMsMyM7HJI/dKJdDo2DEiOQo3bjfSVk36IJAztEGLDLJkgp0aeyfZ6jiv0r9w4Oi5XPkQNx8M8rVRQ==
X-Received: by 2002:a17:907:2bd5:b0:76f:591c:466b with SMTP id gv21-20020a1709072bd500b0076f591c466bmr52336691ejc.504.1667931474804;
        Tue, 08 Nov 2022 10:17:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/15] {reset,merge}: call discard_index() before returning
Date:   Tue,  8 Nov 2022 19:17:38 +0100
Message-Id: <patch-v2-02.15-e9962ad790e-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two built-ins both deal with the index, but weren't discarding
it. In subsequent commits we'll add more free()-ing to discard_index()
that we've missed, but let's first call the existing function.

We can doubtless add discard_index() (or its alias discard_cache()) to
a lot more places, but let's just add it here for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 1 +
 builtin/reset.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729d..a6698adbfd3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1794,5 +1794,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	discard_index(&the_index);
 	return ret;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index fdce6f8c856..69f18a248ee 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -481,5 +481,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr)
 		remove_branch_state(the_repository, 0);
 
+	discard_index(&the_index);
+
 	return update_ref_status;
 }
-- 
2.38.0.1467.g709fbdff1a9


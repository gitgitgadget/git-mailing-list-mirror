Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE14C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjALMzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjALMzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594A4C718
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso11994198wmq.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzu51gbI4kPQrM5vuhDrMD3XjxfNa8lhb2PtM0FzNUI=;
        b=fj7m8G4fMZrn/OC4GOjMmJ54xjpfhxRlYAwooGjjHyBxslWh3dkFK4KZNha/kWpYXM
         x0kVDsmyjpsvk+gXa35l6p/4GUSvoLPy37cpLfXn7vBCwsNpQd+sfMnRrtB7NNoCahBF
         CuyAvCTqsAhRcNzDeIsr9sV/GE+5ET6lqvtU462L++zVmEYIGVq27+lZfVKGpzDeym8Z
         8i3ZujB8QtKWb4CMT+Z7QcvByGk8kjHqNnj8wIfmYVfK0duht4snI3PveAeuyKGA5Wn1
         H67xNkSw2HOwTHXRIjw4k5SbSC+Tk0jiRdFGJENkuKNNisAQVhIEZv5TMCiRpdJbwPgo
         uCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzu51gbI4kPQrM5vuhDrMD3XjxfNa8lhb2PtM0FzNUI=;
        b=v/tPqQDMO9sQRgyCumolO2nFsFSTxrN4FDt/DYRo1v0QnoCbXgTYJWpcS3QxYIrv0w
         r4iMB2fUi6nBDzNVCjpmlRxgrEOo08jhR5D3cHG+rqQcJtbB6iF8D17sMKmPEXeaFnJf
         zFrgXKj+TZ7Pm1EiXqpZBRQmihwSrOThHPvqMgrSz14sZqjsMCuCTSo8SEW1ZsxaN9wZ
         MBjsQWSU/uSxkBrMvr6GEflYV2Myk20E+E9odihTQOfauPvB4xmKQhOipjEeldigIhVp
         ce/9KeF0pESw0HPYPa6MjotKIPhFA06nbLJrJtfDXhZd1zwClZ8ZyOhA2PGju9kQJdqz
         h0Xw==
X-Gm-Message-State: AFqh2krALKdMQLW9wUTPmf3isyPa2JNFnGghb18aqSE3fx/3BQSq1Ncc
        zOxdrxXGrAaMvyNZk8ur38USukajuEHkrQ==
X-Google-Smtp-Source: AMrXdXvOWcAlpm82989FyiKap/78qatcby2eTBn6+h6LYoK22JrLrTcsQBtEQViiMc9h05BJl3aLFQ==
X-Received: by 2002:a05:600c:6016:b0:3d3:3c93:af5e with SMTP id az22-20020a05600c601600b003d33c93af5emr55791591wmb.35.1673528132947;
        Thu, 12 Jan 2023 04:55:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] sparse-index.c: expand_to_path() can assume non-NULL "istate"
Date:   Thu, 12 Jan 2023 13:55:24 +0100
Message-Id: <patch-v2-2.6-6db74fe958f-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function added in [1] was subsequently used in [2]. All of the
calls to it are in name-hash.c, and come after calls to
lazy_init_name_hash(istate). The first thing that function does is:

	if (istate->name_hash_initialized)
		return;

So we can already assume that we have a non-NULL "istate" here, or
we'd be segfaulting. Let's not confuse matters by making it appear
that's not the case.

1. 71f82d032f3 (sparse-index: expand_to_path(), 2021-04-12)
2. 4589bca829a (name-hash: use expand_to_path(), 2021-04-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8c269dab803..65a08d33c73 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -547,7 +547,7 @@ void expand_to_path(struct index_state *istate,
 	if (in_expand_to_path)
 		return;
 
-	if (!istate || !istate->sparse_index)
+	if (!istate->sparse_index)
 		return;
 
 	if (!istate->repo)
-- 
2.39.0.1205.g2ca064edc27


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B3BC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBBJyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjBBJxs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336A2278A
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k16so928529wms.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P0Tf781grCDb8NI2R0AXLKHHdPl9xW3rDX14iewyyU=;
        b=G8ODDhKiLTBASKg7g3WPC+KVTgyNf5wwlnNFpVYdQJQ+0aGNlTp09L1SYl8xtC6u+b
         J9sI1PZ4lkdPMIuR5zMjlip37kdvRS0Y+qptXmYXAfny1JfE03lMZl68RDbW5OvUXzFx
         YP2uE5CFYaQuGPRG4XxBWK+Oyx1Ww0sU7W5bZ4eCWhyMTCXxLQR8j4yy5eahgAP5wnE9
         pvLGcu0mOHpKl+JkAEX80o44gK4X+Lw2dj/a5vDrfAxalFdmvWmqwxzb0RhPukCbgI9c
         CdCxe0cxEmoSSNNq228fZeeQlTFWRgXFXhONeuJ3K+Xo4INLwWFwC6sRtRXd+fa0viIA
         5X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P0Tf781grCDb8NI2R0AXLKHHdPl9xW3rDX14iewyyU=;
        b=hqNuVeNTTNLznLqobp7+WSPQdgJMaNrrUQvH5Vj3ml8s5l1sE+2UK+n5wlomQ0nh1G
         BlnvqpzKesu/Z8qCVKT4xmxCk2Kwu0juqyxGguqG6PkxHnZ9li9I1YGZkQtd+iwOfs3b
         tf6eLAEA9fO3qRfPbTNl1fDl8fI53iEOc7IyjgDMWYsoMAg2ZPYa058maLlKGXzVSPDs
         OkVmORDvw9KfRUr1HzRJ+kGVPv76GUqXQQaXc+9jqRivt6grqyomxsID+Of25CGS3j8r
         3dJNuR35dJAIDdYP4ILOS0RXiyv7myRyWglTgCISQnHooK94ciogR/CzkrO36oJkBxf8
         oZRA==
X-Gm-Message-State: AO0yUKW3NgCQET1KrRNMnX/BZGNK82GuM+i7tJ9wtHBjS/r4HtUr+Ldj
        j3lrF8Ona1hWNlU2neFXIoDqL7keVcuYSMUp
X-Google-Smtp-Source: AK7set/iZbh6InJSYeyKjq0JyjWQPkHt/yTV/LtJnP45yV2ts4AYPihFQsLFVUpehiMDkCRisU8GJg==
X-Received: by 2002:a05:600c:1e24:b0:3da:f665:5b66 with SMTP id ay36-20020a05600c1e2400b003daf6655b66mr5888621wmb.6.1675331590950;
        Thu, 02 Feb 2023 01:53:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/19] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Thu,  2 Feb 2023 10:52:45 +0100
Message-Id: <patch-v6-14.19-7dbc422d5b4-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 32733e551d4..5a834b1f291 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.1.1392.g63e6d408230


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38844C433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2066E610CF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhJVI6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhJVI6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A6AC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so1045971wrl.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/opoB5BVXgEvuPJdb6xV7Te3QJvo22WiNDNaNJ9eRFo=;
        b=QdDkfa1146qdj8S/Qyi6fAjqrnHDWe3cbW+HEEdq2u+M2PWRPxYv8CWMf2v0Ev0h3V
         d6fpkEyaDZZ0FlICdpT+0DeRaorCHD5oL1BRyD7FmAXceDm0VIAiju1Y8si/509qdPaH
         dnSOcKfSPoohAfG4vMrElj0oR/Fq5WbQpu7W081pd6f0+TTBDvVxYCsRbEqk84/ZLlxr
         uC8HpM2kxfW3AAcHFwZ0yQ1Ns0cB9PbXgY4F4eTrDVPOK+Q14GBQjsNZNxnGJ4uYREh8
         X6zYVKNtxXm1b2ZHE1EyHK9A1OvczF8m8SA/D3Usk5yU4VgAiaCzxiekdDu6CDnXinbN
         9MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/opoB5BVXgEvuPJdb6xV7Te3QJvo22WiNDNaNJ9eRFo=;
        b=oz9G3fcugJ98IYKADeu1CiILYUZlnTnq4Cio8BDH0VS3AoJ8GIEnzmwH5sHEsY3mCb
         7dnqOt8w0TBmumIJvVZOKHR0oHgjkKRXztAec90Z7YvQh+hpb0ke64FXI0c6u5tqq6SV
         LEs4jmmSP9atZC2r1pZeFKuCFB+UVmg87XGm74Y1AOM2XpvTF9i0yktwvV2OxdGMXX3E
         3rRm5zzoYVH87qQAklTlqM4lZWKg7fowl9hhhYm0NF/pSllm8T4t/5fQ8UqUcVylypZw
         ku/pnzPPrbYn/NsxT0A7SI5OX9cqRxiJes1I5HfiLuCUJFZIGhUE6NwQWnH393rnp8I7
         WdIA==
X-Gm-Message-State: AOAM5307TtVQ38Au4dxJ28EDE+KwFYIwdFsh+GkQOGaBoUfCMq9zvdD8
        WkIqjEdfPmUxn6oTFRVUsV3r9Rvx++gVxQ==
X-Google-Smtp-Source: ABdhPJwbmjLgdm9zu/a3KWyl2TEaBbBkGRsGBeB5OXFOTX9BPHqQUqu1d2ViZqBPX689Gdjta1HGqA==
X-Received: by 2002:adf:a2d4:: with SMTP id t20mr13604512wra.229.1634892953257;
        Fri, 22 Oct 2021 01:55:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] reflog: free() ref given to us by dwim_log()
Date:   Fri, 22 Oct 2021 10:55:44 +0200
Message-Id: <patch-v2-6.6-6ea5e611ae0-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When dwim_log() returns the "ref" is always ether NULL or an
xstrdup()'d string.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index bd4c669918d..175c83e7cc2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -653,6 +653,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
 					&cb);
+		free(ref);
 	}
 	return status;
 }
-- 
2.33.1.1494.g88b39a443e1


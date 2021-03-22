Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F6C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1C6198D
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCVMMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhCVMMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECEC061763
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so16457814wrd.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e58iYwhIObbuqd5RNDuxdgtiM/Lkey7kKK4pNDhm04k=;
        b=NKt4ravpgfoiWefWMVUyN6npf/abzw0zWA29nZX5X2ltCyLKpPHzfpbfOzg/iD2Bsc
         aWCNR3ul2nlQ9WJGMyEzpvn+CQUXxEHmvn5VLZOoV5XlSK9TIY/TkhG69cApHnEhfq8n
         5oWbjfC5NImONTlmi1hgP5CzRLhcxfNGXYBf8Q3Vgm8bKhsH1x1tLID8LafKvjsgLRXM
         dcw+N5U2NOpoo4WQmn18Nn+nVBqZKLvk5a9z/ha8lwfQJY/IoH+Cglpdjtvwek0lUzvf
         rt7cip55sg0m5sF25DrIBMgc2PRCXSZeZQo9la+NVQwvJZt77hIW2kvVGaqq40pmCLIi
         n4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e58iYwhIObbuqd5RNDuxdgtiM/Lkey7kKK4pNDhm04k=;
        b=HJ+QnV+mwHcUmVACO0R1iEWEZXdXA/F6SnEeN25N3UZOYRQVXnlU/YG7LHg0L/1CO6
         OJZksbvkJHpBqr2QL5jqn9PUEaaJHpP330JETSo0prwdxD0PL+64MhOvK55Kjo3Hilmj
         URs38PNsUaNlQn3qngPTLkVd+bK3Fr/hEZPI9wNIqztLJ62HjtGELSAxVi8acC/bBmK7
         /I8q8oMCJM5e5Vra+K+aS/X0eKTjhcHAf/GYEnve8cD2w/ipse2WUyPlazCoicjuVxgg
         95USfckabe9xCXKUJggZKpvZ1qoxebtGH/lxLIo6wVdcxU6SneVmBDDvkEV5DYZGHIaW
         eFdQ==
X-Gm-Message-State: AOAM533SnAntnxxh2DrbnmQq2bwvAikN05tRV4Dm7OZVpBbKgLlKM0vd
        etDQNP2nfhe7kUbS8GQKk8J3v0NokfxOhw==
X-Google-Smtp-Source: ABdhPJxrRMEasiYXjZ096YIrdik8p2Xtw5W598O8xqzPGDoTZhnyzQCWV8/uwm1To2/O5pVl7Oe3Ww==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr18196050wrl.344.1616415130088;
        Mon, 22 Mar 2021 05:12:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm15621142wmp.30.2021.03.22.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:12:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
Date:   Mon, 22 Mar 2021 13:11:50 +0100
Message-Id: <51b782bb9b6270a0b1f69df8fe9e2e4f5aead2a2.1616414951.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616414951.git.avarab@gmail.com>
References: <20210306192525.15197-1-avarab@gmail.com> <cover.1616414951.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "xargs -n X" limit for running spatch from 1 to 8, as
suggested by Jeff King[1]. Now that we're not using --all-includes
anymore this is going to take much less memory, so bumping the limit
should be OK.

1. https://lore.kernel.org/git/YEIGzXMDax83cwAx@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index eaac14275bb..543fe472482 100644
--- a/Makefile
+++ b/Makefile
@@ -1204,7 +1204,7 @@ SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_BATCH_SIZE = 1
+SPATCH_BATCH_SIZE = 8
 
 # For the 'coccicheck' target; SPATCH_XARGS can be used to manually
 # tweak the xargs invocation. By default we invoke "xargs -n 1", and
-- 
2.31.0.285.gb40d23e604f


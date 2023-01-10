Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE152C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjAJGRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjAJGRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240C1C912
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so13081521edd.10
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH8wHgZPT5jUEBRn+r5h7oxAazaP5ARLEm+xQHgqjBs=;
        b=OFlcLWksUheyjMI58HvbbIs77fP2eMBivyHEfDcmjPHdiRZVOB1pcyrXh6BHGCEUwl
         5vOr4ycFesGRaSKaf+qUN7k6FlG8f0xcX8GBKUDdZza4lkRDZrUWL/uH/h0AE4DNXGZd
         Fok7haSq0MzC0nN/bmafUD5c5LOWMWIYWqOkMizwfsq+FIaCUh5BA9BCwQfiQt2dHhzX
         Tm1JQjfr9qh0Pcjo++KqsjEvT4XhxbLS+YuWm602O8R8cPtgedYg9Kg9C9uGx0lwjMTT
         T/5nWLOhnKZvkS64R8Z8WPdPXpPelhdyf0Aj3fMiPP+BZNoneYHZocszhGaCd96o/G5J
         PinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH8wHgZPT5jUEBRn+r5h7oxAazaP5ARLEm+xQHgqjBs=;
        b=QTj7/7/WE7ud8OZY+nITaIsJf3rS70YCII6EKcG5rc9tY7CjQczlcx4qF+ag/f/nhG
         OGMGxFBGQwwrAqei+lR7W7e17+wvE2gMmwqSeyuIUnK0iq8k7zYjkvIrRmMSDLkwsh1C
         H9+HiaS6phFgRPZRfY9/Txv0A7CSwFi2YSQbvcWHEn9GvoL0qBp7LQcujoRYwKt5unqu
         auSqclDomA1t/Pji1dktXm3z/QqVSNAZ87Q4xKNFRcNrYcwFL6xxlkilPSjzsjhhI4QR
         I0jwuQEjdxGUWm7tKM0xmxpGyvqUXtefmGF3KwUFX6cC+y4K1MEhHOrEUlDY/qKtO+Ps
         XI1A==
X-Gm-Message-State: AFqh2kqXMHtD7vZz8BecTj+jIw0q6+nmmLf5PoLMWAYuXwzB1GpWRMec
        mLf8iiNfQhXmIFWemOH1s19DcITpkL0aAA==
X-Google-Smtp-Source: AMrXdXtg/+oADhlDyL54HJNL5UbbMLPqlKIjN2KzA75AqnnpR8WjVfZx/UdPAM3qzNftsYTY7KbBqw==
X-Received: by 2002:a05:6402:c0e:b0:483:2c00:a851 with SMTP id co14-20020a0564020c0e00b004832c00a851mr45879601edb.31.1673331458750;
        Mon, 09 Jan 2023 22:17:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] builtin/difftool.c: { 0 }-initialize rather than using memset()
Date:   Tue, 10 Jan 2023 07:17:29 +0100
Message-Id: <patch-1.5-214fe7d3fc2-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor an initialization of a variable added in
03831ef7b50 (difftool: implement the functionality in the builtin,
2017-01-19). This refactoring makes a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index d9b76226f6a..1f9d4324df5 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -361,7 +361,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	struct index_state wtindex;
+	struct index_state wtindex = { 0 };
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -387,8 +387,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	mkdir(ldir.buf, 0700);
 	mkdir(rdir.buf, 0700);
 
-	memset(&wtindex, 0, sizeof(wtindex));
-
 	memset(&lstate, 0, sizeof(lstate));
 	lstate.base_dir = lbase_dir = xstrdup(ldir.buf);
 	lstate.base_dir_len = ldir.len;
-- 
2.39.0.1195.gabc92c078c4


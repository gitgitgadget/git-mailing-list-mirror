Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D6C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBFXIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjBFXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC7658A
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so9425571ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qaB6QyMdYM0ttC5FZue2+oQbcFA4V6zAni1aJXFS6g=;
        b=eZ+sUta1D90ezdx01v2fJ8c/vcvHIXmoSr4ozbWExz12j7PbgWa1IPKkRFuquV94aj
         nUQDTr6tKgWenZFBHnl810bWD8G9yUXHNWAZB4IwsTrpFdZ3uzYrkpU+TNXbdYsNa8rc
         h0Bdqz/9rKGJKgqY3Cma5RYGCVtsuXPGn9y5L8yq/1CexATdT0VoBGDxjNCs/0idLFuT
         CO3I6KlTmTrxtnQLrlwJ63TALd1Ak+ATU9uMePNw0hei21esMZhdPyhbjnSfh3+CJxaF
         CZEPzB7BWhXmwyd05aIr/6QmSs70QCIdL2ZrTQb3OsBh8eupziYupbz6g1+my6MpkIDz
         ggiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qaB6QyMdYM0ttC5FZue2+oQbcFA4V6zAni1aJXFS6g=;
        b=VVHAQIeYUOhjRw4h8OzFAbka6I4kfB6bdXYxPw4SsluCi9xw8GSE+1W6DPLCifhkHN
         vly8jUETY/aXINx1LzSpoUG34PQXYACCgNROOxuJYtJToIdhOy3sHpuMZqPBJoRNa786
         DyB65DbMmmAKv6+2bJR5dkG9vo6jfWqSFUIhoBfWZXgQfld6Cc1poEwV8qwzFBwxBW3Y
         ZnF8HNCoVIy0JavFpnq3YUDGz5NNcqiquByTvHglvUMqHBbYgo67FPt5e4W/mPqouSYs
         rzGOtiEFDZ58ZcfntCNbueBm5pWfqxOFmfWitvlRUXVNDyJDtVniIhRf7zr6t5cFwTRx
         WsJQ==
X-Gm-Message-State: AO0yUKVmsInv05GG5+iD5nC3kU1nIPh1AGk9ddbjMvdTu1EidvuSd2DR
        n2wq6TbwS4TIfLNSOUMXPWmjyxhEFt5erAea
X-Google-Smtp-Source: AK7set846zYfQIkU4hw7h4K8NzLDE1Q0RYx0xYGr9IAPeXs3z7NvBNIxi90zvZLZI9tqjGpDbsXYbg==
X-Received: by 2002:a17:906:a0d1:b0:883:be32:cd33 with SMTP id bh17-20020a170906a0d100b00883be32cd33mr1132924ejb.35.1675724890686;
        Mon, 06 Feb 2023 15:08:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 02/19] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Tue,  7 Feb 2023 00:07:37 +0100
Message-Id: <patch-v7-02.19-496bc2c46ce-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05). If we can't verify
the bundle, we didn't call child_process_clear() to clear the "args".

But rather than adding an additional child_process_clear() call, let's
verify the bundle before we start preparing the process we're going to
spawn. If we fail to verify, we don't need to push anything to the
child_process "args".

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.1.1425.gac85d95d48c


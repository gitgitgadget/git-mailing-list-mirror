Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE52C4727E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8BF23A63
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS/9L0Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIUWBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUWBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:01:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E3C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so14584180wrs.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=NS/9L0LwP6WH9HszwfvKMCTcHAJz9nzQP5yK+UIBJlnf00/9u8803caRCzjwzSsAot
         UCvTIGam6m7pbqXMwAnZqok36sh802toYlsqyh3kUvjfAHnm2e5+HaswgtUrsukbduq4
         TfteYWCqWSdXL57lkODsMbD61YyFWHdSsSxunkvPO4vGDNF/bDbucKloJBYtxs1HvwCg
         49Ex/wSNnQqkgMQwsh0CH4Ov/uk2ZmCaZMOMKbtW1zCs6AL0BbzS3MQjlzfCqkj7bzQt
         EgNvBJ118BqwKaXQnOZlkAB/SKxpuiKIyLsaj+vMaISd2hBTvaKIR4RAz6G+bZ58xODo
         3sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=cx5N1rkjyFyMWi6iBnQaLLF/ZoZ8eOatT6B5ah95NsPYrTN7NygVnBM4VPIl+q5KSd
         qEQN3BjN8cfWpEJeQ0npYiDCdHJoL7n9RKID9mjgsijtWhxWM0Vo1Sh+gO4Vbg5qmKn+
         wIWr2xOEDU6xa3CpnKVyoJVCDVyz9R1/l7TewBCZsiM356Xs7QY/tJ8PLOqU1ZAxBj5v
         mgzaezpl6PUP9l4vpjSwo8N0ZKhBle1Hjum1s/+pACgMQp/2Z76rhrUBGmy9IEM3s7WZ
         Mtk6z/qBWVWnyNYxMfpR3MdZgZ6k3DSLkGWQy25DRztutcQcXWjkMJ1VPU+CIy2E254I
         qbaQ==
X-Gm-Message-State: AOAM533Mw5KmF1CD1e25NrbrgcfrSQAEbBAARC3URTsn+K3urh6EbRm+
        Nmr/idyVMfszIbQ/kFV5i8ugao7u+UQ=
X-Google-Smtp-Source: ABdhPJxzhUEcwoqENLGgJWOYCbv8hbnzx4t+Vfh4ctBmL8nF36fZ29F3rlOkl0SpwPsrdm7wvc+1nw==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr1860471wrv.200.1600725689540;
        Mon, 21 Sep 2020 15:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m185sm1383722wmf.5.2020.09.21.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:01:29 -0700 (PDT)
Message-Id: <587ddca42ae36be3d5b333cefe1f9af768bacc9a.1600725687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:01:22 +0000
Subject: [PATCH v2 1/5] fast-export: avoid using unnecessary language in a
 code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In an ongoing effort to avoid non-inclusive language, let's avoid using
the branch name "master" in a code comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1b8fca3ee0..5527135ba8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1026,7 +1026,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				/*
 				 * Getting here means we have a commit which
 				 * was excluded by a negative refspec (e.g.
-				 * fast-export ^master master).  If we are
+				 * fast-export ^HEAD HEAD).  If we are
 				 * referencing excluded commits, set the ref
 				 * to the exact commit.  Otherwise, the user
 				 * wants the branch exported but every commit
-- 
gitgitgadget


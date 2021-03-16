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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5CC43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025B265024
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhCPCOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCPCNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E6DC06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o14so5862305wrm.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7yPX75bnLAyUrlEM8eLSBYD323wzW2t0mf35Y4YydQ=;
        b=AkRbUsRk7z0INP6NYf18LSrgk3pJYHSn8+QB7Fgf3SP3L4iIG8JHOoZUKMH+y5kAnM
         zzJqXnuVG4rH8uuaAVIqPpw70azpuRkIWqrjGbTR8Y9PHC2VMEJz6RVmghtWW4+Egonz
         37NrbXw/hsv489ZJNFKgJWzg7CkiiEDsoxQRBK5eyNM1EddDCXEWwQ1a5aj2CK7oXP/w
         mnS1k1bWnepZC2+FHveekObvZnxni8VLIzAgfnEKQ3U7w/I/botoHF9YhFvBBCeUBnaC
         fm6pvqGSgEquRXw/3qI3pdJ3h273T9azaRNeeMamE5R7VTp/UpJTS6k7FFA9p2HRyD0I
         Uagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7yPX75bnLAyUrlEM8eLSBYD323wzW2t0mf35Y4YydQ=;
        b=E9vxl3o1L9Lzqf3dxvGHzFwfV0inITUk22gPRL0QfPKbV8qWa9CFQH6M/bj8q8MezV
         qZ0xUfllnBsC6yYizCa+DNs9D5cOqK7kv4QFIhvlriv4lA/SMNFSk1OUgngRtH4b4H5O
         yxU34qfk4jzckIBsKmRX81r4mk87MDDJ2tPp3QUZFIUxqySUo1Y/H0bK23Q8GR9eBmG7
         sO8PWq8N2RcD1ZbZw5ToWQLwyZjFFumRff/7VEV9RIA7jkoRRuKMttT8b0BfyXZ8Sic/
         1+ebyWIBdISmt9+/ouBZgKSc17UJHv5ObJDj65S2XDc7kz2DFsoknTOpgVhsM0hQwBV1
         JLEA==
X-Gm-Message-State: AOAM533C6DHyZCmDMbIHhLxeJYoP5wsuK8FPiMRLgcWw2zURzxz1M4/f
        3mQxQIsLGujeQBFaBdw3op11It6ECwl6Sw==
X-Google-Smtp-Source: ABdhPJx/8oI1K5lBJ1Xio12DivI5d1pBXXt2iNrlHEBh8pJ+7//EJ02YYJ5pkcS2vGAPRXghdDIF/g==
X-Received: by 2002:a5d:564b:: with SMTP id j11mr2320406wrw.326.1615860825113;
        Mon, 15 Mar 2021 19:13:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/29] merge-ort: correct reference to test in 62fdec17a11
Date:   Tue, 16 Mar 2021 03:12:59 +0100
Message-Id: <20210316021312.13927-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a comment added in 62fdec17a11 (merge-ort: flesh out
implementation of handle_content_merge(), 2021-01-01).

The test being referred to here was moved from t6036 in
919df319555 (Collect merge-related tests to t64xx, 2020-08-10).

It has also had the plural of "mode" in the name ever since being
introduced in 5d1daf30cce (t6036: add a failed conflict detection
case: regular files, different modes, 2018-06-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4375027914c..e54be179bd5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1079,7 +1079,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting modes for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
-- 
2.31.0.rc2.211.g1d0b8788b3


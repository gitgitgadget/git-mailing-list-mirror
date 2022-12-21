Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BDC10F1B
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLUEFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUEFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:05:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8E16487
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f18so13765097wrj.5
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rAY6XDHluwg5QSceibQehTmva2W68Qoo8Q0/MVCo5I=;
        b=fn3c8TM/GsPl+LcZpRTduXNQCnr3bg6BgLLSWVcrJLeiw0G04ZW/zSmqGWEJtC2ljK
         45SCR+jiX9JCeEbwyMdM90z9y1dIpNPqapB0hYzd55Ss6IZcEvojs7z+7k3+lMgMMxqi
         k5Ea+38S3CkTOnp5LEZG8tGcYiRRjHxsU7fczofu+kpfDcXmGX7rH8K/UCfPdcuPrQA2
         WhQhLDb2iTFUs75qafsDtHT6ktvQMx/x1xDsK4+gaQlywGyOjJ+UbFQojzCtr3xA+LHG
         bgVuA4inXhIGSkBY7Zg8iaZhGIEFuoTx5I50HlOsMXtftOd8Ir2w4eZ2phRlLhnXB709
         45Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rAY6XDHluwg5QSceibQehTmva2W68Qoo8Q0/MVCo5I=;
        b=vDIavR2QaBfL8f2IhhFAQP3ATfch29c1qBRToHshtm+SPCZqOwsUVCDmaniHQiVl5+
         eFPizsVwgLsz/nYP9vNQ8fEP4zSo7cBzGhzbZqj8CzQpL737L1ahmpKwd8QJzjoTUKhY
         FCeKX1WpD6eJ7wKcW87DtzxwIKKdyMBNEIG6JJA9pGft8zvKXUq1GlnyJthY897NMp9g
         XgiYwTdfVCCYuijrG6jp5P8ppDHDu38Qie3w/7nyDtee/8aRow6t3o0tWANIte80DkA2
         BukoVKDxjfQMaGkd7fBYcUFk7pzygVWAhPOpF606BoqMGv2rrnYtGBl8GOgymuGXHw8p
         OAUQ==
X-Gm-Message-State: AFqh2koOvwOJtg5xaHcMyXQSRRXEviUZbH6eZyuRq71lQS/1MhRUKMpk
        zii/QNA+J5VxDBaST0mzhQX11Zz2l/k=
X-Google-Smtp-Source: AMrXdXuTezHBsne3D0z3XvSkuDtNitpQx7x0UD6dZNX7blfjJv0NB5tCgRSBYclpnCyp0ZOAezU+Mg==
X-Received: by 2002:a5d:4008:0:b0:242:7214:55e4 with SMTP id n8-20020a5d4008000000b00242721455e4mr69696wrp.46.1671595506211;
        Tue, 20 Dec 2022 20:05:06 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1195:e411:35ab:b445:697e:1e87])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b00236c1f2cecesm16462298wrt.81.2022.12.20.20.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:05:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/3] pack-objects: allow --filter without --stdout
Date:   Wed, 21 Dec 2022 05:04:44 +0100
Message-Id: <20221221040446.2860985-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.39.0.59.g6bb98b4b00
In-Reply-To: <20221221040446.2860985-1-christian.couder@gmail.com>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught pack-objects to use --filter, but required the use of
--stdout since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Remove the --stdout requirement so that in a follow-up commit, repack
can pass --filter to pack-objects to omit certain objects from the
resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2193f80b89..aa0b13d015 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4371,12 +4371,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (filter_options.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
-			die(_("cannot use --filter with --stdin-packs"));
-	}
+	if (stdin_packs && filter_options.choice)
+		die(_("cannot use --filter with --stdin-packs"));
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
-- 
2.39.0.59.g395bcb85bc.dirty


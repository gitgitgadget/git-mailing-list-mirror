Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2DC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiL1SBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiL1SAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E51C7
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o5so15548828wrm.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me5yoomandW5HHAqMIsi2xDzzDfq8Zh88Qy9zDdhyGg=;
        b=lq8n8vUtKxWWa6Zvi6JPLPlIb1VHVOfyh8hrVvrwnjmNlepnWdSLYeg5oo0Q/ZJQ5Y
         Mq7FE0jIpzu3zcT8BpJsFq06/4KV3mjLgAbMO3PAGA+6v+ie8S3eWhTixfZQ4PdJoukw
         H4cDlzwDDgALa3bVciChc/B5h67u/ZaXs5xF2E3ZLAcqSZ+giIqdCaLksMe/zp9LTy3y
         pju6lYEMuuaxUN7uuhAwtAZDuzv1OwtOrEVL4ETwZ4b5r7Sk041mK5/yY23n2V/BERtc
         G+IgjE7IcdhoUPdxE0YtaeArJBdToXJa/pIUVLSiGCIzWzd9WoghLhUymGl/JudW1sx/
         vCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me5yoomandW5HHAqMIsi2xDzzDfq8Zh88Qy9zDdhyGg=;
        b=Yv3WK7GQm6ntVai/S/KNA1poWxJ2+eRebouzIBmt1R7k466tFFlh0kqHcgpy1FmDA0
         RONdl6HQ9E55J42pTBIK+0c3JqyDys6ph9ThPkHhddl+svjL5NVylKbwRn17ag6HyEx3
         D60FRtPGFkvRfvEy2Aoqw40XIOID2wzDGma/UvO+j2c3bZKNDntHixrSHhJHMlXDFAUz
         0kB03imD6rPynozwKcKBWiNq5N0sk6EUjbbnlunxMSPCNG84U2PAX6Ga7DdtQYS4sH7f
         FRXDPd0liuUrPeCzZ12GbrnUACR4sAU0HirmZGgKLhDUCZipmXjjSiA6B9Cw8fWz9DpR
         yVdg==
X-Gm-Message-State: AFqh2kpYyKe9tCBAwR7D4kztfP4oyJI93E8N8FGuYcARxnjfSRMRoAma
        o+jINQanVkh01C+MK9WUpxnlIMIi2olA4w==
X-Google-Smtp-Source: AMrXdXsOu4c5XpD2/tjKOj+hbmb4WMphIGiETcM+xS9rT0HLutdKWq0XBGoEajra/vqYeh0TCtYSdg==
X-Received: by 2002:a05:6000:16cb:b0:242:1b0d:9c58 with SMTP id h11-20020a05600016cb00b002421b0d9c58mr18876068wrf.69.1672250440686;
        Wed, 28 Dec 2022 10:00:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/20] builtin/merge.c: always free "struct strbuf msg"
Date:   Wed, 28 Dec 2022 19:00:15 +0100
Message-Id: <patch-15.20-8deeee4278d-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 465028e0e25 (merge: add missing strbuf_release(),
2021-10-07) and free "&msg" also when we'd "goto done" from the scope
it's allocated in.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f2..8f78f326dbe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1577,6 +1577,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		commit = remoteheads->item;
 		if (!commit) {
 			ret = 1;
+			strbuf_release(&msg);
 			goto done;
 		}
 
@@ -1589,6 +1590,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					  overwrite_ignore)) {
 			apply_autostash(git_path_merge_autostash(the_repository));
 			ret = 1;
+			strbuf_release(&msg);
 			goto done;
 		}
 
-- 
2.39.0.1153.gb0033028ca9


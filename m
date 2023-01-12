Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2840C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjALMzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjALMzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2484D48B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso10603287wms.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyHhpMNFBBtnIoEGNT1isi0WOjpUaWcd11btsDDC8l8=;
        b=hyiC6V1I8doBPd9tppODVg/ctGMz3082R61w4BSDxK4S+fyhnEvSPLMKB7ykYSbBAL
         +DqpBOGQp0EcMGHTK/nz+uf7HZaWbi78Pgpno1fiWCPGBufT8MUYWs6Hf4yJh5rMGvmi
         fi8kcQHG3QwEpXu7r6N5Gl3stt3UtV0yAIHEP+V7HiWnyVQc4uwcxqxH9E+RZeVvTnj4
         AT40KJXN2N2g/N31Hkfmu5u4Y1nCCKo3gwDxwQbDKTN1onRYaIrv9Dzy4mbIfrxY5OET
         tOi0mlJtMgwrGAA6WVdBAOAKhGHHUTMGB81q3DqKCL+hw1acc7eb45aiSpREGQnv01+l
         jrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyHhpMNFBBtnIoEGNT1isi0WOjpUaWcd11btsDDC8l8=;
        b=asb6bBkDUfurbh0RdhcpJNWSrNtkAXrT1VKG8XnwjEi8Co/8/ijpQYOMJT4kCPDJsE
         +1PG9caKKxL8e/wDCSmudLs1jWZNE5xjWXDLBt7D/CW3j38BsceqtBPMQXD1+Mr9ifqn
         XJ3TB/qFIEPK425mQYWw1UM5M/es2L3O+9xMzX56gayVFGtW/VQrdZlHVFGOb1jlyeYF
         uVdQGm3SwwwqgDVz3SrticPRBLyvkxrNR1cQuGeZ9d03jcv/KD75me0wT8yrjWkMvxNU
         FfxQjGcUoB60/Jrjz6n4bdSNFROiEKH88HINR+32SmEYlsimWUAVB/m4mXo5i7lKefPF
         amWA==
X-Gm-Message-State: AFqh2kqeQBQadGs9d98OZurUusBYqxW6LCv4Kf8nhit3k8GrrRsR2nHN
        yzVPbC+GGm1HNyBzCRf/cB1DHju1Dy/ipg==
X-Google-Smtp-Source: AMrXdXvYQK+wyG00fU04cWS57PERlwUkXzQU5wtmMTNLuObs3jufyKXNp2UNLrwb5RFFchFBGRZuqA==
X-Received: by 2002:a05:600c:1c2a:b0:3d2:3376:6f2e with SMTP id j42-20020a05600c1c2a00b003d233766f2emr56176933wms.9.1673528131924;
        Thu, 12 Jan 2023 04:55:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] builtin/difftool.c: { 0 }-initialize rather than using memset()
Date:   Thu, 12 Jan 2023 13:55:23 +0100
Message-Id: <patch-v2-1.6-214fe7d3fc2-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
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
2.39.0.1205.g2ca064edc27


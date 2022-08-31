Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5EECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiHaXPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiHaXOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A8DC8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so20114435wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DQx6imhlBUneY92pgX1y9t5DR4IRY0cgGsLxwK8nfqo=;
        b=B6hoFkFCjdImar2LDzc6RNq1f0eYizjxI9btNdFE4F5oI1ipkZRbgR0+1R68Es1417
         CTYSDycAskjEe0djc0PVxD/1tK3iXJBCR5PazN0UrC/pG7mqUpQNVkXUx0E61A3TDyg8
         VKcNq7QaG8I4EYuEGIvZB7ZH5ydox9I2l9lgI+h3JITrWT+mQ4eDSc6tb4OFYwaJtyxS
         E6o/iqLiGmpVVbd5hLr8f5a5tnlQorvR9g2PlAtI5xG4REZxiyy63wISePyvqY0jbfeE
         KpY1boppDDeRomz1SDUk0Wt0/fMABbCHO2+bpEhRhClhtDCgzTeqM7WQiI4Fb4VuvmAp
         KUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DQx6imhlBUneY92pgX1y9t5DR4IRY0cgGsLxwK8nfqo=;
        b=NctsSlDB94S9GRBLEWcaEufqmP8ASPGhm2YUDr1B8AgJYaSeDe1FKVnzx1oXeuZWG2
         2EdGzN8B3osOWMGeopLHdlQ8aF4HDfD36mVL+lr3YD8gqd7RjqWeBHH3N8cA3VB1WQs/
         jZ8FdHKV7GKHFJNwfCTTr9iZ6xTikNhYJG8Xw7h9qfejZ9IujIhd4oJC4MB+ej5/6NRe
         QZTbxDnTaboyruVahv+ZCh10pPJm+h147gdMt95izwJ9URfmuA+i0aCM9h08mHb+HMje
         0g1nj9xy07bdixoLaNn13cBCJunvP4eNOvL2FwMbjXXHgBmKGmlpBTGSczp0KjkhYezi
         kzWQ==
X-Gm-Message-State: ACgBeo2/To4KERqy4Z/LwuEfS+ofXBaFMWPPd9Co3jdRlLyw587eXyaP
        WYjzQ3SM+qlABCyZQHmuGzAtS4qiZ27UkA==
X-Google-Smtp-Source: AA6agR74m2hU5jOD2mBc/itOLJv2WkhALqmePDBx4vpOZ/EVgKBOfbHqgV/KGC0ijAhuFqEVfbJZ4g==
X-Received: by 2002:a05:6000:243:b0:226:d241:11e6 with SMTP id m3-20020a056000024300b00226d24111e6mr12005506wrz.187.1661987686788;
        Wed, 31 Aug 2022 16:14:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 04/17] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Thu,  1 Sep 2022 01:14:11 +0200
Message-Id: <patch-v7-04.17-505d7d5077e-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The module_update() function calls module_list_compute() twice, which
in turn will reset the "struct pathspec" passed to it. Let's instead
track two of them, and clear them both.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f8603a6bb5..e8bc6f17330 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2564,6 +2564,7 @@ static int update_submodules(struct update_data *update_data)
 static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec = { 0 };
+	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2652,7 +2653,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0) {
+					&pathspec2, &list) < 0) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2675,6 +2676,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 cleanup:
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
+	clear_pathspec(&pathspec2);
 	return ret;
 }
 
-- 
2.37.3.1420.g76f8a3d556c


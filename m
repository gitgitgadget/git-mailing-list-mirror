Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F255C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiHBPy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiHBPyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96A21E00
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a11so7423779wmq.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+/ZNVqBsfgknuRDQojhTWjipLSi6/6Jg9my/1d/snd4=;
        b=kFMjYmoUwcZzA7s3CJx3sWUkG1q8Q1CCHp2etjTu8BSIW1G1qCTtUwnRuMy5d9EScL
         l7kVoJBvqpKBcQYOlGCELU4jzOa/jui3imdeazXGTXMlHX6folge2vSOI5GVnnodlCBU
         ONSaQ7a8AVob7nnouYu7vO+bLECH2zREB3MUTCKLleT7mEYNqsjLqwCZyDm/gql+o2z/
         zRdroBPqlib3yaer1TbGxL68r+XQ1cQN86G9aXsAiyxDo6/WRb98yvIa6spOJkosznjt
         JS+eWUN61E9RO/V8gAW/J/XNlN5Tv980LGbp6hJQMAE3IbWhk13pxaF2BGCUsv37kO60
         jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+/ZNVqBsfgknuRDQojhTWjipLSi6/6Jg9my/1d/snd4=;
        b=kLZrpA0O33KdNvNPP+cf0IcS9tLENMe7jKNWNez9AG3a2YHuJiznwoGN8T7zwBkFe6
         jYamd+YX787Z+I8dMHB4cXlg7y8x22HUH9Yj6phtxpzs/CREGWEk5TVQdStpLTs6Rcp2
         /Nb+VjrVDX9oQZTMPjH3408gdgGNoG07BgobXC6gk0udNxj6FPSLXJ6eHJFaIhpkBH6h
         3/Eu68yCdl1mN0nafh7pUBortAepOY+YYoeX+zh7D96PrQIk9xXYbrykIB5+Rt2ouWLj
         2nk+wMWqWLGUmF7i4h12zUoIDjnWqtdwgwKelcubonYhx8YKPGdSTUFoudxkB3z/LaT2
         dSaQ==
X-Gm-Message-State: ACgBeo0HBV5MIxVoAKiEOD1HTAxnnx2zcP0OEdM9D49Zyz87D51hpKGH
        UwROIuvmqAI7YIarWxiueK9/udLB6CSsUw==
X-Google-Smtp-Source: AA6agR5vMQ5G9IeNVEa9rdsSUXNDQeIOgT81nehuaFOZphG06iTCx/0qtKxsEBJNWtQDIBWyaGR2Iw==
X-Received: by 2002:a05:600c:4113:b0:3a3:4b67:d086 with SMTP id j19-20020a05600c411300b003a34b67d086mr101298wmi.20.1659455687055;
        Tue, 02 Aug 2022 08:54:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/17] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Tue,  2 Aug 2022 17:54:26 +0200
Message-Id: <patch-v5-02.17-d885e1dd59a-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in 1012a5cbc3f (submodule--helper
run-update-procedure: learn --remote, 2022-03-04), we need to free()
the xstrdup()'d string. This gets e.g. t/t7419-submodule-set-branch.sh
closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d7eaedee491..d958da7dddc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2437,6 +2437,8 @@ static int update_submodule(struct update_data *update_data)
 		const char *branch = remote_submodule_branch(update_data->sm_path);
 		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.1.1233.ge8b09efaedc


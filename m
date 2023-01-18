Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C23C46467
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjARMrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjARMqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC28F6DD
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b4so29827259edf.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUT9TATv+YLRC2uUCx2k7tfPpdBzKTTjVU9oWfociQA=;
        b=LaKkzfEvHAgy6RdHMSTSNrOKBtpWk8K1VmZ6KXIrTI7aRxtbB3RKPQvDejoE7Bcjzq
         t9v2zPojHEFnc9+uBYDeNovfWVInJ0vdplW5MgmIsiGLBnZKugpnNShjB2C3lEnhskTY
         UW0eDgdHPPo25qyR47vinrjxlDR8E7wmKqT4F88NG2sGztUdL5mSocCAgXN8Qd8Bp7pz
         2PyFM27vI6sqMEJHO7KOTIqnsfxfGtWg5aNdAQC9sQZIZgP3ToZDBzzn252GNdyrzo37
         R4giaQRceTPJTJuVC4YU72gLJSuXjffkpAC/CAC97CXixS9OoEyUojU+B2XKKqgMr5SS
         0Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUT9TATv+YLRC2uUCx2k7tfPpdBzKTTjVU9oWfociQA=;
        b=OkE8CfDpf3mn45Ami6fKZQOSrPoMKPERyYYM+bfhAScZK2nNw7PdMxz1Jz8OWcQSpO
         iUAAX6FKljOd0Kmnh1hx57is0xoJuBCFMxHi98BkA7dI+7Z8dejEgTHHZTox5DgRHOX7
         XFOODeuX09ij0SDCWuHPH99IKu0sQ723xetbre3imhvp1y2Cxi+xMWLp4zmMpZzRdOFV
         Tq+3U98L1bdeYLZtDtPRGNbIUCzAVcGGB0CfW2Km+Wu8MYguiv5P0Ee4LAkR3H0aMpj9
         wfOvssEG046KymaJ/ptBGS+ljGD9cbmlfj/fU5u9DIs5F3zaZb/ZeEcOqjCktGH4FAGb
         yVsQ==
X-Gm-Message-State: AFqh2kqtm26dNGjAZOzD15H32EZPUjTA+c67waetGlnBo84BRQlYVMGx
        Jskr0oXXV8HD8g8WgQ/z6/Mv+kmOzWE4Ng==
X-Google-Smtp-Source: AMrXdXs91912SGg0gEMChpuXTxIbD1mK+I76KAq2xMP3yPX/eRyW1aOwbPzxCcOkjRU3UmzD+0Exjg==
X-Received: by 2002:aa7:cf92:0:b0:48b:58be:472c with SMTP id z18-20020aa7cf92000000b0048b58be472cmr6429051edx.18.1674043725089;
        Wed, 18 Jan 2023 04:08:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/19] show-branch: free() allocated "head" before return
Date:   Wed, 18 Jan 2023 13:08:25 +0100
Message-Id: <patch-v5-12.19-3ff86cb808c-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop leaking the "head" variable, which we've been leaking since it
was originally added in [1], and in its current form since [2]

1. ed378ec7e85 (Make ref resolution saner, 2006-09-11)
2. d9e557a320b (show-branch: store resolved head in heap buffer,
   2017-02-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..358ac3e519a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -956,5 +956,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+	free(head);
 	return 0;
 }
-- 
2.39.0.1225.g30a3d88132d


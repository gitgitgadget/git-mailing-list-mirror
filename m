Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB6C3DA7A
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiL1SBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiL1SAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B418391
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w1so3415056wrt.8
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEoAVPFWQj6eTEnHFPwT8ljXdYVMaWUYtcAMHRyg+Aw=;
        b=Tqh6eAvz0nA/Jwat8t1vV3DjX8LZLGJpyptlBTG/CYz4n7otb4EPEHUkmHSsmlUCX1
         7FQ/nDv9sxfTElvveQdiaC6Q06U8ZYVH++Zn5G1t5MytHqb6VwOJ0Pq7DmvyorUDaCXV
         XOAx/uKgVCZ4JgZT/Bqotnzik7xM0qijxLk/SmD7oiI9b69QrvrkttbsPHyFcLp97f/P
         oMHh8/VTr0aj1XcGTK68j/q73Mlb/vyVJRyIHXsWvaED43qktm42RYtE5VtY+hlT1GRo
         xw9dxB4tFLLLC2sgzgqOrt/fP5iKhvhLcv6QeWoZNhtVKGkQyZ3uyvhu1Rc37KQGuSui
         Eaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEoAVPFWQj6eTEnHFPwT8ljXdYVMaWUYtcAMHRyg+Aw=;
        b=Q0stN8vBlcjxJ8rC7rzfHbtfM3TMaJ2Y4NxVe9E5ENIXYD0NK9SysYU4JD/rXue2Vu
         Z0yfQxl8CkShj+iglgWbVOW7dTf+CNoRd9Mq7uB1nN365lcOYHumnompBaG0GmlmkdpX
         esQXUX4Etl/Ovl5YmPGMq3hSBHStHuN00lpYQ2cMGyn0+b4o1cdIQWxghFxxHD5bWZ7X
         +I1jzDeAkyFBy1CQgTKgfSTq9vPSVJ+81TaERV6ONYgNJB8xuuRuJyhi1VAzZvk1xGlE
         iNBNhEXiJhC3ZEol9lXFw+TzdCky5kRxMm3i+dqzf4sR8+1hGbx7a9RtzPqLWhcqtI35
         OF/Q==
X-Gm-Message-State: AFqh2kqPyzkVTXZ+xLX6s/cBYIM83rfpM4mfByT2T+jH2onwdjlARfjz
        Y3J3HJJvLw63ktzblc+qW542lNTYkxXJew==
X-Google-Smtp-Source: AMrXdXtXFOMBazJTE26wDoat7N1vojh2p30JQ8k1zOy11NVsHe9TL6Yz4XynKRpqODbloCdVD3K2lg==
X-Received: by 2002:a5d:4ed1:0:b0:285:4b69:ba06 with SMTP id s17-20020a5d4ed1000000b002854b69ba06mr3526402wrv.6.1672250439772;
        Wed, 28 Dec 2022 10:00:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/20] show-branch: free() allocated "head" before return
Date:   Wed, 28 Dec 2022 19:00:14 +0100
Message-Id: <patch-14.20-9df41b090b4-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
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
2.39.0.1153.gb0033028ca9


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCAC433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiCUXLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiCUXIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993F39CEA0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a1so21280106wrh.10
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnFuVnVjTWHB7jECLJVH1BpGSkn/m49hn/B0SfIihgk=;
        b=Zk3gsnqbQnwn+f5jFNwzOT93LJUoIcx41Df66CiUxAQ7A1Ho6BL4Xewc+gvYPZcVTn
         pU7atPn+r+N8lI4wS6MSmaK0QPiXT6zVLPg1GbvESDaDou2kQFXyCAWChFMrRsLebyOw
         hoIDWuOZcSQ2yIosh8HXY5Ydq5B4xQmQFZMHgK3xuBfzBb6YaQRQjgmSr0KXfPcntjwA
         cjSxkZSHBPduYa+qZ55JwtVx2GCPXBYfzAf9eKRG4JuILgcIbbWVOuBpwOdQphq2N8eS
         JCetDUpQ0JVsoUdeRQE+admGtucxGe4Td7LlMT1p1khc9125eB9wuuKo2BKaWLA7lqaR
         uEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnFuVnVjTWHB7jECLJVH1BpGSkn/m49hn/B0SfIihgk=;
        b=qyhfBLa4vCBC2olmi+h2wJRV47+iyZ2CT+lkFiZt9j0jNov8uvIms6Bgbq/RrXt73q
         +LogLOFrVaTOEvgVsAKKugGwkSIqxlRi27B6189DFW8Uovl4zyVfyqlPYfZC1zvioM9m
         +NSW5hcU4s5MI88wVZJCKyDioWTl8bCYeQ0ahb58SMHv4dc/hWMfOvkdZjjWPVvUZHPB
         uTnH42N9lY2eR2LJj1m1TJ3ahle5LfhLgkALtLuHjedKND0M5FjX6DZvG5h0NH3qOip4
         2050YoWvSZfaCYrfpTfC/RaSmjkCw6tTwrZDWNk/ufsM+3YZYTxv/EnF/F+Z6QzG1gkx
         5onA==
X-Gm-Message-State: AOAM531yS4LaUQMWhAPu+SZSXc28U6LMcn6c9pyN/ibp0FLy8qwtALyh
        Tc4HzrJpG73ReFVce0PH41+XDVwgHnI=
X-Google-Smtp-Source: ABdhPJw5miK/mooTgBZ0u6CzMSBgCzLETUlP8XDJfMoHjd5HEVjp0dalepls/lXDdO9MaD4mzPZdHg==
X-Received: by 2002:a5d:4892:0:b0:1ed:beaa:778a with SMTP id g18-20020a5d4892000000b001edbeaa778amr20000639wrq.35.1647903355307;
        Mon, 21 Mar 2022 15:55:55 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:54 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 16/41] rm.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:58 +0000
Message-Id: <20220321225523.724509-17-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 84a935a16e..4c4546bad8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -369,7 +369,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (get_oid("HEAD", &oid))
 			oidclr(&oid);
 		if (check_local_mod(&oid, index_only))
-			exit(1);
+			exit(EXIT_FAILURE);
 	}
 
 	/*
-- 
2.35.1


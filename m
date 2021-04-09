Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A064C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C156115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhDISrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhDISrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1433C0613D8
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so5264573wmk.4
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nRIiEHOMQacIKhSM4hM6YYL/Sj3DGgQ9TGsb2WDUID4=;
        b=Rb/RFh8GZBm7UFp9t3IN/gAmIUxmgWVvqTP5/n3i0WEIhsxwFR2ZDT8vxET9VPuSOD
         hDmkk7QUa5jlJGaeovHkeidarmVzTAmLkVeL8kwfj4tMHhJ4lzV45obinW1+eHqnZh3V
         +pZZUt5zq9Qn6e26+QPTfVyyqTFUDyUZmNVqTMqWfrl2uKy6b9Z1GB8cGJKvFJ+pb9vj
         w0CUxI0gfg2C2S7L0aW5bj+hCCPSwZsPTH+NVaRRpFAUFJQQLWyJnNmMWEvoydlaRgQY
         iGWx2QMJapFF60n7839Yyu70/BhggTuLJtl0JUTobdvzKnuKCAFSheBvaTVkQ0ohiSS1
         3/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nRIiEHOMQacIKhSM4hM6YYL/Sj3DGgQ9TGsb2WDUID4=;
        b=KFUCAh12lyxXQAIv9n2FH8AQVjdmSIH6gRs2Cm3hmXaHf7zdVx9pFysj6Doad2wQ85
         W76NE7Uz5fdo5m+i9Qcw7HCt8+LRVM+oLJ8BPoywOoMI3MBJrfq8SMm+n6a0Z2kEhZSK
         zzurzoyvXuF4Ir6aSAKPSfBKN99AWH5TjbY7wkr8GTem9g9/2DYZ8ZNcKQ/IA2E3PuUM
         YTfVUYaD99p5AZcDNFBehbl1uzCSMajXehYBXyHHLIAqxiILhVq/aD1yKqDKba2Su03G
         8F082EVvNRipAEW2qleSwT2vXQMqF83qkhc9DzZRNJo+G/RZiMEd5d5feujbAScQ/PEL
         braQ==
X-Gm-Message-State: AOAM533tWUnElLNm/3rrUnspVpYPMc0CFWYJ7XTut14VSq6Wd4Z4aNn5
        nXbW+LjqWsbMx32JAnCMr3tztIricdE=
X-Google-Smtp-Source: ABdhPJzUWJVI8DR4wORAqxQQDfAyHK7IM8tINt2ClNpZ7aqEboXut3EtsZeSHY/KxU4m9f5hQ4+MGQ==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr3893730wmg.22.1617994056457;
        Fri, 09 Apr 2021 11:47:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm6213557wrq.65.2021.04.09.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:36 -0700 (PDT)
Message-Id: <8c7ba2b83d5d4dc6e8193955ef55282db38320e2.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:24 +0000
Subject: [PATCH 05/12] branch: FREE_AND_NULL instead of NULL'ing real_ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

real_ref was previously populated by dwim_ref(), which allocates new
memory. We need to make sure to free real_ref when discarding it.
(real_ref is already being freed at the end of create_branch() - but
if we discard it early then it will leak.)

This fixes the following leak found while running t0002-t0099:

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x486954 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xdd6484 in xstrdup wrapper.c:29:14
    #2 0xc0f658 in expand_ref refs.c:671:12
    #3 0xc0ecf1 in repo_dwim_ref refs.c:644:22
    #4 0x8b1184 in dwim_ref ./refs.h:162:9
    #5 0x8b0b02 in create_branch branch.c:284:10
    #6 0x550cbb in update_refs_for_switch builtin/checkout.c:1046:4
    #7 0x54e275 in switch_branches builtin/checkout.c:1274:2
    #8 0x548828 in checkout_branch builtin/checkout.c:1668:9
    #9 0x541306 in checkout_main builtin/checkout.c:2025:9
    #10 0x5395fa in cmd_checkout builtin/checkout.c:2077:8
    #11 0x4d02a8 in run_builtin git.c:467:11
    #12 0x4cbfe9 in handle_builtin git.c:719:3
    #13 0x4cf04f in run_argv git.c:808:4
    #14 0x4cb85a in cmd_main git.c:939:19
    #15 0x820cf6 in main common-main.c:52:11
    #16 0x7f30bd9dd349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 9c9dae1eae32..514a3311d8d1 100644
--- a/branch.c
+++ b/branch.c
@@ -294,7 +294,7 @@ void create_branch(struct repository *r,
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
 			else
-				real_ref = NULL;
+				FREE_AND_NULL(real_ref);
 		}
 		break;
 	default:
-- 
gitgitgadget


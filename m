Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B26C43460
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A78E61364
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhDYORI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhDYORF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4886C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n84so1358692wma.0
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wIX81AgrL0S6PqMg9w1doAN+VWSJB1WdVOmEUxYaW8g=;
        b=nL6cY6PtPB07NIOxujV+l4h6Zn+d8ZdlSm3+QxHnSxMNjOJTOfvd3qHTpCzq0Qu8xL
         AM/2E3NmutW2tdNyvkFNkvCxoayBTy9X/eQDN8qsKSQ7nME2+N3OXZVTF6g1/62fyd+N
         glq7BhTP8Ficfz2AhFpYnyIdW0tahTKUbn5BLeE8gqN0qqQ89s44cspOxAQ6XSPIeNUT
         KrBGLYF/mmFc1Ze4NZaLsu2UlFhlXxi1HwpsS8kS/1XzR5J1mwrfSc54s3MaiI4TFAO8
         u07IIfULdEe4pNTc1KELZ9Vx2tc9pLgtHobpjSlqmw/2iXW4oxktxFgZ/qdxLsSeqPPw
         duTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wIX81AgrL0S6PqMg9w1doAN+VWSJB1WdVOmEUxYaW8g=;
        b=Q7/pP7UEU+WgW7+TVavUsncGybo3vrCyeiiPZg50Hc9ICsBcF8VGe9QORkaD9JcIfN
         aXXP1HWfMEuL687AtHcprg7f7xy15QVd5/r2nCSFu6aQ6kR34o1AofxYQdx9nOSkxfE/
         yccONWwTPHrGTqTMG46FtsKIrP1hmKrYTYDLOwWmVLr0G2BaTI3Utkw9yY/jVR96H7om
         cHEC+fNyRQ8PAoZhJ6V/jfnLC13ztFFXg3dpRGvN3KuqLS6QXU/XsUdUQ9sQx5KIpqXE
         5W5JMvq6d4gCRsqEup7ceduSw6oh6YclzmrP2Tz5A/cqqlKrGlyKXQDevaB32uZR0TBq
         mZrQ==
X-Gm-Message-State: AOAM531XinS2bnmdPE/84BJtVwuaaB+SU0FXPMwoTITx7+GJ+l0+XwxQ
        XnfVq1byaiG+us3FoVN2haEl2q0aLt8=
X-Google-Smtp-Source: ABdhPJwZWEPrd2KSlFFF+IuXqQkIxIWp41sJ5r1OzVGLlCV+Us6v5mXzDzfjirjyBUrJ4Ii4UJs3Sw==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr14511512wmc.90.1619360184681;
        Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g197sm1052263wme.43.2021.04.25.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Message-Id: <154c6714f30596db84711b5cd639c62ace5b721b.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:12 +0000
Subject: [PATCH v2 05/12] branch: FREE_AND_NULL instead of NULL'ing real_ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
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
index b71a2de29dbe..2260325d58c0 100644
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


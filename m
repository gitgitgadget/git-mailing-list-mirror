Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCAECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiHaXP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiHaXPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29138BC95
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n17so20125542wrm.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9rTRwJ+AE9rbWIGNQ76h4RR+VhmupN0i+3XMiMJWDBM=;
        b=fwScGzepvxMDM6of0qgv4TzMedXuZ1mlqTV3QZr4RkgKvcoaKZZvJa+QKdzjgpB7fE
         lXUy69vI906pFr4Rtz7dq2XL1VAMTfY63EOhD9qDoBn1bjXvI3G+d2Kjal48Fw06kl5O
         PkR6YOn28HmniIuU8dqpvOaiVeG+645+s3lqH9QKczn1X2aPxErGIVlQyqu5y6Bywkhl
         OPROR3jVN9g9I6VcgvMIU97+HfXBbPJ/FJAqb1Aii/2zKq8XLnkXrCFT9KC5KpnrBfeN
         9NMv1murRZ9bX1Lcax1pOPUBeyRje6UdKPKOTiTiUG+PqRmy0zE7UMZpyQeqLBTFTo7r
         fuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9rTRwJ+AE9rbWIGNQ76h4RR+VhmupN0i+3XMiMJWDBM=;
        b=LdkpKbOIj3BxDvda6kzzje5B41denfT/tecAxeG3u1fXswzVO1LjQiR6bqgRXE2k9w
         Ncov6ARSVhYZkohxUFwZ4OllIlbgzV2xY14k2VaDmYzYmRegEJK06OV/rktKm0yl5lHU
         CAyCriChA8poWoEMVp41rJaG5Z7JullHJ7Eurwvb09269NhzmlFGJrOejkG4dGyrJH8X
         qzsRZHMskB3uCGK3YKt2T4dII87rhZMgfzgfqIcXQ7raJXJ+3kQ5SiZuy+K6elk+q6Wf
         RzS0WaZO0SvW+bHwn8N8Q9pOhv+dMgeXoR7AfTZvjtFeEI2rjcfF9M8MAzLcoVoYX0Y5
         7LZA==
X-Gm-Message-State: ACgBeo2ZHHLxLG8EcegfZJeHQQ7DK7OtL9T/vg1ksrPpLfhh4C4zF5u3
        C+SJOH44pHiCq7luorpYm8Giz7GtHixI7g==
X-Google-Smtp-Source: AA6agR6poOCCu9WrLLZQGWILMISsye5uUeZLkqcYWYx6HO3PhbcB7PkvSwOYTMUZWRC1M5UBHH2GSA==
X-Received: by 2002:a5d:6488:0:b0:225:f99:338b with SMTP id o8-20020a5d6488000000b002250f99338bmr13327815wri.638.1661987698180;
        Wed, 31 Aug 2022 16:14:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 14/17] submodule--helper: fix a memory leak in print_status()
Date:   Thu,  1 Sep 2022 01:14:21 +0200
Message-Id: <patch-v7-14.17-33babb1a165-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in print_status(), the compute_rev_name() function
implemented in this file will return a strbuf_detach()'d value, or
NULL.

This leak has existed since this code was added in
a9f8a37584a (submodule: port submodule subcommand 'status' from shell
to C, 2017-10-06), but in 0b5e2ea7cf3 (submodule--helper: don't print
null in 'submodule status', 2018-04-18) we added a "const"
intermediate variable for the return value, that "const" should be
removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7c62916da3c..23c9e28deaa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -583,10 +583,11 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
 
 	if (state == ' ' || state == '+') {
-		const char *name = compute_rev_name(path, oid_to_hex(oid));
+		char *name = compute_rev_name(path, oid_to_hex(oid));
 
 		if (name)
 			printf(" (%s)", name);
+		free(name);
 	}
 
 	printf("\n");
-- 
2.37.3.1420.g76f8a3d556c


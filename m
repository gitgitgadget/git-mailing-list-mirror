Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D954C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiG1QbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiG1Qap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918DA39BBE
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a18-20020a05600c349200b003a30de68697so3589126wmq.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FSpUAMJ0iKq0Vfc5uXG+vNrC5YsYtmjkk+76h9qdYAE=;
        b=kiVG3ezpRgKov4eKgAruQ3U3vkLmEEMP4ktXLvLfd//PUcz2xBtvVUDYJ8YA5xPpS1
         Q5sfpaetidb2yt63C2qaUXGdd1CX8vjGsG/5LxLDGRZk029HNelytRA/rb/PkE68QjZl
         d9bYgw4wKajEXFlg1xZmhD6C6H3dbBSlll8ki9+yILxFQ+TIjUeuxRCHRYw7tqJAw6kG
         RFH5YVwqcpEva9Vk7NVbQJvgUmJ1k6j0Y6+/11Jl7UPaRsCzuCyVZsKcT1yYomJrh7vL
         8pOiRXV4cttW5cwC5RHrQJJLsFfFxPe/P+t214MeOu1PQAJ3o5OImo5QtlJIwa9HP2rC
         HJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FSpUAMJ0iKq0Vfc5uXG+vNrC5YsYtmjkk+76h9qdYAE=;
        b=nawG2WnEQSQ6Fozu1BujgkrstHbXZ+UGGpsx5vniBZdaWGxOlIgTc6JCXBgsnzYfze
         6JQgAeIwUhzTiPUNPh3neiCjKDYVrxj3UsrDvRE+mbq/6/YywVysqsOmVav2sgTTrgS4
         OhwmaKxP6nm5DMIgRnGtHtKy61BCdxe+MEW20Cd8De2vlIxD2W2mBgUxDM9Wzjf+rL2l
         UIm1J0v2Zq/HFKfksIw3IncsTqtNw53ajmJ4cYZkV6TKAomWNP0xcxXIS9NsUutXMB8o
         nfowGhOoMpNBUGi+3aYrNmE82cJCqVI5xdMt97RcGXfnKb1nuyXcHkLN1/ox5+JHrpsL
         BeMA==
X-Gm-Message-State: AJIora8yFOVOkpK+6Qqc/hcsV0nOOFU4Dwz20LoxWCPjf8qKxgMST/De
        ENKXIFY1MEEGdJBInTxpDVJP/OZjxTW0bg==
X-Google-Smtp-Source: AGRyM1vIwBmSDhRqV1zIU+l4betfZ0ZOVMbOO5cufrZiT9Zr2CA7I8Lx2o6KgUoESGf+T4K26VZIZA==
X-Received: by 2002:a05:600c:ca:b0:3a3:58f6:94e2 with SMTP id u10-20020a05600c00ca00b003a358f694e2mr125594wmm.131.1659025832497;
        Thu, 28 Jul 2022 09:30:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/17] submodule--helper: fix a memory leak in print_status()
Date:   Thu, 28 Jul 2022 18:30:08 +0200
Message-Id: <patch-v4-14.17-53ba1705eb6-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
index 6077aecd202..b51b60d5c77 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -570,10 +570,11 @@ static void print_status(unsigned int flags, char state, const char *path,
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
2.37.1.1197.g7ed548b7807


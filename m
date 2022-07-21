Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6299C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiGUTO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiGUTOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B188E4C8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so1332125wmj.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myLC+ZqfQqTXEIgftN8DvdkREXdtkzgV+aYv8VPorLA=;
        b=PRv0oueqLVcPERAgcgRKNSXHmuWkIFDW7nM+yMa1h+FOvvlGfJYIZtCQeuueAkcPff
         sA4w3vuOCUsM26YbDuqQb/9caakeggf/f8A8Ix7pHJqwp68glw6khO1BnirQgKIRt4a5
         mG2WnZ7awxILKcd2YLfaNcJZmqZYRH1VT6UdZze6Qt3iuFjl4Y0FMinf7iodDgaN4v+t
         HUarTdUqLWE0lx6NXztHbqRH4/Z9aZ0E0njffBv1iVkkYXgaX+0Zfh9CtcARk6CtMYms
         DW5oFc+fEqIza+4bzFQV02Ogi11wX4qUDp9NSc5bMbiVv1CyzcBtefMuKW203RRsAo6J
         8VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myLC+ZqfQqTXEIgftN8DvdkREXdtkzgV+aYv8VPorLA=;
        b=k/62WjHKBlFlbdOfM4sYVLvz/b31/ATHalDjE2XPe4WYAgpW3JZDkseXlTrIuux5o1
         KrFBgCTgDvxn7o+dEY/vwOZCYW4hwywNt0jV72dyc1XD+piWuzRCG2MVdhBCnNmWMFK8
         XWyhH4SpudDXx8JUAyRJp0G3ul28q9Z1aeA/NYFLl7xVt1TfCL0vcSuTTzKMghXkyE2/
         Gr7xav19DpLc0eaFA9/fiojduX/LbDiOyapIBgN/hrnVrgJ+EoHUYkC3OAxLkT5dTZKC
         H8ZWP9TNRV6CC+2lNz0DCz3i683S4UUBObo/FnjIcNIPfPeaAVM/4r0k3rIYQFNlx390
         93IA==
X-Gm-Message-State: AJIora9vAEuFt5N3/NU/FKXQKCRIre+Jl978YWMYcZH4uCERa/lRYgAI
        UVV/nJvzZbI19zUppbVxwTi49+XyHMYpsA==
X-Google-Smtp-Source: AGRyM1uruA23abTru56albnyMmkHzr0C5jjZAIKxdQ4K1Dq9ZQ8pYqS0ryynw1sStJgbxpYfjzN/8Q==
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id k3-20020a05600c1c8300b003a31f7025a5mr9541783wms.54.1658430853384;
        Thu, 21 Jul 2022 12:14:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/26] submodule--helper: fix a memory leak in print_status()
Date:   Thu, 21 Jul 2022 21:13:15 +0200
Message-Id: <patch-v3-19.26-7ef89abed86-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index 0fb720d3a16..4decbdcdc5c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -637,10 +637,11 @@ static void print_status(unsigned int flags, char state, const char *path,
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
2.37.1.1095.g0bd6f54ba8a


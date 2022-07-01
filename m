Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD3C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiGACMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiGACMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ECD5C9E4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nl1-20020a17090b384100b001ef0930ec9fso607172pjb.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hk44uy+nIhh4BP3afglzKX71919gUBL9sVJTuv4iSn0=;
        b=sTRFKYzpPPuDPv++q+z0T5970yz4kIv/Txq+s0EwBpDQZwnIEt9tI5QygHQjWEfdKd
         TgCslKLoBhlKv8jjmUdFAUfP0wRyUVMe7ICqs8y+BLPgWKLkcU4ynlGXOf96Atnk2iCe
         +gTfjjGA5RKmugXMa3WeC4I9lH+HwPHrsEcnUGxLTtOVLubr18HKZgtLj2o63UCpCYmV
         fLKDwMy2RHKEEmW1lgG32xrY/cayqeCFCtndhIAiiv17NPLHz1YY/a+UiGBJdAS0l8jw
         twMBVMQOOquKT8Vy8SeKkLGypMtoOxT6xttzdDppoxYRFzpYPpVu/WZ4ydSkAjuoxgSc
         MWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hk44uy+nIhh4BP3afglzKX71919gUBL9sVJTuv4iSn0=;
        b=0cOSm+C2R4uIuLM5hQC2jsCeyftKthGPHqQ7VIqREDOoNBfwBvU9OEzuuYkzJdHiuC
         GSjBhbzCkuQAWZnECKQayLgxDauS/glQFeSmgaOZX9baPUCsdK1KhroVp69wx8/duLDM
         7gPsrIFSUw0HTFp8q0p/gltVz5P78puXuPYlehPFum8FleBCBZBnDHflB0QfDeJXscNf
         bZ/kBSDeugnFd1OfF73lUTQc1yCqs+2TbuiGwodiF6Ok0M2tzWM4pG+0bJ+IIk2YV0oi
         feo5HM5l0690Bihi2ajxU322HrNMobH2F6xBfnYS/VJEny8TS0/NifrpCqS89wznSQ+k
         lt9Q==
X-Gm-Message-State: AJIora8ZBU5nvHfp9btk5ifzae1DX1TbfteYvLSWHFF5FvFkmcZJt7pg
        S8b3PyuKDckqyFA1gIqH0H4vJl+gHlyXdFTJ5rDV/Pxio/iFBqnd5QsH00RqRnIeYXR2qUhXtRQ
        h97JWSFKuCROscZ5Scd7dmli1E98ERe2yOmU55Ff0KFIA+IJMPWexAuzGjY8uDZg=
X-Google-Smtp-Source: AGRyM1vZJ7MYs37Et2lzgbJUuW39rco1Bzy3kz/YFF8goxB0GfQBQFrmGALLLeq4dVJT5NaXiC/vWsj3wz5ifA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:1c3:b0:16b:a8f8:882c with SMTP id
 e3-20020a17090301c300b0016ba8f8882cmr8100640plh.158.1656641534134; Thu, 30
 Jun 2022 19:12:14 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:53 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 3/7] submodule--helper: don't recreate recursive prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

update_submodule() uses duplicated code to compute
update_data->displaypath and next.recursive_prefix. The latter is just
the former with "/" appended to it, and since update_data->displaypath
not changed outside of this statement, we can just reuse the already
computed result.

We can go one step further and remove the reference to
next.recursive_prefix altogether. Since it is only used in
update_data_to_args() (to compute the "--recursive-prefix" flag for the
recursive update child process) we can just use the already computed
.displaypath value of there.

Delete the duplicated code, and remove the unnecessary reference to
next.recursive_prefix. As a bonus, this fixes a memory leak where
prefixed_path was never freed (this leak was first reported in [1]).

[1] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9381127d56..4a0eb05ba2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2416,9 +2416,10 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	if (update_data->recursive_prefix)
-		strvec_pushl(args, "--recursive-prefix",
-			     update_data->recursive_prefix, NULL);
+	if (update_data->displaypath) {
+		strvec_push(args, "--recursive-prefix");
+		strvec_pushf(args, "%s/", update_data->displaypath);
+	}
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2514,14 +2515,6 @@ static int update_submodule(struct update_data *update_data)
 		struct update_data next = *update_data;
 		int res;
 
-		if (update_data->recursive_prefix)
-			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
-						update_data->sm_path);
-		else
-			prefixed_path = xstrfmt("%s/", update_data->sm_path);
-
-		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
-								  update_data->prefix);
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
 		oidcpy(&next.suboid, null_oid());
-- 
2.37.0.rc0.161.g10f37bed90-goog


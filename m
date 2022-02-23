Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiBWHdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBWHc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:32:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5284F465
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:32:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q1so9310713plx.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDcGsR79skgK6tQiIMakyb4pTzR7cHIChyzy6UFAm/A=;
        b=ovN7jWGj5viIpaKuyOK/jNKJFWtztSeHrj5NC3MGqCZIRksI2BvlRB+CvikvARoMXU
         HwuogMHc2Mxf3cj3SJzlN0ew5BnwQSp5UYtwiY7XLcoMjgsVlQvVCid/3tAbgdbWRYG2
         8nonj3kpSGZYDsJIdnDERwPOZqvEUe5r2z3aYjk+Vz16gLHtTMg4t0RPJeVtOhB8uoT+
         IzjjedhPJ/FkAeoq2SDeTKIDsaIXeDHu4sOBfIzW8wdWX9PuFP6dBdeBd3POoR6ATQnf
         WAMYHaXxPtE49d48tURQgLEh15EthdruE+UJ2JbarRY4P1Kzik1bH+DApw19Sn7sV5js
         1XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDcGsR79skgK6tQiIMakyb4pTzR7cHIChyzy6UFAm/A=;
        b=AVUuO+n2826U/PxsByYDYeys56T3udzer9SqGEZ4DnmCxD2H2iIWZTOCmOIp5BrNq+
         CRyWR5e45XYHOvwIFTXunrHqJMCgmJmbl1tcH7LKKoXzw0IQ7q2C9rKLPjbQP+a0Cwfg
         JfARIAa4XNvdfKluucwUM8zK/4MSBjp+ElNgpQ0kTEVbnCwJpFwoAlhKYVF17ovRtmTv
         IhX4r/PF4TdcnkLLqpgMdfL3HzuVlQnEs4hb99MJAzcyfMlzEl+jsFj9rDxEH12Mtu/x
         Vf9tmW6/BrAU7lbUJxrG+0ao7cmDgm6g/UOChaU4argpMS6+mTO/8pshIyx+tXbKOPux
         zy7Q==
X-Gm-Message-State: AOAM5337qOxQ+6gHdCENFYxAqSXgfByYo9E5Bwhl+rTGbl/a+baD/NnB
        EnRpI0/Ra/1e3o69S23/g1xvaBrQ8YQCCw==
X-Google-Smtp-Source: ABdhPJz6yxWEVsYHTKXHG/LCHug+cnK75hy0hmGMqwu/RpyS/1FiLd+XQ96o7VEn1i6lqWLJU1rkng==
X-Received: by 2002:a17:902:dacd:b0:150:4f5:1158 with SMTP id q13-20020a170902dacd00b0015004f51158mr17230plx.67.1645601552198;
        Tue, 22 Feb 2022 23:32:32 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id h10sm20542607pfc.103.2022.02.22.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:32:31 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] switch: mention the --detach option when dying due to lack of a branch
Date:   Wed, 23 Feb 2022 00:31:25 -0700
Message-Id: <20220223073125.640133-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users who are accustomed to doing `git checkout <tag>` assume that
`git switch <tag>` will do the same thing. Inform them of the --detach
option so they aren't left wondering why `git switch` doesn't work but
`git checkout` does.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/checkout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9b31bbb6d..10a035feed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1398,6 +1398,10 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	struct object_id oid;
 	char *to_free;
 
+	if (advice_enabled(ADVICE_DETACHED_HEAD))
+		advise(_("The specified commit is not a local branch.\n"
+			 "If you want to enter detached head mode, try again with the --detach option."));
+
 	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
-- 
2.35.1


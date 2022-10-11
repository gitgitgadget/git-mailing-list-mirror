Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF20C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJKX0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 19:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJKX0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 19:26:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157C6F27F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z24-20020a17090abd9800b0020d43dcc8c3so218001pjr.9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=im4HlctZZKrR9Un2oLKgHczK0bYCIv5ClqJwS46AMOM=;
        b=caWc/XnvV2KgFs+aiywJd7vKS0ysHRDqA9A8366T0kZOOsq2Huuebkd0c2CttYFxtI
         +PwkoAWwzGWSeovYyk439oq6W1kXPDFu1twb4zyCKG0MoYbsc0kg0KlmmYZ3fDp8Mv0E
         0ub8szAb22T+wTH7e5nIPXWq7i2XnbQkybODMY8HwXMhdQ5X8IUg/prQ/aFFyc/32Nob
         j+BxcskQYr3oMaHAgUk6Ir3KJP3EKZPrWe6TbPA5xlLixLeaXBjkNbBtVXhZArAvcHBf
         7V3dBl8ViCihY/AsTD6nDGPsMkbdoJe1EpwohH5QSpIUq6HvzBbdA1tMNub7aev44yHg
         i2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im4HlctZZKrR9Un2oLKgHczK0bYCIv5ClqJwS46AMOM=;
        b=IVGGLLi8xIIEBrw5ABY49aDnlBZo1Si2DXu7USEn4VCXaT3aGRcOO8l6qKNdpQkHA1
         4A/Tc7UD62xXDQw6gwUA27klysyNDvcTLOUg1qwHQkZBg+Mal3Lp/0T2Xq13lkqi/Ryo
         orpFxyEAmdswu3/lHzZIRe4u9PLEGouzZ8XDYqShZheEyShcnTSRr/ATuTunKjnBgDaP
         wipX/SCu9zfkX/LZbBp99OI5RCvOrkREetj/HG2wYS869djwy1n1y6A/wVEP/6bDjSHn
         UEf+AxX7gpmBYxNPn9b1BtxSH1RuE630ZiWaPFAcL/Eu3qSxTavf1XwuzDkhrP97Y8J7
         0QUA==
X-Gm-Message-State: ACrzQf01o8jeIi9imIyBN1aDLJ94c9RnIftHTtlas721ZOYBVYDQ9Tlg
        tGpl3/1wRi5tu8/2bXfIuKnN1NKCbUtSNVG8YUQI4VeHQOLSb4BWSp+Wqsyr1KlaFF6vYt0NMRr
        kVSev413gxob7hstj8ge/XWURqFJmwTNoejukVkGelImMOq6wco+6slmgwJOC2s07LA==
X-Google-Smtp-Source: AMsMyM5W6ySAfFyKWOJjqBA5hCpnVVHcJUyIOP0CIa/TDT9tlimiISpzunsonNIQk5NHgszltYXZzP/CsmrPad4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4c02:b0:20a:7d26:149 with SMTP
 id na2-20020a17090b4c0200b0020a7d260149mr1822820pjb.134.1665530794534; Tue,
 11 Oct 2022 16:26:34 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:26:03 +0000
In-Reply-To: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011232604.839941-4-calvinwan@google.com>
Subject: [PATCH v2 3/4] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Flatten out the if statements in match_stat_with_submodule so the
logic is more readable and easier for future patches to add to.
orig_flags didn't need to be set if the cache entry wasn't a
GITLINK so defer setting it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a23..e249322141 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,18 +73,25 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     unsigned *dirty_submodule)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
+	struct diff_flags orig_flags;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		goto ret;
+
+	orig_flags = diffopt->flags;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
+	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
 			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
+		*dirty_submodule = is_submodule_modified(ce->name,
+					diffopt->flags.ignore_untracked_in_submodules);
+cleanup:
 		diffopt->flags = orig_flags;
-	}
+ret:
 	return changed;
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog


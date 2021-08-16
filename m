Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2896C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6496113A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhHPJLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhHPJLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:11:00 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F90C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o20so25757949oiw.12
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0X0QqbgBQoqTrKw0OU/KboIDFkecYk7oQsICFv+w0s=;
        b=sZBtrQowXNySn9pz8LgvC/wPCv8x64KkI9NSXimnKB3jNk9JX2mC64ZSAWnf+yAV7c
         Jj/VqGhvmJrPquzcYNBRGxewhGuhQCKn6+3dSck522iwQnmuzLqRu992vfl2ZyoLejVj
         Djjh4DkdQShJsGhv9WvoDzIwhYsHyStylgV9itA/YLvN4ycI0fo1tsnaQP40Gn4lA4u+
         PGG1NOf0SV1iVhktfaSgTLk+wKhX+MTUKVYw1JNZJZRnc+7iLD9j2FTOsQrH9lG8Bm7n
         jkKmUIfdVr+NscPNWgsx+MuDYbaLHQ3686ETMbi+DmyFLp8EBN3NCTXb3LoirszWzo/X
         rU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0X0QqbgBQoqTrKw0OU/KboIDFkecYk7oQsICFv+w0s=;
        b=fg1Ov8MWZVuU0pOdwNKVy/7F7qDPDQizaXl3Fw6sLG4HfPMtj5lSJ+fnAnXQNsWJT0
         EB1bx4fyFLoUjqB3y1wsSpdQFhUkN2Urz6oVYWDotMu5Jv4vmd8ULUJzKaAw+U+65QK0
         R0B7WWO8psbUG5zWYiDUE4ubRKjt0Z1JBVopFzg3isTRpEaejrFvCXx7IQIibmNcDiJt
         UjYXIbqsJaDwud+JqX+/ky2SQ8MhPGsL1Ving+XA7h5ybpkeHD/8GHGdDNxdetDL6nzB
         PcCIRult2ZWT2jRQeU3XB18OP2aWUXJrs6XVH06WdxYhofuyGylx8MV9uyD8xBCT+U8z
         Viqw==
X-Gm-Message-State: AOAM53228WeoUJ4OFWYo1y+1FTV748yucMdgPtO/eL3w9pim0+LMjhxq
        5acqS45qXspvWRFMRCg4D/UdUY5iboM=
X-Google-Smtp-Source: ABdhPJx/KFQD59HKgs4YTd93IFMxTi2n1UFHYcWkV3E2YZpUvHXBi0PUA51Tt7uNAqFqktAdbGG0/w==
X-Received: by 2002:a54:4182:: with SMTP id 2mr811832oiy.66.1629105028719;
        Mon, 16 Aug 2021 02:10:28 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id m206sm1973603oif.23.2021.08.16.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:10:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try4 1/4] completion: bash: fix prefix detection in branch.*
Date:   Mon, 16 Aug 2021 04:10:22 -0500
Message-Id: <20210816091025.548095-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210816091025.548095-1-felipe.contreras@gmail.com>
References: <20210816091025.548095-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc8..6bcf97ce79 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2650,8 +2650,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.32.0.48.g096519100f


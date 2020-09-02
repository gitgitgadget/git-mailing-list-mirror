Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE1FC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4951620773
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiV2IXhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBUQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:16:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E6C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 13:16:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z4so732411wrr.4
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2lo+LuM7Rl5YAHNhjvd0n/lh7ybSatYjuFayPoUIwDQ=;
        b=uiV2IXhbHEWs4BZ9oNUwTsLC8CtptgAP7xjN2Obktui1+chNqRKmkz3jbQUOVEkP5J
         Axgtc17xcvFfRN5o0tfp57QAkzKETliMAsla7MSD1cxSI9R/31nsNj+v6yCfkMgmlJkj
         cJza+jaQthlkRZooT0R962yVxhNd1v0i+/z6N5mxn2nhw0xOmL5N87IByG/BMz39YcKS
         ObfAvaFV2AELFNBad92vu9GyGkJeTIwMoxjzUjR4aTPqq4P9ZysKnrs+f2GdNmc/eYxZ
         RkeeAVdY+CbRpf2PxEwXOAlJbyUZpebxw0svMpPv9/6+/kBrLtZzBFQAAv26Ok7YBnh3
         KgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2lo+LuM7Rl5YAHNhjvd0n/lh7ybSatYjuFayPoUIwDQ=;
        b=d21nvMONDH9WK+srCbmDuIlNOvuDCWHhxhJsVgTzjHLlYc+1PxucdihQCKI6lIlQl5
         aCEKlRhK9qOrXmU6CbochpfGe3K3vs2KxVvbpP200IDZyWpL/CwRS8F/AWaqB1XsVov5
         iSTF7F2wmk7ASgnrXs6vTQdWGXMaje6C5uYatui1yc5Wj+1mbgkkoi8JxUwTouUCsMQt
         9IVlp1Eny3AAP9YMh9VmOuwpaVQmgUiBBa7RZ/dbrRAJjkqGZfZdsAEhHk1uEiMM882v
         vSZAFhYbIVLHDVQoofvBGWu7qd3pUk4g28X1Iq+6rMvlvw7CB4x8LAkAl3Zvf239AlIp
         7wSg==
X-Gm-Message-State: AOAM533HAKXZW8GOOj7g1EOy1WEDZEmfugrd/+TEfKfFIuNrosiYDRj3
        2Bx//BJUYBHxG+leiY2tINYg8OcDKI8=
X-Google-Smtp-Source: ABdhPJxoCxaI3gx7lg/W2U2MjWFRDW2VuV2rXQWp9N+0vtRxavVsQlxn7ENigUX4bwTMSJO9wqgeNw==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr8504513wro.43.1599077799960;
        Wed, 02 Sep 2020 13:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm1065793wmh.6.2020.09.02.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:16:39 -0700 (PDT)
Message-Id: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 20:16:38 +0000
Subject: [PATCH] vcbuild: fix library name for expat with make MSVC=1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    vcbuild: fix library name for expat with make MSVC=1
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-722%2Forgads%2Fvcbuild-expat-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-722/orgads/vcbuild-expat-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/722

 compat/vcbuild/scripts/clink.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 61ad084a7b..df167d1e1a 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -66,7 +66,7 @@
 		}
 		push(@args, $lib);
 	} elsif ("$arg" eq "-lexpat") {
-		push(@args, "expat.lib");
+		push(@args, "libexpat.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
 		push(@lflags, $arg);

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget

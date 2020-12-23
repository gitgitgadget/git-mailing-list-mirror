Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3372BC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22032333D
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLWOtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWOta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:49:30 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE1C0613D6
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:50 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q25so15177959otn.10
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nksOzkRO7V89Iku9LV9aw38tUKmP672WcontRTEUnR8=;
        b=o10qyCcP3fnrnbN4Xwa8gpN4mpYJu/Ueh8ZEATqIHJToZrIA3i/ycI9Iv0xajrZETs
         mQIkII/TZcLcLiqakQ++Pk7r3maBHfqe6qXvQys+680hHlTdxLG16+vn/REJ4I4kic6n
         wEthQf5v7YvmNXbkAZUTQPXO8gVbV0nCzDyDnPDKTXFC2LQplS6OJzZsYdeAW5QEkgtT
         ayLZHvfy0csinoqkdRJogz16KVm2XOAchQeuqhNBbpuUc+HEbl1quDetNS79FCtRqKpa
         U0BtKQxKSuA9LOBs7qa67rGXHfsHIzZW5DLo0GYC9vv5hXMuVFBDCe2rOr6jQ9QPUdUe
         HcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nksOzkRO7V89Iku9LV9aw38tUKmP672WcontRTEUnR8=;
        b=DVTCUjpo/fEOqrWuQ8PyyKD3irYshPZBnqzOFj664ZEYx2UVeR+62jj1vRXdItyAro
         ZfDfgPGtb+sZVy6ijWhmVenS810x5NzotBAxi/Ou2bLfzuOFcNlnpdXiYH4pcBlaR55P
         f3/tJcz3eBTZWt6HKD/hEpBfU01mFbPmeEsVGB2FgoP2/Moi+FUfC9DNc+QQjPHcwHnH
         T2yFC45SD4htPXbfkZKUEHWUmUsp81/VeqAQZTsICBEh5jTvfKgY3LVeYncTld3Qi+GW
         96wMDu4kAkiOXY0fIuzU+4aB1QI4Xu6d7VfV1q8a3Xq0Spiqu8iqAZXxj3mppWQaytT5
         Zy0Q==
X-Gm-Message-State: AOAM532CANk9+t/69YgC9D3WgD+CbowJAPawlgrXcLkmZyUmFQ3Rxugu
        juhu/fz+Cu4FqwhjmVnV2VDN3db91W3/Eg==
X-Google-Smtp-Source: ABdhPJylj9NhiCOrTEP2LO1TH8C7tA77bqHRPg2XwTnUypa/UrofRELNn4RFfcMSgUhszENWhRTpOA==
X-Received: by 2002:a9d:7301:: with SMTP id e1mr19130784otk.304.1608734929574;
        Wed, 23 Dec 2020 06:48:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h93sm5382873otb.29.2020.12.23.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:48:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] completion: bash: fix prefix detection in branch.*
Date:   Wed, 23 Dec 2020 08:48:42 -0600
Message-Id: <20201223144845.143039-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <20201223144845.143039-1-felipe.contreras@gmail.com>
References: <20201223144845.143039-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..10d225cc9c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2633,8 +2633,8 @@ __git_complete_config_variable_name ()
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
2.30.0.rc1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96101F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeAEUDP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:03:15 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34308 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeAEUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:03:12 -0500
Received: by mail-pg0-f47.google.com with SMTP id j4so2376855pgp.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W39amOWmWEleEuA2XJD26UOvCP7SSAwq1mjwh/tlfk=;
        b=syeEk1pERbYVe7LLLDjfp4LgoWwUZVBpzCB5Gs4RbTe1UmVCNlUcGfVSMvEr4oWCr/
         EBwd6B1+TXmJ9cv5CIziRBuUzD4iHbBQ5UrT145W0OvrfylQA238/kqmPTxCQDXsbnav
         34zte1QBSwggrZpjBZMdmyd8X7ZFCHgtXTXZU3YXw99sc9Iy0BTaA2KMsD7/fKNfEeRM
         /OUdVknNgPiAOrFdZMjI+pyYh82cH38FevsCbWwQA6vArqRP6KEkfNuKIEf84KtcNjM6
         0ILpl7oqYrihAV/fPTDRlweGjcaprdt8i4+Qo7Cuiqko0FZcRbOeR2sAR15/bFJQVwNe
         sIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W39amOWmWEleEuA2XJD26UOvCP7SSAwq1mjwh/tlfk=;
        b=TqYF6PBP26Yo3l3pxiuBDYaKkYnsKsvAlBSe7ZUYJIjeiNu928ndi5bYlme6AwIJl+
         hFnK9MO4hYv+pDAVBvgsFnwtc6LYaapMG9KIGMdqw1hKSdHXW6UUbuknvQP3SVvrBgD3
         ruDSs9emvkRH6PFmtUQWh600Or2CwBm2gFUeMolFUEYw74VOx+mf3iCijgh3V0BJJzU+
         gQT5ZtNRUgLkwdQNTtgqQm515tyGbu7XXhMYD7NWNDJZo5/ZsLB1Y6ZrSancpHC68ukF
         7ArYlOTk94nuDJJogPYnDLbsE3RBWW+ylKQGDxHUZUB6FeEoyA/DdKvDnf/ozs+6vynm
         z9ug==
X-Gm-Message-State: AKGB3mJSx+DXi6q+P9UbXPeUEBFVE5lwCvLH2eNQ6iJUoqp/CqeB/OGL
        PqGcIajNkCZoc305Cs2h6OP7UA==
X-Google-Smtp-Source: ACJfBovk+DYPlLPp7AWgV3SsAIKr7wv0mAOCrtIUQI9qgh6ltafoCtUi8cuZ57Tciq/kdkl60Y3iBw==
X-Received: by 10.98.161.21 with SMTP id b21mr3970840pff.113.1515182591356;
        Fri, 05 Jan 2018 12:03:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z123sm13027859pgz.22.2018.01.05.12.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:03:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/4] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
Date:   Fri,  5 Jan 2018 12:03:02 -0800
Message-Id: <20180105200304.34173-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180105200304.34173-1-sbeller@google.com>
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
 <20180105200304.34173-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that the test replacing a submodule with a file with
the submodule containing an ignored file is incorrectly titled,
because the test put the file in place, but never ignored that file.
When having an untracked file Instead of an ignored file in the
submodule, git should refuse to remove the submodule, but that is
a bug in the implementation of recursing into submodules, such that
the test just passed, removing the untracked file.

Fix the test first; in a later patch we'll fix gits behavior,
that will make sure untracked files are not deleted.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-submodule-update.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7699046f6..fb0173ea87 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
-- 
2.16.0.rc0.223.g4a4ac83678-goog


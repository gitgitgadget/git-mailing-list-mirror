Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A5C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B1820781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Gf4O1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgKJVWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbgKJVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:59 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E1C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:59 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j14so148363ots.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c80GcgqRsU46vOjDm/wQpmL7rkTgHbBp13e34/gMSPE=;
        b=M/Gf4O1AygGAP5eSVUol7uBvheHLeuRiBvTfiT8Xp88PNdygFptV3rX9LcYJOGHXS0
         SjijPra/M54BCMpfCKjVYxyE9dvogYM+aE6Pf3H4Ho3MkbMqLI7P00JkEatk8ZgiR2Hg
         HJcndFOEiLgqwjJWqNMw4pRbkJW8eVhVTtBrf3GTkDQot7dSD5IuAiW1sQTdKwPFuySy
         Q/c4rDDQmhP+Qy1a6UzwAQG9arrScdpJ9s7Af1tEFvdaACLSs/IKWkx9x52CuuMhx1a0
         WmFDxltkeSaLVGuo7M7I3AM5ibTWyhXdrr8BTxXMm3kmIiQOhUHL1C8sjMRQXEl3HzLm
         mJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c80GcgqRsU46vOjDm/wQpmL7rkTgHbBp13e34/gMSPE=;
        b=NFSnepANS7LLcEzfXlKhMiUxO7ckT0kslg8iqmRQeTWosK4M/e61gqaViD/Q7w6duD
         6Cge/0552bfP8XRNYccWB9ONYNQ7AGC/S/t1XlTuSr7oPq66umQZvP/owOvlKf3Og6IK
         OAXIcqDw5vFHMV4IVf7ZUnrWxzlE1Z9x3dRr70aAr4zutGHtyGWNgae+7ofONOunz9s9
         n6w0U6X5kMXlZW5iRhbaXA+OznO68bLRDJ9U1G/+81i/7e5dpT6a52KRLWG2zUo1LARk
         d/eYpZcII+m563308cJotVzi1sZFGNFVdA2j5FM/ywZG4W79BAb+dC6K8guocu7aPiMf
         wTxA==
X-Gm-Message-State: AOAM533qnsjo1DH644naxN5YuHgYvGK0HSnsO3iZHpt114zBw09nT3dB
        3y1m1I6jM29Cuuzkfpycp+aOVHl6M2sgIw==
X-Google-Smtp-Source: ABdhPJy3tVV2WfFOjqFIT1rkZK9xubRs8iODeBqtpo3rfa34r2hZ5MbfTs+wQp91nIeRRDLsWqA5lw==
X-Received: by 2002:a9d:39b4:: with SMTP id y49mr14756404otb.20.1605043318678;
        Tue, 10 Nov 2020 13:21:58 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h28sm36111ooc.42.2020.11.10.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:58 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/26] completion: bash: factor out check in __gitcomp
Date:   Tue, 10 Nov 2020 15:21:20 -0600
Message-Id: <20201110212136.870769-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can reorganize the rest of the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 15d7490cfd..bb1250f10c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,9 +321,11 @@ __gitcomp ()
 {
 	local cur_="${3-$cur}"
 
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
-- 
2.29.2


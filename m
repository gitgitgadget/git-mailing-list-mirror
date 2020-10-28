Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E58C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F832072E
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imq2qJz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbgJ1Wgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbgJ1WgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:36:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45788C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:36:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y186so1271805oia.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3WpVsMKwdvTGTVNOo2nmf7Caeji6tbc/0LH/FZybMw=;
        b=imq2qJz2X9OH/bkC/v2x8kBPtCLqWPwipwsBMdZHWmA8XuYrd/c5XBD/wxq8YdKyEZ
         vzqEHMnuHbCWt0eDgUWN7xmkN9Op2rFY/yUD83z1OGoDPtcdhTo7YRrOCB00zEpYVhBv
         ACe079yse8pPkL1S0GKNqIQAnh0BxsotQzjcJS1iIoX8QKNMLHzD92DpyWrvaC9tA7Uj
         w5doM7xMPSMFjkKBVruJfDGOqtpGbFh9qvUKbQl1+NTLy31T1daCL1KAWZyNF/RWQebS
         F8LH1BYnrxLtzfobHQNgYDZZawT9mx+2YcBhFmGY7FJQg3TdDmc1IWoVSEuRotiUOjJS
         1KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3WpVsMKwdvTGTVNOo2nmf7Caeji6tbc/0LH/FZybMw=;
        b=I+2Aum10WoG8ncjfSQJp4JDmJPRvLpF7IQZyORbZ3y5w5UwDSLqGXb90BfybciEuyN
         1RmLFtdOTcm6OVYVFxDV8C81EUowkh4RFmdH0jDhkXYxi44iyOJzBhQLxPk7jFN8yToQ
         RKHCBYmAn0wgoX0tHh+n52yQ9fKVDb78dVfYUnObsztVkHaa1y3y1gVbmDwksMjJThxG
         O22R+v31PKuU4Q/F4h1sVy93e/FiqLZmC5oepLUBtQFiDQtEAdZuVsTou1zbmC+TNACd
         nzOR2vcVg6LHMQeS2/op6pqe4/hxhKCFpi6zqKRxGEdvnvx23ym15QKxtuIfL0IWR+fD
         pmyg==
X-Gm-Message-State: AOAM531BE1OC8H06CTp42pilA9CO+Q7l0D+MWikKLMaiw2IzbRluAdj7
        N7+OKmICDkNEGqnYSB60UVST7sTGMSETUw==
X-Google-Smtp-Source: ABdhPJyqp8M4l7lqXE054RAIkcSprpgxqtIhrLzRJGCUUmLkOCZQXwSHEqFAkNuwILJKKB+UKeiwPA==
X-Received: by 2002:aca:d987:: with SMTP id q129mr3719678oig.5.1603850857471;
        Tue, 27 Oct 2020 19:07:37 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h6sm2293210oia.51.2020.10.27.19.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 14/29] completion: zsh: fix splitting of words
Date:   Tue, 27 Oct 2020 20:06:57 -0600
Message-Id: <20201028020712.442623-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Files don't need to be split by '=:', words do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c5b875993f..d9ce5e1742 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -124,6 +124,7 @@ __gitcomp_nl_append ()
 	emulate -L zsh
 
 	local IFS=$'\n'
+	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
@@ -132,7 +133,6 @@ __gitcomp_file_direct ()
 	emulate -L zsh
 
 	local IFS=$'\n'
-	compset -P '*[=:]'
 	compadd -f -- ${=1} && _ret=0
 }
 
@@ -141,7 +141,6 @@ __gitcomp_file ()
 	emulate -L zsh
 
 	local IFS=$'\n'
-	compset -P '*[=:]'
 	compadd -p "${2-}" -f -- ${=1} && _ret=0
 }
 
-- 
2.29.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0AC433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhLZWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhLZWh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7BFC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so29174802wrb.0
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQYEwOW9qF8DcIBDbgR4/M4U3/Uqh2rSEv3XZ9o+qQQ=;
        b=MTYvoTTHGkPxyUZIux42kYnaBmgZTof2kkxOfGXRu+Cy6MbUO7wLKhq9qirYarAn+1
         lOWVdJOc7Z9woPxJspMQrHdnAGDh4gGbkhm5vexixqxalwjR/VxIaeO09B7klaXSVCmr
         DE0dHtxLaMntnyIs4qO+Ski8jW3cqrgFlPuxYFsr2vqWvPk1cW8Rfx3yS9KN/mXolpIn
         MnDUCWUUdB8gPbWP/XnDMzghHKko8QVkM+oj6cIY1r5fi1Z5wRei7+QToAEuIF+yONPr
         qm+XoS+Xt6XrRW9CnCDtF74cPgDDZCyRNmL25qLdi6ovpTl8IekdnQZaE4vtnvFC0xUM
         QDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQYEwOW9qF8DcIBDbgR4/M4U3/Uqh2rSEv3XZ9o+qQQ=;
        b=haVTi+uEZV27iFrnyrnRjHuy1Wc6vQzuJOth36K2aHUGOcHUResnwJBod8cs34FbhP
         hdpGnuNrq4txM1kfhj/oxQe/tQ9ruD3udvrKSWyZ9Q4CXcYtxdtSfpNSwcROK5ewx56Q
         EJKAVaz3RvnfuQtnTdIMQ/IOFANqKE0TcvUXmuCavxKHWYw59iVXi0SWGX76olOHqqCN
         lPquX7oqQTH30kFGL8lcmXW7VDeVRhPN89O7GqsPjuTsuy9AUkrevnU/wtUU7IN1ww4R
         ZSemT6mN+t6TaJs94Nae51qpKNdkHuJNmXRRTWS0kfF3MIG0+EbruCFHj/p1YpDuqIyg
         9alA==
X-Gm-Message-State: AOAM530y5GuueSjLn2KyzyZkuOU4nNs1vhz51cX4RI+r0tAYWWxjhmEM
        Kwm9f1Q407F5p52C51LgShSGYkx/JgzDnntf
X-Google-Smtp-Source: ABdhPJy/eoJR7bydAWxJoT0wUXK7gBPxOWTbE7X+E3xmQnLYpjfPofxpxOl27LiOIY/1Cb0av3qAlg==
X-Received: by 2002:a5d:590e:: with SMTP id v14mr10795704wrd.208.1640558246333;
        Sun, 26 Dec 2021 14:37:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/7] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Sun, 26 Dec 2021 23:37:13 +0100
Message-Id: <patch-v6-1.7-b62e6b6162a-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com> <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.1.1239.g84ae229c870


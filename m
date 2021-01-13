Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B095C43332
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCFE235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbhANCFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbhAMW0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:26:06 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E5C0617BB
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:53 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id w79so4438839qkb.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6uTH/FXaX3m7SUUvF9L2p8MarPwkp5TsZ0UURmpTH/Q=;
        b=AYe6QSgsMCo0XwDAj7nBgB+K1kCJ48IzDiEjLkKfneJ5Dj4mv+yALrP2gEIDzD9Vrb
         rFgPL6LxbIa2pXT1AKIoXMATYexnG0rly72ecjR1Qvz7/vLplCVeVAe3jUuKvR5SKgBL
         5McQC4/KMsgq3GJ3PVQCGbY2/OiatPBEr95+0+iV57GkToBbM+Eon7j0DzkRfoU2OqbM
         GLdYPR3U0QhZNc7Dny97bean/tmmbNj2quZFS84uL+ulbJNFZdLI4RprGpONCS4dgtRg
         rIj8hunLTG8cUHas4tboKDcK1yXArnZVBEWyQzvXMyqb7Q3f0Td2j2YM8jv+kfaBy1vg
         widg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6uTH/FXaX3m7SUUvF9L2p8MarPwkp5TsZ0UURmpTH/Q=;
        b=NR9FJLkOtcP+GYiICA2KFOd1LL4YezD6Nt2sVmawQGimsRaNmx5zuzYv/ywmlAG2KA
         4MTmfY3YMRuFeTMYBqRvpP/zTIhg8NGl1TTDBs6a7ArPTqZbJyQvvTJOGsLKf/Gmr/03
         7+VYZQg7LNyfd7bpS3NqORFYnWwmkdNNUDj68jM1b1NF3whPa89yKsyGFqPeisO+3Fnl
         P96cSOAoT4bvGxbohSaUDzLC+452OFdy882hQaxiPL4B2KuuHq7wz7UAgjONEj71sWSg
         7nG8jymwWh24nLkrUbN6H4g7OVvGiyx8vW0ifj2gF7/+vH/jsgIBRJ/pq3xCHlgrcrF3
         uelQ==
X-Gm-Message-State: AOAM533QgN/ejjUjvHkN+X9NH2JGZpYE/KFGKczHIpPorRKwckdjc9Od
        IPLo4A63V7ina6Omq6cCnAp7Nn37SIsIBg==
X-Google-Smtp-Source: ABdhPJyJ1AEV6k10d6kUzH6pCaEybhM+M+onw2+gHhPHjmov6qZDeUknu9ScAOvlMxnVVkzoIhuPNA==
X-Received: by 2002:a37:43cc:: with SMTP id q195mr4359989qka.382.1610576692472;
        Wed, 13 Jan 2021 14:24:52 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id v5sm1967686qkv.64.2021.01.13.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:51 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 15/20] for_each_object_in_pack(): convert to new revindex
 API
Message-ID: <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid looking at the 'revindex' pointer directly and instead call
'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 936ab3def5..7bb1750934 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2086,7 +2086,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		struct object_id oid;
 
 		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
-			pos = p->revindex[i].nr;
+			pos = pack_pos_to_index(p, i);
 		else
 			pos = i;
 
-- 
2.30.0.138.g6d7191ea01


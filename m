Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B5C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7226109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhDZQTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhDZQTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C7C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:23 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so47506835otf.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkpqofsC6vSb0sqju36o+DrgZ50Q5Sj9L9IIsXoOv0k=;
        b=cc9L6Lads9TOMjNNi/tFz+gTfdKMy5DYIbUj+H3U+EqmKaC8oPQsgwFES6ZRIJCjRI
         SRpIk7u8uW3z8Wsj8MJP5dCpgdZkmNharDJh6F9TqChnZJii8SjXZ5ieYQWqbQ6+aChw
         Otl3b59RihIWJbonsQF5as+wz+66TKKt9+hcZszgjHt9POwAGbjYd5yhiHK95ML7i5n7
         pLNFlu0T6IPnYv8aqeHvyUfYDC76e4hPYI432UKq3hfOrPYCbgw5lJE0a+2a/1vFkuR2
         6M6191xqH7hhIitezOYGW72zCdOcAtWiDLtIkJWgwcQgwtZGZtc/hUAowQIhmq4h3z+1
         PTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkpqofsC6vSb0sqju36o+DrgZ50Q5Sj9L9IIsXoOv0k=;
        b=AeoZKaXpzpUpOxbgQMyvoxks4wkeVJpZuV5UL40R2oGhGBlJtIHZ6rUxHBsyGnyGi3
         1eyB17I/2f5OUpuMVnanzH0POoUpNz2nwwXUuI3U+7gvzGtH5LXB+Gpf1B0xfhKi7jFu
         2NcO3iOda1bXuiRhSw89DdVyElWRULOF2j64TRpoGrf3t5BXHa42chNvRGFxEil//W+3
         SB+cs1galrEAvKPlY8Itz/oHT/9O8jeIe/U0sFTYdjJXfsC7Crm5drUxdkePTut5QaVG
         PxvBsiZYGHOXc5fnGe5R5mlRHDM7/nCRwuFAbDGh9ldqog6x17Mm7cYhhgyJQghqxfQx
         K1Vg==
X-Gm-Message-State: AOAM533+YNgj7dokx3Ab1dHzWPZby6KEJt2qHJUdTC/2bL1ST91Qw8a4
        PDcmpnu7Xgw6lNyRCJwSQin+goWUBBqnfA==
X-Google-Smtp-Source: ABdhPJyY3jHr1gO0cuLmkoxQtsfbb9Nv5hHZIfrczV+3GdI7xkmvJ4efpu3/qBMHp2F69cslmxsG8g==
X-Received: by 2002:a9d:6483:: with SMTP id g3mr15639615otl.332.1619453902583;
        Mon, 26 Apr 2021 09:18:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d12sm72940ook.1.2021.04.26.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 24/43] completion: bash: change suffix check in __gitcomp
Date:   Mon, 26 Apr 2021 11:14:39 -0500
Message-Id: <20210426161458.49860-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't match the prefix, we shouldn't match the suffix either.

There are no functional changes since all the callers that add a suffix
add an =, and if $cur_ ended with that suffix, we would return
immediately.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 766c7f57c7..82ef19097d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,8 +346,8 @@ __gitcomp ()
 			fi
 			break
 		fi
-		c="$c${4-}"
 		if [[ $c == "$cur_"* ]]; then
+			c="$c${4-}"
 			case $c in
 			*=|*.) ;;
 			*) c="$c " ;;
-- 
2.31.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C45C77B6C
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDAItQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDAIsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9E20D95
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bx42so2867278oib.6
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxExUwGAmU+W41qHeQpDY+jxHXuozbBiHk+T3Un1CHg=;
        b=jg1ijjwUvoa1LCKELk/h7MIVXLmH2uJuzgxv42Ng49QNCF9ghLmzKU+0N0pim78Yvs
         wXjwTuww2ZLPlSwuIqQqqeWtIPTxQeIlRrqKsff1TnwQ4b6JJ5TflnrshXcV6+bh2IdV
         0lIEExAns4RRGBLh21wE77iGdcY0R//JZGX/7lK2RaQmq9Uy8OSm1yjZ5+0UaxEQy6QG
         otnW8pDFEKezQM+V6uzb9HCYj4WUJnB+Z4/zZC37nPMMRkaQ28UTo6GFb7S1oOR8GJSs
         QxjIZSa7yjW+vHxaS4kez6WYqsQ50ago/+lP4T3SWXclA3o7aQfiyzC8PcoX2/qZhosS
         JpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxExUwGAmU+W41qHeQpDY+jxHXuozbBiHk+T3Un1CHg=;
        b=np3Bsh80ihpuHrBcVY06asgphKmUSbqk0CdJqDGrlQUtK0BntVXyOrTd2KRW7LGDgX
         PWBN/LH2YIdkNj6aa/9VsC8i1UIe6TDvX4xrDIj/NvY80aseONUypsxZEI9rzbsUq5ad
         WdH8EwEamh42ABCc6vnzSmZY9SUHhDObYUG1kpDl+T/MRz74DkIBLGz3fgHurEQ15OEe
         aGgjlm7T3+OK19TmEjoVL/O219K5cXx9JmyuMJXxr5kKDLuZ9tEnxrsD6peRImrcjdb4
         L8ZbG6NpuG4pCYVmbG7Ugj3MEuTJ2VHrx9dKpaWl/dbawMqEzXIczDZ7MMVCanOOUqE3
         bQHQ==
X-Gm-Message-State: AO0yUKUHCTTepL0lYTTDt0XNLnntZlxxLZ88I0WS+nzxeFE1eKuBKcn2
        SrGPNKJjwQVqApIR4xCmzNg/w0mm5Fo=
X-Google-Smtp-Source: AK7set8c+uPtsInPT8NX7ythkLxWAQfLKOT2lNMZQeIFcf1l+inxicZEWpArKlET8HyzWGfWRCKzlQ==
X-Received: by 2002:a05:6808:a91:b0:387:3694:d5d6 with SMTP id q17-20020a0568080a9100b003873694d5d6mr13139802oij.25.1680338841247;
        Sat, 01 Apr 2023 01:47:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m184-20020acabcc1000000b003896f132821sm1836650oif.41.2023.04.01.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 39/49] completion: zsh: simplify __gitcomp_direct
Date:   Sat,  1 Apr 2023 02:46:16 -0600
Message-Id: <20230401084626.304356-40-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much different from __gitcomp_nl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 83d2bc99a1..170f3d7f5e 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -90,9 +90,7 @@ __gitcomp_opts ()
 
 __gitcomp_direct ()
 {
-	emulate -L zsh
-
-	compadd -Q -S '' -- ${(f)1} && _ret=0
+	__gitcomp_nl "$1" "" "" ""
 }
 
 __gitcomp_nl ()
-- 
2.33.0


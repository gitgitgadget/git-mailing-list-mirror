Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F0C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C20860F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhHDBJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhHDBJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 21:09:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C7C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 18:09:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q6so987963oiw.7
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rT0rJ4kuZOyGeSNbcmERBlY7prURfPrk/PZ6ZLhKZK4=;
        b=c27cjS+HxuoEc6uXpxGRSNsGM3kwXCfxNcOZCjYJoylVrHbBxCQQJl2FEsPF2kFOPb
         EH6+MDzOon9UBtuVRnHzzHFQ9clZVaYrnHeybj1fdGXscioY6tPc5vEKexm+cwC83itp
         I76UlUU866j0RD7hIt5zFO+9aijvmKvxSg/ziEqnzAcrhGaMUJHsIROJFW4zhqByv9yX
         qlq23stic2yo7hpKU8RM2A83YOmkLf/O1CX51P1RFT3BlyU/qWLjKmmdpVmTGQYL1zhI
         jYpguc4MtpVNmDyfFTejyCDe79LfoNZKgoR09m7OePogYZ3pmQal9l3JaR7yBBHXXoMa
         fUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rT0rJ4kuZOyGeSNbcmERBlY7prURfPrk/PZ6ZLhKZK4=;
        b=ZA22MY4cZvHlPjYRydX5GsiEgwbobvwLnQpie0DvZisjTNsrotKmaXEm348uaGJ+fX
         49aSPTdENleOy7NdDNThC5rsq2O4Ma2lMQrcVo5Ixpz3g3bB3Dhznxp7We91YRVRLHHO
         R4pJsKvIR4qcdvvAsjdrRBnJLkskcKi/r9eD+lbeKO3wSfA1fg8yZa3Wu9uAx1+krAbF
         wkmJkN9hWOrPXvhRJUCCTDZspcY7BJIAtQdrYfQs94OqnOX51UVCqBd2He6SR6z4QBLO
         GktJI48UXqCu/ujDroqYO9CU56yy7N12vVgr5Vv27tIpzUD9OdFJHjRETwpNisynJaZW
         4T3w==
X-Gm-Message-State: AOAM530AG+Omkq0ugLS2XzkNYPbsMmA7ZiQ9nBoqlwwa61ypcdkNJtkG
        GpQS1xfo8uV6pioCAbY+a3uf0YQd+Dg=
X-Google-Smtp-Source: ABdhPJxRktGbocTnpfz7BSe0wmBj4wltHJ3bCkXV2oOrn7zptmuVFvFaWmT6nwn1X0zKcdDLAehJ6g==
X-Received: by 2002:aca:aacd:: with SMTP id t196mr16229612oie.12.1628039367685;
        Tue, 03 Aug 2021 18:09:27 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c21sm179721oiw.16.2021.08.03.18.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:09:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     pietzsch@mycroft.speedport.ip, sunshine@sunshineco.com,
        tair.sabirgaliev@bee.kz, lists@haller-berlin.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] gitk: check main window visibility before waiting for it to show
Date:   Tue,  3 Aug 2021 18:09:00 -0700
Message-Id: <20210804010900.33133-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.433.g9a510e7e11
In-Reply-To: <20210804010900.33133-1-carenas@gmail.com>
References: <20210804010900.33133-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>

If the main window is already visible when gitk waits for it to
become visible, gitk hangs forever.
This commit adds a check whether the window is already visible.
See https://wiki.tcl-lang.org/page/tkwait+visibility

Signed-off-by: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index b62c12f..cc587b5 100755
--- a/gitk
+++ b/gitk
@@ -12664,7 +12664,7 @@ catch {
     wm iconphoto . -default gitlogo gitlogo32
 }
 # wait for the window to become visible
-tkwait visibility .
+if {![winfo viewable .]} {tkwait visibility .}
 set_window_title
 update
 readrefs
-- 
2.33.0.rc0.433.g9a510e7e11


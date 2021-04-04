Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA1C433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D16E61359
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhDDEJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 00:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhDDEJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 00:09:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D376C061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 21:09:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x16so8027727wrn.4
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 21:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7/uYu8yGO3joiCIz3YbNeX/EC3RTbAUjJHzJgiKiWdQ=;
        b=tbsqfnegYJ99+GoZ7dMqkSvkgSu2HphwOMEq2izRysjo43lH9v0yygKgjSe28uKb4h
         YQYuyfR7LTzQVyKhCwTmjBJFLc8B9aeE/0IHoiK79033ineC5T/SFJWB/GhddGpkvrFT
         IIO190oJ0WBuhAofJnwONOtYdljchAa3lB/kwZo1sRiPN1QhNX2UMIU3nmnz10sg/zTA
         nx26lukRxS0t8ALDNbzYWkXk4+nRtI81JI13JjzSGRWhumZQxMD3lGFQMzH4tn45eyYs
         UmLAHJEEgRadHwjk0/05za+FccTgcQoSQlXyw8JzwGHeEk4Q13vyuKlmM3n21Qq4+goj
         BXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7/uYu8yGO3joiCIz3YbNeX/EC3RTbAUjJHzJgiKiWdQ=;
        b=hZRGNbRaN0j6aIgd+E7svtIb5OK37byZa18W8RJ/pWe2kIhLz0boJCcXfaofWKotji
         9Wa6jefjxSG/uWbnixDnfuDqBsk3jJB9H//k/nG8LWQC0VzZOuujWUk5dHvnWgGXiXYV
         ZAAZg+l/ESsnCQI3ks3J/a50cf200WnruKrXdLRccEsaksZo2C9CbkSJBRM9tVLs4Y0p
         K4YfbC870IMVUa4rDvhndGUdiYcuyd8EO1BbZf4r60+LVPpD5SBd3kna5l/gFYEFF502
         zvS61vrtTkCQYUfiQ1rIdNbCA+zPzFVSzvJZA1hav42GblBfSzbU0ft1cNsMXfFTO8LD
         vN1A==
X-Gm-Message-State: AOAM533qRWIeTlk4lYFdQFA69l6xj/zFXzFf5eDS4VBG6CkKB+gExtfG
        WwLEUXisNQizRcWhr/nX9V0=
X-Google-Smtp-Source: ABdhPJyOQzZRd30rmWdA5GdHXclRME6bt/BqEvoCsywA92N/dBKlJiu496QwVNARC38iLR7bMv75sA==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr675376wrm.197.1617509345246;
        Sat, 03 Apr 2021 21:09:05 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c4200d5df61eebbad8b22.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:d5df:61ee:bbad:8b22])
        by smtp.gmail.com with ESMTPSA id x6sm18050938wmj.32.2021.04.03.21.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 21:09:04 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/1] user-manual.txt: assign preface an id and a title
Date:   Sun,  4 Apr 2021 06:07:38 +0200
Message-Id: <20210404040739.2671960-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210402121303.344914-1-firminmartin24@gmail.com>
References: <20210402121303.344914-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a more satisfying way to keep the change minimal: it turns out that
[preface] does exactly what we want. It just adds the missing id and the title.
No renumbering, etc.

See https://docs.asciidoctor.org/asciidoc/latest/sections/preface/

I attached the diff of user-manual.xml, user-manual.texi, git.info,
user-manual.html (using html2markdown) and user-manual.pdf (using
pdftotext) in the commit message which I also reworded and shortened.

Firmin Martin (1):
  user-manual.txt: assign preface an id and a title

 Documentation/user-manual.txt | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.31.1.133.g84d06cdc06


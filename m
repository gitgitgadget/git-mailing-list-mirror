Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561FEC433E0
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22714206D8
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 17:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR7WM4Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGYRb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 13:31:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD0C08C5C0
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 10:31:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so378680pje.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=E5yxlPUU6FEkF0nHy83QQRcKzbqnhIXb3ZAJsQBjNa0=;
        b=lR7WM4PiwkrdqgT0NAvCaoWzBaub1BqshGod0QoDoideo8YacUtiS79uQbVW4QJBsh
         7yphUNiJVUgzeblyVvk4ybat1j1xkKFMrShLQfgJ96CmBEsRa2woTw4mWPvOw1PUn35h
         ffVDnzkaTqe3e2/GMtQ7I8bHeZHTS6OrTLbr9k74pDfasNAkrowz+wwGQ/v0FIquSOXI
         5sXX3ztN0Jaop94K1Hn+hNM+gvKrAjYUmu4iSaZr9Yd0ZlaeavtDvGSnejzy51uoJcdz
         9WEmJIFZ4Ax5kyRxVMX+Q4PRE8pJAvnBsMovpQ5NwT3+DL0CISVeDDDdGuqEl/J8/JJa
         FISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=E5yxlPUU6FEkF0nHy83QQRcKzbqnhIXb3ZAJsQBjNa0=;
        b=rgqHAkJNR9Fe8msYOKp38zRDWJtO3i33zeVZeyuuTG1BkmbuJaYA/Sw+tCY1na64AC
         lGijjk1pLohayNf32cMMjj6LaTIdCXetx2xbFrbbtobu+uswPbn82GM5yvd1T5c/x9NL
         ILb7Nk3eMux4BKf7b5usQOkslVDgiuBJ7TVS9+pp57Nd7b8EX5kJakh7zQ8RSFs2Ehis
         U6ItQaVKWtFvz0zAX9tBROb1qq7t8XtksU59C7SY7jSTwmdcIK1U8Vy+11xmget5b+vi
         V1gp44cybFDdhoUdVZtDNQ+PIboiljHttHoNlIr9OrmAZdIXnXyB814L+iaonFZa2BJq
         JgLw==
X-Gm-Message-State: AOAM533/aBE1gMYqvwEfv4XuTBOMGcu3RT1xtT3Gc4rNJa9NBe1dCsvf
        sHvvrAU64+TI0ja82YRsxZCWCRYbC2w=
X-Google-Smtp-Source: ABdhPJx0tJT/amJwhxPTTUf5MdwFVftnsiWMLqFJUZFt5Uq9f8P/S26xwIreQEf9sUMUR6rD5ubclQ==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr13065169plb.21.1595698285503;
        Sat, 25 Jul 2020 10:31:25 -0700 (PDT)
Received: from konoha ([45.127.46.115])
        by smtp.gmail.com with ESMTPSA id u40sm1034659pjb.39.2020.07.25.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 10:31:24 -0700 (PDT)
Date:   Sat, 25 Jul 2020 23:01:18 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     mirucam@gmail.com
Cc:     chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 02/13] bisect--helper: use '-res' in
 'cmd_bisect__helper' return
Message-ID: <20200725173118.GA614724@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717105406.82226-3-mirucam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Following 'enum bisect_error' vocabulary, return variable 'res' is
> always non-positive.
> Let's use '-res' instead of 'abs(res)' to make the code clearer.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>

Although there is no set rule for this, but I think that your sign-off
goes at the last generally. This is what I have seen on various patches.


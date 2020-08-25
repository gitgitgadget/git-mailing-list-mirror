Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0485C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCC92074A
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=premiumguestposting-com.20150623.gappssmtp.com header.i=@premiumguestposting-com.20150623.gappssmtp.com header.b="FFF8FshO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYVT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYVTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 17:19:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E57C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 14:19:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w13so197007wrk.5
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=premiumguestposting-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=aoHqmH9sL+OcIlY4FyOlkTJUBUWRl5bkF8J+rcVr6u0=;
        b=FFF8FshOlU94FCDZtE+6QgQIfp7uYsiZSyGt0iaWKowJVGnj3f3SuJugZBKFrTEoeJ
         e02qum1C1BsuFRkNVXD9fgZeWZ5lMsTNlov/GXQHS3KcRwi4dv422lR4iIDQnAkoloN+
         LpgbpYrvQuTqI82mTuQGYyj/Vj/JIpGzZhdT5mdpqSGWi56fFKQ8aoGrWwzaIG089P1L
         mQmkirGrFsy6B2vNtqUgYgT7XdVGQVfjpF7ggkFdDh3MtouBmFI8AsZKaatmvE1W6yL3
         NnbxA6IvrSuDXIq+/Kh1CGyM4pVGA7tdi4yZHysu31UijgTN2Hw1qNc0femQiG7UXMxR
         z+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=aoHqmH9sL+OcIlY4FyOlkTJUBUWRl5bkF8J+rcVr6u0=;
        b=i3i+Xe9F2+ZASESF208Y2o0W2MVD+khiy+gh6cBeBiWQ78Tetwd/7A9P2ASdYaiQF1
         uNeTONyqeAlykQqiwSTybpJ3GBmlF2qqcDmkg5VtatoQA97ILuLwgM37Vslvz2Wkry6C
         pWNwgYEii/hJblAJBn9tt1npurrkWFglZc4+4CkNwj4sFmvv8H6oporM/crU+MtBVOC+
         D16/KxbaszSA5NweWRcv0w9rtbaZDaC+S4nIykklIelxXwMAlGdylmDJlVfJce4fEvf9
         vS8PpLdWSkeCL98Q3OPLbzpsd2ZC25Um3mtUEjBhmYz7BEjSvOWMdfptmF2g7gCProEt
         CCWg==
X-Gm-Message-State: AOAM5321OnsXkfO759/ImsaRmOFKJt7SenY37nu0RE991WsxsUHUZTHl
        jpfC/r85RDj33L0YBZoOJWTgKqCkYmZQ1kOx
X-Google-Smtp-Source: ABdhPJxkD8XBvhe9wBMyNHo46DcWJOZVxPpi1NDl4MVU6huELdX8aoit/1sgyCuT8OlO6z3wqG5T1g==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr11540873wrg.413.1598390393668;
        Tue, 25 Aug 2020 14:19:53 -0700 (PDT)
Received: from 39.35.131.93 ([39.35.131.93])
        by smtp.gmail.com with ESMTPSA id 11sm681391wmo.23.2020.08.25.14.19.52
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 25 Aug 2020 14:19:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Russell Fenton" <russell@premiumguestposting.com>
Reply-To: russell@premiumguestposting.com
To:     git@vger.kernel.org
Subject: Paid Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Wed, 26 Aug 2020 02:19:48 +0500
Message-ID: <79723828004881898010020@DESKTOP-FB7ULH6>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

Hope you are fine and doing well.
I want to make a long-haul business association with you.
I will give you elegantly composed and one of a kind articles identified wi=
th your site.

I will give you 2 to 3 articles each month. The links would be the do-follo=
w and relevant to your website. No gambling or adult.

I will pay Via PayPal or Payoneer.

Much obliged.

Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A7C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0121A2080A
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQFDmYix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgIGRVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgIGRVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 13:21:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1BC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 10:21:33 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y2so13055605ilp.7
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ovzGGoeZ6bRG8vBYPNYN7AnRDXz3hHfu1NjKE31F6p0=;
        b=bQFDmYixzy3PmmI7GG4pU/zo/9f/p0POcQeWxjqYzn3U+wvzrGY4HXrb0r25aORg6Y
         Ql+k0f07w683BiN+iqGPbqnID44dVWRU4Raqz1i1JVGWyup6RkDvAZD3hV1sEvGEl8T0
         dNYmmdutN95fOZ7iL8A0FWbVu/NfLMeBv8ZpTu9Y8BgOpURFjVLBb7O6plmO59Icd5RX
         jpBmNXYeY3O0zKlO9rJkzjejdve7sCYG/nQVJT2j3Cjcg7S/ArBf6m1pKW3L/+8ZAz09
         nnqavMaagfZqclEn+UfeWyoL76BO9abx0E7xChzjcn9Wqv5u17bSq6wgKP1t/EJN33G2
         2Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ovzGGoeZ6bRG8vBYPNYN7AnRDXz3hHfu1NjKE31F6p0=;
        b=RWmOqnte1xX9qDanYl26RajA5I2eucnL0FLrwqVMym30UgaGPzpuhooH3hcUK28t/e
         QYJsld0QUn+lj1BmsNVZbnxesx8Cy/XBQvIOgRIQ1ahTWzhlIGqUVKza8dpT33OD4BU+
         2SFrtXgQ7cPSu2/JcmlbF2DV46tjY3DzP28HYWFnF75OXoPtLQZ/P0Ng6o1t0ftwHmFB
         BLlzH3oQ6SKXiq3A16NWzl+R3bFt10+ivUnGf6sMTghbStNPEXqVmkIax79EhkBapsFO
         qYjghjAeTidLmGX1QtkVlyVFa+bzdXCzbKUy3ZbU2lU0PEVHbzkOAqpHtvJ2NWcGr15N
         ATow==
X-Gm-Message-State: AOAM530Lql2dlnadMCoXLK8DEJztPrwgS/+uvLQJ0f7hB2iM6IR2jBlv
        162qvnWVt30GmzcPqY9Jy8W0Fcu4oW/gP/D39yeyJ4bg1m4kWw==
X-Google-Smtp-Source: ABdhPJx6X7os/6OSlFN4mj0/Dd3RvwFHaCdXHo3Btl3jqqApwZ3SrsDQpD/WqueIX4LvODF7aaQJ9ILC6miEZswyJzk=
X-Received: by 2002:a92:de45:: with SMTP id e5mr21347122ilr.102.1599499292735;
 Mon, 07 Sep 2020 10:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200907171639.766547-1-eantoranz@gmail.com>
In-Reply-To: <20200907171639.766547-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 7 Sep 2020 11:21:21 -0600
Message-ID: <CAOc6etY1Wdfbg5D-CHSg3zOtGWko+de=HEAnRfgVO_QfK9w07Q@mail.gmail.com>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Git List <git@vger.kernel.org>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2020 at 11:16 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
Blamed the wrong branch. I should have looped Derrick instead of Jeff.
Sorry about that.

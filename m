Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49790EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 08:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGGIpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGGIpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 04:45:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BC1FC4
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 01:45:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3faf39c8ad1so4016225e9.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uw.co.uk; s=google; t=1688719514; x=1691311514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6R+GYvgr3n6wodhyS48rSa95hcYfwF16pS7iYb+EL0=;
        b=LzdY6/xpS4xhAThC0aUPsPlBwkpYEp61e4dF7cwvm5T8NEO79XEF7CNT0PZuHb+wh0
         LZXzUMespucVJJD2Aj/Bk0i1ceZQgP5aea9HKkxr4UzJ3Ki6LrFXDBKl0lqOVbfxgU90
         2QIje5DD9+krcEqJ9hvazs3pxEpQtGX7dkf40H9lD3rNet3BBb/b5hn4L3APh9zFQNrY
         2xIIfOZ5rYYj0SuSsBjcZVTTnRM87I96zHSsEE+X7e6jDhVa1ix64K5C84RqX7noGk3T
         bebaPqE+89plXntzNl8jZ0sRpjrX1jGBdijxEQ6qdoR8x7pxuWPhFZP+CYfHRUYm7Ysh
         gCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719514; x=1691311514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6R+GYvgr3n6wodhyS48rSa95hcYfwF16pS7iYb+EL0=;
        b=Dxvl9Y04CqzuhRxt4O+gBMc/hKETFLli7ImhVy5Rk0cUZlWixoYk573xrpqRinDTLS
         pFN/+KX93Nbg9rHNBJkqn/Bc0wb/0Aa1bwD/dpr+y75YQHJoUWV2KfDlIPIlznA2QrCc
         PR9lUSGCLjBlMoEBlrm9FbSpjgK94Fzo9AHs/XjQQK690yRtLHDHfFDZ1wJ5GdUxcYLC
         6IBrnrJ3819IEOgl3LcS/1pR7Cc2N5ETqMjpk79xVD0caQWM0xaJKZ8WdFVWEDtX3/Rn
         FSRwrDSi1ChqXrFUnzNHXGmlTSHR24pLGtVMA4RAntNnpl7g9ulehPP00YW0meRnYod+
         W+SA==
X-Gm-Message-State: ABy/qLZGAk5Quy+JxUnf3wXWmsfeR0ccPU1zzSUCLRyoHznzkQy3NYDm
        7O7ZlIfyeE8NdblEAbGFb3Eda/zGHzgeUEqJ/by8nhL6R1BOKbKOMJQ=
X-Google-Smtp-Source: APBJJlFCOO65PHLJWSR4fITARkCBk7GuyQAct4/2cVOGgPek57CT8YT4br1oPUf0gt/GUdmfTq5sIL1NJEKmuG3Ajoo=
X-Received: by 2002:a05:600c:5115:b0:3fb:aadc:41dc with SMTP id
 o21-20020a05600c511500b003fbaadc41dcmr3675257wms.4.1688719514187; Fri, 07 Jul
 2023 01:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
 <xmqq7crddjtq.fsf@gitster.g> <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
 <xmqqjzvcbvqd.fsf@gitster.g>
In-Reply-To: <xmqqjzvcbvqd.fsf@gitster.g>
From:   Matthew Hughes <mhughes@uw.co.uk>
Date:   Fri, 7 Jul 2023 09:45:03 +0100
Message-ID: <CAEzX-aCnp0avSbMdyFQz=3s4-hjdeVwnndR5b7UeZo4oNMnv7A@mail.gmail.com>
Subject: Re: Expected behaviour for pathspecs matching attributes in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Jul 2023 at 22:01, Junio C Hamano <gitster@pobox.com> wrote:

> Study the use of test_when_finished in other tests, perhaps?

Thanks for the suggestion, that appears to be what I was looking for. It's my
first time looking around Git's test framework, so I had a scan of the docs but
managed to miss that one.

I'd be happy to submit a patch adding those tests if you'd like. Though I would
like to just confirm that in the patch I shared it is not a bug that:

    git ls-files ":(attr:otherLabel)sub/" >actual &&
    test_must_be_empty actual

I.e. that no files are listed here even tough `sub/fileSetLabel` has the
attribute `otherLabel`?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFDC7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDYBug (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 21:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjDYBuf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 21:50:35 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA09EF6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 18:50:32 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-5ef4d902708so51734706d6.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682387432; x=1684979432;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjOrlgQMBYrWZ1GUJpsIU4Emw8jhxZavM+QWkfSEUG0=;
        b=mbNQCnLxm1Y0Zp0A+Lg0dtHwwmGh1H73uAYnNsURN77ou2sIooX36nb/D2fwyQITPF
         SFnbLo0qPBMBOwZktAX0jHS93WOXFttxhaecTUEYYYULnQtt7Ud3AFTTfxTMwDxWzsVL
         pSH0BaubJWCqDyv5Rb6OrO/e7chXmBTT2WzcGX1HwqUQ95yX8ipLL7EkoC0zVHr9XvDg
         sbdnGtbuNf/UyjCH2lSWKAoQfqpPHampFM0m+wX4shkgkc9R7E9jCCh4zn82T2NQf5zd
         06IXnGHFOOMNrDILYNhUDOrT5st1r/yw3O95AVKpbpli5I8C8KWwglPxl+XjaS4X9R5Q
         A6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682387432; x=1684979432;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjOrlgQMBYrWZ1GUJpsIU4Emw8jhxZavM+QWkfSEUG0=;
        b=h+lutE9cCot08sHCOOarBpJA45fBzlzv6lYeF3yct+J9yjNbfJ/1qN6MYOR1NoZlOL
         MUqLVq3VfrAw4HWYomqELx6xrBpTZTy03kaDv0e+VTxVNI3w7zlGFj5wYBuE/AjyyZT2
         NajybkOZeKRo/MpVqMhAfnQDYsJKssdAy2B3PVi9ARHs/B6LAyA2Ei8I/GZXu54bPlCK
         0NQHFeOo2dtRBSv1VkYhQ2JNhhDExm9TKe1gsCApNTcSZigipxvGrNCso1TqYbdZa7RF
         OSEfX68A9ihTdU5FTwX6Oh/Id0RXySeQlVGA/A+kqrU90/Wcgx5kEsMEPNx1TEac1/1v
         96Ag==
X-Gm-Message-State: AAQBX9fcNDMZq7rnePkH2hncFKJvogbdL9V2JM+oy7t+JtgGV1qtV2Mw
        DUKAl6lx5DmaXHn3re6Guqt3H5P+ol0=
X-Google-Smtp-Source: AKy350bI+etw36HtFefQU2xbw5uq92do7re+3W4cmOhCvsoBDUpwq++eJYKseRa4ozJM4bdyon03fQ==
X-Received: by 2002:a05:6214:501b:b0:5f1:5cf1:b4c0 with SMTP id jo27-20020a056214501b00b005f15cf1b4c0mr28906868qvb.38.1682387431828;
        Mon, 24 Apr 2023 18:50:31 -0700 (PDT)
Received: from hurd ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id k1-20020ac86041000000b003ecf475286csm4045457qtm.39.2023.04.24.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 18:50:31 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <xmqqjzy19coy.fsf@gitster.g>
Date:   Mon, 24 Apr 2023 21:50:30 -0400
In-Reply-To: <xmqqjzy19coy.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Apr 2023 14:45:33 -0700")
Message-ID: <875y9kspax.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:
>
>> This adds a new --header-cmd option to the send-email command, joining
>> in the ranks of '--cc-cmd' and '--to-cmd'.
>
> It sounds more like it makes these old two unnecessary, which is a
> very good thing if it is the case ;-).

You are right, that --header-cmd can be considered as some kind of
generalization of the more specific --cc-cmd and --to-cmd options; I
hadn't given it much thought myself :-).

-- 
Thanks,
Maxim

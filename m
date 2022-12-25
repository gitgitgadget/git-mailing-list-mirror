Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5646AC4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 11:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiLYL0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYL0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 06:26:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FF62D0
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:26:02 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r18so5823409pgr.12
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sReKrOZ2W3ftjpTv8mns4UguEX33pJ+MT6IMKlaw+ns=;
        b=R8TpR68uotC88eWg6hm8r6rxbGIIk87WQKZ/6GOUW1/uaxZxPrVoaIkAAFqFgnTYm1
         +ipWNhBTmHIjQbXsd+XQ1aJ6YlBN33cGZRl3hZFFAYpO/nU9FFAaXrOUU6CktuN8RvpE
         +0qPpOgIPigo5Ffw2MncGdMSYBgejuNl7wkHL//YA16ChI7UCIwjcs4iHezU/C9Udf0E
         1AZKzQdYSwVfu6lMf0mNx1uoU4BZH8R+HLGK/uLHn3b2KYQMLbGHw5vAEfJNZaKD/sLX
         /56V4eRwJDBtur3joulgasd2sBJx/WT3GnZGH7o0/HhB0IKI6HNH6ZZ3WNeDSS9w2GTd
         cvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sReKrOZ2W3ftjpTv8mns4UguEX33pJ+MT6IMKlaw+ns=;
        b=3En+en/5ufcWQ7qRv26WSJCJ+CmmZA1/U3UY0Wywox+3gJ77+sjIi7inDI27TYyQhv
         FfkHGGISpiJmt2FzOhWhy33LelqjU+kkvt/ZH2HSu3n4H8VpF+LjmTzKvGaftahWo61k
         dMEh5ME3ZroQ8juRGo5YGva2DrgoVO8b68mThrOnevl7/ntEVwEDhr4ubkZmm6dPCL0F
         AEZg0EZSKiPV7UgWpqM4i/au7Br53k73fgA74jJc+DaX1NWBdS5JFqt/sul0CB8nVmYN
         f5UIAtwSvkeWEjmGkXlXq0t7N8kEGrl2G8chELEYPG5p3oZadKJCI00wnkB4rq2/ZhXy
         1g2Q==
X-Gm-Message-State: AFqh2kpmDl/pRVnYn+flowymX9W8gX1BceF9ErjmAu6zauaXBFP3jPio
        HRA/yZWPmccWM8aeMeYmJ+mYX+OZf6yO5Q==
X-Google-Smtp-Source: AMrXdXulgKMxqoHjJtZUKx58lJr168Pzn8Yr+rikEIsgqCltWi293WoVfa5sIEjzk292lf36ycmIjg==
X-Received: by 2002:a05:6a00:b48:b0:581:dda:cec3 with SMTP id p8-20020a056a000b4800b005810ddacec3mr2155505pfo.16.1671967561516;
        Sun, 25 Dec 2022 03:26:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z189-20020a6265c6000000b0057630286100sm5162873pfb.164.2022.12.25.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:26:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
        <xmqqr0xkt07x.fsf@gitster.g> <xmqqlenst021.fsf@gitster.g>
        <Y6LP+fCMmP33T6Cx@orome> <xmqqtu1prt2j.fsf@gitster.g>
        <Y6NApq8pFcqkvlFg@orome>
Date:   Sun, 25 Dec 2022 20:26:00 +0900
Message-ID: <xmqqo7rrohbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> Your changes look fine. I applied them to my local tree and everything
> still works as expected, so feel free to squash those into the commit.

Thanks, will do.

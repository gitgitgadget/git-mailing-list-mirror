Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF456C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 21:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBEVKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 16:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEVKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 16:10:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FC12052
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 13:10:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id be12so9906984edb.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 13:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAVYtENjx++4v9u1Soco7PaV082BBcQMs6xHminrnKw=;
        b=G6u581p3Lpcj+s215r0quT8mAUMSXyPlpSUdfc0iU24T70VZJ5I6E1XyiqxEz4rNQU
         wBSC2RxetH7d6Et82aI1CVGzoPodPIj58Sogk3j0U0sBVUY8XmoOVZuKUW06glYNwRx0
         gM7J6pRYKWVItWfnLSP2nGGeaeNHW+svwRTWuTOCxM5kojE0CZRYDsOM6nZFUx4zeKLx
         2hn127q7KTPR5hhxHqo+9+LKAGynGmFZEMdpNijBkfpQZtH5bs09s3aySTPIwHOqf9QC
         p3rFtUD2A6oac2CBZLT3OSv3fG/rjAlBXH8y4ZGPq9YbDJoKI9uMy8ZYoWKEDa7BJioz
         QfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAVYtENjx++4v9u1Soco7PaV082BBcQMs6xHminrnKw=;
        b=AbE16iW84lqDiAKven1hiAIKPg8U7G5Crk4rCzjVKhB/ThpxtjC/KfrxNUQVnpgLQK
         lDweT/WgKcYQlSzlxvNY8jl/aZN6/G0NcUokxfhBYPW9yIkMqPjZ4WLl+CYD5ykqAbv7
         W7gPVSiYNZqTi8GzAmXRnU1YdHNoKHQ0LKfPQ+PCf8fTV8I7KJaawfi1Gn16uBLSLcRr
         BTtCskBZbE/FItgzl+Of52E6mXZh6Fdg3OJQD9SeqK78E9jmj/UKmF4Dwlt5TKJSdEDZ
         ScRJEUwLGYryFycPdrh0r6k1biltnWHIwIuds6DmUGLEE5TJ5eiFWTLnl5BbwR/Kb0qV
         NO0A==
X-Gm-Message-State: AO0yUKUcH0X7+ZLVIY0CagZPD9mUHDk88avGTn3r+fdK6pspnmsfDOHv
        DEyqvRdh4Ic54NPRxlzQ4gg=
X-Google-Smtp-Source: AK7set91gfJgclbQMslpi2pgrltJct1iRV2klFDsLd5LsLudk9l/nCL9qau1F7aBNcy/YPgAX6q85g==
X-Received: by 2002:a05:6402:4493:b0:4a2:3303:a3bb with SMTP id er19-20020a056402449300b004a23303a3bbmr17101701edb.16.1675631414036;
        Sun, 05 Feb 2023 13:10:14 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709061c8600b007c14ae38a80sm4476743ejh.122.2023.02.05.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:10:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pOmH7-0006dl-0R;
        Sun, 05 Feb 2023 22:10:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: use size_t for {base,df}_name_compare()
Date:   Sun, 05 Feb 2023 22:09:18 +0100
References: <d272fd03-a005-f6ad-3f00-6b1a970a519f@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d272fd03-a005-f6ad-3f00-6b1a970a519f@web.de>
Message-ID: <230205.86y1pb7r9m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, Ren=C3=A9 Scharfe wrote:

> Support names of any length in base_name_compare() and df_name_compare()
> by using size_t for their length parameters.  They pass the length on to
> memcmp(3), which also takes it as a size_t.

This looks good, and it's nice to see changes that slowly address the
greater topic of our outstanding -Werror=3Dsign-compare issues.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5321FC77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjDQQGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDQQGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:06:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05141A4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:06:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b73203e0aso3503145b3a.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681747611; x=1684339611;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atHKPQ/1Z2kEtjB8GFWAmnpxI7FqU0Zje8aC/iPPUHg=;
        b=ObTlVH3lpbyfQ3nFbHiShQSvg5GoxZjJquTfGoRkxuRbPfGRKloImeKKShqq1Ty+zR
         iHftOVcLLEVUfjHpD4V/b9/1zQxat/cm/I3UWIatuePjlSxK6/fCrdyz87zfIav3TbYA
         A6VrLLhySYvmejZBS1I7qgd9FTQYwW2F6sYTS6JwQslvau+VvZD7JpegiTNlQa1qZg4G
         1r8nOVVdfveVdbuhBqUqpn84Au9V2z/CHkt2zWFqnxz5RIWBXPPiRfx20NMM5D4J/ZtP
         ZG2bFlZSqWaQw787DCMfXCgyLi3jchsEHNzagZn30wFodsCE4QHIdOYdf2WU2ULDDOIq
         dUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681747611; x=1684339611;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=atHKPQ/1Z2kEtjB8GFWAmnpxI7FqU0Zje8aC/iPPUHg=;
        b=EnTdtXfAhW+tIGYOgDtyCsTtxwPSpzDpEDYDtPYoa8cTA3T3tEILURSc+XQBDDAVgd
         Tw3d04N/SIt3GKeYjZfeKVepqmxlMXdsd+ucdMez2pxB9hCN4Q5TvyRC4bJCKtvLcsjc
         5OYCBSgxYSLJBLW3bFrr7fgiVLf1aVG9dpiVZ/E4WsfogJFPiXAhBZz6PvjvVNwYnm0d
         QGuKyV6+c5HyXjgeZVzyz26mzD89/gDWQYZjXWZ5XMXfgwJVIOskYSw/CbbGWIXrwza+
         EOy7EBkcEC02aU1x56rvAc3POTEB1gMFHlsdckHgjqj68Eyj4+Yp8TTwTMhHVUyqrT6r
         u2lQ==
X-Gm-Message-State: AAQBX9eSDyqRnKeE2c4YRCAFDGyEdl+z9xK8yGpw9GfjMaklc9lsWmjN
        WaAlahjydlXig44eXOZEyLllcyQu4aI=
X-Google-Smtp-Source: AKy350ZuEsNbPVxTi6DAzvTAzBz7vXogu7cD9kWUtgA6IluX1rscl+81Jo7TmXT/ZcXRVB2qWsserQ==
X-Received: by 2002:a05:6a00:710:b0:627:e677:bc70 with SMTP id 16-20020a056a00071000b00627e677bc70mr20475356pfl.14.1681747610972;
        Mon, 17 Apr 2023 09:06:50 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id l16-20020a62be10000000b0063799398eb9sm7710772pff.58.2023.04.17.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:06:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] v0 multiple-symref infinite loop fix and test
 cleanup
References: <20230412062300.GA838367@coredump.intra.peff.net>
        <20230412063118.GC1681312@coredump.intra.peff.net>
        <20230412090423.GA2187240@coredump.intra.peff.net>
        <20230414212404.GA639653@coredump.intra.peff.net>
Date:   Mon, 17 Apr 2023 09:06:50 -0700
In-Reply-To: <20230414212404.GA639653@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Apr 2023 17:24:04 -0400")
Message-ID: <xmqqttxeo5lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 12, 2023 at 05:04:23AM -0400, Jeff King wrote:
>
>> I'll squash that in and update the commit message before I do the next
>> re-roll (but will still hold off a bit to get further comments).
>
> Nobody said anything, so I assume the rest of the series is perfect. ;)
>
> Junio, I see that you picked up this fix as a "squash", along with my
> other "v2" update. Here's a v3 that does the actual squash along with a
> commit message update. That ties up all loose ends from my perspective,
> but of course if anybody has review comments, please send them.

These look good.  Queued.

Thanks.

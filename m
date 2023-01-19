Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB143C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 16:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjASQYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjASQYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 11:24:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8AC70C67
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:24:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z13so2773483plg.6
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUmXDXVqMwxfZuInVrmd02QrJWeOw3966ODh9p8uOFU=;
        b=YhUR2cLRvXL/0JJkuVRgsZZos/27bjXyJQeDC8srOjgHgK4b3/EmsOBRkVsKlEGCH5
         LVnrXiZNG7vIlTgFdWgV0yBsCQCl9ec+Mh/wBXK5I1/bm/PrhRAfMqGJtzD8QyYYgqtp
         6CMJJk/u+QGKR2I1AYxzvaCfBfzv2qHCKR/70ljYlfzYkz3T1IQxujlHteUyQw7odSyK
         DC5n7tYqJnhRKS8opvcWgPlp7LKzm7BsNwROX51qDmtKla6KBcffx4xna91NQEcUxbET
         xLdABrxxg+8bSTRIl5VqFrIdWrABzzhVn7NGrNY+g60zcCCdqcByJrsJaNjXUDoGKEEt
         kdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUmXDXVqMwxfZuInVrmd02QrJWeOw3966ODh9p8uOFU=;
        b=sAuKSlW8035D1S3g/lMdaUjW5FW25uXEqjb5Afca1TXdcygMl2KTrUkY3mICdSTnKD
         2ChUlSYmEvBAyGBKpkkHJDURWcptd653ssVONPHx52uwJZla61SvwgvM7XN864Z0L/Kc
         ngnYoPLSjWhviBSd9QZ0nh57A7hTdqzBQ/e2xAq7N454huf+9JqG8P4EpqbOarq+upSI
         yfFvreSKYmPBlgeDfsH9AHr0dnkolDku4z5qsM1xwEzS9YWOjEOYpBuR/9ZExPcxD3I5
         qYOnVRBzcbxug9johXsBoq/hTDi/24Ba3dGzwkXVqSv6WJs8l7qNaZI6paK3/YwOc3NC
         QsBg==
X-Gm-Message-State: AFqh2krrP4XmqblEJWh56q2TVNV9jVDE9b0bSAv7INL7/V9OcnBAvVlJ
        wxc/Tx3B1h7TxT9a4db2CpE=
X-Google-Smtp-Source: AMrXdXt0rVx+PTCvgyoQqDOXw3uVREFGdw74WWDgvavoVWbjufmkIf4197Koa6TTzm32Ps/ztzN52g==
X-Received: by 2002:a17:902:d506:b0:193:2fdb:db07 with SMTP id b6-20020a170902d50600b001932fdbdb07mr16246382plg.43.1674145446931;
        Thu, 19 Jan 2023 08:24:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00192c5327021sm25391729plg.200.2023.01.19.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:24:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH] git-cat-file.txt: fix list continuations rendering
 literally
References: <20230118082749.1252459-1-martin.agren@gmail.com>
        <xmqqzgaf4xrf.fsf@gitster.g>
        <CAN0heSokODyuYUEgaU8Ym_Evvmdp_y1-V0LxbsTECgm3sP9d-g@mail.gmail.com>
Date:   Thu, 19 Jan 2023 08:24:06 -0800
In-Reply-To: <CAN0heSokODyuYUEgaU8Ym_Evvmdp_y1-V0LxbsTECgm3sP9d-g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 19 Jan 2023 09:04:26
 +0100")
Message-ID: <xmqq5yd2332x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On Wed, 18 Jan 2023 at 17:23, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Are you comparing both roff output and html output, by the way?
>
> Yes, I'm trying to make sure all four of
>
>   {asciidoc, asciidoctor} x {man, html}
>
> agree and look good. For the manpages, I use our doc-diff script. (In
> this case, I wanted an empty asciidoc diff (HEAD^ HEAD) and a good
> Asciidoctor diff (s/+//-ish).) For the html, it's a bit more manual
> labour, switching between files in a browser and convincing myself
> everything is good, visually.
>
> Luckily, once both tools agree on the manpages and they look good, in my
> experience, the html is probably also ok.

Wonderful.  Thanks for your careful work, as always.

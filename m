Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132AC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 22:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiJFWvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiJFWve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 18:51:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6CB8C2F
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 15:51:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f140so3401934pfa.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfTWd5IundrGRz1TCk1+KWYdrYEIlh9wE7Q5mkdNmzo=;
        b=gGoFEyRlYBEEbA2l2upieROmJU6/kbgjay9bsCYvOktjZXfsqJMsExbnF48xEn+rs8
         xs2StSboEM4C08WdM5quSswPalmDCzNlu5Zv5XMC/nYE1BQ9SIkR5WtknEB7wGIO/WQ5
         gNy93J11fo3kkWY8UsmOATZSJBD30LgKDuKZQlA12ywc89EJc/J/l52eFlpwbFtoaMTr
         Xesj3gpQS37Lw47u7Y1qsnixSOiY7mTMkydjBgU789Z/Ux9RlCErzLV3FVTgctAX6T51
         wmAWefx1SVWu3rkp7mDB/yOTfdebFSeTGXoX+v/88Lr+/PCPF9KQqlKCQxJTykLBx95/
         UbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfTWd5IundrGRz1TCk1+KWYdrYEIlh9wE7Q5mkdNmzo=;
        b=XV4jv8murCuaQpNAscNaBxbk1Ey34zKYFYhUkKi4akeTGKQvELIdSdAVQ6PReEnkh4
         ro6HrHUvuuCeQdfDYluIA9Rb+bOhdIR4U1uEwfaI6NfQ6hz62MnxLZuUFSlE5AMwgJmV
         FIC8zgi5GCZuQsM8KnYHXgFelac5N23uvO52AaJH2anj+z8XqSbEuPI60Kx88Xtc43V0
         s2NVGsw8LlbK3/FgiGvM4VwyGuuAk05qeuiYj2X2Fm6G8pTg2ZDwlJiwY+pHgnOZIP/5
         ReU2KCODlMOg5X9fP8YsIq675ehH1GKfuxefaZdokKbhdAMl3pSw77LPo3Fd7J97u4ZL
         incA==
X-Gm-Message-State: ACrzQf3BQ5qoiEseRGdZJ9HLCssX3iS+w5spZ05uTUidxglWXGND+RTX
        IX42vjT0uO3dJHAMUkfLSN8=
X-Google-Smtp-Source: AMsMyM7EmJEIPiqF0EgNjT/ruKPPzbGxe1kefe3tLx4b8VWV1XTPzmKlQwxu6QvU+ht9RFurAHqJew==
X-Received: by 2002:a05:6a00:15c9:b0:541:1767:4ce2 with SMTP id o9-20020a056a0015c900b0054117674ce2mr2047497pfu.30.1665096693123;
        Thu, 06 Oct 2022 15:51:33 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x63-20020a633142000000b00442c70b659esm250316pgx.91.2022.10.06.15.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:51:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/2] builtin/merge-file: fix compiler error on MacOS
 with clang 11.0.0
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <7cee38788a7a3c2c09a238e01c5bd825445f999d.1665085395.git.gitgitgadget@gmail.com>
        <36cd156b-edb2-062c-9422-bf39aad39a6d@web.de>
        <CAPig+cT7_H6EDU9s1G38QrepACzN2vzCopAn7S=PDb0so_F21A@mail.gmail.com>
Date:   Thu, 06 Oct 2022 15:51:32 -0700
In-Reply-To: <CAPig+cT7_H6EDU9s1G38QrepACzN2vzCopAn7S=PDb0so_F21A@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 6 Oct 2022 18:30:56 -0400")
Message-ID: <xmqqczb4in0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Shouldn't we rather silence it with -Wno-missing-braces?
>
> That was indeed Ævar's suggestion in [1]:
>
>     Since this is only a warning, and only a practical issue with
>     -Werror I wonder if a config.mak.dev change wouldn't be better,
>     i.e. to provide a -Wno-missing-braces for this older clang
>     version.
>
> The problem is that Apple seems to invent their version numbers out of
> thin air with no relation to reality[2,3], so it may take some effort
> to work out suitable "version mapping rules" for config.mak.dev, and
> nobody has done it yet.
>
> [1]: https://lore.kernel.org/git/220712.86lesy6cri.gmgdl@evledraar.gmail.com/
> [2]: https://lore.kernel.org/git/Ys0hhYjPExuNWynE@coredump.intra.peff.net/
> [3]: https://lore.kernel.org/git/YQ2LdvwEnZN9LUQn@coredump.intra.peff.net/

I agree that telling affected users to squelch the warning is a good
first step, and automating it, if there is an easy implementation to
do so, would be a good thing to have on top.

Thanks for digging up the thread.



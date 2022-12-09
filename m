Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73601C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 01:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLIBYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLIBYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC7BB104F
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 17:23:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so3299064pll.6
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVL1IxBqJGpXvHN2TdgK2XX5m5TYUs5T/bdf05X4YbU=;
        b=f4tPXD6EXWPzUcsMVDs4mShsmVaGEZ1K9OZJb7zOfiUVNsyH2QJ9iaIdX1X7mE/GwN
         AK8L139hTCOtCCXiz5ByJwO63Gz2T2hTE7pODCOQKEuHoVqHrK48V9pvjWaPlQ/5vn7F
         32RikwVpPJa5zjgbFbvraH4AgRcNNoY/fg0IJIFGW7kO+BC3hBqb+XHPIcw5e0c5xEH1
         Nktk7yO01GadZtQNDvQQwo7c1l5OxGUy1og5bTtZGkneB3ac43a0m6qqJbiLf7Lu22Hm
         UA7FeBhdjJ20MRBgWhQzHH/BdAQ/rFlnehg7fshG9MzhsnMiqhc2SNEvQsvE4qTfgeXd
         Us5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVL1IxBqJGpXvHN2TdgK2XX5m5TYUs5T/bdf05X4YbU=;
        b=Ss2czFNHevee1h2FLjuePJSdwzhAvWhEhkTq5nZMkOgbGDaO/bJ+9w4nwS3CL+4IYt
         ZT6OAy+T0vGAP2lrHsPeUHSM8IgsFHWx2DKS2UzcgDB07U90GKeeqHdJWN4VJzWGuPOS
         PbYeDXXWoZNPnVVlKJjzEfYW+v7zaCaT16flV7skI/l/mvi63kBYg5tALY7VA7Og01a7
         coYfmbS+4+QF3n2Bu5mPDwAu/5pzmWnFyHRlS05WxwbhSY+E4wEn7rtSuM/tdYjz0fU3
         kEI36qVg3OJcaxVsktAmq0cvFUZfTculfVsMW11T+iK6mb61ieFYDqFlb74Z8lt3baxk
         LNHA==
X-Gm-Message-State: ANoB5pkl8b7HNWpBjx2MgsAVN1osrA7kj0mt8yLHfHXUNX2+GglstM7s
        QrZKYVcMxKAIq4JiRbgJHAo=
X-Google-Smtp-Source: AA0mqf7j8a/jjC15E+sRDNP6iOen2rf0py53uC1k5Da0+USJPUfK3G0pN3L4GxzJ8jQCjUjqiwjakA==
X-Received: by 2002:a17:902:ebc2:b0:185:441e:58ae with SMTP id p2-20020a170902ebc200b00185441e58aemr4058463plg.17.1670549032887;
        Thu, 08 Dec 2022 17:23:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b00187197c4999sm62563pln.167.2022.12.08.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:23:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
        <Y4/xSObs9QXvE+xR@nand.local> <xmqqlenj7t0b.fsf@gitster.g>
        <20221207084027.7dhyaatkzaawrg4g@vulcanus>
        <Y5EQCD4XCsN10HO+@nand.local> <xmqqtu266cj5.fsf@gitster.g>
        <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net>
Date:   Fri, 09 Dec 2022 10:23:52 +0900
In-Reply-To: <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Dec 2022 02:27:03 -0500")
Message-ID: <xmqq5yel2wuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This made me curious about the opposite: is there config you can set to
> get this behavior for --signoff? I think the answer is "no". You can do:
>
>   git -c trailer.ifExists=addIfDifferent \
>       commit --amend --trailer="Signed-off-by: Jeff King <peff@peff.net>"
>
> to get the desired behavior, but using "--signoff" does not respect
> trailer settings.

A customization to allow addIfDifferent may be an interesting idea.

> I feel like config is probably a better match for the use cases here,
> because the decision about de-duping is not something you'd usually set
> for one particular operation, but is more likely to be a project policy
> about what the trailer means (and that includes Signed-off-by). So you'd
> want to set it per-repo, not per-operation.

Sure.

> ... The one exception is that the
> generic trailer.ifExists, etc, would start affecting --signoff, which
> _might_ be a surprise. If we wanted to retain the behavior there, we
> could say "--signoff is special, and doesn't respect generic trailer
> config".

Yeah, that may be safe, however it is very unsatisfying.

> Alternatively, it would be nice if there was an easy way to put your
> ident into a trailer (what I wrote above doesn't really work unless you
> have those variables in your environment, and of course it's a lot of
> typing). I think you can hack it up like:
>
>   git config trailer.sign.key Signed-off-by
>   git config trailer.sign.cmd \
>     'git var GIT_COMMITTER_IDENT | sed "s/>.*/>/";:'
>   git commit --trailer=sign
>
> which is only a little more typing than --signoff, but it's not very
> ergonomic.

It does not look _too_ bad, though.

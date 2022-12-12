Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D85C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 23:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLLX6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiLLX55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 18:57:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6382F1AA37
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 15:57:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t2so10799261ply.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 15:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M30qDa0ATJEGWJcTVKcYlrbXpsCUuvo0PzqM16E9Hxk=;
        b=VRPh7Xu9CHoRMfHwG8vdKbjjUpz3PT8qADiuCfyr1OOymyGLGmwD7BiNNTwwpUH2HW
         cgEQFJizF2PxPQspc4UtvXP0W8IhXxbvpmuWX1kpP9WBRaje256ovtn67ZWj3XQIcrOa
         lUyBYqPwrmCbaD+wW6/7DeWPMOf8U+L4HAW5LnAvdx0eAD0/BrXWsCr3XzjVyrlFRHdD
         4CppBZ/iQDGsef5MT5zypvR4fmUBOSm0Cc27lLtLjTUZPP1saOzYVqtT1vYm2qTReoo/
         67vShDHfTj+NJSQmC54m5GTOubrRusoU+BWBBq60i856XTx83fJJG4i8Emp9aKnLW+ZM
         xWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M30qDa0ATJEGWJcTVKcYlrbXpsCUuvo0PzqM16E9Hxk=;
        b=sKTBf+Rnsr5laV2gecQULLCfrXnJeSWK6EPr6jHvUo6qdwlt5c/LWU344onQ36v7Mp
         yTrUeVKMh26mFZsYj5+77vgxdzdJTRS9xO0aLOTpm6/Bq4x3wvc91296Wpa6n8T558+P
         Ls2PPYK8UmuK5kJUehzxtRWHiMc07M6Qxrp/35nLPx1WXPjCL9F0/ypqSRnWNIE4zG1V
         h5cG9hw8Bx2IZFviht6mJhPFSCE+S/NXLJkq/ZVoTijQ/RIPOL0yR4VwePG0TRCbQ9Zv
         TZXaQzPgsgGzZoJQ0M72Cwu+Nr9JRfSEn5j7KlHdB6QFnrtRsjdR4Pbs3jx9GrlSfgex
         aXCQ==
X-Gm-Message-State: ANoB5pkaoJ7z8tsA4olAiSwy3CoTSI1k+KDaYB0P8FspU+/e5fU862hQ
        HGqlD2pD/8HsDPnBnlyeCMo=
X-Google-Smtp-Source: AA0mqf4mGx8mSTbItCPvjh/Ay1BPh3tC4ReN+lLYq7xYCGWPu5KXDdhgT4tUAjW4WsUfbbrJj/fTgg==
X-Received: by 2002:a17:90b:1891:b0:219:9a7b:b6a8 with SMTP id mn17-20020a17090b189100b002199a7bb6a8mr18199059pjb.32.1670889475772;
        Mon, 12 Dec 2022 15:57:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a035b00b00219186abd7csm5995445pjf.16.2022.12.12.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:57:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
Date:   Tue, 13 Dec 2022 08:57:54 +0900
In-Reply-To: <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr> (Johannes
        Schindelin's message of "Mon, 12 Dec 2022 09:32:38 +0100 (CET)")
Message-ID: <xmqqtu20qinx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The hard-coded object IDs break the `linux-sha256` job, as pointed out in
> https://github.com/git/git/blob/6ab7651d8669/whats-cooking.txt#L522-L537.
>
> Please squash this in to address this (Junio, please feel free to
> cherry-pick this on top of `tl/ls-tree--pattern` to reduce the number of
> CI failures):

These days, I gather topics with known CI breakages near the tip of
'seen', and push out only the good bottom half of 'seen' until such
a topic gets rerolled, at which time it gets added back to the set
of topics pushed out on 'seen' again (and then ejected if it CI
breaks).  I excluded the part with the topic from last night's
pushout.

By the way do you know anything about xterm-256color error in win
test(6)?

https://github.com/git/git/actions/runs/3676139624/jobs/6216575838#step:5:196

I do not think we hard-code any specific terminal name (other than
dumb and possibly vt100) in our tests or binaries, so it may be
coming from the CI runner environment---some parts incorrectly think
xterm-256color is available there while there is no support for the
particular terminal?

Thanks.

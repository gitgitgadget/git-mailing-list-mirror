Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA2C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 16:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCIQvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCIQu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 11:50:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA8FEF36
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 08:41:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so6852413pjb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678380090;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu9mmJE4gXs3vevjsqOpGLSVUsd0VOr9oHdUjFATqww=;
        b=d44pCTM22QChff+ZVV2ai/eu59KrwUICPLWL7kOb8QNos4RH82nQAwszwK4kQEYhIN
         10MflatcLRi7wgHt4i9OHmAJI1ctITqhtZh7Elf+EhTVSBQd0sEMpad3nG7fVB/dyDH5
         Jtt1zbA18TFSl4FSycZtjkBFOfOWCZ5SSOwlp68Tsvz9V53F70bBVQE7EugT7rlkVtxz
         B+BuUKAgpba7UhgFSN8zFZXXltsfNHJBnu6lN3vzUItUokwW1i62n7HYnvFuIneTn41k
         grEit19XVnMJyZTdwjYc8cGTaq7p8IqK76JimABVy8WoAoBY1dAihfH6qi3zPEbpgDUV
         O6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678380090;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fu9mmJE4gXs3vevjsqOpGLSVUsd0VOr9oHdUjFATqww=;
        b=LlHt16tYZqCFgMpZNSPm5R7qQOHBHRrVH7J15rxtCoNM76cu8LQyoO9J5f7gDZz6c+
         Z/4MSh4vV9Oirkx83AldmH5VECMaRvZ/7Fhiy4r2Mza/XQAfFzaGCbxy0wfii2vV+gwF
         9TSr75qUg8bTN1Qu+tyGwG7c2P7F1W96QXKc8l/FB++578OCsLrcknubqHknKnGsx/e6
         7gKWspkfQV1exjg0e+TjvQ9XnzOEPvkc+gTv8hgcL8RNe9MMG0Rm2qW7mnzIlk6F2E4m
         zWiBdk9kRAfz67WT7dr1nf8C7QQOiROH4mHS0KngJzJAnFNQkNrkTxac5gnZN8WnGdO3
         i6UA==
X-Gm-Message-State: AO0yUKXfIUaDojYUeBIBnleuKZnDZhuLFz1cnGNuptbRchZNPz9+Los6
        AOU7qyf2oI0fzDM39PbGpXlnBW08tuo=
X-Google-Smtp-Source: AK7set/I/Fixh0oWDWjlh3DRApZarbBjtkuUfT0FZYzt36kGpoCr8hgFPpq9ZIyah75d6ZbEHPz8bw==
X-Received: by 2002:a05:6a20:1e5b:b0:cb:9db3:e5e2 with SMTP id cy27-20020a056a201e5b00b000cb9db3e5e2mr18268792pzb.17.1678380090128;
        Thu, 09 Mar 2023 08:41:30 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 6-20020aa79106000000b0059085684b54sm11857047pfh.140.2023.03.09.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 08:41:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] format-patch: do not respect diff.noprefix
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 08:41:29 -0800
In-Reply-To: <ZAl4pZV08a6Bgoip@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 01:11:49 -0500")
Message-ID: <xmqqy1o5op1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - if a project really does have a workflow that likes prefix-less
>     patches, and the receiver is prepared to use "-p0", then the sender
>     now has to manually say "--no-prefix" for each format-patch
>     invocation. That doesn't seem _too_ terrible given that the receiver
>     has to manually say "-p0" for each git-am invocation.

It does seem very terrible if any existing projects do use the
workflow, as their receivers need to change their workflow, though.

But we can declare that we do not care about such projects that do
not honor our -p1 worldview, and I have no objection to this change
if we can have list consensus for us to go in that direction.

Colored patches, by the way, cannot be applied, so perhaps we should
disable ui_config altogether, on the other hand?  I dunno.

Thanks, queued.

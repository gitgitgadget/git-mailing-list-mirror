Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E68C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 03:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAODtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 22:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjAODtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 22:49:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1EDE3A4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:49:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o18so4945733pji.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHf0U4ELlV/bvE+uUgUoLGU8hZOxs7Y1pDqysD02AHQ=;
        b=IN69zjnksZyXn3A/ZNhGiKA8ZPxsRi5jwhro2pat0TWK60MNpoSdz1q/zU2QOLtdpB
         sxesJMTI9oUo/3ec/APww2T3fPSLG9cxeDUAWcBsEtkJHFj0ArQZODTintfZX5TBP3My
         XlFSIy8Qpw+iJbpENNoQ7hnwxRWLSU+ZIWcR9O0tGeQZ1TT7lAfihKfIdFJHm2M5kiEG
         0na7+mnfRSKe7pkulzo5uHwsFUEhJeHHoLn2WRVHwQK95ZnJbZj0BDzSBfso15RFumjB
         Ro99Kn1iBjJGj+6ak+h/2qn4acsDGCCSrgU4FnNMdv3QbiORz6QiSzb9aY3uAE7yCLxx
         uRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHf0U4ELlV/bvE+uUgUoLGU8hZOxs7Y1pDqysD02AHQ=;
        b=1zVf2ikghRq05I6qVORNKTGpl/jROqhuH+zyI5IBkUlVHJV6boKIE4tddCMJWiqvsp
         Dn3O0IlA1OED7W1grVeoao6fyc9/a24UjhI5vrCMu86e3ABuGWc+DeZOQPUZ0xZoVuEN
         NP96sdQ3P33qG+qFjUQhCQ8uR0iHETDdSe28T9I8SVFjsdMF9cOpEWYwpMowPfxxtAWQ
         3Tqez1u3W4HIvWHZ3dIZRzXs5SXPZawkGFA7G0gbACDtuJzb9UDVbxk/0M0jY+l/rgsn
         U4U3PM9yTsAaM8a73TtdsoYiT1Zv0XUE7vaTwdiFfWbRHrTJHJREuqrNrAhLza52wIHt
         fIiQ==
X-Gm-Message-State: AFqh2kqFmgfbRpcGWtGcH0eCGYNvA0HnPARoAvLCldjzQ3pAnOdLIpTv
        6v4ntbJVMDri7PhHCvVW2nk=
X-Google-Smtp-Source: AMrXdXu3pvatv5ORkPFwsg/F/HWkCuwNJDQu6wZrm9x/2yUOErL29MuSF4SkD9oDfEDPVpcYWJN53A==
X-Received: by 2002:a17:902:6ac5:b0:193:3980:98d5 with SMTP id i5-20020a1709026ac500b00193398098d5mr17931859plt.57.1673754548477;
        Sat, 14 Jan 2023 19:49:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00192e1590349sm16530224pln.216.2023.01.14.19.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 19:49:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Jacob Abel'" <jacobabel@nullpo.dev>,
        <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmaso?= =?utf-8?Q?n'?= 
        <avarab@gmail.com>, "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        =?utf-8?Q?'Rub=C3=A9n_Justo'?= <rjusto@gmail.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230109173227.29264-1-jacobabel@nullpo.dev>
        <20230109173227.29264-4-jacobabel@nullpo.dev>
        <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
        <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g>
        <013701d92893$3fad5d10$bf081730$@nexbridge.com>
Date:   Sat, 14 Jan 2023 19:49:07 -0800
In-Reply-To: <013701d92893$3fad5d10$bf081730$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Sat, 14 Jan 2023 22:41:21
        -0500")
Message-ID: <xmqq8ri4ihjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> I am wondering whether --detached is a more semantically consistent option. While --orphan has meaning in checkout (not one I ever liked), detached makes more sense as a description of what is intended here - as in not connected.

An orphan is not even detached, if I understand correctly.

The state is what is called "being on an unborn branch", where your
HEAD does not even point at any commit.  HEAD only knows a name of a
branch that is not yet created but will be when you make a commit.

While "(HEAD) being detached" means that you are on an existing
commit---it is just that future history you extend by making a
commit from that state will not be on any branch.

So if we wanted to fix the misnomer, s/orphan/unborn/ would be how I
would go about it.


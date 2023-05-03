Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C46EC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 15:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjECPzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjECPzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 11:55:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AC5591
        for <git@vger.kernel.org>; Wed,  3 May 2023 08:54:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5208be24dcbso3656018a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683129298; x=1685721298;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS6o6bONbb0WLzayAMFdlEEady9T+933FLDdc5GCCSU=;
        b=RmtFRL8JayV50gOJsPwIz0joa9sdo4lqn5TztDj6r55mhz5h/DspKrezWr/AxTIF6u
         vqWtMr4RLqTd2KhvZ40n+Gpdq0TMSRJyVmZ3rOY+6NT2fgDMyCkazP87wLpFDPZ7FA3p
         /WpbJxHsnQTApTtDcNyFVPAotFwDToEJ1ynEsVwcVBaFw1JKjdCh+DoHy/JnyOeT9hGD
         V1D8SNK0Z/eSiiuCQDwNtpX7X2VMyv0TI+5wlQg7nlNkOk/J87Psi22R1eyY7hq/AA/R
         nvxlRgkVHEx1cf+08mBRLkqCdmeE/iZjQZvQpibKHWqtPvoCstKkP0p2SRraCYdjvDTv
         y0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129298; x=1685721298;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zS6o6bONbb0WLzayAMFdlEEady9T+933FLDdc5GCCSU=;
        b=fZNnnKY1zIUdgWmMsD3U8+7ixs+XSmasNEE+ouK4ulHPhzjoQaICC+//w8Ao9eZVwh
         GnBkGFcdEPPF0hKJsh2DNRs0lCIlXz8+leb9YZrFkezYt81drP6vTbJLe/Z+yvj9GLMV
         QZYhbueDH1CPVr0NFoe5aMCQX870Zwtm6nVlRun5fRhf13ZlDCvVHX756U0eLuxgfgIw
         5Pywk0373pXyEEsYofd8a/ZrlKF2p0bq9T/YxvBvMAdyeExLpCMAWT+RWCML/XLhU/X9
         j3YR4+Eo/lkxAmWLBZ2k56Lfys9E1fSC5RZzfhUFtzYjCJGLDHWssFVM2MVgiX6DPRew
         yzDg==
X-Gm-Message-State: AC+VfDw/6NqxbLRcHk6+atGaOIPBslUC61QxhdQAPGiu5fj0jjVXjbkI
        I0hrKAaPpvhGgnFT5ap3ILc=
X-Google-Smtp-Source: ACHHUZ74UQq2ryqcX8lpIhAgtRhZar6inoRPFvJFLKk7s1NQVmTraOSsSeIWW7cTFOdpOpDpZb0xRQ==
X-Received: by 2002:a05:6a20:9191:b0:f2:4d44:3560 with SMTP id v17-20020a056a20919100b000f24d443560mr27770830pzd.19.1683129297896;
        Wed, 03 May 2023 08:54:57 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a6c8200b0024e135c2ea1sm1572737pjj.18.2023.05.03.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:54:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3 0/6] t: fix unused files, part 2
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
        <20230417191044.909094-1-rybak.a.v@gmail.com>
        <xmqq8re74t3j.fsf@gitster.g>
        <CABPp-BFCBPTBc9savP13gNFmBo_WCnZHUv_Z8bWE6T6GZOrs-Q@mail.gmail.com>
Date:   Wed, 03 May 2023 08:54:54 -0700
In-Reply-To: <CABPp-BFCBPTBc9savP13gNFmBo_WCnZHUv_Z8bWE6T6GZOrs-Q@mail.gmail.com>
        (Elijah Newren's message of "Tue, 2 May 2023 21:11:16 -0700")
Message-ID: <xmqqfs8dwgtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, May 1, 2023 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Andrei Rybak <rybak.a.v@gmail.com> writes:
>>
>> > Creation of files from redirecting output of Git commands in tests has been
>> > removed for files which aren't being used for assertions.  CC'ed are authors of
>> > the affected tests.
>> >
>> > v1 cover letter:
>> >   https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.com/
>> > v2 cover letter:
>> >   https://lore.kernel.org/git/20230403223338.468025-1-rybak.a.v@gmail.com/
>>
>> This round has not seen any further comments; shall we consider it
>> pretty much done and ready to move to 'next' by now?
> 
> I think so.  ...
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA74C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjELUsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbjELUsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:48:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234111733
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:47:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52caed90d17so6474750a12.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683924477; x=1686516477;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WbZxr29ai5Qvrii7e1bzR2ctn5F/xYxZ+6lhKxeoHw=;
        b=DiolpzWpWgI4gV6Hn62AxjloAYY5qNDmPjwTDhxdPV8bdfz7hryXibBGCr2TTaUTy5
         BnuOC+KxzpeHXMRqVY5n1apYaMX41uL6XGq2JEv0+UeuG04+1GlnyBjyrHvl08MZVCMT
         cB6/qkg8kNzP/mB+DrYoREd/ViWgtb0FtO3gOoPnn3SYwZrncCaarqA4VBfRqmvCg1ya
         QvW77xnBRew1B81cG5ugMyLYVVLk9HQbWMcaPQTUbKI0oCCOZClB/8qMchqN54aYExvy
         X1bYOLlXsywNwmORhz7gJWSTIp3vrG0lqmSolc/DVXfYbFjfdkHmpd3Qc7rDh4nyB0UY
         b2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683924477; x=1686516477;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WbZxr29ai5Qvrii7e1bzR2ctn5F/xYxZ+6lhKxeoHw=;
        b=aQJkJ/mwvVdvFtuFTHrxJdx0NUUQt8Nb5ofHPJu7f2Y4M1ASPcLB1mI7oy+m6KSZo1
         84Vq5kkg6jWXHz6uDO/L6wtkOs/pgYw8dugQPUMu8+8iXhlcVmNJYPsnRP0UQDHYw1E+
         O94ZR0gh7A055ccbTlrk8AuKJ7rTMU4bXaZROomo2Dyw7d9MoxcMTtPHa0EbBeeXNYib
         HusGxYjMeSZkRq6rqhm/LWzGAccoUiXGF6mtuLrTVYk2UwrFKoj4HWIJxemQ6PfQaVIy
         ALLILUNsUcKQO6NjK+BAPgmdpxfRYh33GV3BMQULPMXuUpBpxHXQ5xV1P0Y3TN0NXJNp
         0JeQ==
X-Gm-Message-State: AC+VfDxQDHAvIbRwHQ6k1ncz+iAYyaan26evEnvb8EIjoj/LRl8bHhIK
        yBlhTuZqgpw+7gZWrZ6/wlw=
X-Google-Smtp-Source: ACHHUZ7v+XVsSJng+xRZsRRRHnpMqzr/pubCO1PxRM6RzoldZH3vdMFx/5oB68f84UaYCNKhfddUIA==
X-Received: by 2002:a17:90a:ba8a:b0:240:f8a6:55c7 with SMTP id t10-20020a17090aba8a00b00240f8a655c7mr25525066pjr.20.1683924477518;
        Fri, 12 May 2023 13:47:57 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t17-20020a639551000000b00519c3475f21sm7186059pgn.46.2023.05.12.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:47:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
Date:   Fri, 12 May 2023 13:47:56 -0700
In-Reply-To: <645ea15eca6fa_21989f294f5@chronos.notmuch> (Felipe Contreras's
        message of "Fri, 12 May 2023 14:28:14 -0600")
Message-ID: <xmqq1qjlp98j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So your rationale to reject a perfectly logical behavior that *everyone* agrees
> with is that it might break a hypothetical patch?

Everyone is an overstatement, as there are only Sergey and you, and
as we all saw in public some members stated they will not engage in
a discussion thread in which you were involved.  In addition, at PLC
I've seen people complain about how quickly a discussion that
involves you becomes unproductive---they may have better sence of
backward compatibility concern than you two, but they are staying
silent (they are wiser than I am).

> Just do `--silent` instead.

I am *not* shutting the door for "--no-patch"; I am only saying that
it shouldn't be done so hastily.  Indeed "--silent" or "--squelch"
is one of the things that I plan to suggest when we were to go with
"--no-patch is no longer -s" topic.  But conflating the two will
delay the fix for "-s sticks unnecessarily" that is ready for this
cycle.

Anyway, I will be wiser and will stay out of this thread from now
on, as long as you are involved.


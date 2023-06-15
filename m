Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D2EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFOTQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:16:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163BC271E
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:16:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54fba092ef5so2383155a12.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686856559; x=1689448559;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5p9uRsZ2nwHcoYKjPvNrvxO621U+4DK4hKeqDSlU2M=;
        b=JNP5nMmwzlqFzG+OGK/DxD+mbZZErQ2oaB0+Zq1GmR90x2yjfsDQMfTkINejCui7zV
         21C2QCK8iLVK3H2aHKbEJucFtQM8DER0VDUixcpkxT0lM6ee7kaX6g4GiORz+uCcOl8+
         dev/nvcWukEJn/QDkY1pgQKU6/7JGFxNW78BZis2su5rsD5OWOSh6opcIm7K5+Lz5aNL
         huSLbqqD6NbLpQB2JpgKdKvDXZ3wR+vUJtO+2Zmv1gIE6WhMUASoMvWDlI9F55te/O4Y
         +9XQeRKfM1OhVm6jPnI6TuL+EDah62sO2qCPVFC2GVqamgq/VT4YaLd8CEnGAfqkYSO5
         yFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686856559; x=1689448559;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u5p9uRsZ2nwHcoYKjPvNrvxO621U+4DK4hKeqDSlU2M=;
        b=UhPxFWXr8PB8XlFkQ5sC5nR1gVCkU/ELPqkTMK02jtSv8MGKK1w0fDiGSGfAKztJcH
         TeVims/IlDZlPXyykLicM+mSrMP++VqewddqV0/AgI+Ccyo559FOvGCXyImKF1SrG0ay
         0opyzRjeKAtLH0MfRyAFVJePQWxkFRM5rNtt2A5Xi8uvdDyiS6O0NPBmATnpi5jSEGsd
         QNUkjaUWv2/UPf64UUX8QWCUOBAH2zpcG6besvR+SqnqwRQ/T9i+i+i14i1TEyUS6l8O
         JAdDGLjsYEw2wESzTcMD2u0yNUeZOogunrC6FBEvSdJb0eddwU3m3i1sJ85fKbvXQnAK
         WqWg==
X-Gm-Message-State: AC+VfDzL+7+OCotHyq+IEDK67xgLm4FzcYT4ziofUMJFllZPAWrvN5gO
        Oa7QGicd537XlT7G1os4MBzkUXtxRYQ=
X-Google-Smtp-Source: ACHHUZ4pfEipV8hanC4mpm5/tTQp7/+9N5n0nxszC0L+62YoPt5LEFLMwEtsuKOdLVk6+73EDOUhlA==
X-Received: by 2002:a17:902:b585:b0:1b4:ff2a:24e5 with SMTP id a5-20020a170902b58500b001b4ff2a24e5mr5293921pls.43.1686856559431;
        Thu, 15 Jun 2023 12:15:59 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001acad024c8asm10752947plc.40.2023.06.15.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:15:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
        <xmqqh6ra26vq.fsf@gitster.g>
        <CAPig+cRzx2r34tqqi527sBcDXm3h_sLR1Y7_gX9R4uQ4KUKzFA@mail.gmail.com>
        <xmqq7cs623v9.fsf@gitster.g>
        <20230615071314.GC1460739@coredump.intra.peff.net>
Date:   Thu, 15 Jun 2023 12:15:58 -0700
In-Reply-To: <20230615071314.GC1460739@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Jun 2023 03:13:14 -0400")
Message-ID: <xmqqmt10v8nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was not following the topic closely, but I think there is a v10 of
> this series anyway, so you may want to eject it from 'next' in the
> meantime (I had assumed you were going to do so as part of the
> post-release rewind, but it looks like that happened already and it got
> re-merged).

I can do the post-release rewind again ;-)

I somehow had an impression that the topic was more or less done,
but if it deserves another chance, let's give it one.

Thanks.


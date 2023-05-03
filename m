Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A03C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjECQHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECQHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:07:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E905591
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:07:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf706768cso31175255ad.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683130020; x=1685722020;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVQixacTdnnQ4X6QUycqUJx1ATIg0VKoiGOfqoLEW8k=;
        b=ESOtzPI1h5RFNct5mzPgD3h6GQojQVkdkKc/gxgNP8oJIpeLpP/TOoIIQBcQkznSvg
         I2qWbAgTVdltMtGxi6UxWiHx/pYkIK3cgIingjXqwDUCE4uniKCAjAMpVJP+HDEhZISy
         LoKX9ScTfT/lBaWQX8mzK1Ctnacxi+dX33KQihmQb/fDSWhBj1ZRwRjqH41vkyOu91bI
         uTTP8vQZsHN0N9s44GF0PX1hhaLWLZHpbuYKWg3B2OtYBNBSZzFTKK//M8YKfPRpD4b/
         iADQcaC5F4bJrrGXNYq2s4BfVmWPLXtVO/oQ7tHKjUPWTEZQNViYhbmvcOZB53SgiFOD
         ARDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130020; x=1685722020;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVQixacTdnnQ4X6QUycqUJx1ATIg0VKoiGOfqoLEW8k=;
        b=d2w7YKeCImWGT76YzoKnDRLMt4SY5jxfHIRlo9XVmHItSAgznzZF4JQApKk868RK5f
         fdArwLwM2gH8HIlu6QQoC/BT4kGize5bz8IcB8/xGA98U3EJgI19EXJjw7EW6woI0dT6
         ItVQYgtK2P+pe3EY5QEUDC31DtouBRN/9dreK3e5BJ+KhvTTrb2UEoOs0p24K8B3DCq+
         vBvvi1ppyo/rUlfu/tDiWbtHx2cKlNne1LQO+XvlvZ4Vx5ETCB1AmHgvy6Ef6UlfTR5d
         +/Rp2SgFqem33wycYH2493MPUiy6RU/p4CEPumDMon3DkTLw2ojSFUKYUpEkG/c2KPty
         Ppog==
X-Gm-Message-State: AC+VfDxNZ9InvzHgL9DsZhJ0T+dmU8Xw5IV15BOubmoNdmmBHV20KcKE
        iGm0uXGIw7x9QjJhU4T4k50=
X-Google-Smtp-Source: ACHHUZ4DxQ7bpaKC6a4mMe7NX4SpWn4OqQAN2GTha7o55gg3JRUL2mgvTnAOzWZz0eWahS7dbGtSuA==
X-Received: by 2002:a17:903:494:b0:1a6:bd5c:649d with SMTP id jj20-20020a170903049400b001a6bd5c649dmr570996plb.56.1683130019556;
        Wed, 03 May 2023 09:06:59 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ba8300b001a96269e12csm18545881pls.51.2023.05.03.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:06:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 1/1] docs: rewrite the documentation of the text and
 eol attributes
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
        <20230503044656.221175-1-alexhenrie24@gmail.com>
        <20230503044656.221175-2-alexhenrie24@gmail.com>
Date:   Wed, 03 May 2023 09:06:56 -0700
In-Reply-To: <20230503044656.221175-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 2 May 2023 22:46:56 -0600")
Message-ID: <xmqq8re5wg9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> These two sentences are confusing because the description of the text
> attribute sounds exactly the same as the description of the text=auto
> attribute:
> ...
> Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
> to be clear about how they are the same, how they are different, and in
> what cases conversion is performed.
>
> Helped-by: Torsten Bögershausen <tboegi@web.de>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/gitattributes.txt | 59 +++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 28 deletions(-)

Will replace.  Unless I hear objections soon, I'll mark it for
'next' and merge it down.  Thanks.


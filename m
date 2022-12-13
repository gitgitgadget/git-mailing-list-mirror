Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B3C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 12:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiLMMk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 07:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiLMMjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 07:39:51 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A501B7AB
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 04:38:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c13so2080907pfp.5
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 04:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyRMCGcNm/hmSIoyIdGAcHNVUyp1lrbVrYstji9zzKo=;
        b=BxVzuzWAWqzSqjwopa/YlwlnT4ZU5V0Jdu/+MkAZ53Y2mKH7TY5Ao/ANE1QXUMeSj3
         6tD3j8mvl2nS8MpnaEAH1k8bvitm1JdqjjMo1Hr98yKkBymvp0lpF9XOVyl9QUgehYoS
         xKNgdn+ecZu88UC5Q5LBlGvTUf4Z7+cCo7CGOTVaW9WOgX8gMjNvP5tETdR9p2KNhkPU
         wEmXuPjdFAWtS5igYDsbJONSPy8LSb/5kRP1hrBXerTFD9RUkt0+Io1DLYnzyxEgMWOR
         PPD0JWOyunE83BlS/jgw93Y0CAGHJTP6ZKDeZz3DygQGBu4GvaR6Ohy15fnPQYDC6r+Y
         b66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QyRMCGcNm/hmSIoyIdGAcHNVUyp1lrbVrYstji9zzKo=;
        b=bWs+Y4wpZqe1nCk9q57z6JTaXy0s+18YolDlFXpm1yL9Q6ULJWITcqHtINdKfOHl9Z
         oPBE8JVZEWoZ2WwKFPHJZNNKycGRSsDceHJArI3czyZ2qUumVFpzkFL/o4CFaDgcpSfe
         GqIZCDka9yYY5LEud2krxablH7nfklCEtxALXu/ipS2LDQNN+b97sZ5vnHWJ62xwUkqU
         K6KjzQKzfI98lTWiJNhS7f0YXv3qHuBA/v+Egags/eBjueRF1hHpZvtkesT4LUHkQY9m
         v9B/4aDjZ8Ou1zXZVrKR4HIRKJ68BhPZPTslHKvztNAjMkj/Xcqqc9wFKvxaYfG/6v3b
         +tHQ==
X-Gm-Message-State: ANoB5pnHaeyDVrHNzpLus4DFFFyn9Z/RILlI2QWjz0c5uquCZ/M3txV6
        sy0aaBAa/P8bRRNfzvw7/bs=
X-Google-Smtp-Source: AA0mqf6XtEN4kZCaHLXQMitwC+CfhDgP+m3NqJe5pY8+ObmwNLCai+mYF0Tyor/coDp0lqYGj38NCA==
X-Received: by 2002:a05:6a00:2cb:b0:576:d50b:7e6e with SMTP id b11-20020a056a0002cb00b00576d50b7e6emr18620838pft.27.1670935081714;
        Tue, 13 Dec 2022 04:38:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h66-20020a62de45000000b0057524960947sm7591420pfg.39.2022.12.13.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:38:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied commits
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
        <xmqqlencqhxy.fsf@gitster.g>
        <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
Date:   Tue, 13 Dec 2022 21:38:00 +0900
In-Reply-To: <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com> (Cristian
        Ciocaltea's message of "Tue, 13 Dec 2022 12:37:29 +0200")
Message-ID: <xmqqedt3zdg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cristian Ciocaltea <cristian.ciocaltea@collabora.com> writes:

> Currently '--onto' works as if the user provided the
> '--reapply-cherry-picks' flag, so maybe a possible improvement of this
> patch could be to handle '--no-reapply-cherry-picks' to explicitly
> enable the detection.

That sounds like a workable approach that breaks no existing users.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA08BC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 00:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiLMANg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 19:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLMANd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 19:13:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BAC140D3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 16:13:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c13so1087450pfp.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zX4UJfeyeVOBmtJt4vPn4DEuLR4dVtA8JyrC27xJv8=;
        b=fB6YHzBHUCorH/XMwspZg7r5Z/cilBusPXcWK9kgTMesvi1XziWHVGiJy7aaLthU/3
         ATY8fgA6pvJJfP0vI0GGt/lAJX9lE3BLht7a0eWuou55UxZSZoR/tW0yFMJ7gOYHkS3X
         wWanCm+CcD6WUA5L2tjTwwoz1MAeFycg1DsaCJsf80Z/bHh/BUJjvqkSQQyIlLB24s8J
         l0GWv488pb0OqzTEujaP2tjjzGn0qqgomBOSKJd3XiXOy1K9lR11ch5jbPKA92koPwp4
         30AzirD0Ifj4Jf89qfGGXg8dIQrub0fdtQyvgnW48X8g4XgOvHc8+zWES169CajH2L2m
         6PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zX4UJfeyeVOBmtJt4vPn4DEuLR4dVtA8JyrC27xJv8=;
        b=Uyu6JJrlN9A5wuL72hFIzQzI5oByHgGI8mEiUYc+pVUhaa0v1rOBU1/sHPkFf7Hci0
         szLpm44hskh6nmd5HJ/ZJ9HpAvxjBq33chQvAIhIOCUtcFFYO32RlPINyeppz+WVQdG2
         zxhI7/wM7uc8W6MiIJnBNEruORfXxRPi5Ln8J29v2jm1EnwNbhhgGGtVIzVH819WyHzD
         d5MbX39h1zxVHpLH5dO6naYUxMD0Yvp8q0G+5ftlhIjl0mebF/J9YAW6TJLr4iqrYug8
         YoGyfdEfl+YokCeKgUp6fHbd5ccD410XffaG7WXc7a3Dp6T4e2nR9HXnCXqkOl7Gk5vh
         h5zw==
X-Gm-Message-State: ANoB5plD3WK5XPF3/jOgUFYwsOcVqQavZDwEq8lzRmExowfv8BI1Tltc
        J0OymjnCaPS/M+pTWYJa7LA=
X-Google-Smtp-Source: AA0mqf4DXhRM55wLZJdGAs74ToOPi6VIiogi1u4qaLPVKH37K/FXnOIx5IOVTR8XV5lezcD6jiuqmg==
X-Received: by 2002:a62:6303:0:b0:578:83f5:554d with SMTP id x3-20020a626303000000b0057883f5554dmr5236745pfb.23.1670890410587;
        Mon, 12 Dec 2022 16:13:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00576df4543d4sm6326961pfo.166.2022.12.12.16.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:13:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied commits
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
Date:   Tue, 13 Dec 2022 09:13:29 +0900
In-Reply-To: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
        (Cristian Ciocaltea's message of "Mon, 12 Dec 2022 13:35:15 +0200")
Message-ID: <xmqqlencqhxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cristian Ciocaltea <cristian.ciocaltea@collabora.com> writes:

> Let's consider the following operation:
>
>   git rebase --onto new-base upstream feature
>
> where 'feature' contains a few commits on top of 'upstream' which need to be
> rebased onto 'new-base'.

Isn't it what "git rebase new-base feature" for?  "My 'feature'
forked from where 'new-base' came from but they updated 'new-base'
so I do not know if some of what I had in my 'feature' is in
theirs. Please forward port what is still left in 'feature' on top
of updated 'new-base' that I just got from them".

The primary reason why we have an explicit "--onto" is so that
"rebase" is used just like

	git checkout --detach new-base
	git cherry-pick upstream..feature
	git checkout -B feature

to deal with a different situation, i.e. "My 'feature' forked from
'upstream', and I have a commit 'new-base'.  Just transplant the
whole thing on top of it", without having to worry about "what is
already in new-base?" at all.  After all, 'new-base' may not have
ANY ancestry relationship with the 'upstream', so "inspect commits
in the range upstream..new-base to exclude those that are the same
as the ones in upstream..feature" is not a well defined operation.


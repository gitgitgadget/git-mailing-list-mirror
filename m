Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517AAC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBASuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBASuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:50:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F93AB3
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:50:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso4208187pju.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMV5guU7K5sQFcwxYGQJKnXnXOKjxa/2nRAbfaOyExA=;
        b=K+9On4pdFoM21VptszbLVzhUYWLfjRAEENHmJy3ruCS8xcpN2SOr/FmCD7IuCR4A33
         ABGMqQHx0HSKvB6mYefY5Z2MVwbwKgyoNdArbhsLj0RXb7gr2/HIhHbQlfm85WAag6it
         1O91jnmichjAewkXGJ7fTGo7Egr3ieoP8OkcU/8fdJA3EXWDCLWaRJhD8eXLhK0H0u3k
         NTFU56w9/MA1ZsxcjyZ3eit11aDi8IBydmKXgk75vyr/IyrhWTfHLtTAUIscHRRC0L44
         8v8K6hEkWx+QajXsXW6wUUmXKstQMQXdkJscYAdiT6npSD0i9DLyZJ8bcC74jUFwX6TK
         3AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lMV5guU7K5sQFcwxYGQJKnXnXOKjxa/2nRAbfaOyExA=;
        b=pUBCmUshxlYxOXrXaqLXA/8yQ+MfpLNGz5jLtB+6NwvBCArg/FuqU3dRaiMqpO9Dbw
         iEYGc9eLrDZfrTpqx6EZkLS274zG2168UYU25aZ7edYPeOiHEGVpa2aAbBWOj/Da8NN0
         ti+n5v/JlfyWVl695bZayB68TMduhatjzTw+PZOFABIV4zqsUsFmpBdcHPUhQxEgGPrK
         k7DRXwy53v6BnxT6A7h2VI50dVd20Zrszg64Jq6m6CBhWi0XBnmuW4XS1CeqYDVsxMa6
         x51FvSaKVxLjPpELczDJfgcx1gJHhQ/ndF9JC7iqZJBDwTRPpCYKdkyWYerkkFFRd+dA
         2c8A==
X-Gm-Message-State: AO0yUKWtltpNNiR1hbyYVeaRGEJQr5ATpLGy4eHfbER+LWmi335IIdVz
        velJLcc7uUKdwbcqjhVPaog=
X-Google-Smtp-Source: AK7set+hOn2LweMJUdCeU9/Aiuuv0kZbi/zye0bkQIbQKKIGIVqhUrQ1p6xFDltfDJoTsUH9P+7/wQ==
X-Received: by 2002:a17:90b:180b:b0:22b:bae2:ec93 with SMTP id lw11-20020a17090b180b00b0022bbae2ec93mr17667888pjb.3.1675277405179;
        Wed, 01 Feb 2023 10:50:05 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a440100b00227223c58ecsm1629412pjg.42.2023.02.01.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:50:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] credential: new attribute password_expiry_utc
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
        <xmqqpmax5c4v.fsf@gitster.g>
        <CAGJzqskO0sGNtuuSkKWxknh1qv523TfA3U17X_9higDdYdg+PA@mail.gmail.com>
Date:   Wed, 01 Feb 2023 10:50:04 -0800
In-Reply-To: <CAGJzqskO0sGNtuuSkKWxknh1qv523TfA3U17X_9higDdYdg+PA@mail.gmail.com>
        (M. Hickford's message of "Wed, 1 Feb 2023 08:29:56 +0000")
Message-ID: <xmqqwn51z0df.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

> Thanks for the guidance. Writing a better commit message clarified my
> own thoughts.

It is great to hear that somebody agreeing with me on this point.

We try to write in a way that would make it clear to readers of "git
log", but I often notice that trying to explain the changes to the
code clearly does force me to realize better ways to write the
changes.

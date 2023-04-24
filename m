Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD0C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjDXVpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjDXVpf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5315589
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:45:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a50cb65c92so41138375ad.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682372734; x=1684964734;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joZsh6SeReTrLLffuLe8kQtC4PKMxpPfe8FLaEnLYr4=;
        b=Js31AQXLNOyvQVzKPV2i4nrNplW9Kb/MuYmChJxJQgBj7J0Tb4ceZZLmFuiQVQn38O
         +Us5dF62pKrUzS6P/yXoZaAjmESRKTdC2g1MirfKP2DJasa7nNImbZ+DOjSitbEswcwp
         CRGWbcEdpwPEtcbyw4q8e/VFn0iI5E7WFc8V1A7YN2VJiJiE5iTYgIdtDprebwr2+/bg
         fUwyE/n1iDkFzOZDdl4DaChgcP7Bu3c5cwQr8BBzLGhBRxLfnY7wlTc/6rdnkZXgtyoJ
         QNQFbuAo0jLDqw3kfuKA6Fot1WwOtjGF0yz1xQPefS7Ezuv+evC7pxjXYf9u3uWi8wy8
         svcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372734; x=1684964734;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=joZsh6SeReTrLLffuLe8kQtC4PKMxpPfe8FLaEnLYr4=;
        b=InIjWZ4BTHrvJ1ul77h2S3efCrO8tJNNl5xUKVxk9zFIe+a7StbkE5U2jndXAXWenR
         5fMJdGTiHBeuRQdU4+vwGz4yWTcn4ArPQQiuKBZOxxxS2W915OZ6efCvuBdXo2c93eLW
         VLXr43PmEy62ONwsKBV0lXOxlyaQNr0x+Z4QjLTBR+5/DB9SdRDDf1mgVUg1Xgv8Nyy4
         31l0q2qyJZPmR1JDG1ZxIvKAnelTbR9fBsvPXjadnH26VQn1snsKPjPHhVBSjMfEOqLD
         X7CVeTyuzkO/HyNnYNPIaCYO+W70AZslTppxXbl5kqPEifECFzb0uQA8WnF+j7gW0U+T
         96Jw==
X-Gm-Message-State: AAQBX9dL2OUVcyxyQNBE9/r+OJY3m5DvVilUs6nJAbHmmU6eI0A5IyTe
        N+jyrjNiuEiH1LKFgEh1l6o=
X-Google-Smtp-Source: AKy350bTCGdRSPrmcelkTolLJMD85rbr0k1H1FD/LKMr1Ty9OTHAjGXwwJlEpIJ/9oJLcwkizX0YfQ==
X-Received: by 2002:a17:902:e812:b0:19f:8ad5:4331 with SMTP id u18-20020a170902e81200b0019f8ad54331mr18653610plg.38.1682372733951;
        Mon, 24 Apr 2023 14:45:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902864700b001a63b051b0csm6931929plt.282.2023.04.24.14.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:45:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
Date:   Mon, 24 Apr 2023 14:45:33 -0700
In-Reply-To: <20230423122744.4865-1-maxim.cournoyer@gmail.com> (Maxim
        Cournoyer's message of "Sun, 23 Apr 2023 08:27:42 -0400")
Message-ID: <xmqqjzy19coy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:

> This adds a new --header-cmd option to the send-email command, joining
> in the ranks of '--cc-cmd' and '--to-cmd'.

It sounds more like it makes these old two unnecessary, which is a
very good thing if it is the case ;-).

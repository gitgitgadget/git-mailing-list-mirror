Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4514BC7EE25
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFIS6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFIS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 14:58:38 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33735B3
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 11:58:36 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55b3d77c9deso1428080eaf.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2023 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337116; x=1688929116;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke9uCqK3HbMQJEu8Td9fUfG7mqwX1m4nG7zWH/sbgS8=;
        b=OLcKQz89tEErudAqzu3lc4mBXiraGNwwaw9+BrfCrQnkOWcpMZdYwJOwsfSg25duFe
         j73lk39f6bjug7Zj7rQNZBfmrlOjdzc5LHdm+YzN6HPUvutkVEV9ZQHlrAJEReOrOwgu
         gFrHvU8DQZwBnggOGZ8gEfZOF7hBZdKrxFH5VbZaj8xkACBJvl2t2lJUMAY2x05Ak2bP
         cB+uXcemxQ/SHpTXtk2NDmyUxPoqNeIBP0i+AdyEGEN3+96hogUTblb4gW3QTe8xlXCv
         iAcinpBftclPM14dHAczsQRi+UQCIED5UshGCbmHPKW3R7gBT6EU3RLRBqL0psSqXlKK
         9dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337116; x=1688929116;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ke9uCqK3HbMQJEu8Td9fUfG7mqwX1m4nG7zWH/sbgS8=;
        b=J7FVhBjEigaWlg6NZrJVmsjt1Ohf/yHlp5yBQOQDP8e4cQcI0Y74RWHlDwmXsNKINA
         ONNB43vFMsB7RVZdaTpoUEpiCB1BLAlVCHZblyLfjWiCS3/YZmxlK7fUZRJ/qkexyeW+
         YVCFXvUVc0oJOpl/uwi+oRz/Ubo5mAlKeoT06RNnhzrz0H7WeCnPt0ZjBmCpB1sbC96b
         DkiNIc3obEhTTL5XjcjHuIt9JsKawQ0JVIfytzonX5hg/1pl+KJxHtzZee6oNb2JEi4r
         5FKeWYToquDeMsC6sWNVsgqYpw0PcTMQuWUpIhe1jmJ/PR3TNSLxJA/V0NcYSn9tWSna
         7P7w==
X-Gm-Message-State: AC+VfDyiSSH9coNqeZXn8t3XdGGUCqqyfZVR0fS3uDiLkC3ef08kq1i6
        F9VPOJ1OGfxhVyqQdoKqZZE=
X-Google-Smtp-Source: ACHHUZ5JJi5w0lW6ZiCtdwFMndVl2JfMn8yDPo1r83zkPCcipSdkZjz8mgpiiScEFG0ytprjiIfJGA==
X-Received: by 2002:a05:6358:c09a:b0:11b:3e4d:a203 with SMTP id fa26-20020a056358c09a00b0011b3e4da203mr1829340rwb.23.1686337115690;
        Fri, 09 Jun 2023 11:58:35 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id p25-20020a631e59000000b005480e2e8ae6sm3065625pgm.67.2023.06.09.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:58:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: Anyone know why git ls-remote output might be corrupted?
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
        <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
        <e6f9334dd93c683b97ecdf61eb06bbe28b0a4e30.camel@mad-scientist.net>
Date:   Sat, 10 Jun 2023 03:58:35 +0900
In-Reply-To: <e6f9334dd93c683b97ecdf61eb06bbe28b0a4e30.camel@mad-scientist.net>
        (Paul Smith's message of "Fri, 09 Jun 2023 11:33:42 -0400")
Message-ID: <xmqqo7loo42s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> I also checked and indeed, the git ls-remote command does print to both
> stdout and stderr as part of its "standard" behavior:
>
>   $ git ls-remote --heads >/dev/null
>   From git@git:myrepo
>
> This is unexpected to me, although of course there's nothing inherently
> wrong with it but usually you don't expect "regular" output to go to
> stderr.  I suppose the idea is that people can run:
>
>   $ git ls-remote --heads 2>/dev/null
>
> if they want just the output without the header.

The above sounds like a reasonable expectation; then the issue is
there are some fflush missing when the command writes to one stream
and switches to write to another stream?

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F4C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628E864E24
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhBQLIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBQLI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 06:08:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D5C061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:07:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g20so7247540plo.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hbab1jeLN7HlZdJbwuM/DkNUm6uw0cvzUnf26IZYGIU=;
        b=Gk7GLemtz4/181b3fQLT/50J8f3EhMApWn9YAQHbw8jfAt9QPpJuBRRM/z2J1w+kVw
         fW92VfSjtDWS1mUTUSrxPabOQj3rR6SV8Fcr765SEPncsRm90RiIQpg5GPcce/fP4Xhv
         4YUuc7vV3hxSZ5uNpd9mXcMvB+G3rF5YhL2/H9C0kOe0SM83WuKyE3KY63nDky3MKA4c
         C1d5PGWEIZvirAo4ER6VH7QQXoseee8Rq/pYkniKnv7/AAz1vMYEno5WwaFCaH2IhfOk
         G7Pcbjkm8QgYwpsG8bAtt+tRhVr9icJqo0n4P/KxqRucrvDN1eyLf8gvi6a5Xxg4bidT
         VmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hbab1jeLN7HlZdJbwuM/DkNUm6uw0cvzUnf26IZYGIU=;
        b=DeeLO/dB02H1wQn1RsWvmckeTJDfIny4/2Tm+WeF4cCs3AvEPbQwR1qAQ5nUqG8dIS
         MRQvsiBThSGA/rSeyFp6MkMoRLd05gmeh+xNBKskHD0Nay9SKSOLB3x+eKuMRP4hqZyv
         SLNFuNiMYpR1VcHlqMNmp2DhI8sUIrNcrTKDevJviGJ0K+nRINjwWcfPq5W4avvr8H2A
         ZPSDKVO2Epfwt2Xilav/QI5AwBX+E2tsDWE1jQpOqFTus9+tEsiykHFZ1khJYDXBTb0p
         OjATd/lOg9g8DL0QCC5htyIU5+uSTW2LPTwQ+VVGvwRa69qxyRWpWP4PWgUbzzLADS3b
         uRww==
X-Gm-Message-State: AOAM533jvILaAmhAdpoeBxlvKoTxJ37LbdAjytkH5RDw6RfxE94FFLhZ
        lutSb1nqmqnqGgT9Vpv9aBg=
X-Google-Smtp-Source: ABdhPJy8YflGC9ZPhjkXxjjXb0kPz91V85AfKA5gRZIYGGzyY3blSab0Yx4LF7eeQOCt1mT0IKIRBg==
X-Received: by 2002:a17:90b:3692:: with SMTP id mj18mr8597255pjb.83.1613560061961;
        Wed, 17 Feb 2021 03:07:41 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id u3sm2222928pfm.144.2021.02.17.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:07:41 -0800 (PST)
Date:   Wed, 17 Feb 2021 03:07:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v1] doc: fix naming of response-end-pkt
Message-ID: <YCz4+xPVyL+hTZzR@generichostname>
References: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey,

On Tue, Feb 16, 2021 at 09:21:50PM +0000, Joey Salazar wrote:
> Git Protocol version 2[1] defines 0002 as a Message Packet that indicates
> the end of a response for stateless connections.
> 
> Change the naming of the 0002 Packet to 'Response end' to match the
> parsing introduced in Wireshark's MR !1922 for consistency.

Thanks for catching this, this is an obvious error on my part. In fact,
I'd go as far as saying that in the commit where this was defined,
b0df0c16 (stateless-connect: send response end packet, 2020-05-19), I
erroneously called it a "Message Packet" when I meant to type "Response
End Packet", which you are now correcting.

> [1] kernel.org/pub/software/scm/git/docs/technical/protocol-v2.html
> [2] gitlab.com/wireshark/wireshark/-/merge_requests/1922
> 
> Signed-off-by: Joey Salazar <jgsal@protonmail.com>
> ---
>  Documentation/technical/protocol-v2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index e597b74da39..6c55d566d8b 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -33,8 +33,8 @@ In protocol v2 these special packets will have the following semantics:
> 
>    * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>    * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
> -  * '0002' Message Packet (response-end-pkt) - indicates the end of a response
> -    for stateless connections
> +  * '0002' Response end Packet (response_end-pkt) - indicates the end of a
> +    response for stateless connections

A couple of aesthetic details: I see that these changes are based on MR
!1922 so if you decide to take these suggestions, you'll probably need
to apply them there too.

	1. It'd probably read better as "Response End Packet" (with the
	   "e" capitalised)

	2. The mix of underscore and hyphen in response_end-pkt is a
	   little odd, although I see that you've done it to make it
	   match the surrounding code[3].

I think that I'd prefer if 1. is taken and 2. can be ignored. But with
or without those changes, consider this patch

	Acked-by: Denton Liu <liu.denton@gmail.com>

Thanks,
Denton

[3]: https://gitlab.com/wireshark/wireshark/-/merge_requests/1922#note_502316230

>  Initial Client Request
>  ----------------------
> --
> 2.29.0.rc2
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE751C761AF
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDCQhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjDCQg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:36:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA432120
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:36:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y2so19585624pfw.9
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539817;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou3IRZnzTRPrdMIKNdU9nqTGJffhTLohAZuelYTyXhQ=;
        b=bTErinmP2Z2S9ccYOELtBPJ4Bo9iG0iJyzxf+LhDHMYXuSygg5QVu6bPkP4/S6/jfH
         6xoIcHdI8gNSeQWjJniXug6ZbucYGO2UZbdzsJZk82SCenVmLoDjQ//VECl1u1bEjxfC
         4uOHLd454BygXqGjOY4mn34R4Ke3Ml3wM2SMrFBjAeFK5FVqFJTp0typDLdSs1/DuN7O
         PsNqXiDSV1u4pyG3G64VKltqpwyaMyi2aZV80EWdPjyfHe1xVrHwoQqOrrFGHoRK1fgI
         iFdKjNbxgw1nk2WfWS8PWFN27muasai590zEQaocFo6xUVNxzNL/ye8GgpGguRFHikCe
         fVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539817;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ou3IRZnzTRPrdMIKNdU9nqTGJffhTLohAZuelYTyXhQ=;
        b=3K31VTYV0P8eHCkiVeecpIbGZtPdCgW8jlom6e0+FlhjgnuIlk5e6VfRfA2oHhWK91
         fqIWe7b7tyz7s9kTjywOjJerT7UerindsKQHZ6gBjAJqIgaBQPIrRnwRD6bwGR47nHlc
         fYVGBpVcnSAvkE5jIoJq/bsL7Onp6FzaxnI13o/+j5hayja0+Wt1p2NG6/TeVeZXw9Uz
         AIUggcaJepy4HSdOJ5/et12PZtD0B218NVA8Uvtw/BptiZa8W0c3hOkzOZ2EjefNB+Ds
         /1rDOlGixUrUsqW2elgGN+E5b1l/IKbZQthSopXLNaOAZDnKnYuJ7oAWIRiZZjpNKUdI
         TUpg==
X-Gm-Message-State: AAQBX9d72ubEBlAUDRs3iN7iAbRK/F2IBg86qvuepyLtjzv8RJAcWcGb
        HopAEc00hOHiIZWaxtea+MI=
X-Google-Smtp-Source: AKy350ZPmGcaZwGlJ+DhNI9EfSg6i+I2aQG/In2knTlx4fydkck8yOZlIkSISmiuSdoelLUPF866nA==
X-Received: by 2002:a62:1c83:0:b0:622:dd9b:e2d8 with SMTP id c125-20020a621c83000000b00622dd9be2d8mr30195149pfc.3.1680539816789;
        Mon, 03 Apr 2023 09:36:56 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0062e26487e7esm613464pfn.155.2023.04.03.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:36:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Bruno Albuquerque <bga@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] object-info: init request_info before reading arg
References: <20230402130557.17662-1-worldhello.net@gmail.com>
Date:   Mon, 03 Apr 2023 09:36:56 -0700
In-Reply-To: <20230402130557.17662-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 2 Apr 2023 21:05:57 +0800")
Message-ID: <xmqqsfdg7wif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When retrieving object info via capability "object-info", we store the
> command args into a requested_info variable, but forget to initialize
> it. Initialize the variable before use to prevent unexpected output.

Good eyes.  We read the request packets to decide if we want to flip
the .size member of the structure, but the result would not make
much sense if the structure starts with a random garbage in it.

I wonder if we can tell our compilers (or runtime checker) to help
catch a mistake like this.  Did you see our sanitizers complain, or
something?

Will queue.  Thanks.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  protocol-caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/protocol-caps.c b/protocol-caps.c
> index 874bc815b4..94c51862c5 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -79,7 +79,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  
>  int cap_object_info(struct repository *r, struct packet_reader *request)
>  {
> -	struct requested_info info;
> +	struct requested_info info = { 0 };
>  	struct packet_writer writer;
>  	struct string_list oid_str_list = STRING_LIST_INIT_DUP;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E1E1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 04:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFDE1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 00:27:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54591 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFDE1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 00:27:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so12801795wmf.4
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 21:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m9y2muGEgkPXxVxkMFIl4ZztJk7RVj9j5MGArlQRGIo=;
        b=ocb2LxZatmvMNMpN3d3BBJ1fNyxBL+hvGt6665tBfHPlt0L3JlVHE3fxmSctUsRz1P
         Sw+hooQDPTjogwBbqKV7k5EvjjyrGgH+kywOtyZB9qMegiS0KBxvsHd3XaHdeT8n2JeD
         UlNBcNubxAZxmC/BvRhrNifSbFm9eR7pQoe4cVIfCvN5yNx7ZfBoQMraIw0HS5QQEnWG
         S4O4B7Jq07IqiI1ofe1dunGC7IBwgAR4zHAKIO050AxKbfbkfWjbmUj/CiM0yC6q7Sg6
         m+p6I/yLGDq92E8Lqt5Y7Mwn7usqZQG7Vo+uD08qY+bkW6lFQ3X18cjTMB4BT9wtgz9g
         Vk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m9y2muGEgkPXxVxkMFIl4ZztJk7RVj9j5MGArlQRGIo=;
        b=VKtWZJluvHTGwCxDwEdgPynSVOoyDGjqsG6FHOmkNdtBUWtQ1Or+2RybINV49Wo/7T
         G+hX/xCE8xak6IxsYr3QS1I4K8wyznC4IbeTG9v2OGyKjbxOEBYi1+wybAVn1Qw7Woyj
         qDzon1FG7uGdeta2AqQvAddZ9M/q5/t8vLxEc/PJXHaEDrJKiDcxojeB5yO2T4gcWm8e
         SZA1MyD1mfXuwGr4Xz7rxysAUCMKCS3NzFdkBt1FZatMQt76Ovi8jQ08cNjZGDbvcQ2Z
         MLOwN1lQwOTc5JE9n//vMFLfDIpaPQxWfUGtnyfnmYjP/RRwmwrmIJCfetrWum8fMT12
         I8Hg==
X-Gm-Message-State: ALKqPwfl5+eUxCRJyTr3OC3xQxg7oRpt0GDlbmCZGOuFm0OsBTdcj3AG
        cHnLRLiZXPaCKSV45Awcy7Y=
X-Google-Smtp-Source: ADUXVKKeeDsneSQKxbR5/xNo7p6m54h847aD8B5gTFhPqhL9r2rc2zX5oXQtir9KbR4PetIYVGt5NQ==
X-Received: by 2002:a1c:e408:: with SMTP id b8-v6mr7293730wmh.132.1528086418675;
        Sun, 03 Jun 2018 21:26:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 140-v6sm9175738wmi.9.2018.06.03.21.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 21:26:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
References: <20180601200146.114919-1-sbeller@google.com>
        <20180601200146.114919-2-sbeller@google.com>
        <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
        <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
        <20180604035637.GA15408@sigill.intra.peff.net>
Date:   Mon, 04 Jun 2018 13:26:57 +0900
In-Reply-To: <20180604035637.GA15408@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 3 Jun 2018 23:56:37 -0400")
Message-ID: <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I've looked into it before, but that causes its own wave of headaches.
> The source of the problem is that we do:
>
>   const char *some_var = "default";
>   ...
>   git_config_string(&some_var, ...);

Yup, that is a valid pattern for "run once and let exit(3) clean
after us" programs.

> Doing it "right" in C would probably involve two variables:
>
>   const char *some_var = "default";
>   const char *some_var_storage = NULL;
>
>   int git_config_string_smart(const char **ptr, char **storage,
>                               const char *var, const char *value)
>   {
>         ...
> 	free(*storage);
> 	*ptr = *storage = xstrdup(value);
> 	return 0;
>   }
>
>   #define GIT_CONFIG_STRING(name, var, value) \
>   git_config_string_smart(&(name), &(name##_storage), var, value)
>
> Or something like that.

The attitude the approach takes is that "run once and let exit(3)
clean after us" programs *should* care.  And at that point, maybe

	char *some_var = xstrdup("default");
	git_config_string(&some_var, ...);

that takes "char **" and frees the current storage before assigning
to it may be simpler than the two-variable approach.

But you're right.  We cannot just unconst the type and be done with
it---there are associated clean-up necessary if we were to do this.

Thanks.

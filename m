Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8363A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeJKIpF (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:45:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKIpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:45:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so7700881wru.9
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5JFqhTQiTqcmr2E/An5LjBv4QIy/WQpoMSIwEebthak=;
        b=iL2hLnyPRaU+WbcvdmscfJ2Ifur0PLxKWsjutjxJ3aFSlZ2Qjf3OUjhahTXm97zL4i
         Uvf/lmo9qXLKphrNVJIPjlGaQekH2rqTHGUFVcnC3/irobl2q9QQywlKi7AdTBew+QB6
         G6lKzDCDLAKlFY02nVo/EXi7Td3jl1ddNTaedKXrjaxJV/V4id8lqfUs9zA4Vx688c96
         kvzayjkILtStHAwZFezWfMaHjbI86hgKRs37NxA6mqlEngE+EWzmaUiFNkeyoOoqNous
         0SfLyarDT/Jb3A93DSfQHJGxWqbeMNqIvdi2ItrC+mYBaCgzxU3srVIYuKQHGcS0VZQE
         QSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5JFqhTQiTqcmr2E/An5LjBv4QIy/WQpoMSIwEebthak=;
        b=Q7imEJMP2z/KxrjP1WdUajeBZi2AtoglN/48GKWmxcThKDis/ownetn2MJ08cKXWpG
         M1u3FKHHbg+MRRtKC3mJsSv8qCbWBawsu6VYyKdssabcP4pOXvxPPTTtdms9Diaq6n0e
         8sjpU6v1DxxEjjCUqC5oyi7nqoo5XWBNqkRgQujAzIZkUa/yShxMqpXUxVtNTjEVjdg5
         QJPFOhpqqcN23Ka+Z3Em6Nxxa1QY+5/szvYsEMvrq4EV3ivV7ChmE+xhN64m/NnlQOvl
         BFf/8KTqkOqkH4o9B7UGk0iuJKVDgKHycsyUXDV9EeBppEmpVSNeG6MJ2Wj7CXVA/pmV
         iRjw==
X-Gm-Message-State: ABuFfoi7Saw1oH7uM0SivA2qK/t3zxGDjWfeTrUvq8dWk+NIh0kkgF0g
        N5huNRKmEvSrfA1xAqwDcBE=
X-Google-Smtp-Source: ACcGV61WVV7hl2wRWCPKwtsNkK2F41jwZ4efAIwtIXpnacKuO6F37y6hezC7T+NDdIkGBu/8vOmocg==
X-Received: by 2002:adf:8206:: with SMTP id 6-v6mr25262933wrb.160.1539220814085;
        Wed, 10 Oct 2018 18:20:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b143-v6sm32852752wma.28.2018.10.10.18.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:20:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] ls-remote: release memory instead of UNLEAK
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
        <0102016657e7d068-16e15ab5-335e-4a2a-8bbb-bf2242514ad2-000000@eu-west-1.amazonses.com>
Date:   Thu, 11 Oct 2018 10:20:12 +0900
In-Reply-To: <0102016657e7d068-16e15ab5-335e-4a2a-8bbb-bf2242514ad2-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Oct 2018 08:18:21 +0000")
Message-ID: <xmqqva69i8j7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Use ref_array_clear() to release memory instead of UNLEAK macros.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  builtin/ls-remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK, this is immediately before the command exits, and we have a way
to clear and release the resource, so it is obvious we should use
it.

Good.


>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 1a25df7ee15b4..6a0cdec30d2d7 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -151,6 +151,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	UNLEAK(sorting);
> -	UNLEAK(ref_array);
> +	ref_array_clear(&ref_array);
>  	return status;
>  }
>
> --
> https://github.com/git/git/pull/538

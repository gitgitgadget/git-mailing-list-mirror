Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632531F404
	for <e@80x24.org>; Wed, 21 Feb 2018 17:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeBURlz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 12:41:55 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33883 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeBURly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 12:41:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so6834497wrg.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jZYBgal7r41pCChLxOh1GmOgLo8+gm+Nt5ZoWBEdNB8=;
        b=Oy68DE/emA4ubSSNCD+OAO1KrHZwfPShiL8dg1IVyL+0+Om3+RqxQcx5nUSYveWsa3
         UlmqkSGYA7Wjf8DglNb0xGVsJsEW7fGRzAfGEbdELnYvMTBrMpoGFPwaFog0kT7GqZgL
         t77VDrb5LQ+rNb4RMDJbrqvpa6PSTAn4/Bb0EK9BK/q4gPPQLOO5XBNu0uKeiujpGt1N
         za8AYWjtYqnRYcQVE87Z91DlarVw2zMP5p5s2vwQ80qgYlhHVqInS0IjpNsAkdhzkkMo
         l1tUzLZoyOWC6PeeevFymxtypLIylZIn4NPu49wJMS9dN2qPFNcwClwxfFVR3xCqOIAd
         f/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jZYBgal7r41pCChLxOh1GmOgLo8+gm+Nt5ZoWBEdNB8=;
        b=FI8TgL1Um1j1yovuxuYDyamaP6DboW40QJLoCc7tL1m+uFCn3INUnmBW5ujYNZobiW
         YI9vaLAdIijUtSyQUKHB2CyBKtgDIdShOqnjtKcANtkVnyHYaPzZCA1Aj/iXrXfYByX3
         Ued8vRyDX4OghmsV0543A62DLlOLCSwE2l4niYDtmQf3HiWPW7h2sYO9Sut8S9VScS49
         wslZMa6v9Ywx5PaUrp2qf0iJ0YFSEIvhcAzma0ony5A+PPyn+FPFUkf8xfoS6lFVxNNw
         Cb5AtvCXTbpjVu/x8cgGTNv76ahdvLvnwaHkE+7PnOUx/qyF11QudtrWwglOlMgTVyP7
         7+KQ==
X-Gm-Message-State: APf1xPDmeOhFAE4CN65+uYtOX6tEd2v90qVT6L9GFdpSYh7n3gPKB5lz
        fzfcDPDQRhiuec+hp3/tNUw=
X-Google-Smtp-Source: AH8x22755YOMfDVp0jiXJyPVDbaoBb4TT1bOA28T9HNYByfM8LaGwvJQr2iZN1SOha+9X+hbv73q2w==
X-Received: by 10.223.190.15 with SMTP id n15mr3914128wrh.82.1519234912725;
        Wed, 21 Feb 2018 09:41:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g84sm3971685wmf.38.2018.02.21.09.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 09:41:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] ref-filter: get rid of goto
References: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
        <01020161b7288324-d478f224-7a37-4341-993f-3c82a9941b7f-000000@eu-west-1.amazonses.com>
Date:   Wed, 21 Feb 2018 09:41:51 -0800
In-Reply-To: <01020161b7288324-d478f224-7a37-4341-993f-3c82a9941b7f-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Wed, 21 Feb 2018 06:59:01 +0000")
Message-ID: <xmqqpo4yz1cw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Get rid of goto command in ref-filter for better readability.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

It looks like this is the same change as the bottom-most change on
your "cat-file --batch" series (and is obviously correct).

I am puzzled by your intention---are you re-organizing and rebooting
the series?  Either 'Yes' or 'No' is an acceptable answer, and so is
anything else.  I just want to know what you want to happen to the
merge conflicts if I queued this while still keeping your "cat-file
--batch" thing I have on 'pu').

>
> diff --git a/ref-filter.c b/ref-filter.c
> index 83ffd84affe52..28df6e21fb996 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1494,11 +1494,11 @@ static void populate_value(struct ref_array_item *ref)
>  	for (i = 0; i < used_atom_cnt; i++) {
>  		struct atom_value *v = &ref->value[i];
>  		if (v->s == NULL)
> -			goto need_obj;
> +			break;
>  	}
> -	return;
> +	if (used_atom_cnt <= i)
> +		return;
>  
> - need_obj:
>  	get_object(ref, &ref->objectname, 0, &obj);
>  
>  	/*
>
> --
> https://github.com/git/git/pull/460

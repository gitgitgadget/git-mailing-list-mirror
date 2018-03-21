Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEAD1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeCUUgv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 16:36:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39086 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeCUUgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 16:36:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so6536880wrc.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mUTkKFWKkYoqOfeyH/KkM3zXQFrtdfayeG6pSGoBkwc=;
        b=ZZ5q4FXOrGLwPP92aLiAyp87U6amhv8daXyIgW82ulaR4fj4+J1k9G8DePJV6NNVcf
         tfkLtQu2Sn4liDxOmwkXGSYXXMtxXcFhrZA1r1y18XlhM62GljAm3brrCuchUagUnUbA
         /MHolxLuGBWPoaCTfa+NCxxfKdYkeLRuOOqbA9cWVLXPp3YPqFPMyEIm6ifAFU1TrrAq
         bgVMD97BNcmi8JvYLNZunNbl6ulfiOsUqOxJkp4eozrOP0t+LjmGymSyQtgKw016IWrs
         vxXl2UrSqUIuwpoT6v+FO7tSQ5Ufj/jIPbrDiyJ/qQsSfp1ybaE6tO65mu7VGbWNoafC
         sAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mUTkKFWKkYoqOfeyH/KkM3zXQFrtdfayeG6pSGoBkwc=;
        b=DLiIsehuBMsDcqdK8QuCJuwj+Jhe6bm0zAI4/U2YiaU6L7c4FvfVCipTyQAxMLaClo
         Rk7APAjg0WUnHtNJ4JZdiL4FHe6zT0Pbav9zmQTunuUmnvGEtDOYl5ctW2RCVp9cCRrp
         ConWgceE2uxTHfl1Jz4ZbQfywCQVfNoGhxZXCcidvGBmvyeekveqQ9ervoXrNPntZuRv
         zCszAuJyV9KSiuqibJbzMfjpkGrbAk5YNBffnx0EjdmhHr+kA6pcKeahXmDUEobQSaam
         ibmtkehAZP1TNipSRt2uP4B2nTlWWA63oWnm7kvBwWEmt4C8QxKghCg6j1A+GFu5smix
         bMSQ==
X-Gm-Message-State: AElRT7Hst5cjlrYCyelHCxO2KBPJ0IOXyhO+DZ1lhHiwz9kmCfDAw9/R
        jZ/7SQAzHyggyoQZKEvGlmBkZ4Qc
X-Google-Smtp-Source: AG47ELtGezYi5Rr3B9B43DTMd6w/0Vnn1V6jIUu7jpLRiBWJPxfoTvHakgIPJbM4hdd/nBYecf0MGg==
X-Received: by 10.223.170.152 with SMTP id h24mr16821243wrc.193.1521664606544;
        Wed, 21 Mar 2018 13:36:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f22sm10196929wmi.39.2018.03.21.13.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 13:36:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 4/6] ref-filter: change parsing function error handling
References: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
        <0102016249d21c96-29f058b0-a43d-45b7-9c1d-5ea2382858a2-000000@eu-west-1.amazonses.com>
Date:   Wed, 21 Mar 2018 13:36:45 -0700
In-Reply-To: <0102016249d21c96-29f058b0-a43d-45b7-9c1d-5ea2382858a2-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Wed, 21 Mar 2018 18:28:49 +0000")
Message-ID: <xmqqh8p9np2a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> @@ -2144,13 +2151,15 @@ int format_ref_array_item(struct ref_array_item *info,
>  
>  	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>  		struct atom_value *atomv;
> +		int pos;
>  
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
> -		get_ref_atom_value(info,
> -				   parse_ref_filter_atom(format, sp + 2, ep),
> -				   &atomv);
> +		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
> +		if (pos < 0)
> +			return -1;
> +		get_ref_atom_value(info, pos, &atomv);
>  		if (atomv->handler(atomv, &state, error_buf))
>  			return -1;
>  	}

These error returns leave the formatting state "state" on the stack
holding onto its resources, no?

The only thing the caller of format_ref_array_item() that notices an
error return does is to die even after this series, so in that sense
it does not matter (yet), but it still feels somewhat wrong.



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A68C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBMTYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBMTYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 14:24:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E120543
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:23:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so6272568pjd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeaSfsBKwUm5WNwVFfPUjoF0UtXDIUBaKPpQfisd60g=;
        b=GXeoYYHKD9ltIZoE4iQ+i4ZxdXgtq/Aage7AP7Dd8+Yyz92TFZp1H2LCR9Bk+eHg7K
         MkqEAsAXF2nLlrT2nFCGWbiTMPQKjXvmP6TA1Zw6PfsM1O+eTwriI/0cBNPLUDvVOzHu
         PASwR8Id1MTxT2CiWv1jlcaClDCJ6snziA3hszg7vGk9lU9Qwa8FtCDkA8YpSlDpojzl
         MGq8ApcI4e3N5l284pKMSis/Ku6g8ncg1VPQVfM3uIzDQNZjExLtF3SSsR0QsRykkfDQ
         OcNdpOffZDxVYbmtn6IzYtRIAJJXmfll8BvEH+kAAjoUyHfo6lL732XXprMIxGAM+liZ
         HL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eeaSfsBKwUm5WNwVFfPUjoF0UtXDIUBaKPpQfisd60g=;
        b=vWnNVMMQvubMqqq9TsaM3mjCltT6RPe5cETcz5Ju3T+/DgDuGTwMyg0qJGeS18kkPK
         1CIUWH07JIF5M384E9sNC6M0BtdAKdwxA1s7nLl9Vpx7HUT47tPMI85Hr2uSetUy0HCW
         70oVYI3037Z6yJAI5jsbEMBzyOA+fyAaRU6+p5EsJ3I7FPor6NGcN+Q8Vcpl9aN3aT5U
         sHxn4w8Puqvl9WQbdkgwYr3Av5gAclNESpqWs5PO3joOptwLjMieXqleEyiYrWknAukQ
         uGVlyMqvaMzaRXglEOmockY/gVifFnNgInV8dBMman3Cvj2aZUddnU/eZKsYEGGwZKZh
         eP1g==
X-Gm-Message-State: AO0yUKWFjdv1WimLnz4F55cccBN5LsHX6xTuLWOR3sywN+QIjw7kw/jb
        FF+hEudh6Iza+KTaJl3Peno=
X-Google-Smtp-Source: AK7set9K21EkjQFXj5TBv1fkcy83gdMKoIYamiDLwJH/7sBCp1t+h3nDG0DpAEypiHNhl0kq7ywC0A==
X-Received: by 2002:a17:90b:1e06:b0:233:d5a8:16 with SMTP id pg6-20020a17090b1e0600b00233d5a80016mr8298415pjb.0.1676316236223;
        Mon, 13 Feb 2023 11:23:56 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id l69-20020a633e48000000b004fb9250c9fasm3148950pga.37.2023.02.13.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:23:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] leak fix: cache_put_path
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-2-calvinwan@google.com>
Date:   Mon, 13 Feb 2023 11:23:55 -0800
In-Reply-To: <20230213182134.2173280-2-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 13 Feb 2023 18:21:29 +0000")
Message-ID: <xmqqk00lbc8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> hashmap_put returns a pointer if the key was found and subsequently
> replaced. Free this pointer so it isn't leaked.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  submodule-config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 4dc61b3a78..90cab34568 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -128,9 +128,11 @@ static void cache_put_path(struct submodule_cache *cache,
>  	unsigned int hash = hash_oid_string(&submodule->gitmodules_oid,
>  					    submodule->path);
>  	struct submodule_entry *e = xmalloc(sizeof(*e));
> +	struct hashmap_entry *replaced;
>  	hashmap_entry_init(&e->ent, hash);
>  	e->config = submodule;
> -	hashmap_put(&cache->for_path, &e->ent);
> +	replaced = hashmap_put(&cache->for_path, &e->ent);
> +	free(replaced);
>  }

Out of curiosity, I've checked all the grep hits from hashmap_put()
in the codebase and this seems to be the only one.  Everybody else
either calls hashmap_put() only after hashmap_get() sees that there
is no existing one, or unconditionally calls hashmap_put() and dies
if an earlier registration is found.

The callers of oidmap_put() in sequencer.c I didn't check.  There
might be similar leaks there, or they may be safe---I dunno.  But
all other callers of oidmap_put() also seem to be safe.

Back to the patch itself.  The only caller of this function does

	if (submodule->path) {
		cache_remove_path(me->cache, submodule);
		free(submodule->path);
	}
	submodule->path = xstrdup(value);
	cache_put_path(me->cache, submodule);

It is curious how the same submodule->path is occupied by more than
one submodule?  Isn't that a configuration error we want to report
to the user somehow (not necessarily error/die), instead of silently
replacing with the "last one wins" precedence?

Assuming that the "last one wins" is the sensible thing to do, the
change proposed by this patch does seem reasonable way to plug the
leak.

Thanks.

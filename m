Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E0BECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJ1SMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJ1SMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 14:12:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5622E8FB
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 11:12:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q1so5475972pgl.11
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjKZXjOAm0koSqJVSIcdwcekoh0CK8EvGKSwrNcsIxM=;
        b=Lzhoq9ih2VDBnIPAeeK3XK/ML0n8vgPItaI2doDAsQnJlLljwW6FRVbnLeqZmAW9iy
         cZ5PWA4/usGEOJQWR2CQj1rr1sog8hm2Et9jYTy68tEKGx8Vhz/bX/eKVouMlVul+QuF
         kAxnf8VViNepxd5d/+LYE03+dQStqMVuxHtqsJOjM9U8MXLRTQ+Hul62r8DpKaAZqx3R
         ICA2bCYsnYJW3sQ1twUzvbmIZp4R5lTzpz8lUh2VdxoAXR7E6xVj6dDrw3pw/W0jfxY7
         MrQUZ1IkfqevCbJFQLl40aZSEsHJrTuIbDJ5hKJ97Ce6dEycHhC5Y3Z/Mx46pjRGfS6w
         GwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjKZXjOAm0koSqJVSIcdwcekoh0CK8EvGKSwrNcsIxM=;
        b=0dD79IN1ynU31uKzou7ZZ9c+jvnKaqlrqtcqw7BQREGGcWLAmFfcQrPhRC6aY8gMez
         dOpi7BRTfUqE0+7c3mOnaN4KDkflXyW5trIjq8S7dMUQQSSq5GyeTMCmMedh/pgr9aPs
         q+BGV5ybM6HX1JJ6R3NIkATdRX3LQt40ZToPdteXJjqPsqCbiuBAflBFkSKv4BZwD9BP
         jVvRsZbvc0AojIhbxraqYCV+TgqkB0gERGyJx98joGM1zUhMJE5wS4C8M9mZrkEhNeG3
         PDsGigg/Kdm8jToQokJzIXcR1uWYz55x1rEwiKky0RRvWrqMXyxT1SHmffiivoo+2N02
         f/Lw==
X-Gm-Message-State: ACrzQf0/0f/gxDJ4OKkzxFGW6WqFLtC+yjvK9cEN36xS6n3fl6w3Gv3E
        o36egU/61qLQdrEJ7i8roeE=
X-Google-Smtp-Source: AMsMyM4yKWAyLovxGHvpYY+W6LbwDySiIu2Tir0GdbLXrMaV62FoGQelkMLA/kU+gf10VnJqHocXHA==
X-Received: by 2002:a05:6a02:281:b0:45c:2b19:a52c with SMTP id bk1-20020a056a02028100b0045c2b19a52cmr658222pgb.180.1666980754585;
        Fri, 28 Oct 2022 11:12:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f130-20020a623888000000b0056c06d583fasm3099660pfa.219.2022.10.28.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:12:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: allow supplying different view of
 reachable objects
References: <cover.1666967670.git.ps@pks.im>
        <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
Date:   Fri, 28 Oct 2022 11:12:33 -0700
In-Reply-To: <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 28 Oct 2022 16:42:23 +0200")
Message-ID: <xmqqr0yrizqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/connected.c b/connected.c
> index 74a20cb32e..2a4c4e0025 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -98,7 +98,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	strvec_push(&rev_list.args, "--stdin");
>  	if (has_promisor_remote())
>  		strvec_push(&rev_list.args, "--exclude-promisor-objects");
> -	if (!opt->is_deepening_fetch) {
> +	if (!opt->is_deepening_fetch && !opt->reachable_oids_fn) {
>  		strvec_push(&rev_list.args, "--not");
>  		strvec_push(&rev_list.args, "--all");
>  	}
> @@ -125,6 +125,13 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  
>  	rev_list_in = xfdopen(rev_list.in, "w");
>  
> +	if (opt->reachable_oids_fn) {
> +		const struct object_id *reachable_oid;
> +		while ((reachable_oid = opt->reachable_oids_fn(opt->reachable_oids_data)) != NULL)
> +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
> +				break;
> +	}

It is good that these individual negative references are fed from
the standard input, not on the command line, as they can be many.

In the original code without the reachable_oids_fn, we refrain from
excluding when the is_deepening_fetch bit is set, but here we do not
pay attention to the bit at all.  Is that sensible, and if so why?

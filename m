Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B92C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B15861C5B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGFUL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:11:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D0C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:08:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id he13so17470485ejc.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=R6p0qZ5bOaM/eOetZC6JuYVWgKiDpl9pSu3X6KVgUOQ=;
        b=cQ9KDnQjoFYz8G5hoZcG4IeuTqsDreDlwhqwqsJwPg70sGuUX6PFjQWhGdjLUJrT6S
         ssA0Oc+VMys+L+eYq2PsNQabH3ZSqm2QShx4UsaPZt2IK3R6cvkuZclakMvX4VpehQPn
         vt3gaKZfHRCGZ9QXKmZ6GgZDCVlyttcvFsnZ7PUUX6XsybSxoGHEMmlHCiemvvYZJkw9
         rLhW/kx7CiaSS6X8GUU3/0OQfyRXLzDt5SV8dECwHczC9iQMXifXMg7p7o/PyyAPy2NU
         bNamy4Jv84ZfAmPqR6OobFXYlcF+8qb65g77tjQYp8RVouZkUAvzjtM0gxVzdag1SsP/
         Gj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=R6p0qZ5bOaM/eOetZC6JuYVWgKiDpl9pSu3X6KVgUOQ=;
        b=ogz4sPCzT1B4bLV0/uQFcHA7WUMR3JkV1eQ0DpolpOQF/K77g/ztS0K7h48bEj+zoH
         2U6IE+zJUMrYEdt9sPu7+SxDAfreO5uT6P73kcZ9YpB/lfulb4WhcKjJ+aAxOqXnpn9r
         19PI08v/IOObCSmmaegO06uoQxPbqjpHuyAzWf4vqkd/eJXIlN86m/A2wAZhjnAqsG2x
         AjhTLdMOPZAKrgwzETnuwdRz5VD1AZNA2myB4dpNAKTdV9CrPz1zcuYi8eRGbR9awCQk
         97ULlKThorT6dMcnQ9MakUVkFOH25Zd895iMI+oKa61X51CCthIVwHIAlXP9qccTQUtc
         o+Pg==
X-Gm-Message-State: AOAM531WyM245n4EDUNA2Qm0oQ6Uo0TNP7u3+60C5I6BuzriLTm9z5Ml
        a4pe8U0+psb4y3ta9lD4MdPXUi7ynpI=
X-Google-Smtp-Source: ABdhPJzlBRKltbRXR0jtBLSFkqvHGZbl9iZC+U7ajK7oM7SQDNl+hs3C/Kdn+xys6KjXOK0wj6Kabg==
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr20922252ejk.413.1625602127402;
        Tue, 06 Jul 2021 13:08:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h7sm7600385edb.13.2021.07.06.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:08:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Date:   Tue, 06 Jul 2021 22:07:02 +0200
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210705123209.1808663-2-felipe.contreras@gmail.com>
Message-ID: <87bl7f5ho1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f5..05e631229d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (fast_forward == FF_ONLY)
> -		die(_("Not possible to fast-forward, aborting."));
> +		die(_("unable to fast-forward"));

I read the existing message a bit more like "this makes no sense
anymore" (correct) and the latter more like "we encountered an
error". Perhaps something like:

    "Can't merge X with Y, in --ff-only mode, would need to create a merge commit", tip_name

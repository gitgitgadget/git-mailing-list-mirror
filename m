Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56EC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 01:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiLMBwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 20:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiLMBwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 20:52:00 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D995D19020
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 17:51:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g1so1220302pfk.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyEg3+Pt5diCnL0ON9hAGHADC+1vzy1C69M/b46eeh8=;
        b=WXusC9FLUUsowdU/lKCESgcOliJkr1WxawQEcGeOOi1/VNd9PiY+n5iapVPRL3/N06
         ioET+kPCF6p6ft9jIk7ASYZrkvJzZBiBXb7rZKlMA2SG7qsisBqdcJQ3f5l/g65qL4gA
         q6bBzCuyfNwsVJqZa2lVf+5I3NrGn1cuqy9sHEy0Q4k68/NU23gQkcjzDmx3HU5ktZHA
         6n1ur68EMqTydOyVItO4iEPen1snZDsCKGEV4cnWjeuS72ta7yPTpgmGbMadTegr0al8
         wnZAeN6UQr8y7PlPdaO25r1dIHdgMCfeaxC2zFali5fokJXKmeX6gLrCBYPRB596qXB3
         td1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyEg3+Pt5diCnL0ON9hAGHADC+1vzy1C69M/b46eeh8=;
        b=7iqBxkW8feCcciZcT7OgXPDgwsR3PhG6nF6XboLdH+llSvqAzeBn5JL4V3rGgPsWAF
         Ncj5imkm3V0pOc7lor6P5QAggpiwqfhUPb5+73EXGrx26Hu35jWaQYZLITDA+CBRdVGi
         BmwSZiTQ6ge0mtFoZtxa4uzrfwpPXQ7yNB3wogS+2Eg42LUOtQij0LRyoYJNy/tKJsp/
         nVY6NTfz+N6MFxW18OFVZcAQwoyvbJYHmrb0Jx/eeAtIje6YGqwJjwyz4HRUrmwa92QU
         SzLIi78IuOZUD8ac3FSV2cla/EnvOMNlU2eZxHyD/mB9nGYlM4xCFUHKLzqzGKioieDu
         pNVA==
X-Gm-Message-State: ANoB5plhZebOeTKj/P5xKeN6BJbaJBGkv3q6p4y9GI4bfNtEXbMEl4DY
        d4YmWw1qmNdxGvumvnfkWXJRGhgw7lGsjw==
X-Google-Smtp-Source: AA0mqf7+EgHXGFZhtgogvO0gKyxBoc7DjJwA6nUoLH9r5ernyj25vkGMvbf8m7GCusrwMKbZBnaHPA==
X-Received: by 2002:a05:6a00:3393:b0:566:900e:1d85 with SMTP id cm19-20020a056a00339300b00566900e1d85mr17814140pfb.1.1670896318185;
        Mon, 12 Dec 2022 17:51:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 69-20020a621548000000b005741cb643bdsm6383181pfv.215.2022.12.12.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 17:51:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 3/4] object-file: emit corruption errors when detected
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670885252.git.jonathantanmy@google.com>
        <a229ea0b1122f55e91f98475cd7e508f4dd8501a.1670885252.git.jonathantanmy@google.com>
Date:   Tue, 13 Dec 2022 10:51:57 +0900
In-Reply-To: <a229ea0b1122f55e91f98475cd7e508f4dd8501a.1670885252.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 12 Dec 2022 14:48:50 -0800")
Message-ID: <xmqqzgbsoyte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/object-file.c b/object-file.c
> index 429e3a746d..e0cef8b906 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1422,7 +1422,9 @@ static int loose_object_info(struct repository *r,
>  			     struct object_info *oi, int flags)
>  {
>  	int status = 0;
> +	int fd;
>  	unsigned long mapsize;
> +	const char *path = NULL;

It may be OK to leave this uninitialized, as long as the contract of
open_loose_object() is that a successful opening will report the path
to the loose object file that was opened.  Because ...

> @@ -1454,7 +1455,13 @@ static int loose_object_info(struct repository *r,
>  		return 0;
>  	}
>  
> -	map = map_loose_object(r, oid, &mapsize);
> +	fd = open_loose_object(r, oid, &path);
> +	if (fd < 0) {
> +		if (errno != ENOENT)
> +			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
> +		return -1;

... we no longer refer to "path" which may not be populated here, and ...

> +	}

... at this point, we know we successfully opened, and populated path.

> +	map = map_fd(fd, path, &mapsize);
>  	if (!map)
>  		return -1;
>  
> @@ -1492,6 +1499,10 @@ static int loose_object_info(struct repository *r,
>  		break;
>  	}
>  
> +	if (status && path && (flags & OBJECT_INFO_DIE_IF_CORRUPT))

Also, here, "path" should be valid, as we have successfully opened
the loose object file (otherwise we would have hit the early return
that reports only the oid_to_hex(oid)).

> +		die(_("loose object %s (stored in %s) is corrupt"),
> +		    oid_to_hex(oid), path);

If we didn't have path and did not die, we'd end up ignoring
DIE_IF_CORRUPT request and force the caller to handle non-zero
status.  But I do not think that should happen, because path would
be valid here.  No?

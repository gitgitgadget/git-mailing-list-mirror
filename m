Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD5C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiGKOj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiGKOjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:39:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D2D1EEFD
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:39:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id oy13so4313791ejb.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PfNbJ7sJP+5vFoeNk7GK5XJyn8FRx1QZPm7ujxK/TLM=;
        b=ZEllEWffu8iML5Oy7c/A/YBymSoZGNwIfzpnBt79ev+Imhlz2GjDxHzqznMiLL0OO7
         LSZaDEyZ/pjF/i4iVPsmj3B90Scuq2DVQ1E6fNngUhdgl7sg+DbqLUopf47eI85IbzA8
         nQ1gGkFNP2Uhbiu/Cvt4Wr3z40csouVEERuK9DLP5WaGtV6s+QP4JUrG1cSHpNCACbOp
         om641OaNsmtFGiEy73QSw3gduayx0QtWEcE14vajA8YpxWWDcTy+qF6SIMhz2RzOkSCR
         7UpqdbAzy2Cxa0TLy3ZuBcUM6yIXwQ944AqllZV7oNG6skiEx9E/crxYa4lo0RZ0P+Ct
         UHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PfNbJ7sJP+5vFoeNk7GK5XJyn8FRx1QZPm7ujxK/TLM=;
        b=yKnDEu332RMzd1ggZmKym7NzSMxIRxLF0+3TMyLbp+qoy/+SlC5QBqXo8vN/mjTPcs
         bjpA+fRh/2FVK0rhUq7vt7Sp9fs6YuSW7lS5x8ihQb8H+7Gs5LwaEyEtisfiijJgpJ8k
         hcPZbv2I+yamSyXrbhtETv80e0pj2GrqDeXn/ZOgFpVdauhcQQwIrapQ+BEgwp6hdaIc
         ffDxNS97pu8/CYEf87s1JHh9Sl+rituswngEm/CS8u0Kngw6+ERJq2OnzcqTx251yc7T
         cj9YxWBbFP+OpxWgRiDZLLU2MjrzETpc0NN8LiTthgtvtjosBCipeAGCKLWWB2Vbo2ZU
         eLLA==
X-Gm-Message-State: AJIora8iCZ4Lvhvs/4kLmi4OBYD4sRs/DL5ZgaEvahHT2KNKWWuMF0ej
        u8QplVMUuWOAngDbYsxHr74=
X-Google-Smtp-Source: AGRyM1t8d6zG4aAlzVCqqV9Q90r1wSJaml0rjc3K9cUlMltlALAIv8ZxrcjDD2dbpfVvUspjstvypw==
X-Received: by 2002:a17:907:3fa8:b0:72b:5895:f54f with SMTP id hr40-20020a1709073fa800b0072b5895f54fmr4604892ejc.464.1657550354313;
        Mon, 11 Jul 2022 07:39:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b0072637b9c8c0sm2731098ejb.219.2022.07.11.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:39:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAuZ6-000uS2-EE;
        Mon, 11 Jul 2022 16:39:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 4/7] pack-bitmap.c: don't ignore ENOENT silently
Date:   Mon, 11 Jul 2022 16:38:01 +0200
References: <cover.1657540174.git.dyroneteng@gmail.com>
 <009cc49a18f2846c24256102e07437894ac16908.1657540174.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <009cc49a18f2846c24256102e07437894ac16908.1657540174.git.dyroneteng@gmail.com>
Message-ID: <220711.86k08j7lyn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Teng Long wrote:

> When finished call git_open(), instead of ignoring ENOENT silently
> and return error_errno(_("cannot stat...")), it's better to check
> the ENOENT before then output the warning.

Makes sense, but...

> -	if (fd < 0)
> +	if (fd < 0) {
> +		if (errno != ENOENT)
> +			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);

This should just be warning_errno("cannot open '%s'", bitmap_name),
unless I'm missing something...


> +		free(bitmap_name);
>  		return -1;
> +	}
> +	free(bitmap_name);
>  
>  	if (fstat(fd, &st)) {
>  		close(fd);
> @@ -376,10 +379,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  
>  	bitmap_name = pack_bitmap_filename(packfile);
>  	fd = git_open(bitmap_name);
> -	free(bitmap_name);
>  
> -	if (fd < 0)
> +	if (fd < 0) {
> +		if (errno != ENOENT)
> +			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);

...ditto.


> +		free(bitmap_name);
>  		return -1;
> +	}
> +	free(bitmap_name);
>  
>  	if (fstat(fd, &st)) {
>  		close(fd);


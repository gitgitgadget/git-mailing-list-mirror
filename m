Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6FC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC03161370
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbhDMJ51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhDMJ50 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:57:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46ECC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:57:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so24903124ejz.11
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3irkPz9Trae98uY/d9FH52DhiSatte5gLE5zWokGnKE=;
        b=OdjZDWu1PRligQLSeRveWoWT+ulQzTKbg3z8q8E+w868zfeXjwzKKGMycefcMWi/To
         yt4KrCZ/JHCN0oCZXZxcbf2yEP1gsl78+KpsORu7G+NITTTTW9fV5Lo0wPek9s9lAIsE
         AAcjVodRAexOlDSWUR2NUr3vajkCGyeY+D8RQxiwrpzE9g+z48SUC1r1yC5/8A/924Hv
         9bKkJcfEdtGBmPAkbDo6V1MhXxWlW1laAXjRdmMtC0dr7UfH2jB26F88gB+8+akgUWLM
         eePN0F48BUfU3DWfZd9pS+cgnY0X4+vpHi60wpJdcw8pM8XtHTZnH7naoOH3KSuZQ/nK
         F/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3irkPz9Trae98uY/d9FH52DhiSatte5gLE5zWokGnKE=;
        b=DhRoFspT6ZpJGpsV5g7WXEIRAl5SvlAzmVdtFHdyMGbHn+CRL2RXQNUq5M5ExE+dgk
         XUYHS9PKq+09SV4NZbajjamaTbfvZbpR/okxfZs7hwxIzkOZZMKxUtODClUuOJYf0j+4
         nzgVPabsl8iyip01TnM8FkqXDJ2AnKpJCKZCN7apgnShz6L+A1hltS8eU9uGxRkQVW1r
         1JIYnFmgD7tM9OpJgzsc+EJP1hWoH1ovqiv3JUThpqS6Pi0nZQwDSAc0ouJ/wGO+l6bF
         nO0uS/6VKnKqnF8IvdG50kP02QOWmGbIB7QS0su8fdTqc+11sVGj8Gy0Kio8wbizxtvt
         b12g==
X-Gm-Message-State: AOAM533h6vleSHVeTfYtqxGSKJ+v1AgDaUzSzaj3ulGpsCsamM7mIxgZ
        r4JtQuDL8u2C8h+pjdbA6UI=
X-Google-Smtp-Source: ABdhPJyv2r4w4G2+SF3EVT0aflcmb6l3/HJ+GB2DKNTYXopJWvoNQq/mwBVU8miuNtIxqQUTVuw9CQ==
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr31578266eje.247.1618307825630;
        Tue, 13 Apr 2021 02:57:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q6sm7898959ejt.51.2021.04.13.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:57:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 5/8] list-objects: implement object type filter
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <d22a5fd37dd793c78b1ac17244601cadd1f7c0c9.1618234575.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d22a5fd37dd793c78b1ac17244601cadd1f7c0c9.1618234575.git.ps@pks.im>
Date:   Tue, 13 Apr 2021 11:57:04 +0200
Message-ID: <877dl6eccv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Patrick Steinhardt wrote:

> +	} else if (skip_prefix(arg, "object:type=", &v0)) {
> +		int type = type_from_string_gently(v0, -1, 1);
> +		if (type < 0) {
> +			strbuf_addstr(errbuf, _("expected 'object:type=<type>'"));

Maybe:

	strbuf_addstr(errbuf, _("'%s' for 'object:type=<type>' is not a valid object type"), v0);

> +# Test object:type=<type> filter.
> +
> +test_expect_success 'setup object-type' '
> +	git init object-type &&
> +	echo contents >object-type/blob &&
> +	git -C object-type add blob &&
> +	git -C object-type commit -m commit-message &&
> +	git -C object-type tag tag -m tag-message
> +'

Does this really need to not be the shorter:

    test_create_repo object-type &&
    test_commit -C object-type blob

Or if it really needs the annotated tag maybe that + --no-tag + create
the tag after, and it can eventually use my
https://lore.kernel.org/git/patch-06.16-8d43fdd5865-20210412T110456Z-avarab@gmail.com/

> +test_expect_success 'verify object:type=blob prints blob and commit' '
> +	(
> +		git -C object-type rev-parse HEAD &&
> +		printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob)
> +	) >expected &&

Just use > and >> or a single printf with two arguments instead of a
subshell?

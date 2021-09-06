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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05361600CC
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhIFWRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbhIFWRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:17:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD72C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:16:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n11so11115673edv.11
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LREdg2UkNqospH0gw3oozAAGNiBeZPxkAkJ1rMvo4TA=;
        b=M9oDiPZGE29IVuJcenfcMlczsz5OsB7KAl7KsilS2xd/CqALVYCcpB99GSSWeR4gRy
         QMfpl5x9NFzDQ/k0cFZFo+DVWccYQMZDXVHLx90abrO6uMcTJePluvqIBPxhlQxybtHO
         lFJP3M+2CaYzAtAtvwjwHo/3Yz8Y7B4hE+50wbjEr0TjhP0Kij5L+7c7k6YzMFI4ExEj
         vENiKHhLyYc+hJZYcbiDkrq95uB934hAguKXp2y/dXanr8zWsUXaU255NO6EUHwYwje/
         hD/ipFkFSquojnDN3LnLw6O2lta6uNtNQIhhflYKoQtTSqtgXFEoRxTUrXrFVhaq8LhY
         2yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LREdg2UkNqospH0gw3oozAAGNiBeZPxkAkJ1rMvo4TA=;
        b=s2zGMqW91LWxqbBq/5ZT/JJePFFvvUUwiXztXtqARNhj63GRq1pkDHtl9sxNfdAcXs
         i5XBDisA/cfPGgODhFwKYaQqcSl3j+vrA+kpVl0m2Bs/VnX3htMB4QYWo7NDZmcRF8aO
         d82MJlYYP4oaf4yMBjcrzkJ4mc4gvhKZuMvgq5aguV2Xmz9kBu4jZHywcpvlVzSY+5X/
         ImSj/qMDDdB0SQialQHBZMW4rqHKEOszSUoKyNwnJyEPyHuKJoqIZui+Yvhwv0IZZvb3
         XXT2zMGJVRjTEGciyogNbCWZYj9FT+ZPrFGIpa3XHAWZf8I1yH9GtIAcLcG9ljEVaSQv
         XuFw==
X-Gm-Message-State: AOAM530xYTJp+Z+2jwy/udbA6jnne38SBQR9JUvNTIlfQR/3CknGIX6O
        FD5Z7uK1RcA+m0wjQbZPUaU=
X-Google-Smtp-Source: ABdhPJwHXkcZ2qrdcklKca8gW+j3hm6SdniQ64AIKBMCkFtLhBaPsHU0aAkB2Sk3t4vuJWbngCINCw==
X-Received: by 2002:a05:6402:1653:: with SMTP id s19mr15495493edx.163.1630966564714;
        Mon, 06 Sep 2021 15:16:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x9sm5314906edj.95.2021.09.06.15.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:16:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calum McConnell <calumlikesapplepie@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] Die if filter is attempted without a worktree
Date:   Tue, 07 Sep 2021 00:09:11 +0200
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
 <20210906181002.625647-2-calumlikesapplepie@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210906181002.625647-2-calumlikesapplepie@gmail.com>
Message-ID: <87lf49nye4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Calum McConnell wrote:

> As far as I know, this isn't possible.  Rather than add a bunch of
> code to workarround something that might not be possible, lets just
> halt and catch fire if it does.  This might need to be removed before
> the change goes into master
>
> Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
> ---
>  convert.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/convert.c b/convert.c
> index 5d64ccce57..df70c250b0 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -646,6 +646,11 @@ static int filter_buffer_or_fd(int in, int out, void *data)
>  	sq_quote_buf(&worktreePath, the_repository->worktree);
>  	dict[1].value = worktreePath.buf;
>  
> +	/* The results of a nonexistent worktree could be... weird.  Lets avoid*/
> +	if(dict[1].value == NULL){
> +		BUG("There is no worktree for this worktree substitution");
> +	}

This BUG() addition is itself buggy, elsewhere e.g. in builtin/gc.c you
can see where we have conditions like:

    the_repository->worktree ? the_repository->worktree : the_repository->gitdir;

I'm not bothering much with the greater context here, but if we suppose
that we have a case where worktreePath.buf is NULL, then
the_repository->worktree surely must have been NULL, and if you check
what sq_quote_buf() does, you'll see:

    void sq_quote_buf(struct strbuf *dst, const char *src)
    [...]
            while (*src) {

I.e. we'd segfault anyway if that "src" were to be NULL.

Even if that weren't the case then that's not the same as the
worktreePath.buf being NULL, which even if we suppose sq_quote_buf()
won't segfault and just returned won't AFAICT ever be the case, see the
comment for strbuf_slopbuf in strbuf.c. So I think that even if you
somehow reached this with a NULL worktree that BUG() won't ever be
reached.

I think this can probably just be dropped, to the extent that we need
some check like this it seems like it should happen a lot earlier in
convert.c than here, i.e. during the early setup can't we detect & abort
if we don't have a required worktree?


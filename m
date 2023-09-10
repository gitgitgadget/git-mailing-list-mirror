Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C3EE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjIJSkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:40:52 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9418F
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:40:47 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58d70c441d5so36759467b3.2
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694371247; x=1694976047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFosfGRqZfNtzrsx2g7VWORvLKnRsCeIdZqXbHjsrjs=;
        b=TJwF5GtzmjO/Wh//8KPBhTsErTuNr9rlfe7sUGLJU9y0iOZ3QXA2LacDu2Jk4P+Lep
         4Uu5Q0Bmxor1Hsp76rLRTPj8xhxTlQYis+YotXOJc8t8/2AM+jEAzXjbwbkoImLGNfvM
         rayVf5UNSp9LWP82jneuTjoF6Eyqo5Q96VTJStp8vtWIDeTWsaWyUTaUzU+ar8drxOcN
         uYPY91+5Ns2LqBqIil1IpDNVMdam5L6ulg7LPAZuN15O1zkP6tHtfkvOrO/hJyVvfi/z
         YmQrD5fm1KsrNpqW/CxBNt6oohnmEYmxr/MAFHaMb4uV3vEXrQXsBFGcnoyn6BeeTvyt
         H3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694371247; x=1694976047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFosfGRqZfNtzrsx2g7VWORvLKnRsCeIdZqXbHjsrjs=;
        b=FHS7tW1a/9PWjwT8ESf7HSqTbt6TL560FACvT6UXdkmv+hnsmcGCp2fjsIin3hgT2x
         YXvSkzem6Jy/2/2tXqg/R7a7a2T8FYi/49kOXwGFXWefMEaF/U60ciYnhYe/4DbOPIjE
         vwp+lbH0/eWXThhKYV2PmfEy8AVbT9cypKu7ZNQT4kysAgaGW+kOnzP3MAgBVYiayGfZ
         LqLD3fw8n/1fjyfK2OfdDL6B900KhLKFQTPDbLbxzDZ7BFYzXGgkEvR/oUPGPiHBu5bk
         uuGIuPIgM4D7H0jxxtR9cxUyHVLmUYnHpzi4vJuYstKuKWDj7/ZuMBoUtPYXUpFkwflx
         78Lw==
X-Gm-Message-State: AOJu0YzliB1FCNHGP85uMoMyzhW6mG8YNLFEqOghriDuaLaGQlcod/Fc
        xQ70WQSUWZ51ckpAsIbJPI1b2lKdlncAmsa0Nu+K8w==
X-Google-Smtp-Source: AGHT+IFlDXOAOQKjkHw54bCUc6bW17p6cafT0T/LSUloAbNoW6DpIJAqNOgkg9xRn+Rx1kGTxq8N7Q==
X-Received: by 2002:a0d:d80d:0:b0:584:2ea4:a24b with SMTP id a13-20020a0dd80d000000b005842ea4a24bmr8343209ywe.19.1694371246860;
        Sun, 10 Sep 2023 11:40:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w3-20020a818603000000b005774338d039sm1538284ywf.96.2023.09.10.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:40:46 -0700 (PDT)
Date:   Sun, 10 Sep 2023 14:40:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Message-ID: <ZP4NrVeqMtFTLEuf@nand.local>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2023 at 11:10:36PM +0200, René Scharfe wrote:
> Add an int pointer, value_int, to struct option to provide a typed value
> pointer for the various integer options.  It allows type checks at
> compile time, which is not possible with the void pointer, value.  Its
> use is optional for now.

This is an interesting direction. I wonder about whether or not you'd
consider changing the option structure to contain a tagged union type
that represents some common cases we'd want from a parse-options
callback, something like:

    struct option {
        /* ... */
        union {
            void *value;
            int *value_int;
            /* etc ... */
        } u;
        enum option_type t;
    };

where option_type has some value corresponding to "void *", another for
"int *", and so on.

Alternatively, perhaps you are thinking that we'd use both the value
pointer and the value_int pointer to point at potentially different
values in the same callback. I don't have strong feelings about it, but
I'd just as soon encourage us to shy away from that approach, since
assigning a single callback parameter to each function seems more
organized.

> @@ -109,6 +110,7 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
>  	const char *s, *arg;
>  	const int unset = flags & OPT_UNSET;
>  	int err;
> +	int *value_int = opt->value_int ? opt->value_int : opt->value;
>
>  	if (unset && p->opt)
>  		return error(_("%s takes no value"), optname(opt, flags));

Reading this hunk, I wonder whether we even need a type tag (the
option_type enum above) if each callback knows a priori what type it
expects. But I think storing them together in a union makes sense to do.

Thanks,
Taylor

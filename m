Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A3CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 17:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjISRsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjISRsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 13:48:22 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F169E
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 10:48:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59bc97d7b3dso743857b3.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695145695; x=1695750495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHI+584R95bYBD1BTCcgY0T2N8HUa0wmIFwNAkRrFg4=;
        b=Ph9h5307Z90CCU1zB5or6zujMI59igcoePea2/8+XD2WNnN97MFDnLaPTbxEW3Dngl
         UogVdt8wNAxwAXNhCRSwdI5GS3toU3Jygl0OKgD+YXzkrBTFU402Z1EymmzufpyLNgYM
         Rn18FCasxUs2Op48JAuDGiWl7vQV8jfA19DjzBRBfTOQl5FCdxSjkfGYqzdI6Up1baeC
         koviaxROrk/5gwPE3DkOX4qVpfOjeJVUD9qxMrnggGX+JyJGyRZaNjElg85TVKGAVov+
         t4UyZImQDQpmsNkuthjC3bljo0B9ATP0mZQ+r9JPA+nCK2I0P5BAWDEyI0DMzVrjSFBJ
         yBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145695; x=1695750495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHI+584R95bYBD1BTCcgY0T2N8HUa0wmIFwNAkRrFg4=;
        b=nhaz5MqBZRo/dWaR1CPmeuX2VtJ4iLZku25FRyqYMhAaJLE67F+v4uMFFynXS7XEo+
         bvZwUmllFWpYYMzZw5Oqsr7r1+vqbQvdgbBdUgvkq8ISlPBjE0a3Kada0n7KIaPMSrcg
         +LPbxcLfGoenp5Wadkn326CjJJUe1NBxUarjvpCoWaJMx4GoyQtEgog7kc8CxZKGzEus
         hZFYcfIyWEeeuxVd9YyVpnnlJKMAROvNltD9qGPKNeWJyHR2MAoLhxLGvZWboZXnEULj
         mlDr2RKjw83gvwCdmP4K6fQ+e0zW4mIRHFJ08Q+KD11p4Gvq1rBFVmEgCvxeYsh5z6hQ
         83ng==
X-Gm-Message-State: AOJu0YwVHQ24afNHzS9aPxd/Btll1P8CYcspGK2WHk8TvVPlpXFe7myO
        fW+YAJ4pM7LHrR6BhuLU7qo/BA==
X-Google-Smtp-Source: AGHT+IEm8Ln/Xh8xmv9V8XPkDHy0VODlkUdN4IMIg9BDSdgAbsbELv7G1xYFsVJNWkI8yvKMvZGIZg==
X-Received: by 2002:a0d:d749:0:b0:583:8c61:de8 with SMTP id z70-20020a0dd749000000b005838c610de8mr466756ywd.16.1695145694818;
        Tue, 19 Sep 2023 10:48:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g4-20020a815204000000b005897fd75c80sm3320827ywb.78.2023.09.19.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:48:14 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:48:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     mark via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, mark <870355373@qq.com>,
        wangsirun <wangsirun@zhidaoauto.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] fix: check parameters in json-write.c
Message-ID: <ZQne3ThSw6HVmNJc@nand.local>
References: <pull.1576.git.git.1695124498925.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1576.git.git.1695124498925.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Jeff Hostetler]

On Tue, Sep 19, 2023 at 11:54:58AM +0000, mark via GitGitGadget wrote:
> diff --git a/json-writer.c b/json-writer.c
> index 005c820aa42..23ba7046e5d 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -20,6 +20,11 @@ static void append_quoted_string(struct strbuf *out, const char *in)
>  {
>  	unsigned char c;
>
> +	if (!in || !*in) {
> +		strbuf_addstr(out, "\"\"");
> +		return;
> +	}

From reading the implementation of append_quoted_string(), I think that
the case where "in" is the empty string is already covered. IOW, doing
something like:

    struct strbuf buf = STRBUF_INIT;
    append_quoted_string(&out, "");
    warning("'%s'", buf.buf);

would print out something like:

    warning: '""'

as expected. Handling a NULL "in" argument is new behavior, but I am not
sure if it is appropriate to coerce a NULL input into the empty string.
I've CC'd the author of this code, whose opinion I trust more than my
own here.

Thanks,
Taylor

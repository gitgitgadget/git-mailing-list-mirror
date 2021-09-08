Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A9C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ED860555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbhIHBo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346863AbhIHBo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3FC0613C1
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:43:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bt14so838507ejb.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OCNqpi+Cr0qH5B3i7354D7vbUpuULvk6PlxyEkmOe98=;
        b=I+WtJGxWaiyHWlSCN5s6BTzy5FFKIuaWmSG1rloqRl9pxEJDDBXqWGTunuVuNbf5q0
         3j4mWneGM3REheYDd3e4KSt88/79eBzlC2pTiLH3e6W3V5VTEWwEKTr9MW9c7FE4kv38
         niEyhARyMffu9FjK1L6x7/clHXdh6IYeld7MrXvE9SM4Rikq8Ljx1vcYx9BR/F+gRq8v
         g0hgQPsn0b/2D3lTMqJifF0POwUQ+KSprfI/UoZ87EIhrhn02TE3cJccGPlmB92hhsvE
         1fvD8Cs9tdHYrbAmL1mq29kk/01UAjyWmiuJi7C3dIiRSZKh7/RdtR++tv42uclroJ+4
         JDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OCNqpi+Cr0qH5B3i7354D7vbUpuULvk6PlxyEkmOe98=;
        b=jf/JNzDFbl4LA3F3OAxoYIFweiPLxI/XHJICFSnEO6Z0swNFA89WkgBsfPLvJEhtk3
         /FuBnphY5/KDxEppoEJXdYv3TYAK7tgHwvsNhfmGgqN1fcvXzUI68fFBuSm1hI8+LZio
         cXTjlCN0ue0PXzXFN70GnW4NmgTJ5LXXdpgR0yuS22S2u0lwWiewn5LwFVb72uEak2ou
         EsYFO7Wo2G16OB+FTGS1jCsjYrWH1eN1SQ4yWM+6/qoQXqJ9OANM+iTCfELYfFzSYJiD
         SvQRjOQ71Mvr+OhEM5lvjPo7XWb8YOal/2Rx3S1zQ4Q/Ee+g7p5EhxfRc7XIDEISc9P6
         mkVQ==
X-Gm-Message-State: AOAM532yWIjUl+CsSAOfZD9P0n2uJVg2DZXNreoiRqEURX3fhgmyWhXN
        Uj+0HnOL8buQIE3tWPOO9xuFXR/CqvLrhw==
X-Google-Smtp-Source: ABdhPJz7DoR9Od31MCk3GzxRPFWRpB3yiXHV4InECtd5Kt/a7CpeLF1xNXw9cK4weU2Q9aIIu0doZg==
X-Received: by 2002:a17:907:3e03:: with SMTP id hp3mr1385433ejc.183.1631065428340;
        Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k20sm201886ejd.33.2021.09.07.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:43:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Date:   Wed, 08 Sep 2021 03:40:19 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
Message-ID: <874kavkfjg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> +static int git_multi_pack_index_write_config(const char *var, const char *value,
> +					     void *cb)
> +{
> +	if (!strcmp(var, "pack.writebitmaphashcache")) {
> +		if (git_config_bool(var, value))
> +			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> +		else
> +			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
> +	}
> +
> +	/*
> +	 * No need to fall-back to 'git_default_config', since this was already
> +	 * called in 'cmd_multi_pack_index()'.
> +	 */
> +	return 0;
> +}
> +
>  static int cmd_multi_pack_index_write(int argc, const char **argv)
>  {
>  	struct option *options;
> @@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  		OPT_END(),
>  	};
>  
> +	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> +
> +	git_config(git_multi_pack_index_write_config, NULL);
> +

Since this is a write-only config option it would seem more logical to
just call git_config() once, and have a git_multip_pack_index_config,
which then would fall back on git_default_config, so we iterate it once,
and no need for a comment about the oddity.

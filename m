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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491DC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB7961156
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhHUIGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 04:06:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAACC061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:05:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf2so6438669ejb.9
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=N8DBlftg1lRrX4YrDeQewhaeYHaGHGw96goFMtP4JQo=;
        b=W70LZwvdm+oqSwkA2owbRWKEVQYIvxG5crGN62CjB6QczrouR4yBZOTMPyxYlNvmoz
         6JosuzOOnscPxAtIk+9BQ5hn7AFnORwugiMM+f8bmc5ACDVwdxnMZWE97g3cJvWFk0vh
         g4fjLB0HYV0Nh09Dh2x4aZ9mhuGfh/KLhOeG9qAY/SknHFdbMhvo4ySNNKm6WPZVW81b
         auZC7J/JXjQiMZnUlRz4i+TyQG835CMKTuM988O8ZKtGHcsgt48kCamh6xUfNwawgzxQ
         HkJiA+6iJHnz8k3JYK9gbxi6+HUJCd+w26RuDV+FeuE/1+g2fTVlcj2MhY7lwW236dPN
         7JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=N8DBlftg1lRrX4YrDeQewhaeYHaGHGw96goFMtP4JQo=;
        b=hjFHfRo22GS2BCSTeV5A4wfYAYJt6rqrdD3sOVSa36dMlXwf+4Qlac+sTAVAp9IHOw
         WcBRLyfIM89FklSvQb/Bz+j/8s1vflXfo2ye9qP9cCmUuJHt5OAzlfS/o05fd6nHr1dk
         TzKsMk6T+2tyIGdexiD2WWGmSdlEnU5CbuhE721yffrn5+Za+bropUzOLwA8VnQ2MCpv
         YQEbzMDyb5lUE1FEyJ5kqnX31Is0Y+XBBPLo3KgveCksd1Bp8MiJpjMWtaZx8YDaKAIK
         uC4A4qWpnU7gWH71WgzdR68WqXhfv9qPeSEGRfSaoMlIjBuFT5znwgRL3xGXGXClHNJZ
         kxMQ==
X-Gm-Message-State: AOAM533vOE0pWb0i1yvxWrsY9PtPDaXO6BEpvf88UzYrwFteMC67uBYW
        7OGRIQUPvgRpIR+2RgJxeNw=
X-Google-Smtp-Source: ABdhPJw0hcP3d3k+0ID1nxzpU2kzPWA2r5SVgpcyrYwV8koBCVxREb5FicQflT6CeRA7t7loeZ+t+w==
X-Received: by 2002:a17:906:dc5:: with SMTP id p5mr25874354eji.213.1629533154862;
        Sat, 21 Aug 2021 01:05:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm1290198ejw.18.2021.08.21.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:05:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v1 2/3] git-pack-objects.txt: introduce `--uri-protocol`
 option
Date:   Sat, 21 Aug 2021 10:05:08 +0200
References: <cover.1628845748.git.dyroneteng@gmail.com>
 <307a1837196a1508963a70bf4c0c4ac5727e4d19.1628845748.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <307a1837196a1508963a70bf4c0c4ac5727e4d19.1628845748.git.dyroneteng@gmail.com>
Message-ID: <87ilzzgr32.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 13 2021, Teng Long wrote:

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-pack-objects.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 25d9fbe37a..16057b8c7d 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -313,6 +313,14 @@ raise an error.
>  --unpack-unreachable::
>  	Keep unreachable objects in loose form. This implies `--revs`.
>  
> +--uri-protocol::
> +	Exclude objects which hit the KEY (the object hash) of
> +	`uploadpack.excludeobject` or `uploadpack.blobpackfileuri`
> +	config (See linkgit:packfile-uri[1]) in repository and the
> +	VALUE (the packfile uri) matches the given option parameter.
> +	If this option is set, but without a value, it defaults to
> +	the value will be "http" and "https".
> +
>  --delta-islands::
>  	Restrict delta matches based on "islands". See DELTA ISLANDS
>  	below.
> @@ -426,6 +434,7 @@ SEE ALSO
>  linkgit:git-rev-list[1]
>  linkgit:git-repack[1]
>  linkgit:git-prune-packed[1]
> +linkgit:packfile-uri[1]

This sort of link to technical/* doesn't work, see greeping for other
technical/ resources, unfortunately we link to the generated HTML.

(I have an unsubmitted series to clean that up and move them to the main
manpage space, but in the mentime...).

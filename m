Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D8BC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjHIVWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHIVWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:22:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B2C10DC
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:22:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-586b78aa26eso4086627b3.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691616150; x=1692220950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2YdgtxHMcMiJqT99a2wpHhRPhpoSooK4VN0avG/sbE=;
        b=avP5GXqsN8gMN2lRlbVIfHOoYNqvgzSS9D43cLIJ/M32cUIDCYO32aChQdzAj/E8Ae
         JXS5MqK8Mc+H4IHMl2DSt4COS0SwNh1WOqz3b5fuS5qYRxaytuJzsC6+BuLGKsu069B8
         2bGalZ2VCw5a4GlNtMT/o5OYB7d/BNYjXJDgLZNUTV75Hzh0WbYLJ6uVKdxZtiaYDPBX
         lPFgzvOGyCHov8wCakfCuNtQTTPqTLDeJWGjgMbcKoFMjtzEvmu559TCNGEzXFlDPtfe
         t6+YpDZ8FrV7nmk6tKKcLL4LSRcAilXX1tiJAAzPVANlck1bIbmsORH1lOWckec2guSN
         +/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691616150; x=1692220950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2YdgtxHMcMiJqT99a2wpHhRPhpoSooK4VN0avG/sbE=;
        b=Fu9k1MG9iSE7QkaWlwYx32LO1z4KXtJBU1QoLqZmzPSDDBixrvPg7eoJiCi7Xls8Xy
         ODVQ0ph1PgPEDX8fSReAG2YORg6dyOOXBymcDjJICuliTihetKrbvehLuCE001/r2Lbx
         5Q2TBYtGeEWtyC9eDtW5FFFGyJFdr+Az0J9hx/o/4b2kgDed+3CPjPu/rB9dN6axFCcW
         6GO+xJRrkkRQTEv4Zu+sTWmlKRPpwMr6AQXiJ9Xl0M2DdwNEcmOlOmBVs56vnXbkNbAa
         m8jG8tjK4niVLb371vfiPCHzENS7JHkeNFHy9f+GFXXJL/ns5Z9wrD+Yd9soSLKUxs0c
         MexQ==
X-Gm-Message-State: AOJu0Yy9UgIvXKpKQZMkXSsKWPXCzvPrYp9INapQ+h0CpTaxpKrYvHjg
        2rPX7U63Betw+aZZCT5tfQCuxA==
X-Google-Smtp-Source: AGHT+IFWsPGeSFJmR5R37SrZxkpgRPhZPnG5GHAOx246NGyhD9XtZXvUm/dgn0iyoytIx2qnupReFQ==
X-Received: by 2002:a0d:d853:0:b0:586:b686:8234 with SMTP id a80-20020a0dd853000000b00586b6868234mr612406ywe.8.1691616150630;
        Wed, 09 Aug 2023 14:22:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m6-20020a817106000000b00586b2198ffasm3668061ywc.139.2023.08.09.14.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:21:16 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:20:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/8] repack: refactor finding pack prefix
Message-ID: <ZNQDFmyX6Egl9hRu@nand.local>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
 <20230808082608.582319-5-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808082608.582319-5-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:26:04AM +0200, Christian Couder wrote:
> Create a new find_pack_prefix() to refactor code that handles finding
> the pack prefix from the packtmp and packdir global variables, as we are
> going to need this feature again in following commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org
> ---
>  builtin/repack.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 96af2d1caf..4e40f4c04e 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  	return finish_pack_objects_cmd(&cmd, names, local);
>  }
>
> +static const char *find_pack_prefix(char *packdir, char *packtmp)

I'm definitely nitpicking here, but I think that both of these could be
"const" to indicate that we're not modifying "packdir" or "packtmp".

But again, definitely not worth a reroll.

Thanks,
Taylor

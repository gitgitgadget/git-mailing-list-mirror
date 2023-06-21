Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE1EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFUK4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjFUKzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:55:47 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B10199
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:55:46 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5700b37da3fso52947477b3.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687344946; x=1689936946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bvakI2unqmQt6SorqFFMZk2xLYE4kloPqHSPDJLMdc=;
        b=FpHCmDqpT5XqOFp8oMpzpOQasHqnN/BjNqeeag/obTKbxLjiEzQ40Y2nXk+8lTmt2B
         g6iDLlnobnsE0wp+IRL9ogXMPe0n+WZ25KBUISBVLZoOgIEehP+aF6BlEFSL61jVw+DN
         geNrfHBUcH7nF2L/JA+V0TeEhavKfOjQXXPlfNHl/AcNvEKFlUzFgmS07u26NBMkhcjy
         4W5NKaR2vpm0t7iW2D70ZUqH4BbF35wXb3V7M1FWZgEUYzTGB62inKx1gx44ROK9pZLc
         ABtoADmQPYhkOYaXl08WvzRmFi5DYIroh63Jwt3osdi/3AgVbF/YJX/2zFMj41EXPLT1
         NG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344946; x=1689936946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bvakI2unqmQt6SorqFFMZk2xLYE4kloPqHSPDJLMdc=;
        b=MfHKqLhfpURR/nw4xw1jNXvPYvOHEPxTk1Jm2LkloFdetxn6X+BXq7gdrfyp9USuTJ
         TP5/emTMt4XJ/ZqoSgh9SBaQbM/K4H3sWd+Xq+ISfPXXm8eU366OMvn0MR3+3iaxslej
         UsmasGDRVGfdkMP8mnPxpGAWS0xm8N2uTcCVelrumeJL2L2cP//nfApy7tydRgr2Vocs
         xgMwbikwfdW+t1nJEcqivPexxX+tgw1vrkG55de2eh/uc48LXI9fjeun6u5pSikzgoeF
         8W5/r0wOoZ7IIMu6gTTuFG0o/Z+gtBTDS7y3PXGnTImLkCdg84CDJNnXXVxU1cE/n4sA
         5O8Q==
X-Gm-Message-State: AC+VfDzOaLUtobhE/OyZ2j3IuZxV2+Mw6vb5c+ynh+rscZED10VBkeej
        F+V9mnwM+vhVrHWIWCf1JJPiyQ==
X-Google-Smtp-Source: ACHHUZ5QxzPv0KS1JEeUu7OPL+ZUmgscJGh4qcLcI2i0fsjMQfclOl/90N0Usq73dbyS/Gj9O1SurA==
X-Received: by 2002:a81:4849:0:b0:56d:4014:dd20 with SMTP id v70-20020a814849000000b0056d4014dd20mr6936269ywa.30.1687344945763;
        Wed, 21 Jun 2023 03:55:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x81-20020a814a54000000b00573a75cd344sm236924ywa.141.2023.06.21.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:55:45 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:55:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/9] repack: refactor piping an oid to a command
Message-ID: <ZJLXLgE07bapFs9W@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-5-christian.couder@gmail.com>
 <xmqqttv8thjw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttv8thjw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 04:46:43PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Create a new write_oid_hex_cmd() function to send an oid to the standard
> > input of a running command. This new function will be used in a
> > following commit.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  builtin/repack.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 0541c3ce15..e591c295cf 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -182,6 +182,17 @@ static void prepare_pack_objects(struct child_process *cmd,
> >  	cmd->out = -1;
> >  }
> >
> > +static void write_oid_hex_cmd(const char *oid_hex,
> > +			      struct child_process *cmd,
> > +			      const char *err_msg)
> > +{
> > +	if (cmd->in == -1 && start_command(cmd))
> > +		die("%s", err_msg);
>
> I am not sure why we would want to conflate the "if we haven't
> started the command, auto-start it upon our first attempt to write"
> in these low-level "I am designed to do one thing, which is to feed
> the object name to the process, and do it well" function.

I agree, the implementation of `write_oid_hex_cmd()` seems too magical
to me.

Perhaps there was some awkwardness with using the pre-image w.r.t some
later change? Let's see...

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E146C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA1610F7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhHXUfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXUfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 16:35:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77417C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:34:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z1so28025718ioh.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6Dn/zTG9s6zJdekoYx8JCJm1//bBTO80fJF9oNEK7Y=;
        b=c2mWnia1w7giAwA1xtiHbwUvtmKF3P2tDv78siAff3spRlzNixqz3vM2LTaTiCYe00
         WI8y1UfSo/aZutOgzlylJbz5FiPZEH5YK6cu7i19Tfk1/i0r8xDQqaix1rhBmcj1xIPV
         NUMnhaIQCc+jQJ8dH1mHdRwRtcCjtUyMh4buxsR9hGXAVA1DxUJO5ZwHqFKjWaiFjeWs
         JreVEa7KC3pv54+YcdsBA8gxDYsD9n2LLrbjjUbwKBz28PoCnj1Fca6luLJaRPV2YTfG
         g8Hnsr4S3QHDofaRpP5zBmplCEs7f9Y+/jFO6Do7yoq0J6C+U3j8JFXLlcvv/LQ3cVu6
         XYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6Dn/zTG9s6zJdekoYx8JCJm1//bBTO80fJF9oNEK7Y=;
        b=JCswqrZP3FO9FgioQCmQcVgAgCuNr19I2o34vzUO7+pt//nA5vx7TerBBbLJfvYJTb
         ZFy/r2fJEvFqbXusVs+TVBYFy1mnzmYCw1JchmVXfKkwE3UHKr4lGprIAXeTrjfTfGBq
         FDQ99GeQsEPBFzyC5onZ1HqbdANN6WibCdIh/xKcpH3B2UCcMUsjM3yOBBkUYetTeSnd
         0k3tx/sd6W6VtWQM38G7S1G668k6FfoDku9PiGd3eUpFJ4zvOBIb2hN+jF7nvyiYQemG
         ZldIESd8IXxRUFzoPXXxZNns9yOK/I8rKhEMNdb35F/jyEnMGAs1E84OPxZWV7/uWLee
         j7zA==
X-Gm-Message-State: AOAM5337Q+FV0j+i748GGJqSg3Us7+S9/hB8TTyGzHFGrdncV+PA+R8V
        Pv9kVqIlYE+zRjflCJcRn/Ibdw==
X-Google-Smtp-Source: ABdhPJwalWzbLL25CepawHSJDjU2/E/zFFdXApceDyursBRw3PQCpnkI+zz/Bn6Vw74FKsAlG5LaMA==
X-Received: by 2002:a02:1d04:: with SMTP id 4mr35588386jaj.98.1629837272826;
        Tue, 24 Aug 2021 13:34:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t15sm10374920ilq.88.2021.08.24.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:34:32 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:34:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSVX18UXh9vX+Zhp@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
 <xmqqa6l6oafd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6l6oafd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 01:27:34PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When writing a new multi-pack index, write_midx_internal() attempts to
> > clean up any auxiliary files (currently just the MIDX's `.rev` file, but
> > soon to include a `.bitmap`, too) corresponding to the MIDX it's
> > replacing.
> >
> > This step should happen after the new MIDX is written into place, since
> > doing so beforehand means that the old MIDX could be read without its
> > corresponding .rev file.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  midx.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/midx.c b/midx.c
> > index 321c6fdd2f..73b199ca49 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -1086,10 +1086,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >
> >  	if (flags & MIDX_WRITE_REV_INDEX)
> >  		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> > -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> >
> >  	commit_lock_file(&lk);
> >
> > +	clear_midx_files_ext(the_repository, ".rev", midx_hash);
>
> This needs to take object_dir into account, no?

Yes and no; clear_midx_files_ext() still takes a pointer to a 'struct
repository' until we pick up [1].

I asked for some changes in the latest version that Johannes posted. So
I'd be OK to live with this behavior for the time being, and then I can
send another patch on top that fixes the new and existing callers
(incorporating [1] with some new tests).

Or we can hold one up and expedite the other. I would suggest that we
pick up this series to next if you're otherwise happy with it and then I
can send the trivial fixes on top.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20210823171011.80588-1-johannes@sipsolutions.net/

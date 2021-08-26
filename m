Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C2BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F2D60FE6
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhHZWgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHZWgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:36:11 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA00C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:35:23 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u7so4969823ilk.7
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUAcWXLKqLtYyLRUCTkq2QIPDp7uxqJ/F8kFJqP1CyU=;
        b=a3pnI0PvbLeuXYph3IDVqPlptvllkeTMT8sir0V2RuBCjwooRndrzJp8bNjA1pAEvO
         1cc7F/31Q29pyT/Da1EnJHFAxsdkN0cukK5FQbY/8ef6vL7obOI57jVUQQwD63drIGwY
         7oLiDk25jJpMzrs6ZzZ1UFPrdjQKy1jmZXgD6NB+llJVzlBTn+yew4/QvUaVcKjyGKCq
         rb9mydclsddm+LwIoWXWqS5ErScJsfuC5DnSJe3+kbSqoQ76J/ahUeIVjwTKa8XQ/QFE
         OpvYqADv0IOp5u9W/u78OmbxFR1PT2m9l9aLPN2JRR5WFm0iu26/hYBVE5UZM4KKHJyS
         bt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUAcWXLKqLtYyLRUCTkq2QIPDp7uxqJ/F8kFJqP1CyU=;
        b=jmyW6Q/8Itfcv73LkegF6XZ7WaCxUCpPj+ndgwNgCoR/hSFmIaLz6yikRIq0W8qmqL
         6EuPpFjDvyFRejgfT/4jUN7UTmaolvGF8H6L7IImuKLtmQe0fClDO1rrI6zefVccpUaH
         NDxvfKT597i70e4aZiqWXdsNmiHFjwNfpuhpHKD260j/nuaiLrYiFKg1/P1Pb6LSXL8j
         9ZGDj4SNpuJT8AJPodNYjNiArY5xN9LZhev98zmwFHkEo0kxcvPvN1aJNdRdrfgUNjOr
         YSHNcMnuxncZOHv/+v34WDdtuEF50yT4FLD5o7gjld5G1XuNgjpNzPNDDdYWGHtFQIxW
         qoeQ==
X-Gm-Message-State: AOAM533vVrDs3e48vJyflcVGHPPkbe8OVwUNEV4sqHdL+KOzTHp0NCrt
        GnpKAHBwGjw2PX5ZGF0o7aJFXZh1jSp9Rx1L
X-Google-Smtp-Source: ABdhPJwP+Q4+NRkF+X8qv6gy6sZOydvVxAN0l2DURsO2wfyylCrqWOFLJC+cO5xT8tgQLRC6qrFgGQ==
X-Received: by 2002:a92:3207:: with SMTP id z7mr4148296ile.260.1630017323266;
        Thu, 26 Aug 2021 15:35:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14sm2388465ila.28.2021.08.26.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:35:22 -0700 (PDT)
Date:   Thu, 26 Aug 2021 18:35:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, peff@peff.net,
        git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
Message-ID: <YSgXKgHgPwo/8aUW@nand.local>
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
 <20210826100648.10333-1-jacob@gitlab.com>
 <20210826100648.10333-2-jacob@gitlab.com>
 <xmqqpmu0f9ob.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmu0f9ob.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 09:33:08AM -0700, Junio C Hamano wrote:
> > @@ -171,6 +171,9 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  		strvec_push(&data.prefixes, "");
> >  	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
> >  				     send_ref, &data, 0);
> > +	/* Call fflush because send_ref uses stdio. */
> > +	if (fflush(stdout))
> > +		die_errno(_("write failure on standard output"));
>
> There is maybe_flush_or_die() helper that does a bit too much (I do
> not think this code path needs to worry about GIT_FLUSH) but does
> call check_pipe(errno) like packet_write_fmt() does upon seeing a
> write failure.
>
> >  	packet_flush(1);

I was somewhat surprised to see the fflush call here and not in a
companion to the existing packet_flush (when working with stdio instead
of file descriptors, of course).

What Jacob wrote is not wrong, of course, but I think having
packet_fflush() or similar would be less error-prone.

> OK.  This step looks quite sensible, other than the same "do we want
> check_pipe() before dying upon fflush() failure?" we see in the last
> hunk below.  I didn't mention this in the review of 1/2, but the new
> fwrite_or_die() helper function may also have the same issue.

Agreed.

Thanks,
Taylor

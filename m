Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D3C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A9C6102A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhIAUzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhIAUzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 16:55:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52956C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 13:54:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m11so886477ioo.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OOneMI+M8HoAbWp/kC0rUA9iXRiaCTDHOmTOq1ixjXk=;
        b=axMhDhMMdvs0bnIrzuGLPAltULHbq+5IvbcOxGFzfiYMuKrDUMU+FE48xHSVG54N5y
         frLHut2FDI3xZShUmZooFYB/JHW/LwGNk8TKIucdTJXlc5qsLaYG8UKt1wMO1iDmXLwJ
         0gr5yAKOJMpVjUQ2V4aVNr3H5z46afrvYOZqFmfD7VP4bWSVl7jPWV4qEH7CL3KQwrEg
         EX9xjy+L9vpZ9noDSikx6fNTxqjGtw+fB2laKK8EwGgf/7uaYxTaPS9mlA7DepN5tWgb
         A9rH2Ff9FOWLrUkTDLiqDpp3RF+Hdr6MaJzYvjcuwxfXw6J+0m4ruKiDc2x2lbSMNHSM
         sG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOneMI+M8HoAbWp/kC0rUA9iXRiaCTDHOmTOq1ixjXk=;
        b=MpitxnuVdAfBRqjRxfwQFno7eMyC2USPiW3xCEUNk8vGaUFhQMw8SMD8WJ9RHAt1ev
         7PdzLI/IBdQpTehbava0s0OIVtCssKGlHZMcPfXEl55jFx+STINJ3In497h7BAZFOk5e
         N1DFgxsroWzSylgvuHnRXuvS73GGE57jmgNQqKld8iMWP0hZ+LyhVn9VL55AzxFvW7rP
         xur4hdrML2/Za3rHolsgo8EMif3gpjkdRS38Lcwj0bVtC+zMCVGZrxmKzzUCE38WdkMi
         vEgHsLrRT+0jZoNC7IZ+QSYw7Coz8IolcrqevcZAOLRMQ/gX33eRr9W+F5uhegdRlfFQ
         RDVA==
X-Gm-Message-State: AOAM5318UT+ogLCNmAny1vl3zyq9DXTVPVoRhXW5HZc3pORGj8lN2lm0
        39Pdm8BCgQRmEhzK4e8XWElQKw==
X-Google-Smtp-Source: ABdhPJx9fHVQmYlpnmoF5ZbFo8tPvrgn0jMECrKLDBdaFY6cMJ2vRFSKXGwxcdJdaJfDs/0pc3yZ+A==
X-Received: by 2002:a05:6638:c4d:: with SMTP id g13mr1310237jal.43.1630529692754;
        Wed, 01 Sep 2021 13:54:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z8sm347976ilm.29.2021.09.01.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:54:52 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:54:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YS/om1SbCZ1cOxZ2@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
 <xmqq5yvkqidc.fsf@gitster.g>
 <YS/Pqc7lkMlnlBYR@nand.local>
 <xmqq1r68qevl.fsf@gitster.g>
 <YS/juRg9N/cCoR0d@nand.local>
 <xmqq35qoowb8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35qoowb8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 01:49:47PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Sure, I don't mind getting more strict here in this series. If you want,
> > the below could be queued instead of the original 11/27:
>
> That may make the documentation and the code more consistent.
>
> > As far as I can tell, supporting arbitrary directories with
> > `--object-dir` was a historical accident, since even the documentation
> > says `<alt>` when referring to the value passed to this option.
>
> The synopsis has [--object-dir=<dir>], which wants to be cleaned up
> for consistency (or <alt> updated to <dir>, but I tend to agree with
> you that unifying to <alt> may make our intention more clear).
>
> It is unfortunate that "git multi-pack-index -h" says <file>, which
> is probably doubly wrong.  It seems this is the only instance that
> abuses OPT_FILENAME() for a non-file, so perhaps it is not too bad
> to fix it using the lower-level OPTION_FILENAME (instead of adding
> a one-off OPT_DIRECTORY_NAME() helper).
>
> Neither is something that would block this step, of course.

I think there is definitely plenty of opportunity to clean all of this
up even more. But I don't think this already-long series is the place to
do it necessarily, since we don't want to let these last-minute (mostly)
cosmetic issues get in the way of this series as a whole.

Hopefully this v5 is at a point where we could start merging it down to
'next' and then address things like the helptext, `s/dir/alt` and so on.

Thanks,
Taylor

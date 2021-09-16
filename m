Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA8C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE33611CE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhIPFAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhIPFAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:00:08 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A076C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:58:48 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d11so1484762ilc.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K136exbC9JOpOWxQ/HkYQuEn9jgQR9eCpgQYGqlQxrk=;
        b=gCu70x4mjJAJ99YlERe0ZsL2HwHymLIbvaa2KTmqFgtCEeus1X6wGpsDvtuu1PBl9K
         ++EYrZC+EvsAXecW9AGpeYmtLEVWvxvVCdTCQKrmfYZ6CymmSl5cgbpB47Buk01g6l59
         uvRa7SKbPjoS4P4edjO9rCs8R0lf+K0VesyZM6BGMHSNKVZ85qErV+oOKCP8KEU2NMPp
         3lukwzrRQKewAl/N/BYIElEI/zzOCLVr5irz1vqbIZH26rWDp/sGlQqr/DC/SZ3PIH99
         ctwH6bLSgcCLQ9/pz9CkuQ9tVR0nSgXXNmamGVXnmli0x26nIaJdNVcGzLUjmhMsw5GD
         Ehcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K136exbC9JOpOWxQ/HkYQuEn9jgQR9eCpgQYGqlQxrk=;
        b=Ew1d9XVl/F8Q6+k8bZN4d/0bWC0JM9uTdxb8Gnj+UJjtKwUiFsuWViHG2wQyI5rkst
         2VUX9klj36vQi0jPrRdGHeUZhl+mSV5p1ReVmLOtHzFAiVrF+hIdXLjNnut2c/kW8iQC
         DfhTMnyRJ391QxReiC8cxCN9qm7zjADpHU31rlCOJnSUBjLedfcT6A1WNUkZyyKfkks3
         q+pXrVyu0LDDLOJ0HCdTOoNst5+ULtEhEk9TMZOxUEM4+DAsffD7IrBLBM+ekYDS+r+X
         Q4ypUAtNRnXhXikVo8gdruw+casKxJz/UI9J2q151+ApeUkdh6S+dfe+sh1pTHWlY76y
         ICxA==
X-Gm-Message-State: AOAM531oi0AkGxYaY4Akrb5Zj5/ya1f5c10ndEJmhHdPJ8vbWKk056Hc
        5aAlPVZ24fAv11wqDi6we2RSXg==
X-Google-Smtp-Source: ABdhPJzBKlk/8HXh5k+uGDt8wD3RgTB8VQCudeX8PWUxnUIRZhEEuVyLo5Eud7OA9X0szkTErx1Gig==
X-Received: by 2002:a92:d2c7:: with SMTP id w7mr2577858ilg.71.1631768327603;
        Wed, 15 Sep 2021 21:58:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c3sm213147ils.61.2021.09.15.21.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 21:58:47 -0700 (PDT)
Date:   Thu, 16 Sep 2021 00:58:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/7] run-command: create start_bg_command
Message-ID: <YULPBmIYJLv654kz@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
 <YULNs166fGOfVUVy@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YULNs166fGOfVUVy@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 12:53:07AM -0400, Taylor Blau wrote:
> > +/**
> > + * Callback used by `start_bg_command()` to ask whether the
> > + * child process is ready or needs more time to become ready.
> > + *
> > + * Returns 1 is child needs more time (subject to the requested timeout).
> > + * Returns 0 if child is ready.
> > + * Returns -1 on any error and cause `start_bg_command()` to also error out.
> > + */
> > +typedef int(start_bg_wait_cb)(void *cb_data,
> > +			      const struct child_process *cmd);
>
> Nitpicking, but typically I would assume that the "extra" void pointer
> is the last argument in a callback. It definitely does not matter,
> though.

Looking at the last patch (which adds the first implementation of one of
these callbacks) it appears that this cb_data pointer is unused. I
assume that it is used in later patches which aren't in this topic?

If so, then it may help future readers to indicate as much in the patch
message. Perhaps "the cb_data argument in the start_bg_wait_cb callback
is unused in this series, but will be useful in later patches".

Thanks,
Taylor

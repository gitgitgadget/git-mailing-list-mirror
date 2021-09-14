Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A1C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E8760F58
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbhINFSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbhINFSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:18:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D105BC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:17:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so15339298ioq.9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fnc7E7MH8hWpGi00RH1HoqgSAwZ0Vuoa3Urk4Fg0uJA=;
        b=s3hcA6sGJ24sUu4Bq5466Hpt1WZhe8AmOIl/wZpDMuLNUObofDQ55WePRA1UZWQX2y
         pW0Lxfya7Vxo34fT/UliDGekTufZabv4EL01oUdWjTkW3rEXV2xQRYDAinDt6nTTHfTC
         hQRZgvmr27rp10qOyoV6dmK/NbpA3VdnL0Bo82lgga8yNvqQEoVSQ+7Cb5FY7IIA1K8r
         xp5jm4F8MrcDBizAWeOYKlmJLrPwcmHl1udQjE46DLiFPL0eM6NbhpyYxZC4mP/+0q8L
         AsABdy2wREtvEDeERcLh3+ZN1+QsFxFItmVNxT6xYmMUNZSNrFOL/gJO5GL/l6xslF/O
         CUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fnc7E7MH8hWpGi00RH1HoqgSAwZ0Vuoa3Urk4Fg0uJA=;
        b=WQ/7beGkSmlV6UL8A2KMAtpruWSUq6t3xbkDOHhJAO8J4zUHKnTg9dAPvmD2cVViul
         5Q+Yk+s+AzCJdRvxnxl77W7dePYYiLJO8ebGrEI0gdTmMkctY8SGrzo+Iguzior6l4cj
         6Z4HtFjdjJLHJVlMK6EWIogH+rhTCo6f5dCR0LOmZqDDciDUU/5LCHQL6qhJZaEiRDVy
         31ctmVh+i61ElRuUH/1JpXDQX1VnBqPL6tkSFC2Iu39wkKQIFUvc0da2htkGTEqS+i4E
         Hv8hUlqi9RlW95h7G8bhCCgHCNUH3IgF+LQa7lX/HDdzbAJDmDr6ZJRDlUIaqUkPGvCq
         GnJA==
X-Gm-Message-State: AOAM533+aeSU5mc6EvFbkRHsWlorv2ORu5gkd8rtx9e0xkr3rpgT2qcL
        0Nv8hIeh+gPfNlnntfnOWTAkjfItGjg/CRgy
X-Google-Smtp-Source: ABdhPJyPWSz3eDhkju40Y0VzLCa6CY9drdxU8CYJ+qTv8iKDeSHQx24daNN9Nl87dQOxFauOcfc8vw==
X-Received: by 2002:a05:6638:b10:: with SMTP id a16mr13346226jab.149.1631596645275;
        Mon, 13 Sep 2021 22:17:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g19sm6467251ilb.84.2021.09.13.22.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 22:17:24 -0700 (PDT)
Date:   Tue, 14 Sep 2021 01:17:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUAwZDLGTmRfswif@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
 <YT/3BuDa7KfUN/38@nand.local>
 <xmqqpmtbc3o3.fsf@gitster.g>
 <YUAvBso+UsBTYizb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUAvBso+UsBTYizb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 01:11:34AM -0400, Taylor Blau wrote:
> On the tip of this branch, the results are:
>
> [...]

Eek, those tabs are horrific. I must have left my editor in paste mode
when inserting them, sorry about that.

Thanks,
Taylor

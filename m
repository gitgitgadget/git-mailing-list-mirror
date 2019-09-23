Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA381F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfIWIjy (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:39:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34225 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfIWIjx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:39:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so12957565wrx.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MLHucsXtot0U5cYWj2cuvT9+01yHihH769D69/SUQJo=;
        b=Cr3pPweIc/aojqGdK7KpVjLjhL6ReJlXZmudJnf3U9dCwXOMODzcbhbfix/7t13DSk
         cIegzhP/eTSVo9J88LQhSPghJHJZ+lB1Fm3DZ2sscfJV7Tc8RvyDeKknRDHhZBipIV/C
         3tS2ply3rKl7FoBAXrSqLWYMA8IxYZ7THJpU2/DU8pc95YFNpCnxNp7Yf74OdX+18XVV
         xivlgLtoJBQll8HuLmGXR+auQYZBhMU+sqomX6TSbTnJgbhYJ/1dt75+AvGJZlyYiPqC
         ir8eVs76Fdg2aeKmgGZwsegzFT+URL1TDwSBsnZa1GoESmq9MtoXTOInp/cMAft65vax
         QtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MLHucsXtot0U5cYWj2cuvT9+01yHihH769D69/SUQJo=;
        b=nqGsbmswqGJJBimlc8cja9mOiQ0Jcdl5P79s9w22yOdKzPMSPYN3keaPordCvcTmmr
         GdkhqKywozfh5iQPjvVqfgvUJEOxj3M0W25qP/o6nmqU4qJI/EDppulwRFCfSgyMF2hA
         /XfaynPBhwco6qH73Oc0OclUYBkZ/WT/xoV5+33uAkTIhB/4nllNNUKnFpOoiF/iYo52
         cTz+PyAjHVs/tj+LAkFStEr8KYmXLMl+vo4zhD0T2gOGzreg1Mo4KuPmp8VOfQmJ1ARq
         Ta/rzKNXUlGNKHdSjc3m4aRhalrFsANuehIL7ZgpqRaqFf4nXpzYZ8UVZXnqZCgFoigV
         ukCQ==
X-Gm-Message-State: APjAAAVBZpaVm5o3fIkvEz55II7W7RDIFn6ZZNwhz/ygci1hRUkCilux
        OmL8koGPPblwz5yPlc9rZx9Vfn06HaQ=
X-Google-Smtp-Source: APXvYqwYRaqceDb1dBf+wmBdyczHgLFoHelprC6Ca53bUrP1fAHPm6dvrnvaPzO+LpjU7gYSmSGPUw==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr20650999wro.35.1569227991815;
        Mon, 23 Sep 2019 01:39:51 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id r18sm14692198wme.48.2019.09.23.01.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:39:51 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:39:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
Message-ID: <20190923083949.GE10866@szeder.dev>
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <20190923012838.3hzai6ho7vjjhkpb@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923012838.3hzai6ho7vjjhkpb@camp.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 01:42:30AM +0000, brian m. carlson wrote:
> On 2019-09-22 at 18:01:43, SZEDER Gábor wrote:
> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index c785fe16ba..a4d8d312ab 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -9,7 +9,11 @@
> >  #include "sha1-lookup.h"
> >  #include "commit-slab.h"
> >  
> > -#define CUTOFF_DATE_SLOP 86400 /* one day */
> > +/*
> > + * One day.  See the 'name a rev close to epoch' test in t6120 when
> 
> This piece of code says "close to"…
> 
> > +test_expect_success 'name-rev a rev shortly after epoch' '
> 
> …but this says "shortly after."

Thanks.  I did a last minute 'close to' -> 'shortly after' edit, but
apparently not everywhere.

> Overall, I think the idea is definitely sane, though.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



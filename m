Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034FC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1A23110
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbhALQv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbhALQv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:51:56 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1A7C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:51:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 186so2433491qkj.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNQ2rqBAUxQSieD9rdZ2NggE6hl8/q6zatrwt49sbnY=;
        b=qZKjfYRMTCanm2nT4uKWfV+oSY2Bhn25+HHPOexQH+dNWQTNBkQwD7OTAtw5UA7Sfb
         PHCDBzx7gtx647Rw9QDedfqQ6ClmbGTd4q1qLxxsEj8Sb0gdIugKhO7X44Wvx9lFNeL9
         6nhxxvXH+5GX6ZNe+qnGoM5mtEmSc3oLB7dgvXP35jFizhuiU7p86LcqYbbo6Dl9eZOI
         uwfiO6eu7uDUL2/vOfTsxjDkBnJ6wabiu+wGKUb2VuO6vtK5BN9UNGaOT6mHxDrnEyGR
         2dCrtJydruKppCQKdbHOfKnIk47l37FklYdcsZFuIsOOORcz+jZ/jBK+7Vdv/xfLzpCl
         6/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNQ2rqBAUxQSieD9rdZ2NggE6hl8/q6zatrwt49sbnY=;
        b=iCy2Qh6PlKdNszgO6yB8zumZDcgNRkrnHhzgTM4/rc+MqoO38lDetD4J0E0XHH3z3H
         72tKh6vDdDaEZIinghYwq2Oa7I9siGv270rJFuXprpJcsAF1jyBPJHwQciQye2svkBvY
         dY+t6uIY5tMNewj4kBMLWMgH7f6sAoL8TR6cr5Ab2umHIChGNT56eSqK1VsvbDacmOf5
         fESHRgwHK9bPaMjoZoe+fF36jAvDXpTIgIvHs823dzFtpJgXP69s79pM6y1uivir3LIV
         v8gplXPLtjO8JXJqbCnbgDwS3Q49qbb794hbJg3WTbUl3T8PDCjs5hzrJXRF0aW9MddK
         v54Q==
X-Gm-Message-State: AOAM531y1bXrFnYx2d+atOOPQGccNnLaiSDA7W0c+/Wl1dPBsmp7SU5s
        cm/Dr8O+Y6Wxpjaxb//Ps1BT7Fe0Nhg31A==
X-Google-Smtp-Source: ABdhPJzLtwcFwVl8qJZ2NGr1y0ZpBkHkQBNF7zb593Q6BFibktuB+nd47BczzoRR4rORBIwpLTaqSw==
X-Received: by 2002:a37:b105:: with SMTP id a5mr175738qkf.83.1610470275958;
        Tue, 12 Jan 2021 08:51:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id q3sm1558693qkb.73.2021.01.12.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:51:15 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:51:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 13/20] packed_object_info(): convert to new revindex API
Message-ID: <X/3TgQrq1aiAByjJ@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <eab7ab1f35fa9703f56a99fa539839869fe4e54c.1610129796.git.me@ttaylorr.com>
 <X/1n36/HtqAoKXrH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1n36/HtqAoKXrH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:11:59AM -0500, Jeff King wrote:
> >   - Add an additional guard to check that the offset 'obj_offset()'
> >     points to a real object. This should be the case with well-behaved
> >     callers to 'packed_object_info()', but isn't guarenteed.
> >
> >     Other blocks that fill in various other values from the 'struct
> >     object_info' request handle bad inputs by setting the type to
> >     'OBJ_BAD' and jumping to 'out'. Do the same when given a bad offset
> >     here.
>
> Also good. I wonder if we need to call error() here, too. The caller
> will probably say something like "bad object" or whatever, but the user
> will have no clue that it's related to the revindex.
>
> That would match other parts of the function (e.g., calling into
> unpack_entry() can generate lots of descriptive errors about exactly
> what went wrong).

Indeed, and we have the object's offset and pack name to include, too,
so our error can be quite descriptive.

> Yep. Again, I'm really happy to see these "should never happen" cases
> converted to real errors or even BUG()s.

:-).

Thanks,
Taylor

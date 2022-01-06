Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE3C433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiAFWnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiAFWnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:43:24 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B740C061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:43:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f138so4179214qke.10
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GJJ1pr5WiGFOUVPDAP5bVe0uDw4Yyih10MkYhyYihd0=;
        b=Ap8Lz7ckcp91gPtJ5EwD2Mgs+vb4sLi+htw4TqyrW6f990O9lAa1k3HljnRdFeLpq9
         JV6gwQjjNTkd4J41rC+oHvoxxK7Q4GsggABNIPNJ3f5q9xh6qfk95mVu1z35Gt6WoEQ5
         lmOJxoHjci1nvxGWWNJTJYg8AvpcS6mN69esBqB2qGk15HWIHipGf6NaBUl9LEgm9Izh
         2+2Q/bVvjMAkBKX8uLXWOYcoUC68luD1RFtlTOyPZwc9jxZip7GiM/683szr/NRK3cM7
         t6klnoQZc68V1tCLkDrsPskqBvqvyBCFaT+PEA25ka1dpyCP55DY0KfMtEIaegNYb22c
         +s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJJ1pr5WiGFOUVPDAP5bVe0uDw4Yyih10MkYhyYihd0=;
        b=esMgb1hoj1KM+h/40odtR1hr9NLEg0Q3vLCfnEWxLw8Wro4Z/5FaCznN60dIrz5dzt
         NopRQs7j/ySuD73BKvlZbxJOfNhyjfbFjNLMTdifPvHS9ZIDMm4WcyMzcArgpKuMpicp
         Pq4SivYUHBXumhiSZMqgkKHQnF/R1QyddU/JqBlRxfhdIGWlnBUqlmPqTBehG7g76l5z
         mJ1AujIorJctiEkVu/YbSQupVYWpkGIaK8A0nbS1gRY9jmMhqjh+kMefuDSfbqbrn+Dy
         eFsjgftLQCgIqJdByMQrfa9Z+Iw0W7uMb9bAKiOle/1o6jbWXoRh1BF8GiN0CQsoaigP
         VKYA==
X-Gm-Message-State: AOAM531uqwF5BLPcl/4WIicbeK3FKh/fLu4d/JnwjKK6TTJ+5XDlt86g
        XACeeKcnrW0Xp8NL01wrygeswA==
X-Google-Smtp-Source: ABdhPJxzZb9YAf7udd/v1qi6eyUOcQSz4/GQd2BUj9Ilv4YHDQXztjiagZxv4XuB/lre0/ueUSFLXA==
X-Received: by 2002:a05:620a:1008:: with SMTP id z8mr5003303qkj.382.1641509003809;
        Thu, 06 Jan 2022 14:43:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 82sm2132221qkd.77.2022.01.06.14.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:43:23 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:43:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [PATCH 2/2] grep: use grep_and_expr() in compile_pattern_and()
Message-ID: <YddwijcMrmkgJNmD@nand.local>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
 <71bd2d1bcc6486f2e21c649708d3f4fa67dc162c.1641498525.git.me@ttaylorr.com>
 <xmqqlezsbjfs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlezsbjfs.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 06, 2022 at 02:14:47PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > @@ -687,11 +692,7 @@ static struct grep_expr *compile_pattern_and(struct grep_pat **list)
> >  		y = compile_pattern_and(list);
> >  		if (!y)
> >  			die("--and not followed by pattern expression");
> > -		CALLOC_ARRAY(z, 1);
> > -		z->node = GREP_NODE_AND;
> > -		z->u.binary.left = x;
> > -		z->u.binary.right = y;
> > -		return z;
> > +		return grep_and_expr(x, y);
>
> You'd need to remove 'z' from the function to avoid getting yelled
> at by your compiler for unused variable.

How embarrassing :-). Thanks for noticing, I wrote this so hastily I
neglected to even compile it with DEVELOPER=1.

The new version I sent in response fixes this issue.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169CBC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BB422AAD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbhAKQQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733190AbhAKQQe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 11:16:34 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC6C061795
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:15:54 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z20so60356qtq.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BuIb7CAJpMA5YSIIBAngWhqAjVt0kPDU9CyYrtj/LBg=;
        b=O0SP1lMKi4kZ0DcV9cdQjndqzNQJxieBp84Kqo9XF+phsG20qQbWcYPwnuCC/LusuI
         to98g+U2fyBBAHDM3lIcUit+pTZAAboXk3EJHktTZzuv2b8VhfgJchQxhmfNbsE6e5du
         EwGRIYPtqHz3Vr6SNMynF2tmzKoG/o5cqwEXR9bEgTOgeETnj5NXJTUAm7+bdyqfIphg
         +4J6zh6JQEGO5T5BIOIVHKdz+/2OQIWIBfKM8QnYv9PW4GgYPSWXiwfdXosj9EtqSg4Y
         JBG9J6yaSxRKWdpuLd4tTC+pHrbUh+q2KNGy3BGna5MDJu4slfXrmvaSd3S2DKXqODuZ
         3dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BuIb7CAJpMA5YSIIBAngWhqAjVt0kPDU9CyYrtj/LBg=;
        b=MDEDrYyI1ik5d79zlT5azXh3xaK1ZjgSc7YYX0kouvJLroFtV5/nruIQ44sFkEQ5zU
         ziVqFT41iDqHpbu8li8ktg2CPW+y4EMHqKkvjSqe/UHIAIBbtAoLTDlBnudKWGo8ElLE
         YZyQfsvfUKkRJxI6kYw0qQ35mQlHEalYWJn6U6Jgpb1mJ3HNG657Dsz+REsvrrSadwOt
         o/sta2G62JHO15NPPgusE2yQ8Wn/uZg66CXOB7Gp3W8aQnq+1XEvbSSZptg80GW+0Led
         Q07BaFvFve2Ny7K/Yef0xTQt4kUj5DQJvA5Ty9gYcpx+gCmM+A9O4jrawDO+KxAQxnJq
         v5Yw==
X-Gm-Message-State: AOAM532NJ2g5jqUOTewwg7G6h55aw2BdvmWc1fPIq6/dl0mxcQXFEVCe
        zkq1VLZa5KDEhFRqj54jsZUkUQ==
X-Google-Smtp-Source: ABdhPJx3BD3Kdsxl1HGephb+sbgBA+NHm5SLVmmJMTMnEQ51l3rKZRxgsA/vHQt/20rpaZWE64ECig==
X-Received: by 2002:aed:2183:: with SMTP id l3mr318211qtc.75.1610381753575;
        Mon, 11 Jan 2021 08:15:53 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id f17sm8016349qtv.68.2021.01.11.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:15:52 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:15:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 05/20] check_object(): convert to new revindex API
Message-ID: <X/x5tdbM3PzkqbFQ@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
 <b1a6110a-a097-931f-5710-92a1f59a842b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1a6110a-a097-931f-5710-92a1f59a842b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 06:43:23AM -0500, Derrick Stolee wrote:
> > @@ -1813,11 +1813,11 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
> >  				goto give_up;
> >  			}
> >  			if (reuse_delta && !entry->preferred_base) {
> > -				struct revindex_entry *revidx;
> > -				revidx = find_pack_revindex(p, ofs);
> > -				if (!revidx)
> > +				uint32_t pos;
> > +				if (offset_to_pack_pos(p, ofs, &pos) < 0)
>
> The current implementation does not return a positive value. Only
> -1 on error and 0 on success. Is this "< 0" doing anything important?
> Seems like it would be easiest to do
>
> 	if (offset_to_pack_pos(p, ofs, &pos))
>
> [snip]

Either would work, of course. I tend to find the '< 0' form easier to
read, but I may be in the minority there. For me, the negative return
value makes clear that the function encountered an error.

A secondary benefit is that if the function ever were to return a
positive value that _didn't_ indicate an error, we would already be
protected against it. That is probably a pretty weak argument, though,
since any such refactoring would probably require the callers to change,
too.

Anyway, that's all to say that I'm happy to leave it as-is, but I'm
equally happy to change it, too.

Thanks,
Taylor

Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE56C2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFEB206F5
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZzR1ecp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDDMHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 08:07:47 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42607 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDDMHr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 08:07:47 -0400
Received: by mail-qv1-f68.google.com with SMTP id ca9so4991371qvb.9
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pisXdmOKxP7L4p44SfZeQEn5sgw8sHIBYoufEHTDlug=;
        b=AZzR1ecp3LR4gmFgfYfbSlXUk85nKMsGEwoTz8Xs4yehMumOQEfaF8ZGdQXxwuZCAX
         z7eMBpP4CaEKoKX1nRy5nPOqj6+SShhmbBbFTkgLsoaHO3P87k3iuDMEIbx0V6J9KAeQ
         ydZw/htJnKIqJXu0U3G3Z6XpiwU9O+JYeaq622VyOE20eeWfIgNxLRK4+BGLIrW0thAQ
         s6q7Yrq7VOs8mnbzLsTTUTFHn1pa085GRXFQ5JsdEaU8cDeOmFnNsr3oAYXu07FoRYDj
         dQXkGiIDbHMvUjcy2naK3oiEQMLpEYXmjs1jtA22vQCHvTUacOnSwf4v9VNvDztRJozH
         IcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pisXdmOKxP7L4p44SfZeQEn5sgw8sHIBYoufEHTDlug=;
        b=a+x1zCCEHgp9tpFi0fgTfVzMHHaDdmK3+jm45BK21S1j1sX+j8RUbmWFEIcxki3ZAM
         C1tKPJKkvue0ZW0lHP7fYgiYmI6gvY1ZzG859ogtI7CLyfFX1sCb6UHsppwE6uUBJMc+
         6dFJGnoYWWcqNuvitydbNvYAiWRaCcxLvi/7Pxoi50EK0MvpMqpv0NnIh5BBCB7EIORg
         YS1Cak/LoFDK4mfGSBekJXj9p14KY8S8G+XHunktDgpdbTtk/6fxw7kZna0gQOiV6RiV
         2QsE6jUtmczqJZeVfWX2ILGv/S8d4f42dS0AvtknCL2srscL2ZUPVV0Sz/jWOItnnzg3
         I+yw==
X-Gm-Message-State: AGi0PuaoekIKgqm7sUP6/GBfiqeOUE/2bkAXn+xR5Fj45aojUo7Ab/5K
        Lh6yWPdDm48pkbs0GYyVhLo8NWsd
X-Google-Smtp-Source: APiQypLB3C99rGnv4hTt/999SCdSMJJhBth0mc74SbI2aRNip0VuoA4uC+6Zo/SzqgCLH5aypIjmhg==
X-Received: by 2002:ad4:41c2:: with SMTP id a2mr12305029qvq.112.1586002065856;
        Sat, 04 Apr 2020 05:07:45 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id w13sm8655655qtn.81.2020.04.04.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 05:07:45 -0700 (PDT)
Date:   Sat, 4 Apr 2020 08:07:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200404120743.GA636417@generichostname>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <20200401095255.GA60227@coredump.intra.peff.net>
 <20200401140643.GA880372@generichostname>
 <20200403140447.GA639586@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403140447.GA639586@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Apr 03, 2020 at 10:04:47AM -0400, Jeff King wrote:
> On Wed, Apr 01, 2020 at 10:06:43AM -0400, Denton Liu wrote:
> 
> > > So why does your version behave differently? And if this is a temporary
> > > state for a buggy version of gcc (that may be fixed in the next point
> > > release), is it worth changing our source code to appease it?
> > 
> > A correction to the earlier message... It seems like I wasn't reporting
> > the correct settings. I was actually compiling with -Og, not -O0
> > (whoops!).
> > 
> > I tested it with gcc-8 and it seems like it also reports the same
> > problem. Also, -O1 reports warnings as well.
> 
> Ah, OK, I can reproduce easily with -Og (up through gcc-10). Most of
> them don't trigger with -O1; just the one in ref-filter.c.
> 
> That one's interesting. We have:
> 
>   int ret = 0;
>   ...
>   if (...)
>          ...
>   else
>          ret = for_each_fullref_in_pattern(...);
>   ...
>   return ret;
> 
> So we'd either have 0 or an assigned return. But the bug is actually in
> for_each_fullref_in_pattern(), which does this:
> 
>   int ret; /* uninitialized! */
> 
>   /* a bunch of early return conditionals */
>   if (...)
>     return ...;
> 
>   for_each_string_list_item(...) {
>     ret = for_each_fullref_in(...);

This loop is missing a bit of important context:

	if (ret)
		break;

>   }
> 
>   return ret;
> 
> but that will return an uninitialized value when there are no patterns.
> I doubt we have such a case, but that may explain why -O0 does not
> complain (it assumes "in_pattern" will return a useful value) and -O2
> does not (it is able to figure out that it always does), but -O1 only
> inlines part of it.
> 
> Curiously, -Og _does_ find the correct function.
> 
> Your patch silences it, but is it doing the right thing? It sets "ret =
> 0", but we haven't actually iterated anything. Should it be an error
> instead?

I understood the semantics of for_each_fullref_in_pattern() (in the
non-early return case) to be "for each item, iterate and compute a
value; if that value is non-zero return it. If not found, return zero".
The missing context above is important since, without it, we lose the
semantics.

If I'm understanding the above correctly then, studying this function in
a vacuum, it would make sense to assign a default value of 0 since if
the for operates on an empty list, the function should consider the item
vacuously not found and we should return 0 as a result.

This was the type of analysis I applied to the other changes. I'll admit
that I studied the other functions in a vacuum as well since these
seemed to be superficial warnings (since they aren't triggered with
-O{0,2}) which indicated to me that the code was correct except for some
"cosmetic" errors. I dunno, perhaps this is my inexperience showing
through.

Thanks,

Denton

P.S. Do we want to quash the -O3 warnings as well?

> -Peff

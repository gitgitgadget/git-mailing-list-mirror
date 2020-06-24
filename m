Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6096C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B2620767
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moK3nJ7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406060AbgFXShS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405914AbgFXShS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 14:37:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37280C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 11:37:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p11so1527254pff.11
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J/rw0EefxXvXVhLS5F7HXInb0uxOEN9Og4pEwKBkx0w=;
        b=moK3nJ7GBmwwk7uJsSdOZnfWH3D0FVyJoEkGbtxolCDNXjw8T7nfx8WjDbnqlEd8wd
         wGmgoWWqDXhsXQo/z0utVwAm5nGOfGBwRFi5ktMcgAFV+qtMYPSExDNr6CyxvBQYBRWO
         ey7kBK96o2LEUrAcClEaPCGHM/p2IRO++fzAhifsWMKpvMzbHIxJh+eHoaCcG11GRjAR
         TDvRKOr9me+lkVw4sHXhMZ1i303dzbQhtIGR1NQSkFTIkQ8yamhw7UsM+prK1swK7nN5
         8agjALO3+vJSgEvqx75IXTRzx3hB63jeO28agzfRp8/ra9jvuiPUdnPvpnR5J13vI5Tl
         isoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J/rw0EefxXvXVhLS5F7HXInb0uxOEN9Og4pEwKBkx0w=;
        b=CNewluCfLQI7tfyaD1DZVys9dXRsJLI45bI0EN/YDEfDW62vNb24/tvWEfMD/EVBjC
         Z7OcUWJjFMMyOIr08WaFoEF5zEAsPKzJDoeBlnZAW3q8PiizOXEdQ8AbdQJLzhcBYB4f
         Y2AKVpfqmX8FhGte3zVL3WRQWVjaD/3aDBU/O8POZu6Tk64+ZSj0WY+RxLp3NdYgCQOJ
         Bw9JHCzgE0lMrEUtUkkoSSdXtNIqjikn0lsOgA64ZmhEBo42mFaO0X2MoXkZfDG6e6pG
         N6kO1yy5B5wty8rV11RZl+DjqMwQyoUriEbZfHp+NghNaTuYdMjIMHF/MtdRl4qS0N2C
         nt/w==
X-Gm-Message-State: AOAM532opHbSiHzCNe1gNJqwXjUioAlIQUkWGK5ABMP98Lzvse4sE3X2
        3CPGYbR5ijdYz2HQ3TXs6R+/Bw==
X-Google-Smtp-Source: ABdhPJymqNHRvkFa9JpUIedx4awmUa8bf0DNTWZjk8EA33WBHG3yOpfkGexAmx879RZWqaQbd3EMaQ==
X-Received: by 2002:a62:8c15:: with SMTP id m21mr29687208pfd.182.1593023837512;
        Wed, 24 Jun 2020 11:37:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id f20sm551646pfn.51.2020.06.24.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:37:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:37:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bugreport: generate config safelist based on docs
Message-ID: <20200624183711.GA165490@google.com>
References: <20200624012827.34126-1-emilyshaffer@google.com>
 <20200624012827.34126-2-emilyshaffer@google.com>
 <xmqq4kr19j3w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kr19j3w.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 09:35:15PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > ... To mark a config as safe,
> > add "annotate:bugreport[include]" to the corresponding line in the
> > config documentation; to mark it as unsafe, add
> > "annotate:bugreport[exclude]" instead.
> 
> Hmph,...
> 
> > -sendemail.smtpEncryption::
> > +sendemail.smtpEncryption annotate:bugreport[include] ::
> >  	See linkgit:git-send-email[1] for description.  Note that this
> >  	setting is not subject to the 'identity' mechanism.
> >  
> > @@ -15,7 +15,7 @@ sendemail.smtpsslcertpath::
> >  	Path to ca-certificates (either a directory or a single file).
> >  	Set it to an empty string to disable certificate verification.
> >  
> > -sendemail.<identity>.*::
> > +sendemail.<identity>.* annotate:bugreport[exclude] ::
> 
> So "sendemail.git-devel.cc" is not included due to [exclude] here,
> but ...

Hm, I can change this for the example, but I think it may still not be
included correctly because of the wildcard.  We had talked about whether
to include wildcarded options like this in the past too - I think that's
part of why I removed these couple patches from the initial bugreport
series.

If this line becomes included, then what we're really searching for is
anything matching "sendemail.*.*"; is this syntax regular enough to
count on in the generator script? Could the generator script do some
magic to turn <foo> and * into valid regex in the generated header and
then use that regex during the config parse?

Maybe using regex is overkill and I should just check for "*" during the
parse. Or maybe there's already a library to use. I'll dig into this
some today. Thanks for pointing it out.

> 
> > +sendemail.annotate annotate:bugreport[include] ::
> > +sendemail.bcc annotate:bugreport[include] ::
> > +sendemail.cc annotate:bugreport[include] ::
> 
> ... "sendemail.cc" that is a fallback value for other "sendemail.*.cc"
> is included?  
> 
> > +++ b/generate-bugreport-config-safelist.sh
> > @@ -0,0 +1,18 @@
> > +#!/bin/sh
> > +
> > +cat <<"EOF"
> > +/* Automatically generated by bugreport-generate-config-safelist.sh */
> > +
> > +
> > +static const char *bugreport_config_safelist[] = {
> > +EOF
> > +
> > +# cat all regular files in Documentation/config
> > +find Documentation/config -type f -exec cat {} \; |
> > +# print the command name which matches the annotate-bugreport macro
> > +sed -n 's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p' |
> > +	sort
> 
> We just care about "include" entries, so it does not matter whether
> we mark entries with [exclude] or not anyway?
> 
> Puzzled...

I wonder where I forgot to include the context for encouraging
"exclude". My thinking was that some organizations might have a lower
expectation of employee privacy, and therefore opt to use a blocklist
rather than a safelist for bug reports included internally. I suppose I
was thinking then that organization only needs to carry a patch to
invert the generator script, and not have to comb through all the
configs they care or don't care about themselves.

But as I'm revisiting this, it seems like that means a user who works
for Big Brother Corp but is told to "file that bug upstream" could then
leak their confidential info by accident, not realizing their
git-bugreport is using a wider net than upstream wants.

What do others think?

 - Emily

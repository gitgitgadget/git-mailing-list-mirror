Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC4C4332D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9520772
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pBsssAxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCRVUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:20:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRVUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 17:20:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so46886plr.11
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lHtvZHoHLMek/6xkhG69AFlRsdbOwVunBn8hLu5qRno=;
        b=pBsssAxRZmHUHAOi7TFFvrUQx1tKlvySj9WJM4bANKLLbGf0vgNB6xsaVMj+liX8KU
         4Tmeiv1XGu9h9a0lF69Wkmog5LkN+7AMp5QXSEJgrt5ympd9NEEoxPK7wGPK8F/esrRp
         KsFQ+XqrElMcwc1hA+3/C/KyVqzMAUFh7Oy+q7uj/QO9M56tURoifBYhGakdbcuG415v
         86XFbIsiQJkhI1OGPijamxkJjuzkMOZn0Oa9GhvF1C0zjjWBtr6GwM2Yj7TyZ4r2uNRe
         LWHjXxZ0XUERhE13kmyYEhF8EPf4nQPDPa9FOWaB5XFoiHZqGlNrrb8XB6FddzK0v2bw
         TCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lHtvZHoHLMek/6xkhG69AFlRsdbOwVunBn8hLu5qRno=;
        b=nYC7uO25EaaIr86hQZugQhHPvqt4ks4JdM1p1kqP49UedN5G+8eQojPAGCt1nTXkcn
         d6Td6asPd3I1hZhTqBbBcIs625pCequk1umfDckOGcwWfZnhXR+x1/0FEON9PpUmaom/
         8Ks4zGX2S4HOtBJciideOz731dMNUd/8+TbzD4rfK6fiAI31zh6bTbcc6E+npRtjbMvQ
         5epYLhYb8ORoufFjAH4eF5SBYK78u0YjtEVWTX4H1W9zZ1c4VYINYHmOCoQT+m1dk479
         dCVClR5gcGqpGSMU8cOZkz0wHvPGs8tEK4/FjZKrBkszMpAA2L3oSUndqqw0/ogwOMe+
         VMQw==
X-Gm-Message-State: ANhLgQ1wx7e23dXI0Uh/2dhZP4iT11BV7eOlkjGj1z6UEP0CZLleGqED
        8S5ImLi4GXvdl5DRIdNijLFDxQ==
X-Google-Smtp-Source: ADFU+vvxac+fcESzENLdNb2q7GsIgl/+n1E24D+2x5twIInaVfYhqLxtuVHJ71Ri4pn3DzVI62vtbw==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr187104plp.192.1584566412441;
        Wed, 18 Mar 2020 14:20:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y9sm3136623pjj.17.2020.03.18.14.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:20:11 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:20:11 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, peff@peff.net, james@jramsay.com.au
Subject: Re: [RFC PATCH 2/2] upload-pack.c: allow banning certain object
 filter(s)
Message-ID: <20200318212011.GD31397@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
 <13dd0152-b20a-51e1-5940-5e4b67242e9b@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13dd0152-b20a-51e1-5940-5e4b67242e9b@iee.email>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Wed, Mar 18, 2020 at 11:18:16AM +0000, Philip Oakley wrote:
> Hi
> On 17/03/2020 20:39, Taylor Blau wrote:
> > Git clients may ask the server for a partial set of objects, where the
> > set of objects being requested is refined by one or more object filters.
> > Server administrators can configure 'git upload-pack' to allow or ban
> > these filters by setting the 'uploadpack.allowFilter' variable to
> > 'true' or 'false', respectively.
> >
> > However, administrators using bitmaps may wish to allow certain kinds of
> > object filters, but ban others. Specifically, they may wish to allow
> > object filters that can be optimized by the use of bitmaps, while
> > rejecting other object filters which aren't and represent a perceived
> > performance degradation (as well as an increased load factor on the
> > server).
> >
> > Allow configuring 'git upload-pack' to support object filters on a
> > case-by-case basis by introducing a new configuration variable and
> > section:
> >
> >   - 'uploadpack.filter.allow'
> >
> >   - 'uploadpack.filter.<kind>.allow'
> >
> > where '<kind>' may be one of 'blob:none', 'blob:limit', 'tree:depth',
> > and so on. The additional '.' between 'filter' and '<kind>' is part of
> > the sub-section.
> >
> > Setting the second configuration variable for any valid value of
> > '<kind>' explicitly allows or disallows restricting that kind of object
> > filter.
> >
> > If a client requests the object filter <kind> and the respective
> > configuration value is not set, 'git upload-pack' will default to the
> > value of 'uploadpack.filter.allow', which itself defaults to 'true' to
> > maintain backwards compatibility. Note that this differs from
> > 'uploadpack.allowfilter', which controls whether or not the 'filter'
> > capability is advertised.
> >
> > NB: this introduces an unfortunate possibility that attempt to write the
> > ERR sideband will cause a SIGPIPE. This can be prevented by some of
> > SZEDZER's previous work, but it is silenced in 't' for now.
> > ---
> >  Documentation/config/uploadpack.txt | 12 ++++++
> >  t/t5616-partial-clone.sh            | 23 ++++++++++
> >  upload-pack.c                       | 67 +++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >
> > diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
> > index ed1c835695..6213bd619c 100644
> > --- a/Documentation/config/uploadpack.txt
> > +++ b/Documentation/config/uploadpack.txt
> > @@ -57,6 +57,18 @@ uploadpack.allowFilter::
> >  	If this option is set, `upload-pack` will support partial
> >  	clone and partial fetch object filtering.
> >
> > +uploadpack.filter.allow::
> > +	Provides a default value for unspecified object filters (see: the
> > +	below configuration variable).
> > +	Defaults to `true`.
> > +
> > +uploadpack.filter.<filter>.allow::
> > +	Explicitly allow or ban the object filter corresponding to `<filter>`,
> > +	where `<filter>` may be one of: `blob:none`, `blob:limit`, `tree:depth`,
> > +	`sparse:oid`, or `combine`. If using combined filters, both `combine`
> > +	and all of the nested filter kinds must be allowed.
>
> Doesn't the man page at least need the part from the commit message "The
> additional '.' between 'filter' and '<kind>' is part of
> the sub-section." as it's not a common mechanism (other comments not
> withstanding)

Thanks, you're certainly right. I wrote the man pages back when the
configuration was spelled:

  $ git config uploadpack.filter=blob:none.allow true

But now that there is the extra '.', it's worth calling out here, too.
I'll make sure that this is addressed based on the outcome of the
discussion below when these patches hit non-RFC status.

> Philip

Thanks,
Taylor

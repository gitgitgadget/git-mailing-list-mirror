Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABEC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A2720671
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="l0RdBBU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbgEMTsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTsv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:48:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C52C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:48:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so11438757pjb.5
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fg4kmI10wEnBojZ0TieuL7FIHIoEfS4HAVRo3QVasEM=;
        b=l0RdBBU/St2LHQiUU5ZyMn4E/vyU0E0iqp+pQuqp/jTtMRvbmNbgZgMTRXCRc8l+Nv
         +BcwIrOkZni+rQxC5jU5uJDbMCFBTxjupjHWfbmUDaZzQIMY7mf2BiDgdUNhqf15jS5d
         UZ1VTdzvPie3hvdXJmq40YdfSIYtlfjcOImpiT6wkyMUppidSvrFjpmxkF2nLnOlOXPI
         99HGyFMuZT41AtNnhpIOgPOWo5wwAYH+LJdn/fWlOJDU5bKN6qPsd/PLu/Co8vGvbrEo
         eR2JYK+uovBQsXUDXZ5vjnpQ76EQrBHVFNjqi8647vSG+tcJ2iWjyBqLQm21bEdTMaOF
         Oevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fg4kmI10wEnBojZ0TieuL7FIHIoEfS4HAVRo3QVasEM=;
        b=Ugy/LOY+ZsEx9A3LXrgaRLUEjitZGm5usbwDofWCKvyN4gNuvDxbvv2eHkPY5N2uQO
         jh9eYnGXB+G+RqtzQDB8a1Qgx8HHCbdSzGnFKgm3zwsV3PcoH0LUZ+Mog/MSPaz9Z8q2
         K2cHcp1OaEajzKHhOyQTchiOtB3p2FtjaTwh8Lk0UL2xA1MDtxwa4I4DLDY0yB92P6zW
         eRdSxZIQ0gmcC0xGWZBjFfqgxb6M9YZSc8EcejToqnD53sPMHKu04He+XnYrCc/p1X3J
         5rrhQDJ006vyy73D1GbVmXCScEA7IM09EP+HDjH62hNaiBOrlmstmBvP0EX3YPDv37/I
         voEg==
X-Gm-Message-State: AOAM530+3VP111HOzpv7F8xKwtutXXgpHwGw6jgjx+71t6ty+KIs0VE6
        rjV95F556II3P4NYxkNobT76Qg==
X-Google-Smtp-Source: ABdhPJzn7gZVivu8OyeQwkj7UHC7t5X+JdVuFkwTSiaHB/tVT6wvuTV88sOSZhdFGz8+VZR7SqyzKw==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr3094682pjs.165.1589399330954;
        Wed, 13 May 2020 12:48:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c2sm408140pgj.93.2020.05.13.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 12:48:50 -0700 (PDT)
Date:   Wed, 13 May 2020 13:48:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <20200513194848.GA24173@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <5ff56feab55b005b4a4d9559909ce7a08e5fa81e.1588641176.git.me@ttaylorr.com>
 <20200507195441.GA29683@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507195441.GA29683@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 03:54:41PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 07:13:43PM -0600, Taylor Blau wrote:
>
> > While iterating references (to discover the set of commits to write to
> > the commit-graph with 'git commit-graph write --reachable'),
> > 'add_ref_to_set' can save 'fill_oids_from_commits()' some time by
> > peeling the references beforehand.
> >
> > Move peeling out of 'fill_oids_from_commits()' and into
> > 'add_ref_to_set()' to use 'peel_ref()' instead of 'deref_tag()'. Doing
> > so allows the commit-graph machinery to use the peeled value from
> > '$GIT_DIR/packed-refs' instead of having to load and parse tags.
>
> Or having to load and parse commits only to find out that they're not
> tags. :)
>
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 8f61256b0a..5c3fad0dd7 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1327,11 +1327,15 @@ static int add_ref_to_set(const char *refname,
> >  			  const struct object_id *oid,
> >  			  int flags, void *cb_data)
> >  {
> > +	struct object_id peeled;
> >  	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
> >
> >  	display_progress(data->progress, oidset_size(data->commits) + 1);
> >
> > -	oidset_insert(data->commits, oid);
> > +	if (peel_ref(refname, &peeled))
> > +		peeled = *oid;
>
> It may be the old-timer C programmer in me, but I always look slightly
> suspicious at struct assignments. We know that object_id doesn't need a
> deep copy, so it's obviously OK here. But should we use oidcpy() as a
> style thing?
>
> Alternatively, you could do this without a struct copy at all with:
>
>   if (!peel_ref(...))
>          oid = peeled;
>   oidset_insert(..., oid);
>
> which is actually a bit cheaper.

Makes sense, I think this version is the better of the two that you
suggested here. I noticed one small thing which is that since peeled is
only on the stack, I think we actually want 'oid = &peeled', but
otherwise I took this as-is.

> > +	if (oid_object_info(the_repository, &peeled, NULL) == OBJ_COMMIT)
> > +		oidset_insert(data->commits, &peeled);
>
> I probably would have left adding this "if" until a later step, but I
> think it's OK here.

Yeah, I did it here to avoid having to add a seemingly-unrelated change
later on. I agree it doesn't matter much, so in the interest of leaving
the series alone, I'll leave it where it is here.

> -Peff

Thanks,
Taylor

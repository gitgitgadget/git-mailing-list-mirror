Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908DFC6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbjHXWsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbjHXWrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 18:47:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D43E4B
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:47:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59231a1ca9eso4419907b3.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692917269; x=1693522069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdXPXKvwg6/c+D+fktXfz6BHShux2ILztKUWLJuomU0=;
        b=DqqfUD0VytkA+tKC/3uw4T0lxBTRjlb8TpZUlQWSnmCIbGWOSrwfngWuCyr6XPSfqO
         2RarkaKOcI94Aityx11G3lZZt+TjkeriGH9UVsTp6/tNTp/JEypfGmbpBMp4KjfDT3ax
         K5iUMzl+Qiv4Y+vKvIYcCsR6UY6EQ/T3jf1P+KQK0j4cde2JYqwtPYxDUb8JxNJIUbB3
         qsrJdQ75zNlLZI1eg50SUpd7ez6WTYu4VhRKBTVR1axHh152PtMZt1HxuVUj23mZBbiZ
         IDmgRt3CzqN2o2DqL9eRwwhi23pEGRy53saTAx7ES/oqQE11s1UWozaxw6FlraOIHXU1
         d89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917269; x=1693522069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdXPXKvwg6/c+D+fktXfz6BHShux2ILztKUWLJuomU0=;
        b=XXIpJ2gkgKC4V5amf9yzgX6SkgQkJ3IPpBBc5OfmM6mQnjCfTE399KNzS8aqnFgaiZ
         jWaV0P5aGvH4w/WvSs47QWBNfclO1Nq4dIWxuQOGNN2N7RHfRqf34pb1SbsPxCe5zx37
         XcV5Ag9fjXaJ2hM3KErrNN+TM3PRfItayLhLEiV2DFCKbd/SkcfT9ViiYP/PndtI44QM
         lYQtORDwVlSylX4JwyR/b+lB5l6Xt4SjFqmEYqP6zG5QiGc2JMfiTSK6v0xvXvLfE7Bb
         U4dlGYK0x6dAqI1wkLi5+loKKSeJwkfOLL7jFOQ2eyyl1uMSrAkFQ/0NuE74wv/Jkyor
         E+mQ==
X-Gm-Message-State: AOJu0YwM49gS4UKu0TZS0SIFiVo4qoCrvyw8g7dqTxnPP90qqcUPgYFN
        j/J1x8+NPAiy5i/IfwXxiDpmWw==
X-Google-Smtp-Source: AGHT+IHgtAAozQhM2WH8w0DfNtsqMDCflqjEaAsyTAXRnHIkHMUuFC8WNgT78FjQOHsMZW/+DiFLLg==
X-Received: by 2002:a81:478b:0:b0:589:d617:e7c4 with SMTP id u133-20020a81478b000000b00589d617e7c4mr16358792ywa.16.1692917269214;
        Thu, 24 Aug 2023 15:47:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c80-20020a814e53000000b0058ddb62f99bsm155098ywb.38.2023.08.24.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:47:48 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:47:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom
 filters
Message-ID: <ZOfeE1K8aRIECVm4@nand.local>
References: <a4cb5fe69247ba737a8373948c1f4ff8a150d283.1691426160.git.me@ttaylorr.com>
 <20230824222051.2320003-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824222051.2320003-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 03:20:51PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/bloom.c b/bloom.c
> > index 9b6a30f6f6..739fa093ba 100644
> > --- a/bloom.c
> > +++ b/bloom.c
> > @@ -250,6 +250,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
> >  	filter->version = version;
> >  }
> >
> > +struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
> > +{
> > +	struct bloom_filter *filter;
> > +	int hash_version;
> > +
> > +	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
> > +	if (!filter)
> > +		return NULL;
> > +
> > +	prepare_repo_settings(r);
> > +	hash_version = r->settings.commit_graph_changed_paths_version;
> > +
> > +	if (!(hash_version == -1 || hash_version == filter->version))
> > +		return NULL; /* unusable filter */
> > +	return filter;
> > +}
>
> I missed this the last time, but this should match what fill_bloom_key()
> does. Use get_bloom_filter_settings(),

I'm not sure I'm following. Are you saying that we should use
get_bloom_filter_settings() instead of reading the value from
r->settings directly?

> then compare filter->version to version 2 if hash_version is 2, and to
> version 1 otherwise.

Hmm. I think we're already doing the right thing here, no? IIUC, you're
saying to do something like:

    struct bloom_filter_settings *s = get_bloom_filter_settings(r);
    struct bloom_filter *f = get_or_compute_bloom_filter(r, c, ...);
    int hash_version;

    if (!f)
      return NULL;

    prepare_repo_settings(r);
    hash_version = r->settings.commit_graph_changed_paths_version;

    if (!(hash_version == -1 || hash_version == s->hash_version))
      return NULL; /* incompatible */
    return f;

?

If so, I think that we're already OK here, since s->hash_version is
always going to take the same value as f->version, since f->version is
assigned in bloom.c::load_bloom_filter_from_graph(), which does:

    filter->version = g->bloom_filter_settings->hash_version;

Or are we talking about two different things entirely? ;-)

Thanks,
Taylor

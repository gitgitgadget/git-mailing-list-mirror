Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72564EE49B1
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHUUlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUUkd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:40:33 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F7199
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:40:08 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bd0a96e63dso2943214a34.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692650408; x=1693255208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctiu7jqYDs5wT3M/4wLz05C9FQeEfKQJq+h8S9O7CvE=;
        b=d1QtIPk72knYdHcBuJGwKKSxIupYFQXvWnxkt28h3EAwegM2GHvnkblaDJzV5Cn10+
         BmpB8NvuBlt4HauGgfrovWEPmO/fTYZ73t78eSQMFUPFVKn7RzbB1ZBM1LkV/kA0HjvC
         nnOVeEgU3bHpkW4C5IZ9w5i5VQTo83yIiKngX/mkxd1Lp/smhN09J54xI0w7YeyOxF86
         qFKSVJ675TU44zYo33k8Kn97M5CcYQXm5narICZndE40ImYAsMsk4tpGt1XPq+5pZMhc
         1AO2sU0A0duSCTHk6wxiyIEqoVz0CZchYUv8x+akTm+dcxFpf9Gl84pU405UKxEggiKI
         WO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692650408; x=1693255208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctiu7jqYDs5wT3M/4wLz05C9FQeEfKQJq+h8S9O7CvE=;
        b=dZ5bONA10peDfjDfqtnJDO27DqD1dasYEEyIL6Ro4MCa+0sO54NoTbjqXt1nR9DqNu
         hWAQ4W3rFwlSmw196YEfjt0oeQs9YhwKCVJxDHpUf0DnADb+10ll3+wQIzAEoaHtkdYR
         GWguyN3eArN6oezenm/p3IGkTI38mXagratGGrUml8AwIgticLOEZSXs0x7510hSmmVu
         Intx+IryCUqPzOm1HPxeAeDh/6rOA8K4LVVPtbQ0t1C7NFWcY0s+Z8+xvJKdoi5ynxE3
         HRUcFmOj7dHwU1pF7n8TTc+szb6jVchl8+RbubxYcDHSvTfns+sz3/ad4RBEU4sdYVUS
         yLRg==
X-Gm-Message-State: AOJu0YyPXeXBuav6bMczM4ipy4Akm1gS5AednFNUy/LRj00U7ijH8hjg
        Rylm9w2jyINqNICGWQkzjFl5lQ==
X-Google-Smtp-Source: AGHT+IHkMKPyDnzRANjZc1xko+C4Tdv/xT42XUNZaPIedLArz0XMYZeXz/Ptuz3Ul27KxAcLIE5fBQ==
X-Received: by 2002:a05:6358:7246:b0:134:eed0:3bc5 with SMTP id i6-20020a056358724600b00134eed03bc5mr7842189rwa.9.1692650407771;
        Mon, 21 Aug 2023 13:40:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u66-20020a25ab48000000b00d6a4bae16bbsm2049943ybi.49.2023.08.21.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:40:07 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:40:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/6] commit-graph.c: unconditionally load Bloom
 filters
Message-ID: <ZOPLphXoMjq876Wk@nand.local>
References: <6676afe56db74828ba2532f3460e9b73a3ff20fd.1691426160.git.me@ttaylorr.com>
 <20230811220030.3329161-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811220030.3329161-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 03:00:30PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 38edb12669..60e5f9ada7 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -317,12 +317,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
> >  	uint32_t hash_version;
> >  	hash_version = get_be32(chunk_start);
> >
> > -	if (*c->commit_graph_changed_paths_version == -1) {
> > -		*c->commit_graph_changed_paths_version = hash_version;
> > -	} else if (hash_version != *c->commit_graph_changed_paths_version) {
> > -		return 0;
> > -	}
>
> Lots of things to notice in this patch, but the summary is that this
> patch looks correct.

Thanks for the detailed analysis here. This is definitely the patch that
I was most nervous about while writing, but I appreciate the second set
of eyes.

> (Also, I don't think we need the commit_graph_changed_paths_version
> variable anymore.)

Great catch, thanks. I cleaned that up in a separate commit after this
one, since I think that this patch is already intricate enough.

Thanks,
Taylor

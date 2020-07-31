Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A8C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E123822B42
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XUPUyndm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgGaVUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGaVUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:20:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE71C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:20:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so14805279qvb.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tUnnbTMOxBSEE/N4/2AkR6U0JcuMnefGLlIB5ZNVaE=;
        b=XUPUyndmJpxqLmGtvdNf1/d+2J4qvR6tCj7Qklopuo8HRM/4x5itQsO1VbCcKdWpGc
         Ua+E9RjHgKqzfshJYicPRYr3lNxpRonY4MSAZAERBwSoxv9aj/jU+eo1RPHt7trSd9nw
         wpHgwdLzlGm4iYfE3rsVftwqfI2lD8ml3NoRdSuXYbY2FQDbCKry355yOGK/9SCVLnxj
         6qqvlAVz+dn6NqwOSOAvOt5frtNETuoIe2NTF3YBfPXuvwG8Y6GYlM5oEfGhF/xNshKu
         pYozJIJK+tR8A2emu3pBtqtgAi+ewG+gEnazjxUrtXS/Fgr8YXFFrNHeH+EAJ7Y6mPNM
         ldBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tUnnbTMOxBSEE/N4/2AkR6U0JcuMnefGLlIB5ZNVaE=;
        b=O8s5Inn20212sCeLS+ecCbEVlekAamt3205r4xGe8k2K/adX5cbX7rrylCIkwPLQ1a
         6uAMKsZs9ay49ClINWAqja0M75XeV8d3dN8mP3dR9zl+aTwcBrZzKE6xOpG2UI1a3j5q
         7HJtSt6R7uSo30eNEhsuMVWGpn85OWaGm0MTMIfINAWp2GUqnOr9C2/75VD3wSoCtObj
         r9zBHYycNIPuUk/NAOeXct/Br0xFUaKPeXjxvC5cPcsqtFjN4U0qpyTdR8WTu0zZ7Mta
         rfOdOlTd8ZnCYouueRYgE5qWFAZiqAjbf31VjzHQZiMZ0TfAc+AhmDV7dQ6U5i/0q0s0
         fUgQ==
X-Gm-Message-State: AOAM532sphFOq9kNcDqFx6DOMLy07YTvi3ClY3WAyCZxpKb7RmdCeYld
        z/PZQl9pfERfOIs4+uO4V2Jev+fPhxrD/A==
X-Google-Smtp-Source: ABdhPJzQg4qWO6PUhhm7iEpAmjo7nf1giQ0AvXVrk8T9/JV1+Q4UxDgi8FurgimWxZv1mWtX6LpsLQ==
X-Received: by 2002:a0c:ac4c:: with SMTP id m12mr6159586qvb.218.1596230434871;
        Fri, 31 Jul 2020 14:20:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id b23sm7499307qtp.41.2020.07.31.14.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:20:34 -0700 (PDT)
Date:   Fri, 31 Jul 2020 17:20:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 2/4] upload-pack.c: allow banning certain object
 filter(s)
Message-ID: <20200731212032.GD3409@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <a0a04277578333daa0b38a8e06e1738b920f5ac3.1596227003.git.me@ttaylorr.com>
 <20200731205434.GB1440890@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731205434.GB1440890@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 04:54:34PM -0400, Jeff King wrote:
> On Fri, Jul 31, 2020 at 04:26:31PM -0400, Taylor Blau wrote:
>
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
> > case-by-case basis by introducing two new configuration variables:
> >
> >   - 'uploadpackfilter.allow'
> >   - 'uploadpackfilter.<kind>.allow'
> >
> > where '<kind>' may be one of 'blobNone', 'blobLimit', 'tree', and so on.
>
> Minor nit, but <kind> is "blob:none", "blob:limit", etc. The code and
> documentation gets this right; it's just the commit message.
>
> I'm pretty sure this is a casualty of updating the syntax as the series
> was developed. One trick I use is to avoid repeating explanations that
> are in the documentation from the patch already. I.e., explain "why"
> here, but it's OK to let "what" come from the patch itself. That's not
> only one less thing to remember to update, but it's less for reviewers
> to read through, too.
>
> </meta-patch-advice>

Good advice, and you're right that <kind> is blob:none and similar, not
'blobNone'. In this case, I think the "why" is pretty boring, so I don't
mind repeating myself a little bit in the commit message.
>
> > +test_expect_success 'upload-pack fails banned object filters' '
> > +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
> > +	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
> > +		"file://$(pwd)/srv.bare" pc3 2>err &&
> > +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
> > +'
>
> These messages aren't translated now, so we can just use grep, I think.
>
> Ditto in the other tests below.

Ack, yep.

>
> > +static void die_if_using_banned_filter(struct upload_pack_data *data)
> > +{
> > +	struct list_objects_filter_options *banned = banned_filter(data,
> > +								   &data->filter_options);
> > +	struct strbuf buf = STRBUF_INIT;
> > +	if (!banned)
> > +		return;
> > +
> > +	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
> > +		    list_object_filter_config_name(banned->choice));
> > +
> > +	packet_writer_error(&data->writer, "%s\n", buf.buf);
> > +	die("%s", buf.buf);
> > +}
>
> Hmm, the strbuf was unexpected. I'd have just written it out twice.
> After all, the messages don't have to be the same. And perhaps we don't
> want them to be the same? A user receiving the ERR packet would see:
>
>   remote error: git upload-pack: filter 'foo' not supported
>
> do we need the "git upload-pack" part there? Other errors say just
> "upload-pack". IMHO even that is unnecessarily verbose, and I wouldn't
> mind a separate patch to reduce it. But definitely going even longer
> doesn't seem like the right direction. :)

Let's drop 'git upload-pack: ' entirely, and just start the message with
'filter ...'. It looks like you figured out why we use a strbuf here in
your response to the fourth patch.

> I also wondered about the trailing newline. Other callers of
> packet_writer_error() don't seem to use it. I think in practice it
> doesn't matter much because readers will generally be using
> CHOMP_NEWLINE, but it probably makes sense to be consistent.

Dropping the newline should be easy enough.

>
> > [...]
>
> Aside from this nits, this patch looks good to me.
>
> -Peff

Thanks,
Taylor

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB95EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFTMQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTMQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:16:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7914CB7
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:16:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5701e8f2b79so52008097b3.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687263414; x=1689855414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7iIYb2WuystWP+qShf5HRUrQVcwjCUuPvFtFAIOdPoI=;
        b=dW8nLUPvHqYZ8iIL/fRJep5HqwLUvmdah8y3oYeB8RWEgKH+4rY02Q0ONEICa2fPgM
         zEeJT1OH+OHOA5fg9vlyj0nec9FHsl5dBhNRBQA6bUcxyd2Xmm6fKK5XlQbYw2c1i//Q
         G3fyuML4nJJf/j4UAR89ED87gM1eu43U0poz6xZcMoj+hApWLPD2gQ6w9PXyUKEhyahK
         jYynoOnyLbichyo3asvXrmb5nv2MvgNluS38SyFaJwRCqtpE6RxiImK5Fw6vHBCKJRRK
         T5URn7kXZPNOOVuGol8in2tmjw8zi5kyiUW7loZ6e0xpHl5AK82H8WE5nuXvVuN79akq
         bCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263414; x=1689855414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iIYb2WuystWP+qShf5HRUrQVcwjCUuPvFtFAIOdPoI=;
        b=kVatZZoAL9vuYTI2E+MuloBxOJ5RNjU5KdELlGSMx9VKb33H5sAPl9EnlP60m1R82c
         Ygmd6sa3OWicSqGm05A8XPVNE8gDWqnYskS6w26E+2HUT+pblZf8eRBL9J7IIVjecmMA
         6eyTnoeUWcWrWSZJWpjSNS9GtIYhycoA/27APE2UwHNdsSiJoQsSTHXu1XVxKj46P9dc
         vtWUaJhhRiqpOMQ+/+5TWV1w2v3hSNthn4rcjO6+z8sVe391wNFiqY+ahYBemY1oFvCp
         vvG7DvsZjpmqkp/HcPId55jqtpG/hCtcxBWjmd3mf54iLJ+cf1thDTA0NADaUWQ+htGX
         tIow==
X-Gm-Message-State: AC+VfDxC6cgPyRCQiUpEXlJUzPdzEHXoG3pVpQR2ReNnQLrjCuuut/J5
        DNEzQflCM52fRuUlTO5cpp6LBA==
X-Google-Smtp-Source: ACHHUZ5bU68fo+nJKwPSR3XjODvS5jX/M0fIGOE5Eq6lvmvn+EmJBN4f+tGb/vLjJoBZlbFpK2tLEQ==
X-Received: by 2002:a0d:cc84:0:b0:570:75e3:2eaa with SMTP id o126-20020a0dcc84000000b0057075e32eaamr11985055ywd.25.1687263414697;
        Tue, 20 Jun 2023 05:16:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z192-20020a0dd7c9000000b005702bfb19bfsm454210ywd.130.2023.06.20.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:16:54 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:16:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <ZJGYs4hWjdMTSMm4@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <f765b50a8405f1653cbc2e79b375c979c4361550.1684178576.git.me@ttaylorr.com>
 <ZH7ZqjYqyvSOHY8u@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH7ZqjYqyvSOHY8u@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2023 at 09:00:58AM +0200, Patrick Steinhardt wrote:
> On Mon, May 15, 2023 at 03:23:39PM -0400, Taylor Blau wrote:
> > In subsequent commits, it will be convenient to have a 'const char **'
> > of hidden refs (matching `transfer.hiderefs`, `uploadpack.hideRefs`,
> > etc.), instead of a `string_list`.
> >
> > Convert spots throughout the tree that store the list of hidden refs
> > from a `string_list` to a `strvec`.
> >
> > Note that in `parse_hide_refs_config()` there is an ugly const-cast used
> > to avoid an extra copy of each value before trimming any trailing slash
> > characters. This could instead be written as:
> >
> >     ref = xstrdup(value);
> >     len = strlen(ref);
> >     while (len && ref[len - 1] == '/')
> >             ref[--len] = '\0';
> >     strvec_push(hide_refs, ref);
> >     free(ref);
> >
> > but the double-copy (once when calling `xstrdup()`, and another via
> > `strvec_push()`) is wasteful.
>
> I guess the proper way to fix this would be to introduce something like
> a `strvec_push_nodup()` function that takes ownership. And in fact this
> helper exists already, but it's declared as static. So we could get
> around the ugly cast with a simple change to expose the helper function.

We could, but I'd prefer to explore doing so outside of this series,
since I think strvec_push_nodup() is a little bit of a footgun unless
you are thinking carefully about ownership. So making the function
part of the exposed API may be controversial.

Thanks,
Taylor

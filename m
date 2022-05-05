Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4503FC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiEEQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381696AbiEEQu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 12:50:57 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691D21C137
        for <git@vger.kernel.org>; Thu,  5 May 2022 09:47:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r185so95678oih.5
        for <git@vger.kernel.org>; Thu, 05 May 2022 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQxRWZAMyvfP6h6FK7uGiMqMWberLpNMVxMu46Ml4IA=;
        b=U4G/ASGYbfP8PZ1GwFFPMtAvewT+zHUTwcEokanoaXuQZ7eRkdBUe4OeNdu8JkCZh7
         oqoFg/K26JI++zFqB+V3BgMMEp9M/hpXkt1UvA5xLV16ai3Q5S7AOCOnU8VXy44EeZ+m
         KUFoPkSzXQcASI0nNhE1GhiiHR/2GI0kfNJN1tUgU9ig4oWH77bLvbeXUJ50xgnlR3Q5
         PLVco091381h0cGcXph40Fzg22LQQDNQPRN8e+YBhbzdO0zZz0YB6Kb+rpZYRGBDiNVh
         0s4ggrRVa1JO8bZO8m5564hH3WpFX7atCqiImci2lL6pprNiIqlOM/o3fc4BmnU5gZYX
         6nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQxRWZAMyvfP6h6FK7uGiMqMWberLpNMVxMu46Ml4IA=;
        b=XK73hXBCzEOvsNoIj05QrqN4ITxNuoXKPbke5ZdH5wrZGKN4bqB7SNHh/SHIfqIluv
         3+xM8+FwaOwdODCCq3EpIZwFm0JxCbbVN+Ss8HdECcQol9kAhfoZl25aknCTthF6/Dqz
         WBmn1gAp0fEyqO0ddM2QVshMt63Dh6uCfzu3n/zO+w7zZzhhKMA+QIXeYKh5AB7NRYF6
         ju7qDIs+vtKWo7A4tb2zSVDzrln07BCySu3RwvjhgDL7up3pxcJcHPaHtaLSwMZK0Ept
         H+97BG7yeN5yyfuv2zFPfC6wO6xGj+sUgf2I2wByVcSFE3dm3wGdfud/vTK2EJVVE26e
         Vg8w==
X-Gm-Message-State: AOAM531+9kAVC1EP7E4k2o0CXXFnGKDZAcAkYxTiODqCdkncv3ZmF6TH
        zhj8Rj7tQxCnHhaO9fFlWYGL8khIcHDQr83JFcc1Rb3mKvY=
X-Google-Smtp-Source: ABdhPJxzypcupDbUf/lhYwbGyx/sOnMHn5xrmijGNVNqxQmpND82WZRzwTpz2qDRDlwyl9K9UGAqy871InHjBmKgGPM=
X-Received: by 2002:a05:6808:1387:b0:325:93d:eb4b with SMTP id
 c7-20020a056808138700b00325093deb4bmr2981401oiw.213.1651769236616; Thu, 05
 May 2022 09:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
 <20220502170904.2770649-1-calvinwan@google.com> <20220502170904.2770649-4-calvinwan@google.com>
 <xmqqzgjztt7s.fsf@gitster.g> <xmqqv8ukkf6o.fsf@gitster.g>
In-Reply-To: <xmqqv8ukkf6o.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 5 May 2022 09:47:05 -0700
Message-ID: <CAFySSZB72GTaJRvoGXgfkBE3w6+pYz9QVpGgEcsxy_8EDG-xpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] object-store: add function to free object_info contents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the mistakes. Getting a script from Josh Steadmon to
make sure these things never happen again :)

On Wed, May 4, 2022 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +    if (object_info->typep)
> >> +            free(object_info->typep);
> >> +    if (object_info->sizep)
> >> +            free(object_info->sizep);
> >> +    if (object_info->disk_sizep)
> >> +            free(object_info->disk_sizep);
> >> +    if (object_info->delta_base_oid)
> >> +            free(object_info->delta_base_oid);
> >> +    if (object_info->type_name)
> >> +            free(object_info->type_name);
> >
> >       if (PTR)
> >               free(PTR);
> >
> > can and should be written as
> >
> >       free(PTR);
> >
> > If we are reusing object_info after calling this function, we
> > _might_ want to use FREE_AND_NULL() instead of free().
>
> > As this breaks my build cycle ("make sparse" is part of my
> > post-integration check), I have added this workaround on the tip of
> > the topic, but please make sure I do not have to redo that when you
> > reroll.
> >
> > Thanks.
>
> Again, this breaks the build at GitHub CI (static-analysis), I added
> this workaround on the tip of the topic, merged it to 'seen' and
> pushed the result out, but please make sure I do not have to redo
> that when you reroll.
>
> Thanks.

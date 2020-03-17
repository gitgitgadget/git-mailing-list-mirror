Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13413C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E498920714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCQUx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:53:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53111 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCQUx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 16:53:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so833669wmo.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 13:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brvLYpqKE3T1y+hSxTHGZFvkFEU114krp+XaoKEozRk=;
        b=B0MlU7BzuNdQmnog8w6rUGPKd0+Ymt3hDsdl/u0kTY2B9Zh8e0bFx/VVxrw+dVxR7s
         7P2Vm4lPNgnOARXGTAORd0fhqE/nfO4WSSZZhOgjd2TFrKRJztSpvcCCRlosLWHliZpU
         eDfhzJtbFEQvEZ0jj0i9eqRHHR4IuJYS4lsgMpQMPezTXEbbp7QK5NDh0xW2Kb04gZxv
         Taj/XQMVH7X7hiF4C2ZgRjQOPz5pAxFUcjkUF9xSRn/Z3xNGzZa7ato664WZbqLkLS1N
         5EfypL8g50HKtc94Ld1Y4o/NsHpLN5uAwyCoAFq0Rb1YjbWR05zfl5ywHrQ8Nf8M1tyN
         F1Og==
X-Gm-Message-State: ANhLgQ0MtQfEDLoYp/xVV/OEZD93LmyEShLEGatGy2cPix9Q22XjvH20
        oYV2ybZTItcoWP3OSNA+GdZqnke0Bk85FQza3Uo=
X-Google-Smtp-Source: ADFU+vvZKOQfXNOTMRtf+eiiXhNTu56FieE+lf4zB/O7n7ITjB7cy+3pp/VQ32uzpFHSuI62Y8Jm2ir4ycNzuzugrWM=
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr864857wmh.130.1584478435502;
 Tue, 17 Mar 2020 13:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
In-Reply-To: <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Mar 2020 16:53:44 -0400
Message-ID: <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce 'list_object_filter_config_name'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, james@jramsay.com.au
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 4:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> In a subsequent commit, we will add configuration options that are
> specific to each kind of object filter, in which case it is handy to
> have a function that translates between 'enum
> list_objects_filter_choice' and an appropriate configuration-friendly
> string.
> ---

Missing sign-off (but perhaps that's intentional since this is RFC).

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> @@ -15,6 +15,31 @@ static int parse_combine_filter(
> +const char *list_object_filter_config_name(enum list_objects_filter_choice c)
> +{
> +       switch (c) {
> +       case LOFC_BLOB_NONE:
> +               return "blob:none";
> +       case LOFC_BLOB_LIMIT:
> +               return "blob:limit";
> +       case LOFC_TREE_DEPTH:
> +               return "tree:depth";
> +       case LOFC_SPARSE_OID:
> +               return "sparse:oid";
> +       case LOFC_COMBINE:
> +               return "combine";
> +       case LOFC_DISABLED:
> +       case LOFC__COUNT:
> +               /*
> +                * Include these to catch all enumerated values, but
> +                * break to treat them as a bug. Any new values of this
> +                * enum will cause a compiler error, as desired.
> +                */

In general, people will see a warning, not an error, unless they
specifically use -Werror (or such) to turn the warning into an error,
so this statement is misleading. Also, while some compilers may
complain, others may not. So, although the comment claims that we will
notice an unhandled enum constant at compile-time, that isn't
necessarily the case.

Moreover, the comment itself, in is present form, is rather
superfluous since its merely repeating what the BUG() invocation just
below it already tells me. In fact, as a reader of this code, I would
be more interested in knowing why those two cases do not have string
equivalents which are returned (although perhaps even that would be
obvious to someone familiar with the code, hence the comment can
probably be dropped altogether).

> +               break;
> +       }
> +       BUG("list_object_filter_choice_name: invalid argument '%d'", c);
> +}

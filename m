Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1904208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeHHADj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 20:03:39 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:46897 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeHHADi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 20:03:38 -0400
Received: by mail-yw1-f52.google.com with SMTP id e23-v6so54834ywe.13
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 14:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi4v47ERdIm+sIGqO5141Tj5hOk3PNxuIgYFCEMTX14=;
        b=mbT/fvo3t8tE9dBBBOMRUcfz8M5jgSQ21HqvQEZuRDSdWS27aRTNFSDYebZBn7ukd6
         rdXHxIkOWhOAtZ9M2MdTD8guFhzv65LcMkM/x9fOxxHKVmrVxDjI31JwFgKkiK67YPDD
         sF97WFrL6LOaq0mMCf2oc0a7nvTDxGZqqvIUgbQV4OhK6K55quAvs/x6jB8tJXOxZux1
         uhWZX1vfh/6kR2iHrdCEebrasFt6hz2LTRnte7dW4fvqXJQiAwFa7uofIQI4DvimbwSm
         s+5torzPxEQ5mSIg3zPMfd9e5o8B/OU4zFWmUeYDM+TyZOgnWYl6p2rLq/S5XTAXB49n
         EUGg==
X-Gm-Message-State: AOUpUlHOpCgHsLSYVI7D+eZrAzrS7BwsNniTJXYNmtz/DPVBCZ3PNF/Q
        Vpcj+dp9kcNUZ6eNj0kZunImSwzPeD/Vl0ql4l8=
X-Google-Smtp-Source: AA+uWPy97beQyi+VAhJVWI8IuG7ZKWBQxAKSgrvbY8sLtVwZYR6t3jheGBkNvJyMa6iZTu6F/XBg0UsTOh7HTjrCrH0=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr86915ybq.295.1533678434390;
 Tue, 07 Aug 2018 14:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com>
In-Reply-To: <be1dd423-f9de-a436-6127-02cce4ab1977@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 17:47:02 -0400
Message-ID: <CAPig+cTVEq1AGvtxxonbU4PgqeG0fOy9CSDO7ThjVpfGoJaAJA@mail.gmail.com>
Subject: Re: [RFC PATCH] line-log: clarify [a,b) notation for ranges
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 9:54 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> line-log.[ch] use left-closed, right-open interval logic. Change comment
> and debug output to square brackets+parentheses notation to help
> developers avoid off-by-one errors.
> ---

This seems sensible. There might be some reviewers who suggest
different notation since "[...)" is not universal (see [1]), but I
think this is fine.

You'll want to add your sign-off, of course, when taking this out of RFC.

[1]: https://en.wikipedia.org/wiki/Interval_(mathematics)#Notations_for_intervals

> line-log.c also uses ASCII graphics |---| in some comments, like:
>
>         /*
>          * a:         |-------
>          * b: ------|
>          */
>
> But I'm not sure if replacing them with
>
>         /*
>          * a:         [-------
>          * b: ------)
>          */
>
> will be helpful.

Those comments seem to use horizontal ruling to make it clear where
one range ends and another begins, so they already do a good job
conveying what they represent. Changing them to use "["" and ")" might
make them less clear.

> Another possibility is to update comment for
> range_set_append_unsafe to read
>
>   /* tack on a _new_ range [a,b) _at the end_ */
>   void range_set_append_unsafe(struct range_set *rs, long a, long b)

It shouldn't hurt (though the existing "_at the end_" is rather
superfluous since "append" in the name says the that already).

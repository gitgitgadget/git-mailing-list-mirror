Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA8C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83028207DD
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTIUCBUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFMIJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMIJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 04:09:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4BC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 01:09:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c35so8019319edf.5
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JIGjNJXciXnqHZPs5ZAhVS6PNnK+z9UGNn24KWxwPY=;
        b=JTIUCBUc4Uo8MIidx1xAcWph85od8KDHNTHndTtM+zKDQiDyTq+RTHiyhfGL3VYTca
         DgZu5g7eLXu2RPfvi39IHy39DHVS8w5nOuDYtm5IgQ8vk0B7ZwkI2cZ62EynZfuZMVcS
         wst96u4EHnqQnbNo4xUO5l0IwSbLIakC7xHCwSC5biaQgE3ZnUOkR1qaYYRHBoSAI8NA
         cFqXFdgTphqO0OKEn6bBoXu/oXOaasilet0sXPO5wiL7dPht4AYthMMq7A8ePuPBeoFP
         0TTZy8dNVglzRR+j0kwidWAaA3FXIqK+P7Doxn7aCVEFL9I1Xr3jjlp1RlS7+qdPyIgd
         /S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JIGjNJXciXnqHZPs5ZAhVS6PNnK+z9UGNn24KWxwPY=;
        b=q6PTaIaP7q2zGhDjCyJLfAG8lWghRcrnldDewHAzChurrpvXh0tDUdk3FsUXYk2lIq
         NDnIQOGh5zePCvqD0s2wRsaLtyUD9+d4tZDK77r9yP7SFQWw9Xb2n0Ymywrv0T2iSNtK
         2h34oogKr4iFwwG9gIn/D3u7A2ObvslA40vrPxs9I0bBykQlWS7diIa9bOhpIafrnXJm
         a9JILy67vTZuPyMyssA1mP72EfCuOb6saSWGRBy0UTCYYHACDzzAS3rtQZsCgFqKLcBm
         VD9uXyml63Vr9ULmtmk9ZIYwD7grid3UleQ+wuvrg2jWYM2Hl06/SjZUrgtiN87gNUiW
         XYyw==
X-Gm-Message-State: AOAM532NT5w1rh00agXK2mebA3Al07EFN4n8H0Tu0m7gTfnN6bP0WfO5
        EFFUlP35qVj91b1eQ0lzppUHcD+O0nYdN3SXEhw=
X-Google-Smtp-Source: ABdhPJwHtRkeWGWbmGi8znO0xAN3UEfreI6aCig3weRDQDkIqFphLc8bvYKn7uVUMNeqjauS1a1WwW0mTeFYXnX+4/Y=
X-Received: by 2002:a50:954b:: with SMTP id v11mr15449146eda.273.1592035793984;
 Sat, 13 Jun 2020 01:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-2-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-2-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 10:09:41 +0200
Message-ID: <CAP8UFD38UUjaHQ5xdTbCpTLJSpJJmwigr3OcNViiq62cxEiUxg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] stash: mark `i_tree' in reset_tree() const
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> As reset_tree() does not change the value pointed by `i_tree', and that
> it will be provided with `the_hash_algo->empty_tree' which is a
> constant, it is changed to be a pointer to a constant.

[...]

> -static int reset_tree(struct object_id *i_tree, int update, int reset)
> +static int reset_tree(const struct object_id *i_tree, int update, int reset)

Yeah, in rest_tree() it is only used like this:

        tree = parse_tree_indirect(i_tree);

and parse_tree_indirect() takes a 'const struct object_id *'.



> --
> 2.26.2
>

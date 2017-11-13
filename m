Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14851F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbdKMVMh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:12:37 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:48583 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdKMVMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:12:36 -0500
Received: by mail-pf0-f172.google.com with SMTP id r62so149698pfd.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CS7djbhqu43lHCYXY0j+JsCtQvuQjqjxh+Gdkldn4wI=;
        b=dSIm+gq2Zv3eqGl7rar4gEkgZZM6pBWCL74K8BQ/yCVsZOhdnntPpUODhphEoqnjKc
         encV3s4vJSdUB4R/hI1Lr6tYl/R6pPUa7jyGqH/U7lpaikrP6qjMLt5FXx0XcsmLf0qh
         TMPrCLLNW4hlIyO9AYTMkZmt8qHx3j5Fdx650OjDUYheCo2koYbBgd7mcbaVlFC6lD3k
         ASs3MZ9KomP4HBZA/1dLHMLojQp8KKEBLINAlRTb+Qr3J2rVkw4oVsNA0UTGsMe2cWxK
         BtyBp5GZRDJZhwbZXLAzKz3IQx38HIQMjiUx85J8iNu8Qv99u/9siI7CyIuIBt08iwyb
         hs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CS7djbhqu43lHCYXY0j+JsCtQvuQjqjxh+Gdkldn4wI=;
        b=GwW7FFUaJkCipDe2FvWqkua3hWAO0BEwInWneelVltJgNDs9yHZH7iv/JyUwf5i1sW
         AbWU+4ywhG/ynoYx8YReJZRJuniACNCeTN48ItClON7YVG412q0Q6yXD1jkMGoGiEihl
         7fUrhgo2cZQuo2MSoheeN+kzNNFvyAVTW0IkrmXF8Kce0GdzSQjvrOoxkgf9KA8YZxZz
         T5tsA60D4JlRtSGfBu3jrx6wB4JebauQjCwdmSoJX9i56XUXlUDqeZI8c5iD40tB2sfm
         JQAbQcrmMtuUci0UC5E1gxog6iNn3k5HjvDcD06htaGg5TYn9mdzObiPTUu6Z7ZYXXoQ
         obFg==
X-Gm-Message-State: AJaThX6px6O3wxaXXlOmC6X+6g+ddF5WmGpGE4px7HPIbAN0dyP/HqEP
        BSkcJDtNJbmKnsfcKQcjxXBiATjMKnMB51ruCN8=
X-Google-Smtp-Source: AGs4zMbZuIO6aTWXt8Q/avO3IdKm5IxNLLKc18XuSGTMuY+GEQ+asBbiwR/WtL8SwKeivuhTK4ip9KJeGVgeB1SNJwM=
X-Received: by 10.98.202.74 with SMTP id n71mr11177503pfg.202.1510607555754;
 Mon, 13 Nov 2017 13:12:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Mon, 13 Nov 2017 13:12:35 -0800 (PST)
In-Reply-To: <20171110231314.30711-2-joel@teichroeb.net>
References: <20171110231314.30711-1-joel@teichroeb.net> <20171110231314.30711-2-joel@teichroeb.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 13 Nov 2017 22:12:35 +0100
Message-ID: <CAN0heSrFdGQ9469ugQwmjP5ieoxb5NCR3Kpz6ZQ4J5TyarwQ6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge: close the index lock when not writing the new index
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 November 2017 at 00:13, Joel Teichroeb <joel@teichroeb.net> wrote:
> If the merge does not have anything to do, it does not unlock the index,
> causing any further index operations to fail. Thus, always unlock the index
> regardless of outcome.

>         if (clean < 0)
>                 return clean;

Do we need to roll back the lock also if `clean` is negative? The
current callers are built-ins which will error out, but future callers
might be caught off guard by this.

> -       if (active_cache_changed &&
> -           write_locked_index(&the_index, &lock, COMMIT_LOCK))
> -               return err(o, _("Unable to write index."));
> +       if (active_cache_changed) {
> +               if (write_locked_index(&the_index, &lock, COMMIT_LOCK))
> +                       return err(o, _("Unable to write index."));
> +       } else {
> +               rollback_lock_file(&lock);
> +       }
>
>         return clean ? 0 : 1;
>  }

Looks correct. A simpler change which would still match the commit
message would be to unconditionally call `rollback_lock_file()` just
before returning. That would perhaps be slightly more future-proof,
since it will always leave the lock unlocked, even if the if-else grows
more complicated.

Well, "always" modulo returning early and forgetting to roll back the
lock. ;-) Looking at existing code, it's not obvious which way we should
prefer. Just a thought.

Thanks for spotting this. I was poking around here recently, but failed
to notice this lax lock-handling.

Martin

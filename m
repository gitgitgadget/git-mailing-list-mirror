Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B035320380
	for <e@80x24.org>; Tue, 21 May 2019 10:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUKe3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 06:34:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43640 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 06:34:29 -0400
Received: by mail-io1-f66.google.com with SMTP id v7so13464542iob.10
        for <git@vger.kernel.org>; Tue, 21 May 2019 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wFotMAxDJMLtM1QBrtdI5dVt7ofF1ZW5h1d/QD1LWM=;
        b=jMblTKyQt9BT3bCeO4ItpyCf7NOmTbutNriDbGaT88L4UsV8Vprk7xNvN/CshqQRTs
         n6xx9tO4Oy+8Mf85IK7FFaCI/MQr8JUlxmQzBm16OtpHWqK9UdnVNx2nMQdkhygIE4HS
         EOCbwUAwpc7BU2IjqlBruSqeJNnPMuSj0R/2USiOo8oPFn56j1z0J2gGkvEyAx1OW5zz
         a1YRQt1m2g5e0U7zOC/iVbDYzqiPIjDm5RuAalcMRvHT09dnwV3TjQejEO09U0zaOoON
         H0jdXdENUo9dA+xNmoSpUHGqMowp9Qw7kawAhD5q6C9snUvrATSxMTa0G9cglUaYA/hV
         pgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wFotMAxDJMLtM1QBrtdI5dVt7ofF1ZW5h1d/QD1LWM=;
        b=dbCtdyP5kBfltGJgTne/eNijM+Ml/vH2WVnC67354527z66B/WMCixq7GcH2trD5c3
         91ML0WqKTX9I56gOsh0wuMEHCMFcy/GU8xP9iJD6r25HZpKStfwWB6Hy85skilMzp+2C
         HMNJCbSvi7B1NCCKhuITkrjn9YpAJD0r1RechAAWZX5sdxcMNApfA8V63KLn379e1vcH
         wDhhiJk6f9ja+lnreaU7HYkZh6s1YYhSbZ/CZjw48kri+S2tSOs49iKHKvRye9pqDgdg
         qNidfnIKof7b8mqJ/aKPwPmGLGxjKLs9Hq3FgdCdrC2TV+q8MKVVDbmwNmroVpuJa9sI
         GxMw==
X-Gm-Message-State: APjAAAVjq5HmyFebli4iSE60RaFw/m0AXjneFjXh6StxxIrw2s9idc2R
        XpsjdvVVYVhA8fUwZCfGpQhNRV7x8ZPc8P1Z6xySBw==
X-Google-Smtp-Source: APXvYqz5AnGDNPmUcvRfOas3qWgiIGkidro7i05gp/UBIIP5FCFJMGlubui+Kf39k5PPPQTQ7EgU3fg5BxMpIzM3VMM=
X-Received: by 2002:a6b:b907:: with SMTP id j7mr23663343iof.17.1558434868727;
 Tue, 21 May 2019 03:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com> <20190519025636.24819-1-pclouds@gmail.com>
 <20190520131702.GB13474@sigill.intra.peff.net>
In-Reply-To: <20190520131702.GB13474@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 May 2019 17:34:02 +0700
Message-ID: <CACsJy8CoauTdJ1huU=w2YNbw53iea5U304yAu2oCUuTvFRaV7w@mail.gmail.com>
Subject: Re: [PATCH] repository.c: always allocate 'index' at repo init time
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Antonio Ospite <ao2@ao2.it>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 8:17 PM Jeff King <peff@peff.net> wrote:
> The patch looks good, though I wonder if we could simplify even further
> by just embedding an index into the repository object. The purpose of
> having it as a pointer, I think, is so that the_repository can point to
> the_index. But we could possibly hide the latter behind some macro
> trickery like:
>
>   #define the_index (the_repository->index)
>
> I spent a few minutes on a proof of concept patch, but it gets a bit
> hairy:
>
>   1. There are some circular dependencies in the header files. We'd need
>      repository.h to depend on cache.h to get the definition of
>      index_state, but the latter includes repository.h. We'd need to
>      break the index bits out of cache.h into index.h, which in turn
>      requires breaking out some other parts. I did a sloppy job of it in
>      the patch below.
>
>   2. There are hundreds of spots that need to swap out "repo->index" for
>      "&repo->index". In the patch below I just did enough to compile
>      archive-zip.o, to illustrate. :)

You are more thorough than me. I saw #2 first and immediately backed
off (partly for a selfish reason: I have plenty of the_repo conversion
patches in queue and anything touching "repo" may delay those patches
even more).

There's also #3 but this one is minor. So far 'struct repo' is more of
a glue of things. Embedding index_state in it while leaving
object_store, ref_store... pointers feels inconsistent and a bit
weird. It's not a strong reason for making index_state a pointer too,
but if we have to deal with pointers anyway...

> So it's definitely non-trivial to go that way. I'm not sure if it's
> worth the effort to switch at this point, but even if it is, your patch
> seems like a good thing to do in the meantime.
>
> Either way, I think we could probably revert the non-test portion of my
> 581d2fd9f2 (get_oid: handle NULL repo->index, 2019-05-14) after this.

Yeah. I'm thinking of doing that after, scanning for similar lines
too. But it looks like it's the only one. Will fix in v2.
-- 
Duy

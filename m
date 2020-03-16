Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95268C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E542051A
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 23:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="n66o+BYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgCPXk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:40:26 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36186 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732873AbgCPXk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 19:40:26 -0400
Received: by mail-io1-f51.google.com with SMTP id d15so19102687iog.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RsVZ0qHmLcgUTbHNGLj9HXM8aOcsd3qHVzfQZiI9zo=;
        b=n66o+BYP1mVy8/7X0mx8PF82+JjmxSw74lodi7WWDxfFNmc8qCPcgaRH3n2FUaksqx
         vwWn85k1YWn36BeRaCdxUnM2Ng4UJ6grOWiurk/zRY5YOwzGFNkg/bzeMTwn4zeg3q5j
         C+k/XSd8jDKaveEpSUHCaTvGaFLP4jFfpYLD5H0RvnfPvAYzjzbtBUQCoLRs9K+deBPq
         sGhXDAM6tt9PcGor5Dgk7ZKH1Hcm8L2vWI+dCcqgS6yDlTTo7417VSfoFY65agchF7RR
         RPS5ZJB0T9TfUGy7CsuxIIWkbOC8CPadLqoclblHS1fbDMtniVcZ29WEwmZVorM2WQrx
         l1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RsVZ0qHmLcgUTbHNGLj9HXM8aOcsd3qHVzfQZiI9zo=;
        b=CMSlxht3Ucvyt1atiVZHUN0UOduidL/V2OZHVWZjOVRHieoBLE/QziYtT/9tK3DYa7
         B+AAEGYXo+n+rQZvJwU6zRtg8htpqZaxWMhIGHIKrtYq/rTGY91HdnRSktlGD225cKoT
         dc30vl8VbKnEIrL/QFXvz7+vaQ5F9Pc27m7tCWL+kW7kiOdCVKrzbXS692OzMZ6R/n5L
         eCLucADHLQwSUWdrm2itxAYVGapdWC+4788VgnQXnL5z4TCq5HXIyUhZ4o6nrapi+7E/
         3Sv/RrtR3pG5W/ZKwuaNV9MnpJTUoIH3xr4w8WkzsSii6dL+vwDykwwae1eReOVoazAl
         ELDw==
X-Gm-Message-State: ANhLgQ14+wjZZpgUR20o/DlfVnY/UbhYvjJboWMHgWJ+x2WP09Ny1YyZ
        ZE2tjw9g9aCl4YkyygdBF4ZJbmst3I6Rei5TGzuD3A==
X-Google-Smtp-Source: ADFU+vs8pa6OO+qDwP7WgNk0GaDlQeBhefZKxLlwCludVAkFwkAdmEvEcxvjH9eB2jb9xZGWqad2j8yDbtf4vR9hN0U=
X-Received: by 2002:a5d:8f96:: with SMTP id l22mr1451267iol.19.1584402024885;
 Mon, 16 Mar 2020 16:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200316082348.GA26581@inner.h.apk.li> <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
 <20200316172729.GA1072073@coredump.intra.peff.net>
In-Reply-To: <20200316172729.GA1072073@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 16 Mar 2020 16:40:13 -0700
Message-ID: <CAGyf7-HQH7hjuYSmOYeOEvZBWkUzjU4M8Wr50FNPYgG4NZ=5UA@mail.gmail.com>
Subject: Re: Avoid race condition between fetch and repack/gc?
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Andreas Krey <a.krey@gmx.de>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 10:27 AM Jeff King <peff@peff.net> wrote:
>
>   - you don't use config like core.packedGitLimit that encourages Git to
>     drop mmap'd windows. On 64-bit systems, this doesn't help at all (we
>     have plenty of address space, and since the maps are read-only, the
>     OS is free to drop the clean pages if there's memory pressure). On
>     32-bit systems, it's a necessity (and I'd expect a 32-bit server to
>     run into this issue a lot for large repositories).

I could be wrong, but I'm going to _guess_ from the :7999 in the
example output that the repository is hosted with Bitbucket Server.
Assuming my guess is correct, Bitbucket Server _does_ set
"core.packedgitlimit=256m" (and "core.packedgitwindowsize=32m", for
what it's worth). Those settings are applied specifically because
we've found they _do_ impact Git's overall memory usage when serving
clones in particular, which is important for cases where the system is
serving dozens (or hundreds) of concurrent clones.

Of course, we don't always do a great job of re-testing
once-beneficial settings later, which means sometimes they end up
being based on outdated observations. Perhaps we should prioritize
some additional testing here, especially on 64-bit systems. (We've
been setting "core.packedgitlimit" since back when Bitbucket Server
was called Stash and supported Git 1.7.6 on the server.)

That said, though, you note "core.packedgitlimit" is necessary on
32-bit servers and, unfortunately, we do still support Bitbucket
Server on 32-bit OSes. Maybe we should investigate applying (or not)
the flags depending on the platform. Sadly, that's not necessarily
simple to do since just because the _OS_ is 64-bit doesn't mean _Git_
is; it's pretty trivial to run 32-bit Git on 64-bit Windows, for
example.

Bryan

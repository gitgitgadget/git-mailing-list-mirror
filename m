Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C718C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F15C2080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="msP2xFHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBIXcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:32:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36300 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBIXcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:32:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so3408287pjb.1
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zx8v1aIpxOTzBQf9YIE1yCYWB59NIIuUV0YFXNKnkfI=;
        b=msP2xFHZktBjh2fcJLOiJhSgAcNiE6P6hI0KjPsMXxBFYKxgWMa8rqgqG9JboGKJAM
         kWcTDhHivANhLOMHJpFUUT3N+1MdUg5LPyhVrkz+BFQ8UMgVIqR7XeGZFZnZp7KSI2co
         a9iKwvg8KXseZAEOXkCBaJG4TSbLXhlBYI4CwsNAjYA8PKqE19eqy/zgXLP/w8LMIdx8
         UdK9iw0Wu1+MJy4CqZ0o2iLbG6BdUegFfHUtOc+v4sAN0H15s9lxIMyti1DHb8KorX8L
         zeA45ym18IYyi7GMDG3KOoRSVbulvtQ3IFrtdJWS2RjAGShMERjs8Vcyr6X67cx+zAng
         9C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zx8v1aIpxOTzBQf9YIE1yCYWB59NIIuUV0YFXNKnkfI=;
        b=jTakHt6a+OBOYNJx8GQUyhWKJahnKeVWJdpAhXmmyUpsMzFZekyQJvCiZrNWO0sg8H
         ykieJrgQKxKBdFglEdPXi8d34lr7sdN1bpUa5wEKSTwrUsiwwBZUvU0sHwvDfscTd+0C
         dBHyMTEkcCK5DRK2aJK1RWzX/B+X57j9tWGIHMO6Z2h6c2GouGk+o7K4VrosMTYpx6km
         ZQvKKLz5taEkMrzEKG7CN0UFaonZ7iBlskXOik343iYuZ3bIQHqaK8TL3wsezQGDMlB0
         KVvnKSiuhd9DNYADVoR03auXnHw3nlJDDJT8LlngKw9fwUgS0uk0hKKT+2yLVQyqsVDN
         qgCA==
X-Gm-Message-State: APjAAAUqJ6OjGwdd3DLCybMpSQ7pNqvFIaogqItPUGL4Zf8PyXd5BHgW
        ht/xPtVCazDHUUYZTL4VmWDXcP9T97NpnkvY
X-Google-Smtp-Source: APXvYqxuOAPOIGkZMRq0h7xJ+cVNK0oIh40Cuuuv+vwR33tIk//BDyea1b1fI3NZAVKpZXU5kuARPg==
X-Received: by 2002:a17:90a:a409:: with SMTP id y9mr17340640pjp.119.1581291163358;
        Sun, 09 Feb 2020 15:32:43 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id 70sm10276183pgd.28.2020.02.09.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:32:42 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:32:42 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200209233242.GG4530@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
 <4c6425f0da9a6e5ae86530a12f18959ada07404b.1580862307.git.me@ttaylorr.com>
 <CAN0heSrRJYc8DoWQ+NHR5LJ1z7d1GGBni2waP0_Lv7gMYjPPEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrRJYc8DoWQ+NHR5LJ1z7d1GGBni2waP0_Lv7gMYjPPEg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:50:57PM +0100, Martin Ågren wrote:
> On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> > @@ -57,6 +57,12 @@ walking commits starting at all refs. (Cannot be combined with
> >  With the `--input=append` option, include all commits that are present
> >  in the existing commit-graph file.
> >  +
> > +With the `--input=none` option, behave as if `--input=append` were
> > +given, but do not walk other packs to find additional commits.
> > +
>
> Similar to my comment in patch 1/3. Please add a "+" instead of an empty
> line. This one actually trips up the rendering quite a bit of a lot of
> what follows.

Thanks again :-).

> > +If none of the above options are given, then generate the new
> > +commit-graph by walking over all pack-indexes.
> > ++
>
> This one's good.
>
> Martin

Thanks,
Taylor

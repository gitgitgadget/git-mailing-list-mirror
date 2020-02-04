Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63BC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD8321741
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WjsP2rSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDV2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:28:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53006 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDV2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:28:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so1982872pjb.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0EZji/sCH3j9LFc/KRxzoLVDzMTUsbdwkgN00S1S3E=;
        b=WjsP2rSeMSEQTT/JQYSSfhkBRPkkdmSIhQk8VhuB2QR3MtYWUfKZ075eCUciQ1hLfX
         wUX2u1LNzKF37PUEv4NpuZYuOZAiC+Ur80cp7C7rhaXIBKdEoV8UXQJJYFcyU4kmM90n
         2qRbpoYrXCLJd7nVggU/hqjsZhUZChhmWeAc05caY3Oo8pujuRfxMWQ+ae2mPIbei6Mr
         syNZe4bSnjUhY2e7vnXSXkhcKHBlc0L1SnbfHuN8BFx1ReS2tsfiPKkS3R/nsrv6XWK3
         JLFxJHAHrYxD4IeEOVlEubPgzHIcAh8EwRPhWbiTG/PyfyOv7AsFztGIwkXAhi2iO9uE
         mRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0EZji/sCH3j9LFc/KRxzoLVDzMTUsbdwkgN00S1S3E=;
        b=RzTUUzgJ8G01r1uqHgVZZVk+7N+8JmG+ZxFa9LUD0UqvVIWCGrzHlawdBlTOgzP3P4
         SLszGwNF0hFqbsUL9t70u1ZFEVRBCpdvWDVNTwprcoA7+j/JSoM6xeBfFIO/PhyvFMG2
         4qqO2xRYfvB2vy1Irec7yQNJKrX3FdW9Q9GagDUjr7qhhgyvZDyxb90R6t9RVseYBzM2
         QtRyru+IsvKbiMQmmFQz7ItyhH+iAXp35pa9edIBgASYjnI/aMaAUQJOhVGCbN1gcEtY
         f6IXlMvqGnbqN7SZoygI94yVeCTpbYkHKhXY0PLnW6qmKFMX/SHe1RwE0RgGOpbkenbz
         8RMQ==
X-Gm-Message-State: APjAAAV3HgYYc8ZSXuK3L/SptSMTMlCvaYbv0PnUZZr7eZFKj8zRFj3k
        yy7u82TAJSnoakLElsC31pLDDwS26gHfjg==
X-Google-Smtp-Source: APXvYqw4SMgYO+3zQbKVFP+rYe6o5M3hBujdA0OIFr4DgHir/BueabJcbLnyIP6LyHoLbtARzkOAlQ==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr31318165pla.17.1580851714809;
        Tue, 04 Feb 2020 13:28:34 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id x25sm26105788pfp.30.2020.02.04.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 13:28:34 -0800 (PST)
Date:   Tue, 4 Feb 2020 13:28:33 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct
 write_commit_graph_context'
Message-ID: <20200204212833.GA42626@syl.local>
References: <d9819cfb33ad95d4206dd1bbf4b38b7fdf69130f.1580764494.git.me@ttaylorr.com>
 <5d3819180dbc9bc33a8fe4354e2320f497151fb4.1580795403.git.me@ttaylorr.com>
 <xmqqzhdy6sbx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhdy6sbx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 11:54:58AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Whoops. In v2, this patch introduces 'find_odb()' as a function in
> > 'builtin/commit-graph.c', but does not declare it static. This causes
> > breakage in gcc with '-Wmissing-prototypes'. Here is a correct version
> > of the patch that does not cause such breakage.
> >
> > -- 8< --
> >
> > Subject: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct
>
> What happened to the rest of the line ;-)?

Heh. Your email made me chuckle since this wasn't the first time I've
been asked about this today ;-). I manually yanked the 'Subject:' line,
but not the continuation below it.

I'd be happy to re-send a version of this patch to fix this, but if you
don't mind slicing it up, that works too.

Thanks,
Taylor

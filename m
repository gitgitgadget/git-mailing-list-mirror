Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3101F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfD2WKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:10:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37417 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:10:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so1278596wma.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV2L8G2gp6Ww9yS8JpPU6hqyVRoTTFc5m+Y2187ynoA=;
        b=aEJDNP/Ea+JE1LL/o5+OBWskfVI/30Jx+dzCIAYYpWo813KJDPOWiOsW/YGLF9QbcM
         B5pqr4/Hz6aOEii+rxRN2sDyJFSyn2qmfPdTdYhMBPYlYc++i9MgUrI5LVOWpmKEpBdk
         005QnAgqtFou6/tjj8Ady3hxsCvRoQcAH6BijVy4v1O0KHrXjHIZ8nsOgGHKX1I6fUMD
         81Hmd7OuWu3rUzC/nfvf2fcxC+8yk/PFlWL1srbmjCrDnpTbXhT4lsSBqKU7q3epHyyA
         Tw+esVdXEp6QrdiUZI9Egbl+GYHQUn7agdLbbVU1FSH7lZKuQ/9DhZIUOLQQDOalzrEE
         tfaw==
X-Gm-Message-State: APjAAAVwRozdYCnzDrvjZlsNmHnJjlVWmLBJCf9wcHpLnlynCrcayQMy
        0SzvfVCN4Ngr5sodJI5oMrFP4OMcmSsKDMrrTt0=
X-Google-Smtp-Source: APXvYqwVQAmLELuhFqYb7A0WnW37Rlwri/dPaD2mCazvYYuwS8RUuLPuSnhGnaNBabbu+d33+C9PyTGsOioXwxEr65c=
X-Received: by 2002:a1c:9e55:: with SMTP id h82mr840320wme.134.1556575815006;
 Mon, 29 Apr 2019 15:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.137.git.gitgitgadget@gmail.com> <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
In-Reply-To: <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Apr 2019 18:10:04 -0400
Message-ID: <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for transport
To:     Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 6:04 PM Thomas Braun via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Since commit 0c499ea60f (send-pack: demultiplex a sideband stream with
> status data, 2010-02-05) the built-in send-pack uses the side-band-64k
> capability if advertised by the server.
>
> Unfortunately this breaks pushing over the dump git protocol if used

s/dump/dumb/

> over a network connection when using MinGW (but *not* when using
> mingw-w64).
> [...]
> The new config option "sendpack.sideband" allows to override the
> side-band-64k capability of the server, and thus makes the dump git
> protocol work.
> [...]
> Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/config/sendpack.txt b/Documentation/config/sendpack.txt
> @@ -0,0 +1,5 @@
> +sendpack.sideband::
> +       Allows to disable the side-band-64k capability for send-pack even
> +       when it is advertised by the server. Makes it possible to work
> +       around a limitation in the git for windows implementation together
> +       with the dump git protocol. Defaults to true.

s/dump/dumb/

For someone who hasn't read the commit message of this patch, "work
around a limitation in ... git for windows" doesn't mean much. Perhaps
this documentation could explain in more precise terms under what
circumstances this option should be used?

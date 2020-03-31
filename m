Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD4C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A11520784
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeibJkrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCaT0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:26:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37694 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCaT0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 15:26:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so23295256ljd.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bhdvbpQzSliO3AZVLc2yy6RgT/mF0G1gSZU2usypvk=;
        b=UeibJkrW7oXvqQQ3sdzvV3nmaYvBNQAwsgMEywg76o24Ho0wfgZSVpgnS3YZGKtjUv
         gPAw49cqLCPEqie3u5R88vfyqvDbXXFs6LOlaf+grgJSwRPGld87Tx27VF40t80sBppx
         N09Ca00qs1YTsgUjrgshZWpKIC4SEkjgZ5lpaw9YLsCvCGgHVm2z/izE0KH4aSGiNWpx
         EhIAP4dIafEXJ7yiMxp4nIc37rcRTRSkRgkL9GFqAPfX2YNqa1KOa1qUo+EeCXR4buyl
         UJh9j1vA0X2NmBc/CitbIwGAEAvgsEP0fsZZitoZC0BmeHRWlfiyTWcNCHo6knZwFXda
         ogZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bhdvbpQzSliO3AZVLc2yy6RgT/mF0G1gSZU2usypvk=;
        b=e7PP95lb8ToWDRa7aFxFVowTvzXIlWuM6jSS372P3faMpQ4xiixXlwTbb/MloKJoA3
         3A9e5e25pC4O9yDwN0b7hhTCOKgBhTfqcOJKIBgmxMukO6WiGgSbpNhBgCA9RVz2C3+i
         7VJYY5lI28HNNIUfk+11Ef6pRzqTYjrUiK2+IRfnVeirvyUlefrO0qkIF9Y8ReHzBcJ8
         OCyxeStCwqb+8pHp/pMj29+zf2y6cfyNujDtM1OI8TxvlPHD48BmbOj9KUr/M8jnpsO/
         YKPuoh75MnGbyhTB/ZlEIWlsIE4BbzKkM+ja/4p8RCmRxUrAOPmVzDnpF1gbCVnxMXQn
         Iylg==
X-Gm-Message-State: AGi0PuYQLmGTkotrc70OxecyybZp0DjxzbZGK3fChkO/CLDYMy9CNcKt
        dn8eArioqLCVyKz+ozykG4k=
X-Google-Smtp-Source: APiQypJTF9+4QQuWA/fO8srD9Z1ThR94TbBq4X8ekUMeiIElDCzxLbmLxQWeKReZl6tNJIj9K54MFw==
X-Received: by 2002:a2e:2e14:: with SMTP id u20mr6222893lju.73.1585682775462;
        Tue, 31 Mar 2020 12:26:15 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id z23sm9038649ljh.55.2020.03.31.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:26:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Date:   Tue, 31 Mar 2020 21:26:00 +0200
Message-Id: <20200331192600.588-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330094513.GB1735224@coredump.intra.peff.net>
References: <20200330094513.GB1735224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Mar 2020 at 11:45, Jeff King <peff@peff.net> wrote:
>
> On Sun, Mar 29, 2020 at 03:18:04PM +0200, Martin Ågren wrote:
>
> Yay, I'm very happy to see this series. I'd be happy to go even further
> if there's some benefit, but I think this removes the last of the
> Makefile knobs.

Yes, I should have been clear about that: This does remove the last
Makefile knob. At least I couldn't find any more with some browsing and
grepping.

> > After this series, user-manual.conf still refers to older docbook-xsl
> > versions. The proper fix there might be to actually be a bit more
> > aggressive and drop that hunk, making the rendered docs prettier.
> > There's some history there, including mentions of texinfo, which is
> > outside my comfort zone. I've got work in progress there, but I'd rather
> > submit that separately from these "expected no-op" patches.
>
> Yeah, dropping that bit from user-manual.conf seems reasonable. That
> shouldn't show anything in doc-diff because it's not installed with the
> manpages. And the HTML build wouldn't use docbook. I installed the
> zillion packages needed to build user-manual.pdf. The behavior without
> that block looks significantly nicer (the example blocks are actually
> shaded).

This matches what I've seen.

> Anyway, that was just for my own curiosity. If you've got further work
> in that area and prefer to do it as a separate series, that's fine by
> me.

Not sure about "further work" really. I'm pretty sure you tried out the
exact same diff that I have, and I'm glad you agree it looks prettier /
"significantly nicer". A small part of why I didn't submit it is that
it's user manual vs man pages. Another part is that it's an intentional
change as opposed to an intended no-op.

But most importantly: When I looked into the history, I came upon
c2a7f5d438 ("docs: monospace listings in docbook output", 2012-08-07),
which made me worry about breaking "make info". On second thought, I
might have broken it many times already over the past few years, since
I've never built the info. So maybe worrying about that all of a sudden
is a bit unfounded in a way. :-/

(I tried to build "info" while working on this. It works in the sense
that it doesn't error out, but I don't get anything that looks remotely
useful. I've never used info at all though, to be honest, so could be
missing something fundamental.)

Here's what I have. I suppose it could be framed as a patch 1/7 instead.

Martin

-- >8 --
Subject: [PATCH 7/6?] user-manual.conf: don't specify [listingblock]

This is the config file we use when we build the user manual with
AsciiDoc. The comment at the top of this chunk that we're removing says
the following:

  "unbreak" docbook-xsl v1.68 for manpages (sic!). v1.69 works with or
  without this.

This comes from d19fbc3c17 ("Documentation: add git user's manual",
2007-01-07), where it looks like this conf file in general and this
snippet in particular was copy-pasted from asciidoc.conf.

This chunk is very similar to something we just got rid of for the
manpages, and because this appears to be aimed at v1.68 -- which we no
longer support for the manpages as of a few commits ago --, it's
tempting to get rid of this. That reveals an interesting aspect of
"works with or without this": it turns out it actually works /better/
without!

Dropping this makes us render code snippets and shell listings using
<screen> rather than <literallayout>, just like Asciidoctor does. In
user-manual.pdf, this puts the contents into dimmed-background,
easy-to-distinguish-from-the-surrounding-text boxes, as opposed to
white-background (transparent) boxes.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/user-manual.conf | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/user-manual.conf b/Documentation/user-manual.conf
index d87294de2f..0148f126dc 100644
--- a/Documentation/user-manual.conf
+++ b/Documentation/user-manual.conf
@@ -9,13 +9,3 @@ tilde=&#126;
 
 [linkgit-inlinemacro]
 <ulink url="{target}.html">{target}{0?({0})}</ulink>
-
-ifdef::backend-docbook[]
-# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
-[listingblock]
-<example><title>{title}</title>
-<literallayout class="monospaced">
-|
-</literallayout>
-{title#}</example>
-endif::backend-docbook[]


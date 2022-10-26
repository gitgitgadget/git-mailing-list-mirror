Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA84DC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJZVmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJZVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:42:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B573C1F
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:42:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h188so584083iof.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf6IcwPulX/kkPQ/aU+YD2fXLjCye7QVy2t9Y+Nkci8=;
        b=uN4Qb72ezTRVzfIbEEszRb7OfYWYozCBbZJCzW/GfcPrBAyBG7Rz9gTfeKpqsMnyeN
         LAQENqKdJ+UPFHsLNIyBheKSSQVXrxWtmCezQm1wkG9/9HkTb3HOHPPLREO7McTsse5o
         Vtb/lSDt1uz75jOM/IrPK7Teprj7CQvBuo+kPD2EuhzLjvCDOJ+Bs9sMhCF21grUIiqs
         cXD1nj7OaPiImAhI6KiivIML7V60E1ebh4fO9fDs4cClpzD66TDw22HU1SpGxit8rUSL
         3KvRXDHFwAMsdShf7/60gUvrOjcGoTZnNUqbXV6LqXh7DtVexPk0m7NiQwtOFxseA0Tf
         mVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf6IcwPulX/kkPQ/aU+YD2fXLjCye7QVy2t9Y+Nkci8=;
        b=MUxAFSbvlVQpvXuKOCv6iTFOcOCMGdhT3IEgkjX83tqKi82/kqteClPpJgrr4AmCrK
         w64/lIalBkOO8OcmbVfEPynvotVLKcU0LC7JjcnNrLC/f/IAGHc4EwyY81lY72xEVZWR
         gLm9evJlQexNmHbniJ78wl8NIFcZ32sWO14varndGuSOMxocVDHtNt2BVgKaBEtvZ01t
         e44k2/he5nITqpKwiWA/u9i3pfZrZrrro2l2oAh+nwdfiv6ZfV5gdBsVIpkoMc7wvjrB
         Jbkn6t5HZA/qrt9gQT1e5B+DxfCarEBGvw0yiYzS7QFFRi2+F041dRRPiRRw1OJ31jeC
         x7qg==
X-Gm-Message-State: ACrzQf1amfax4Q9cAiyDk05JR7BSxFx4gFFmEbJuz7LLTJMIei0KsAvx
        zHE4ZGDCy/M5Tq+OiSY0kicqQQ==
X-Google-Smtp-Source: AMsMyM5sMZjmk+H64QJo0OoxcimKkpKkJnMMp0fBy0NW2mDUiXA7s6NBnElHaWQkrIh3jIjdWlE+xw==
X-Received: by 2002:a05:6638:14cb:b0:363:ed95:ce4c with SMTP id l11-20020a05663814cb00b00363ed95ce4cmr28848240jak.308.1666820572615;
        Wed, 26 Oct 2022 14:42:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w64-20020a025d43000000b00346a98b0a76sm2395668jaa.77.2022.10.26.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:42:52 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:42:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, avarab@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y1mp23NHB0qzKsPR@nand.local>
References: <xmqqtu5zyndk.fsf@gitster.g>
 <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 10:48:03AM +0800, Teng Long wrote:
> > If the "ignoring extra" is a totally expected situation (e.g. it is
> > not suprising if we always ignore the bitmapfile in the alternate
> > when we have our own), perhaps we should squelch the warning in such
> > expected cases altogether (while warning other cases where we see
> > more bitmap files than we expect to see, which may be an anomaly
> > worth warning about), and that may be an improvement worth spending
> > development cycles on, but I am not sure about this one.
>
> That's exactly good suggestion. In my opinion, I think to avoid the sensitive
> warning and the same time we keep some information to let the users know "Oh,
> there are some extra existing bitmaps we just ignored then maybe can do some
> optimization works", but I think just remove the total warning here is
> reasonable also, i'm good with it.

I think that it is somewhat of a step backwards to remove it entirely,
but let me qualify that a little bit.

At GitHub, we actually *do* remove this warning entirely:

--- >8 ---

From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-bitmap: drop "ignoring extra bitmap" warning

For simplicity, the bitmap code only handles a single bitmap
file at a time. If you have two, it emits a warning.

This is usually the sign of a misconfiguration, but it can
also happen racily during maintenance. We create and install
the new bitmap file and then remove the old one. As a
result, users may see something like:

  $ git fetch
  ...
  remote: warning: ignoring extra bitmap file: /path/to/pack-xyz.bitmap

This is scary for them (even though the condition is totally
harmless), and it exposes a bunch of internal paths. Let's
just silence the warning entirely. It's possible that this
may make debugging some obscure case harder, but it seems
rather unlikely.
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d3fde3d3b28..283da33a648 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -298,7 +298,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 	}

 	if (bitmap_git.pack) {
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		/* ignore extra bitmap file; we can only handle one */
 		close(fd);
 		return -1;
 	}
--
2.38.0.16.g393fd4c6db

--- 8< ---

...and as the patch message notes, this is done mostly to prevent
confusion when racily fetching from GitHub, or due to some
misconfiguration.

And in that instance, I think the patch from Peff is right. If there is
a legitimate bug, we'd see it elsewhere and have sufficiently powerful
tools to investigate it. But the warning is useless and confusing to
users who don't have access to such tools.

For the general case of what ships in git.git, I *do* find this warning
useful. It's helpful when hacking on pack-bitmap.c to know if you've
messed up, and it's useful to see the filename of the affected
bitmap(s).

I think we could reasonably change the warning to

    warning(_("ignoring extra bitmap file: %s"),
            basename(packfile->pack_name));

since the rest of the path is obvious based on which repository you're
working in. So that would be a reasonable change to shorten up the
output a little bit.

You could also imagine adding a configuration knob here to control
whether or not the warning is shown, but I find that to be kind of
gross.

So I think that the warning is--in general--too useful to consider
removing it entirely, and that at most we should consider just emitting
the basename of the pack, but nothing else.

Thanks,
Taylor

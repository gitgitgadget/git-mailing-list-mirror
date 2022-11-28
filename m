Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5DC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiK1Mhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiK1Mhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:37:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206DC77D
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:37:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so10012327plb.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv9FQVaWrTO+pTZ5AD/6LAfu/OPytlUBB7GY6hbKQso=;
        b=GCmcAkVuBFb6oU1Bayl4l/0+9r6hsbtTUt+NZVhwvWBX+2TfXLAQM8rXVe7pGXdSvE
         alXWe7ZiEo+8B0GiGBuABeDgoGVCxIMM/arZjC72azUsOSQcnFDgN7zvVS9Tpd6Ceei1
         9711jSMzrxqwUIxlji0HOype8gtg2oqb/HmQIPLxRrphc+jLKmxkx897QOiAmn+Or9hU
         S5smcAXBAtrRVSw/S4/uv4mQxnPyGJypGHzfJ0+itYCtJgQgex5DBHeXprMDbS1jDZf3
         pIYHYhBekBlKMMkfiKaP2ioimh5xfUr+OBMq8BSz0srIACjk+n+Nj5Qfwtj47sJv2FzB
         wwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv9FQVaWrTO+pTZ5AD/6LAfu/OPytlUBB7GY6hbKQso=;
        b=LVnXiI4IXCYJowfQw9QFGvUs7esk0FfjhjE9K1d6iPrvPguBQvqX9pbLGkbcKPGH1l
         XYb6F2epeZotmCpFZ3t8GMkHjTP2F/60YW8t/TA/c6kY6YyHVLnL7Dy2EIq8n0lwOVXA
         KjWXGQLxXCEBK+HGRV6rJqanhg3F23q9tp9CLOyJNdbFhfsBwcpWNgoqL6nimprSNOka
         26U6g5sUpgajSFbbBz9ixmaUbqQ8fdS1TLfUzn3nJ4KErOgZ/6DP6wHh9EoLKdg93NwH
         OUv7PTFs34QhM3XiJT++RMU8SNaDdXBFsPWPsRNx9k6J2NzbZf5//bPg1EETM5QCHe0g
         2LJQ==
X-Gm-Message-State: ANoB5pnLHsbcByIWex+ikD7vaRXGm/eaX5j+qJU5MEKQ/HG+ICb8Zltp
        iWve4ErjTibVLyRHkiMahXZG3ANQp2l0yw==
X-Google-Smtp-Source: AA0mqf7FvPP3VzTWnPZ/IfIRmKLBISMyXPrS6XlxGX+rJePEVG8zRxebKryYrNnvYLz+Lv7+cEJp7w==
X-Received: by 2002:a17:903:1014:b0:189:5f79:6ac1 with SMTP id a20-20020a170903101400b001895f796ac1mr19153014plb.11.1669639071660;
        Mon, 28 Nov 2022 04:37:51 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a760500b002190eabb890sm5713396pjk.25.2022.11.28.04.37.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:37:50 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
Date:   Mon, 28 Nov 2022 20:37:40 +0800
Message-Id: <20221128123740.54250-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <Y3vM3GZYFy+l006d@coredump.intra.peff.net>
References: <Y3vM3GZYFy+l006d@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> > From: Jeff King <peff@peff.net>
> >
> > We retained pack bitmaps as a quick recovery mechanism while
> > test-deploying midx bitmaps. This is an internal mechanism, and we
> > want to expose this rule externally through trace2 so that end users,
> > repo-maintainers, and debuggers know what is happening in the process.
>
> Re-reading this outside the context of the earlier thread, I think "this
> rule" is a little vague. Maybe:
>
>   When we find a midx bitmap, we do not bother checking for pack
>   bitmaps, since we can use only one. But since we will warn of unused
>   bitmaps via trace2, let's continue looking for pack bitmaps when
>   tracing is enabled.

Thanks. That's more clear and will be applies on next patch.

> > @@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
> >  static int open_bitmap(struct repository *r,
> >  		       struct bitmap_index *bitmap_git)
> >  {
> > +	int found = 0;
> > +
> >  	assert(!bitmap_git->map);
> >
> > -	if (!open_midx_bitmap(r, bitmap_git))
> > -		return 0;
> > -	return open_pack_bitmap(r, bitmap_git);
> > +	found = !open_midx_bitmap(r, bitmap_git);
>
> I think we can drop the initialization of "found = 0"; that value is
> unused, since we'll always assign to it (I think my initial attempt had
> setting it to 1 inside the conditional).
>
> It's not hurting anything functionally, but it makes the code slightly
> more confusing to read.

I agree it's not hurting here, it's OK for me to make the improvement
here. But I have a question, do we prefer to omit the initialization
in such scenarios if we make sure it will initialized correctly？

Thanks.

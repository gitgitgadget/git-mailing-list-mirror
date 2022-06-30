Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E154C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 08:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiF3Ifq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiF3Ifo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 04:35:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48420205F7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:35:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so16396159plo.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wR+mjsQs+VtQ0tKEzORpp0wSljK5WU1d25XXoqcHkco=;
        b=drQQfiQmftY/nIuJuW/jV191Dq9jiU4n8HQBln3JM6sBNLBa08wTXZohesdPZJ1pJR
         i4wS/h+pGkvqPKzkNbl1NtEiEU9EcELlmAQA9oFWVzR5TqQ+96nHnUrbk0GUIevDo6Z7
         G8Mhpke7vqNMLXEjEKFzkOw5TiEUwcE2GuNz3eSA0sIiD3N2p43PaPNqTIacJuZG7ZqU
         bd0UL9CYJhTHXtwE+uTWb1/S17rGm3x8vthOZwuBWC3fsSMYeXShHX+cuhafZI8LLvRY
         VPt3Zlf0UVADCtS8xFHVNo6p5tqGqzuB+wycN0UIQQcWlBRKYXwva+fS1a1d+idJwHGy
         Xejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wR+mjsQs+VtQ0tKEzORpp0wSljK5WU1d25XXoqcHkco=;
        b=m+u78Gue6W/D37lyzj2WKt7IO1sGA0eljKjsEVzIpwtBW10FHtuaWBJSdqJum+wrxI
         b7PGrlQI9/CHWE2LgjKj6RjrljqV1rzI6PDIKF5WhRDpU4vksM+3hyFEY0+B+xzfDhaN
         KI1XNC9pp6eeXAJzfuLG983abzVLIU1ukT3RkrWmU3h4/wUQvFwDedydEUXZx+w3tQZm
         K+WWaJgNHJeFczvjZe4TiMrBv4wFhchvQhg3NxxSCnS7ZLOkUuwJvgkNhO63gU+hSh8O
         EXqXokgq4sq5h1OqDZZIehFeZXo/xuRHbymTCSY/PSm8EIlDQMY6uQAwttZCpc/C3iIL
         cLrA==
X-Gm-Message-State: AJIora9ELgRyO2i0pm0PdLwxIVuE7qqzII1Pn6/jd01oY76eh/iOxwST
        W+WxlrKoxy9dTrSxYXk56/VUY5vvRA0=
X-Google-Smtp-Source: AGRyM1s8GwUeTttuxTXYBGf55PXuUfFM31SVOovFfTXYTt/qtJPXPu/vx70UadxfrGbEm/SbUwTitQ==
X-Received: by 2002:a17:90a:8d85:b0:1ee:dd88:f3f2 with SMTP id d5-20020a17090a8d8500b001eedd88f3f2mr8826213pjo.216.1656578143717;
        Thu, 30 Jun 2022 01:35:43 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.154])
        by smtp.gmail.com with ESMTPSA id 11-20020a63164b000000b0040d4c8e335csm12656046pgw.75.2022.06.30.01.35.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jun 2022 01:35:43 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table extension
Date:   Thu, 30 Jun 2022 14:05:17 +0530
Message-Id: <20220630083517.6411-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yry4ElVFQEsVbqse@nand.local>
References: <Yry4ElVFQEsVbqse@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Taylor Blau <me@ttaylorr.com> wrote:

> I think having some indication (maybe via a trace2 region?) that we're
> actually executing this code would be good. Although it's going to be
> *really* noisy, so probably not a good idea to do that in general.
>
> Stolee runs some coverage tests that show lines that we aren't
> exercising via tests. So making sure that this doesn't show up in that
> report when you run it locally would be good.
>
> See some information from him about how to run those tests locally here:
>
>     https://lore.kernel.org/git/00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com/
>
> (TL;DR: run `make coverage-test` and make sure that these lines don't
> show up ;-)).

Got it. Thanks.

> If we had something like that, we could call that function from within
> `test_bitmap_commits()` before reading the keys and values out of
> `bitmap_git->bitmaps`.
>
> An alternative approach would be to read the table directly when it
> exists, perhaps something like this:

I think we have a simpler fix than what you suggested here. What if
We do it like this way -

    if (bitmap_git->table_lookup) {
	if (load_bitmap_entries_v1(bitmap_git) < 0)
	    die(_("failed to load bitmap indexes"));
    }

Is this okay for you?

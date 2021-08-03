Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28923C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055B060F93
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhHCAnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhHCAnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 20:43:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0DC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 17:43:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d2so12936616qto.6
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+6fkcsAzrmAW36/7EEWpRMxtGU8F1uci00osKbr9e0=;
        b=YTpC0A7NR1Z1GGlmuYgjQwY7+8oAkE0+tCIZefqTxO8zsFcuri/oF3Qxo583l7So7t
         U1xiIsEXkrDJox2HM3EmStHDkPsOatdfOKVSKxxddYCyu/uUjs8mM+6R/UGv6kuvEZK+
         JBABTfbz+K1GOvzQ1CJ/GvA/c4ALrj4x9SqWxcLGzZedJxQu9jazdpDnAFv2PFPuK/7i
         SMgTxDi4oxY64JaEb0C34J2vH+nQTLSoz4OBWScy5IstmVjSiBRlyj9Gd3QHl3BIu5wo
         daJ6HSZpFMEW5NGCLX9GCod15FSsD0C04kEC87lWJKItLKP31malLOYqnsGyCmaQ+oKC
         K2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+6fkcsAzrmAW36/7EEWpRMxtGU8F1uci00osKbr9e0=;
        b=tnbcfSWPOsn3UPI2jyubneJD8cbXZbY3YGwNJR+vi0u8I6guOZC+Ae0SFH5CSeA8eE
         zGukxkXMdrEKJ/MmOePEs6zlkEW+BYfKar2tnazWNkeOPNUITgqcS4IzxUsfzKFE9+yZ
         5DzinKLEzwUKd0IuiuwX/I4CgWybTvli5hAUOsPWncHRrApLIOAqb/tP0/OD4lWM5NIW
         6wo9n07QDlJzAvRY4FJCNUUzhf1L5dui78SA0n38OrCvqVc5bgp9eqhseTbpQIwiznQT
         /nDAzZACNMovoNwvbRU3dgosHRkbYsS1hg1gHWHBBSS4RUeGwv69v4pMIT493ek5a5hv
         u/9Q==
X-Gm-Message-State: AOAM531u7UQJXZOH057UaHkaefDmHoEUYadhlAXVKrCIL2fy4T28fDu8
        7gaNsC53ervGso2icUT0duA=
X-Google-Smtp-Source: ABdhPJzGkx1z8LtZwNSGJHHl9SQ2nYlhxWFXAgn7aXFzDVf+0WZxeqyRZ6C/9a5HcVHUOIIAxFenyQ==
X-Received: by 2002:ac8:7dcb:: with SMTP id c11mr17015208qte.260.1627951381025;
        Mon, 02 Aug 2021 17:43:01 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o27sm6885622qkk.124.2021.08.02.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:43:00 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:42:55 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] advice: remove uses of global `advice_` variables
Message-ID: <YQiRD2OA08iW2cx7@erythro.dev.benboeckel.internal>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210731022504.1912702-4-mathstuf@gmail.com>
 <nycvar.QRO.7.76.6.2108022356300.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2108022356300.55@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 00:06:48 +0200, Johannes Schindelin wrote:
> On Fri, 30 Jul 2021, Ben Boeckel wrote:
> > There are now function APIs to access this information, so the global
> > variables are no longer needed to communicate their values.
> 
> This commit message implies that the reader remembers that `hw/advise-ng`
> introduced a new advice API with the express intent to eventually replace
> those global `advice_*` variables.
> 
> However, it is not the responsibility of the reader to remember that. It
> is the responsibility of the commit message to describe this (so that the
> reader can either remember it, or learn about it in the first place).

That makes sense, thanks. I guess I'm used to projects where I'm at
least peripherally aware of most of what's going on, but that's because
I work on cross-cutting concerns on them for the most part (build
systems, CI, software process).

> Now, as for the diff, I can guess just how tedious all of the
> semi-repetitive `advice_*` -> `advice_enabled(ADVICE_*)` changes were from
> trying to verify that they are all correct.

One of the times a case-insensitive word diff rendering would be handy.
(Then letting the compiler verify that the new side actually works.)

> Big thank you for that!

You can thank this Vim macro which made the tedious bits trivial:

    iadvice_enabled(<Esc>wgUwea)<Esc>]q

> However, even reading through the diff the second time, I managed to miss
> the subtlety that there were two `advice_set()` calls strewn in.
> 
> As I pointed out in my review of patch 1/4, I would much prefer to have
> the addition of those callers in 1/4 along with the introduction of said
> function.
> 
> However, now that I write this, I would like to correct my advice (pun
> intended) from 1/4 to leave the removal of the assignment of the global
> `advice_*` variables here: It would make much more sense to move them to
> patch 4/4.

Sounds good. I'll still keep it as a separate patch, but just have one
for the read-only side, then a new patch which adds the write API and
transforms the 2 write instances. The final patch can then stay the
same. In short:

  - 2/4 (read-only bits) -> v2 1/4
  - 3/4 -> v2 2/4
  - 1/4 + 3/4 (write bits) -> v2 3/4
  - 4/4 -> mostly the same

Thanks,

--Ben

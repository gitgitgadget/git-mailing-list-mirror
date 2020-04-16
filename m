Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F5C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCFD206A2
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cdGCDgHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406121AbgDPBHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbgDPBHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 21:07:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4767C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 18:07:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so728267plo.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQThoZxi2aTxfFZm7bSDQYK2/qAh+U1UcTELzKGjxmA=;
        b=cdGCDgHfd4RL1t/vwc/ukGe0kkr6RfFk0BaIQULOMLJG6593gqG/kfINB2f8z2mmoP
         DnlE3R/pEQdTdjwAQ9795G4a+QpPfr3WgEqgD1iMi4mmhZqigds2hrEZ1e7JQFVH/rOn
         vIOiGyGEveey69pSMhl1P64aiaXmbJQuX02uOlyogiOc27ZydoxGeSeRmYWUi1sh43tt
         3JGLjGWyKtF1wsqsCHFhfmCuU4I0HdBxTqPOFE6H86xVY9bdM77frHTgoI/H6w27B3DO
         Fgi+mXJ8b/S7RYYx85xu+jFzYcJfD5AXnbbPjRRXj0pJzSOmFpDLK9MEV7h0wBCSJ6QK
         ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQThoZxi2aTxfFZm7bSDQYK2/qAh+U1UcTELzKGjxmA=;
        b=GxNJhS54Vemqmg6Ah4Eooeap4CSoMLQ/f5SjTZ+zeEXD9/kMv9yBIkqaHGy3ewa+3O
         i3KeZbhEN+TmytpwPKsOmHfBywsJHFgV6FNqOZP4/2lacp6gndQrP8FbZs1bxrX1WRNf
         Zto8CYrunhxBgxIdASUMBb/u8ckUO+FFCRqmUwwWuSldX05q+U1B8pqtEEjds8C6lt6g
         CIjKz098XpXrTwVgWMLoUjM32QLi+jlp8v11RaNTBJ4Y7SbCrQrz/0p3VsRT6M6uZdMt
         MtQduS2wxT9sBd+eK27SlNyggZGMZt8qhPeYpxgtQUDANi9wbqk/P2yrDC2JtiRoD4rI
         LwmQ==
X-Gm-Message-State: AGi0PuYqruQs42ISvHm5RL8MFLHKX0FoGgBw6hwU07sDI4s+TMdSdRqT
        PGQN4ZcqxNQWctvBfLrw9B9NOw==
X-Google-Smtp-Source: APiQypKc/u8cRcLr2sqDuwtJBGyzuT51NNCiCq558PMxl9S8Mf0e4HsoBJHQHbeVqbsxSPKCQoHYfQ==
X-Received: by 2002:a17:902:8213:: with SMTP id x19mr7572093pln.224.1586999257081;
        Wed, 15 Apr 2020 18:07:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i34sm13684352pgm.83.2020.04.15.18.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:07:36 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:07:34 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH v2 0/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200416010734.GE36156@syl.local>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <pull.760.v2.git.git.1586982745.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.760.v2.git.git.1586982745.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vasil,

Thanks for sending a v2. This all looks good to me.

On Wed, Apr 15, 2020 at 08:32:23PM +0000, Vasil Dimov via GitGitGadget wrote:
>  * override a possibly user-customized format.pretty that would render git
>    log output unparsable by git range-diff
>
>
>  * don't use negative string precision, e.g. "%.*s", -5, "foo"
>
>
>
> Changes since v1:
>
>  * Fixed a typo in the commit message (found by Taylor Blau)
>
> Vasil Dimov (2):
>   range-diff: fix a crash in parsing git-log output
>   range-diff: avoid negative string precision
>
>  range-diff.c          | 18 +++++++++++++++++-
>  t/t3206-range-diff.sh | 10 ++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> [snip]
> --
> gitgitgadget

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

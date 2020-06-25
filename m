Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A1C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139492072E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8myJ/Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbgFYUpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391150AbgFYUph (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 16:45:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715C0C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:45:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i14so7276315ejr.9
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+4OUEcYV4YblZ3GvQpmZjvE+/+wIZHC7zPpNYS2jcN4=;
        b=o8myJ/Ja2Yes3Iie4GKHC9cbr1VxiaA913PEAQMcty6X7h3q7+cBzAkO0ETHj0wH7/
         4z+zeX3mukQauD5DfoEE+jycw1zNQV/4DCU/DyjAaky6f7/hSKOTHZG6Z9ZSK6hqEKG6
         ALMl17dLCnJ7LvI8OLJFS/NfKMb2u2qzVoFpssNyTZnFrmqTeG0dLZhTxl9OR+nDP72K
         SIe2ssdRCbfrIKdpXkjOb6WMZ0hvIdSEdZPiMD0g2Kc9i8DsmWSZW1MF/Fx41+sWFk2D
         QfSvbiU42bsF0nY8QIbogWOYIe5EE7c7wjq3TGYSspRZtmJ3XjCPKrAqH0IYhzfpxbCk
         XCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+4OUEcYV4YblZ3GvQpmZjvE+/+wIZHC7zPpNYS2jcN4=;
        b=bfRLEyY8akamKeizDStZeE0/+MS8AloTJVtJDrI6esyQCPSGa8f5CUFm2KhjVIjx6m
         4WjrIrlkRhIMgiYh50KrKj+iDYg2L+6IVGQmFa59sOJU1bcYcBtI+CMKcEuPVEsodyEq
         ux72ij8ujnsvqL0QG/tR3PVTKpsNZmW9evvwPJeO8fh96OVe2ileOkJGjtYby5Skuqb1
         adqZjTMxFTP5iuVSHQK4ByhUi6MxDg77gzs9JjiQ8hFqP9ZPRo9ZiP8J7Qbr2wihmmYm
         exSqGLu/g8iqOnsC+iJENrHOL5Mn1atr0hrzYxJnJTBqii+avqd9lb6/oDhfAflTWsmQ
         qmUw==
X-Gm-Message-State: AOAM532YCK72e5mtyjkhlc15yT89kZmkLJKXUIfO5r3SwnDoPYTwRfT4
        kADtNsLGSgwIonqdCKkHvCWu/HoL
X-Google-Smtp-Source: ABdhPJwDnIRd7bz3CtQ/3gfx3h3jjmsDTZLeqUfgOqRF9G5LDOFaqpjWeNowR+RpcwenGr8ezvZtpg==
X-Received: by 2002:a17:906:4d14:: with SMTP id r20mr30394053eju.346.1593117936094;
        Thu, 25 Jun 2020 13:45:36 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id j11sm17617700ejk.67.2020.06.25.13.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 13:45:35 -0700 (PDT)
Date:   Thu, 25 Jun 2020 22:45:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200625204532.GK2898@szeder.dev>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
 <20200624114313.GJ2898@szeder.dev>
 <20200624155420.GC2088459@coredump.intra.peff.net>
 <20200625154948.GA3968780@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625154948.GA3968780@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 11:49:48AM -0400, Jeff King wrote:
> On Wed, Jun 24, 2020 at 11:54:20AM -0400, Jeff King wrote:
> 
> > > GCC 4.8 complains about this change in our CI job:
> > > 
> > >   $ make CC=gcc-4.8 builtin/fast-export.o
> > >       CC builtin/fast-export.o
> > >   builtin/fast-export.c: In function ‘generate_fake_oid’:
> > >   builtin/fast-export.c:394:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> > >     put_be32(oid.hash + hashsz - 4, counter++);
> > >     ^
> > >   cc1: all warnings being treated as errors


> So this really seems like a pointless false positive from the compiler,
> and it's a rather old compiler (the warning no longer triggers in gcc 6
> and up). Is it worth caring about? Ubuntu Trusty is out of standard
> support but not fully EOL'd until 2022. Debian jessie has gcc 4.9
> which triggers the warning, but will hit EOL in 5 days. If it were an
> actual breakage I'd be more concerned, but keeping such an old compiler
> -Werror clean doesn't seem that important.
> 
> I'd note also that none of the Actions CI jobs run with this compiler
> version. If we _do_ want to care about it, it might be worth covering it
> there.

C99 style 'for' loop initial declarations are still frowned upon in
Git's codebase, and as far as we know it GCC 4.8 is the the most
recent compiler that can reasonably detect it; see fb9d7431cf
(travis-ci: build with GCC 4.8 as well, 2019-07-18).


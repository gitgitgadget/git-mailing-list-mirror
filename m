Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B048C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKDMhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKDMhu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:37:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A12D772
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:37:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso1569623wms.4
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oIEwAr4Ju7xxeL+VlGEgNQ5NTANpks33FJaIQOkfwg4=;
        b=qVyHAJuhR2PbDGMGLEhcJYp6SHn7dm/+Su0q0iqsWni0gwTx5m/6FebwwvhXusVpFv
         mCOW9b4V4V0cGhTUvD784q8sA9yLgOOp4FWFC/NUJYBkmybVyQAr1mwk7+eN427dLx5E
         NPEgiG1e/nbnG82/rki5WS77LH+CIjbejH49vbJZkrMG8GpkJgSIuFAC7yfkQUPGyE4d
         9GMfNkSZuePB7ug+PQpqMfc70e9Wb8NzMyf4aSFM1QuVwenbbIQ5ZuQdwLAXSLXnB6eV
         NGITy9NYXALZv7NQvtrGcgvkpkJ8txp5JtjU7xDkHBuZQRQJFdf9j7Sw1iRAkyHEupt6
         VZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIEwAr4Ju7xxeL+VlGEgNQ5NTANpks33FJaIQOkfwg4=;
        b=YOFS5dM+riIwxxTHMrVJKlRLhOlEBcP0dujdWIdIQVwH/R6jBmKcs2zDL2gM2dS8zv
         SfaYx9cvfikmcinj+jhZQJbtfeHkNgO3ydWiYaSJ6/1ni9hRZr8uBLALwLPe7AghIPxI
         Ppp6K+2VFVBCOU+aXfSBG8CuJizo0S/d9xVdkiYJYDpeLgqwsIJ8O8EmZPgQEgEglrZm
         FbwyL+s88TT0pNX3dBlkjxyZ4HQ4gDoii9AfPvGViI7dVwulhWydgOf6S/gXUprwZVAC
         KRoiZs+52NZojWOe4DW8QSVhX5CtqTE6EFX4/kg3rCr6LSITCCzLbJVYdH1z8AXTIGsr
         WZeQ==
X-Gm-Message-State: ACrzQf35YumtHShXskyagAJmQ2PSRYQMrNeVb8PylC+SZRPpH3ETGvgQ
        Z46yEANVIuKQLsvVI0LGIkE=
X-Google-Smtp-Source: AMsMyM6kX542k1TzE6+8MC8k3k4abwWAyhhrFaPX/oU+COaF4sLd3M+ID60t7j/IbZmLbpDaiEEsZQ==
X-Received: by 2002:a1c:2185:0:b0:3cf:8e86:1043 with SMTP id h127-20020a1c2185000000b003cf8e861043mr5187924wmh.157.1667565445053;
        Fri, 04 Nov 2022 05:37:25 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d4485000000b002365730eae8sm3309405wrq.55.2022.11.04.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:37:24 -0700 (PDT)
Date:   Fri, 4 Nov 2022 13:37:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <20221104123722.GA6942@szeder.dev>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 05:45:52AM -0400, Jeff King wrote:
> On Fri, Nov 04, 2022 at 07:31:26AM +0100, Lukáš Doktor wrote:
> 
> > Steps to Reproduce:
> > 
> > 1. git bisect start BAD GOOD
> > 2. git bisect run ./myscript arg1 --log arg2 --log -- arg3 --log arg4
> > 
> > Results with 2.34.1:
> > 
> >     running  './myscript' 'arg1' 'arg2' '--' 'arg3' '--log' 'arg4'
> > 
> > Results with 2.33.0:
> > 
> >     running ./myscript arg1 --log arg2 --log -- arg3 --log arg4
> 
> Thanks for an easy reproduction recipe. I used this as an easy-to-see
> test case, which works in any repo:
> 
>   git bisect start HEAD HEAD~2 >/dev/null 2>&1
>   git bisect bisect run echo --log 2>&1 | grep running
> 
> > Is this expected? In https://bugzilla.redhat.com/show_bug.cgi?id=2139883 Todd suggested it might be related to
> > 
> >     d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function in C, 2021-09-13) 
> > 
> > but I haven't tried it myself.
> 
> Yes, it bisects to that commit. +cc Christian, who mentored this gsoc
> project.

It might bisect to that commit, but I don't think that commit is the
real culprit here.

'git-bisect.sh' used to have a 'bisect_write' function (not
subcommand!), whose third positional parameter was a "nolog" flag.
This flag was only used when 'bisect_start' invoked it to write the
starting good and bad revisions.  Then 0f30233a11 (bisect--helper:
`bisect_write` shell function in C, 2019-01-02) ported it to C as a
command mode of 'bisect--helper', and:

  - Added the '--no-log' option, but since 'bisect--helper' has
    command modes not subcommands, all other command modes see and
    handle that option as well.
  - Converted all callsites of 'bisect_write' to invocations of 'git
    bisect--helper --bisect-write', but while doing so that one
    callsite in 'bisect_start' was misconverted, and instead of
    passing the '--no-log' option, it still passed 'nolog' as
    parameter.  Consequently, 'git bisect start' wrote a couple of
    extra lines to '.git/BISECT_LOG'.

This bogus state didn't last long, however, because in the same patch
series 06f5608c14 (bisect--helper: `bisect_start` shell function
partially in C, 2019-01-02) the C reimplementation of bisect_start()
started calling the bisect_write() C function, this time with the
right 'nolog' function parameter.  From then on there was no need for
the '--no-log' option in 'bisect--helper'.  Eventually all bisect
subcommands were ported to C as 'bisect--helper' command modes, each
calling the bisect_write() C function instead, but when the
'--bisect-write' command mode was removed in 68efed8c8a
(bisect--helper: retire `--bisect-write` subcommand, 2021-02-03) it
forgot to remove that '--no-log' option.



Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B5ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJaX7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJaX67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:58:59 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F8F3A
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:58:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p184so11100171iof.11
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wdUgE/0G6A2ONqmIt7FpqLbekZ/5dL3WJBEBslcJxY=;
        b=W7k206OpK2D6NKQ3lJBIxg1G4t3rY5kk1YmBOrDQBC0k8lDNinzAYLg9rhlWC6bIcv
         vj/clrxBUXjkIveXcubWJNvi737JfgOOC/QTmhJlRP8qiQgqaUI8eQt3hkovJSahJm/u
         qipUkZyieJNfancjoZrJSOb7fvYgbT0M0CCZVC6YFnPu0iJZk96/iVEEc0HvvumgPT3j
         fZ0CeUkUjhdWDttuGMvOWar7Nj1/ND8oGZrwpq4E23y+mMBkz7X+a3hohJn5D58AGLy1
         mEXtL8W+OHgYpo/ulXpUb1AFKAJlKg3V0YFgP3LyHz4E7zLLV3N6vlVsKOja56WcGA9V
         GZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wdUgE/0G6A2ONqmIt7FpqLbekZ/5dL3WJBEBslcJxY=;
        b=CpGSwpbLW6jLzDWTvafppGfcJxPi+z/0A2dvQ7Eyl9mayjNc8/cV1a3FfVoA4L1GLQ
         PxbJUcfyIw1cAhAAjB7/x9tiG2ndEDDeMNar8YOzkcRWYJRkTofEpoo06MMwl46jeWAD
         YcHb8Jk/sdyYxJpONfckOmkLPR/7aacbUaEwv0ahpVGEev28X/icVLEjpllLnEbR3vj5
         J7cucZD4L+ox67ATePiGUkkDZbulT2yPJYRZ4x6JrPgYNpquNcm2Yqj7j3SNNUpjAitD
         VljmmP8m283Y14i/+Np8OUADI5ced0lWcqFxqgeMPaFSzgHkAm9vx8H91K0WyxZL9mOF
         iCqA==
X-Gm-Message-State: ACrzQf07J2oAsIFi2YKA1IhevqB/WQZTtJLdN1o1M9kGBFYGo/DWSYbh
        LNJCo+Z3KEuzEn+i55KDp1fpiQ==
X-Google-Smtp-Source: AMsMyM79+VxfCvCeSB1Mvh5jhzxmzp1oJpnwglcieaFiPM3j110eohgc5YexYWfyRFLrwXu2U6KueA==
X-Received: by 2002:a05:6602:2e8d:b0:6bd:543c:6fd7 with SMTP id m13-20020a0566022e8d00b006bd543c6fd7mr8970012iow.134.1667260738576;
        Mon, 31 Oct 2022 16:58:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a02cf33000000b00363a4fcd3a8sm3292989jar.5.2022.10.31.16.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:58:57 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:58:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] submodule tests: reset "trace.out" between "grep"
 invocations
Message-ID: <Y2BhQHynNWkl6cbY@nand.local>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-2.3-708375e3104-20221029T025520Z-avarab@gmail.com>
 <Y12JfADN/YRr9IaJ@nand.local>
 <221031.86pme86tcg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221031.86pme86tcg.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 01:50:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >>  	(
> >>  		cd downstream &&
> >>  		GIT_TRACE=$(pwd)/trace.out git fetch &&
> >>  		grep "1 tasks" trace.out &&
> >> +		>trace.out &&
> >> +
> >
> > I fail to see why these hunks are necessary. If we specify GIT_TRACE,
> > and don't have a test_must_fail around the execution, then why should we
> > feel obligated to clean up the trace.out after every execution?
>
> Because the trace file isn't clobbered by each git command that
> specifies GIT_TRACE, so these tests are basically doing:
>
> 	(echo foo; echo bar) >>trace &&
> 	grep foo trace &&
>
>         (echo bar) >>trace &&
> 	grep bar trace
>
> Now, it just so happens that the earlier command isn't echoing "bar" to
> the file, so this is currently working out.

Ah, nicely explained. This is new to me, since I thought the behavior of
both GIT_TRACE and GIT_TRACE2 was to clobber the file.

> But it's a bad pattern to be pretending as though you care about the
> last output (which was the intent of the test), when really what you're
> testing is the combined output of all preceding commands.
>
> This would also be a potenital landmine with "test_must_fail", just
> because the command failed we're not guaranteed to have written nothing
> to the log (and usually we'd get as far as to write something).

Yeah, both make sense, thanks.

Thanks,
Taylor

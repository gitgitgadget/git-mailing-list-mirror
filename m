Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EBCECAAA1
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 00:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKAAPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKAAPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 20:15:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E141056F
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:15:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y6so8166500iof.9
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RbDuwhRsQmtNCwOkzBFQlCWmz2LuDIQ1UhvPvXVxkWk=;
        b=ueq9Zp4JLLxwe+IhisFT8cBDSjXkQNKE3eCSobl38AhPXOljyfgc2O6qyWp4jUm0+f
         +k4kS3l2gJyCZ4liVsa6EKSlPm5M7wxXRnmBMfEAKZlCi8kWUsKVXCc6F2+dBNa2Wde+
         r2FhhKzr0mfffnl3vONZFxm96lLryepinYdi1PxPaLmaXPoLlz0G3Da1lhtlfqg6UD+R
         yYQPcEyg1cd7FI9cDhGyaDYtxuP6OdhwgUQH2fCmFn9KK+j9VYrsbQx6O57v8QWUS6PV
         r+v/hSSZ53rEFxx7fYbPql0e4zl0U3eBuz3g3Qe0WRADR/dTxtfuxJTM+BOlWBSN9ZMg
         xvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbDuwhRsQmtNCwOkzBFQlCWmz2LuDIQ1UhvPvXVxkWk=;
        b=Y+lPtnVf6pQeBTJ4214htPEnzzd0kRec2fdugm5z3oea0zToOf2t8BXucyqZRx/pZl
         Vv4DBWCGkHkfEYiBMETLNp+fZwd5SJQi2QG+IlyjY+qwWcRjSrYTgz7p4ZBW3UJAXHV6
         cKVJOtKiUy+Oe4D0Lh4pKy29YRlRgSc98b9M+jturQTuQTZU5AcTQSm8Im88PPzRmwcp
         wvlKGep1pyrSJUa+Vl/PWl7IRRma25lJLYx97QVVn3cvkcpgQDatbHuBw32wCCQZIWNi
         yiGJdOiwH7v6c+GdzAhkY9t2zistNeHn3K3dQ8MOvNLk5YFABkMD9esbS8kDIiAM5h7E
         YHZw==
X-Gm-Message-State: ACrzQf0zbJMk+LNkU4R0/eP/nx7J15T/4dYRag2iSqv92DY3y2/5C8aL
        CKCh+ljPvDruGHgs5p/x1YI2fr0lbkstfoaF
X-Google-Smtp-Source: AMsMyM5ZK9e0+0s1TNEaTJkxk6oE6afLQkd/v6kSF/cJvDa+0dOorln6Yc6HXf9VDBhDaPrsrpMFCQ==
X-Received: by 2002:a05:6602:2bec:b0:6c0:e5d2:b924 with SMTP id d12-20020a0566022bec00b006c0e5d2b924mr446579ioy.143.1667261741299;
        Mon, 31 Oct 2022 17:15:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j197-20020a0263ce000000b0036e605a3e79sm3332486jac.17.2022.10.31.17.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:15:40 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:15:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: ab/misc-hook-submodule-run-command (was: What's cooking in
 git.git (Oct 2022, #09; Mon, 31))
Message-ID: <Y2BlK5uhCy77Ot4Z@nand.local>
References: <Y19dnb2M+yObnftj@nand.local>
 <221101.86iljz5z7l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.86iljz5z7l.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 12:46:57AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Oct 31 2022, Taylor Blau wrote:
>
> > * ab/misc-hook-submodule-run-command (2022-10-31) 3 commits
> >  - run-command tests: test stdout of run_command_parallel()
> >  - submodule tests: reset "trace.out" between "grep" invocations
> >  - hook tests: fix redirection logic error in 96e7225b310
> >
> >  Various test updates.
> >
> >  Waiting for review.
> >  source: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
>
> I think per
> https://lore.kernel.org/git/221031.86tu3k6u2d.gmgdl@evledraar.gmail.com/
> &
> https://lore.kernel.org/git/221031.86pme86tcg.gmgdl@evledraar.gmail.com/
> that this is ready to advance.

Yeah, I agree. I was mistaken that GIT_TRACE truncated its output when
redirected to a file, but it appends. So, the series looks fine to me.

I would still like to hear from Emily, but otherwise I don't have a
problem starting to merge this down.

Thanks,
Taylor

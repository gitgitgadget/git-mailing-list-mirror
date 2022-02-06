Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0015FC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiBFKI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 05:08:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABDC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 02:08:25 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id st12so8643755ejc.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/MARxSoydu/uSTzG5/QMyiIX0KCPiC12XG1anfl3IsU=;
        b=HmDnfVAtH3qFeRniOzliSJ77RuglZhikDi/wJtQrfuC2ttqvJSafTz1B/JLOSy6/aD
         WZP+E2V5NN6A1SMsbqYbtQJPjWWQJLbpn1Nlj4VgovXt1DPgjYL0LpqK8uzPD2W9Ww+e
         K/IL1SyeWoQ2szwfG2FpoImRrCXqdcEV0w+weJOffNIC+BzqXQwyVqrveBLG1+bwXrsv
         7Bi4NvEsIHYR7/BX0+m9GNBI4IDTIRT7X+pQ4NlzIG0BSIjUgHBNAVKNYNIzxcmSK4sl
         NfnyNK5S6tLiNY7zNWWontmpBAZalNPM8SK8ZqxCdGu2rg+3DW3P2ZFoHP6o+VLnqBJc
         LX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/MARxSoydu/uSTzG5/QMyiIX0KCPiC12XG1anfl3IsU=;
        b=OnKJc4R1Pt8+nrIpWHGkzcDEVLKPxL2oixvUN6kE2F17buQV2oeuzgX4LSqqJwpD3N
         vWkNUpokjijDsZBYk1I8VqPjONbFq/fWy2BY1AnZ0N6/83YwYscoYEzuMRTBrYEV+W2b
         V0z4/vhoD8IZvhYrWH/iBnFe8C8DbYsUDQBw/hb7CRRn9CCTNJVrTEHkDGZ9TwJyWbWE
         H1tiejHpQpbHLaWo6qbuTCKcOvPR13MpTPL/Zh0YMRlVoprcnl7krlPPZ8ahAf+Jpyg4
         wQ9gRC43k0dvogQ8fpEy0Yd+YytZHVZuYIXQssPWRpe+KMWR9zaAQjHDjG8AgiuObwUI
         ooJQ==
X-Gm-Message-State: AOAM530+qSVid25hU+4g7cAkNgdI2R0bNPuWrQeDV1FODAo8IruJpm2o
        fQB8fDPgzibUof5QhAGy7h8=
X-Google-Smtp-Source: ABdhPJxJ/KU5nCE6hbMJPJzgIVyq/8iEuS81IBfjfMbd/MIX2pY7d2GY9cvitDa9F/z7wEpTpG7bcQ==
X-Received: by 2002:a17:907:7f87:: with SMTP id qk7mr5921378ejc.746.1644142103691;
        Sun, 06 Feb 2022 02:08:23 -0800 (PST)
Received: from szeder.dev (94-21-146-211.pool.digikabel.hu. [94.21.146.211])
        by smtp.gmail.com with ESMTPSA id da9sm216208edb.1.2022.02.06.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 02:08:23 -0800 (PST)
Date:   Sun, 6 Feb 2022 11:08:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Message-ID: <20220206100816.GA1936@szeder.dev>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
 <20220130090422.GA4769@szeder.dev>
 <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
 <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
 <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 05, 2022 at 06:00:02PM +0100, René Scharfe wrote:
> >> --- >8 ---
> >> Subject: [PATCH] grep: disable JIT on PCRE2 before 10.36 to avoid endless loop
> >>
> >> Commit e0c6029 (Fix inifinite loop when a single byte newline is
> >> searched in JIT., 2020-05-29) of PCRE2 adds the following point to its
> >> ChangeLog for version 10.36:
> >>
> >>   2. Fix inifinite loop when a single byte newline is searched in JIT when
> >>   invalid utf8 mode is enabled.
> >>
> >> Avoid that bug on older versions (which are still reportedly found in
> >> the wild) by disabling the JIT when handling UTF-8.
> >>
> >> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> >> Signed-off-by: René Scharfe <l.s.r@web.de>
> >> ---
> >> Not sure how to test it.  Killing git grep after a second or so seems a
> >> bit clumsy.  timeout(1) from GNU coreutils at least allows doing that
> >> from the shell, but it's not a standard tool.  Perhaps we need a new
> >> test helper for that purpose?
> 
> https://mywiki.wooledge.org/BashFAQ/068 offers a Perl-based Shell
> function or aborting a program if it takes too long:
> 
>    doalarm() { perl -e 'alarm shift; exec @ARGV' -- "$@"; }
> 
> It doesn't waste time when the program finishes faster and seems to work
> fine with git grep.
> 
> I can't actually test the effectiveness of the patch because PCRE2's
> JIT doesn't work on my development machine at all (Apple M1), as I just
> discovered. :-/  While we know that disabling JIT helps, we didn't
> actually determine, yet, if e0c6029 (Fix inifinite loop when a single
> byte newline is searched in JIT., 2020-05-29) really fixes the "^\s"
> bug.
> 
> So I have to abandon this patch, unfortunately.  Any volunteer to pick
> it up?

FWIW, I built Git with your patch and USE_LIBPCRE2=YesPlease and run
the test suite, and it succeeded.  Though I can't judge how much is
this actually worth.


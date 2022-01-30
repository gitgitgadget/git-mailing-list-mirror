Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE501C433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 09:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354334AbiA3JEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbiA3JE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 04:04:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A0C061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:04:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id s5so32873428ejx.2
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8T7YwkTs9M4cO5m0wU814G2B4ziFXERq7fbbNe0Oaoo=;
        b=n7OTvkXSTVGSLoXNVJizvXyY56ldY5WPu+oUZf/5ujo1B+PRjl7fhjXAfPxMW/H4nx
         PV4x0zt4YqQXqxPFRaBla/oqXibLH8hAZqjexXfVoE69WeSarNU/5x8uV+ybmW1i9Zor
         WhfJVQcptds6DmyqCL/CnWL89/RzOEhvIXVBMxXMYSOp92X5sPFBLbOQtSmcYRpTxgpB
         LnYQsBJblgxcvAXOL3MY19IOi1eTfQJcx1+5eiTkYcZvS2O14b7jNhEtJFH+KTfVLkLU
         Io6dhJ6Xt4vYEQaLWPZr69cTycjE8tYidpSSPc4lspcRFWeZXf4u4VhGG06Ayo+iCWyj
         zlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8T7YwkTs9M4cO5m0wU814G2B4ziFXERq7fbbNe0Oaoo=;
        b=Xw9fNTGujRFt6L2T9ADlHAkU5FhhDAiFoUcBVwraw84VMecZYRMuR8PxXb4fmF7nzb
         VpFKWb/9ZX6t2z+370gdmxETam8Ahaq/jPhaCSPxNlLFY4+EnkLujC0u2/MlYe3VY15n
         WG/WXHYkzlYbJjae5wYj1g7V/OtZtvYaCJj8fzQtmPQldacvlybS1q2ILSFLu/tHs07O
         Oe4Ny27WRn4NavJPE2DptwQk09cUsCYxI5ggno3A46tD+XdhZpyNrHa9A7Tvhfb9NJ30
         OvjMrh3FZEx+o+yHyMp7HSCDX09IPlXiruv98VKJbesLRymx2k9WO0iIX0pBTIslVnnS
         qwtQ==
X-Gm-Message-State: AOAM531MNLBjOMJ0MnlvEQk5+ofE0ymlh5/7/z5E/Da+A6M9sgG3Azn8
        UDkrX7n5HVbYQXJeM+GuR04=
X-Google-Smtp-Source: ABdhPJwt04UpT11MoAnlS6d+XcIeM/lTIL8VUAhva3i5zHY74vPjYADcRsKBybdvreAKib8+2iAvtw==
X-Received: by 2002:a17:906:7313:: with SMTP id di19mr13355752ejc.160.1643533467438;
        Sun, 30 Jan 2022 01:04:27 -0800 (PST)
Received: from szeder.dev (94-21-37-89.pool.digikabel.hu. [94.21.37.89])
        by smtp.gmail.com with ESMTPSA id bu17sm11987211ejb.123.2022.01.30.01.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 01:04:27 -0800 (PST)
Date:   Sun, 30 Jan 2022 10:04:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Message-ID: <20220130090422.GA4769@szeder.dev>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 30, 2022 at 08:55:02AM +0100, René Scharfe wrote:
> Am 29.01.22 um 18:25 schrieb SZEDER Gábor:
> > On Sat, Dec 18, 2021 at 08:50:02PM +0100, René Scharfe wrote:
> >> compile_pcre2_pattern() currently uses the option PCRE2_UTF only for
> >> patterns with non-ASCII characters.  Patterns with ASCII wildcards can
> >> match non-ASCII strings, though.  Without that option PCRE2 mishandles
> >> UTF-8 input, though -- it matches parts of multi-byte characters.  Fix
> >> that by using PCRE2_UTF even for ASCII-only patterns.
> >>
> >> This is a remake of the reverted ae39ba431a (grep/pcre2: fix an edge
> >> case concerning ascii patterns and UTF-8 data, 2021-10-15).  The change
> >> to the condition and the test are simplified and more targeted.
> >>
> >> Original-patch-by: Hamza Mahfooz <someguy@effective-light.com>
> >> Signed-off-by: René Scharfe <l.s.r@web.de>
> >> ---
> >>  grep.c                          | 2 +-
> >>  t/t7812-grep-icase-non-ascii.sh | 6 ++++++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/grep.c b/grep.c
> >> index fe847a0111..5badb6d851 100644
> >> --- a/grep.c
> >> +++ b/grep.c
> >> @@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
> >>  		}
> >>  		options |= PCRE2_CASELESS;
> >>  	}
> >> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
> >> +	if (!opt->ignore_locale && is_utf8_locale() &&
> >>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> >>  		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> >>
> >
> > I tried to use 'git grep -P' for the first time ever, and it hung
> > right away, spinning all CPUs at 100%.  I could narrow it down, both
> > the complexity of the pattern and the size of the input, see the test
> > below, and it bisects to this patch.
> >
> >
> >   ---   >8   ---
> >
> > #!/bin/sh
> >
> > test_description='test'
> >
> > . ./test-lib.sh
> >
> > test_expect_success PCRE 'test' '
> > 	# LC_ALL=C works
> > 	LC_ALL=en_US.UTF-8 &&
> > 	cat >ascii <<-\EOF &&
> > 	foo
> > 	 bar
> > 	 baz
> > 	EOF
> > 	cat >utf8 <<-\EOF &&
> > 	foo
> > 	 bar
> > 	 báz
> > 	EOF
> > 	git add ascii utf8 &&
> >
> > 	# These all work as expected:
> > 	git grep --threads=1 -P " " ascii &&
> > 	git grep --threads=1 -P "^ " ascii &&
> > 	git grep --threads=1 -P "\s" ascii &&
> > 	git grep --threads=1 -P "^\s" ascii &&
> > 	git grep --threads=1 -P " " utf8 &&
> > 	git grep --threads=1 -P "^ " utf8 &&
> > 	git grep --threads=1 -P "\s" utf8 &&
> >
> > 	# This hangs (but it does work with basic and extended regexp):
> > 	git grep --threads=1 -P "^\s" utf8
> > '
> >
> > test_done
> 
> I get the following result and no hang with PCRE2 10.39:
> 
>    utf8: bar
>    utf8: báz
> 
> e0c6029 (Fix inifinite loop when a single byte newline is searched in
> JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part of
> version 10.36.

I saw this hang on two Ubuntu 20.04 based boxes, which predate that
fix you mention only by a month or two, and apparently the almost two
years since then was not enough for this fix to trickle down into
updated 20.04 pcre packages, because:

> Do you still get the error when you disable JIT, i.e. when you use the
> pattern "(*NO_JIT)^\s" instead?

No, with this pattern it works as expected.

So is there a more convenient way to disable PCRE JIT in Git?  FWIW,
(non-git) 'grep -P' works with the same patterns.

> René
> 
> 
> [1] https://github.com/PhilipHazel/pcre2/commit/e0c6029a62db9c2161941ecdf459205382d4d379

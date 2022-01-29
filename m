Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD2AC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 17:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbiA2RZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiA2RZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 12:25:47 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831CC061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:25:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id me13so27574314ejb.12
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ntQ6Fwm1VckK9fKzi+IPMYr140lEuWTq3hMuqjrFJEI=;
        b=Y6Hj/RP4tdcsn6LfrtxnNozQ+reVQ7ko3X71hp1DurJWFD4c1WxoR3V4dbLwpZ7vm6
         FoS5GaiLuF57WsyFhabxdCFe0vQuH2yEgW0btUE7hicJG+8sMjbtgNe6gWDJEhzooQVd
         yA9LcaSv7OcaW08BHjzm+GyMze49QDnZPX39vnJBwkgnEadF49PiewHjPQLScTij3bg6
         yog3F4197hjMMgPObHfeXGKLIf5ifkDr/ylTQq2KwmjMIns1HQjb648ZZEcpEgakRTgh
         GbKtlZtXPUr5+vO+AOR6us1667Z8kMXJKjM8hpHJfdn9slfBH23twbAJj3tR7WivtaLS
         CHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ntQ6Fwm1VckK9fKzi+IPMYr140lEuWTq3hMuqjrFJEI=;
        b=DujVV1+6u/21mY/tnZS9V2a7mMlcaGabPOnbWjXyRTsWbsXZvZNnSbjJHbN1qNtENF
         wEzNCe0KIe0cJHfKt6+LVSjKOJrPpqQT8UFgCSyxA5ggulM5JhteS02QDyR7/VL34bdg
         cKf64pYhc99onjBY57GQLnyXiuLbB/vx1Y1RvLk9wmsR8QCAcj+tQorC9vP49eDtVzZz
         L0bx0HNnvc2ySapJj1WoalklYQ541R4wf8F+MVIygEB4GKINbyXRIKY+Q9qqM72dFjuF
         Ox5KFg9eaxanJ8iSNEk/Yk7MIPivRuEPG6abz1DT4k6BTqB4fHOmwRMFGyHrpxibz+gR
         ahLA==
X-Gm-Message-State: AOAM533obKoAof3IPMGooNzbYHi0N+vLCuZyW8mYjpKbU9kjWxbprnWE
        z9Yl/v3/9NjyLYZI6zk9ci0=
X-Google-Smtp-Source: ABdhPJynTlmP0986j0LDEu5jF6VE5PzS8zkSalqrmgNjL3EeMkO73yP66aIZLdz1lvewhAeWCRBA1Q==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr11361320ejc.24.1643477145703;
        Sat, 29 Jan 2022 09:25:45 -0800 (PST)
Received: from szeder.dev (94-21-37-89.pool.digikabel.hu. [94.21.37.89])
        by smtp.gmail.com with ESMTPSA id c14sm14917835edy.66.2022.01.29.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:25:45 -0800 (PST)
Date:   Sat, 29 Jan 2022 18:25:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was: [PATCH
 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Message-ID: <20220129172542.GB2581@szeder.dev>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 18, 2021 at 08:50:02PM +0100, René Scharfe wrote:
> compile_pcre2_pattern() currently uses the option PCRE2_UTF only for
> patterns with non-ASCII characters.  Patterns with ASCII wildcards can
> match non-ASCII strings, though.  Without that option PCRE2 mishandles
> UTF-8 input, though -- it matches parts of multi-byte characters.  Fix
> that by using PCRE2_UTF even for ASCII-only patterns.
> 
> This is a remake of the reverted ae39ba431a (grep/pcre2: fix an edge
> case concerning ascii patterns and UTF-8 data, 2021-10-15).  The change
> to the condition and the test are simplified and more targeted.
> 
> Original-patch-by: Hamza Mahfooz <someguy@effective-light.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  grep.c                          | 2 +-
>  t/t7812-grep-icase-non-ascii.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/grep.c b/grep.c
> index fe847a0111..5badb6d851 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  		}
>  		options |= PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
> +	if (!opt->ignore_locale && is_utf8_locale() &&
>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>  		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> 

I tried to use 'git grep -P' for the first time ever, and it hung
right away, spinning all CPUs at 100%.  I could narrow it down, both
the complexity of the pattern and the size of the input, see the test
below, and it bisects to this patch.


  ---   >8   ---

#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success PCRE 'test' '
	# LC_ALL=C works
	LC_ALL=en_US.UTF-8 &&
	cat >ascii <<-\EOF &&
	foo
	 bar
	 baz
	EOF
	cat >utf8 <<-\EOF &&
	foo
	 bar
	 báz
	EOF
	git add ascii utf8 &&

	# These all work as expected:
	git grep --threads=1 -P " " ascii &&
	git grep --threads=1 -P "^ " ascii &&
	git grep --threads=1 -P "\s" ascii &&
	git grep --threads=1 -P "^\s" ascii &&
	git grep --threads=1 -P " " utf8 &&
	git grep --threads=1 -P "^ " utf8 &&
	git grep --threads=1 -P "\s" utf8 &&

	# This hangs (but it does work with basic and extended regexp):
	git grep --threads=1 -P "^\s" utf8
'

test_done

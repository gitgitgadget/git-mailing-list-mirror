Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF280C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC821BE5
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbhAXODe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:03:34 -0500
Received: from avasout04.plus.net ([212.159.14.19]:53674 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbhAXODd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 09:03:33 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2021 09:03:32 EST
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id 3fpklWe8GrXCc3fpllyt45; Sun, 24 Jan 2021 13:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1611496422; bh=7d33JZi/3hBl4faGwl05bj6EBEAo2JYGwfwn6epOkdU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MXA8mggoltxiFFWZe537sci24IH/QGwJHLAzjisZqBxf0vK28eX/LEFxiNe1X0kqX
         p1mNfOX0k4z+n0lBzTDgvNaNCQpFo8EPt109iLM70jjfehXM3/HTHjo5Ip7U/pm3V0
         Va4nrCHgK8s5hYpG0WTaolHujBdkfIn4Knph/6KSf+xHWbIu0bDBL7NBaTn03WU37u
         q4YCvb4lp3yRm7aLvULBm3x49gncESLuqkiTR1kavIFFlrfqXM0Ne/rH9iGUM7XtvL
         gC4oz3f8A2mIW3vMw1nQgAkp6endx/lXGB15nJt7k5NKzejq9vnXUtxT+iw8R06Qaf
         YGLedaE5Qx05A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=A1FWTvhxAAAA:8 a=Q8b9Qr7X27ls-alY698A:9
 a=QEXdDO2ut3YA:10 a=gWpziBj3J3xXidSoAfP2:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 2/2] grep/pcre2: better support invalid UTF-8 haystacks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <20210124021229.25987-1-avarab@gmail.com>
 <20210124114855.13036-3-avarab@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6fe69ede-d24b-1742-f699-c9af05560c0c@ramsayjones.plus.com>
Date:   Sun, 24 Jan 2021 13:53:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210124114855.13036-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCiq7RTIKLo9mV0YcBLfgf1QpVN++MhsDTMlbW/CxISoX23k37AUZ2+59QINw2jQzMQ/IrtKRQwghJT/uVYvyzpfc+r0yOORnTnpnWn0Db429QOb6jrP
 KUqgILkQBnBagg0Gqu6sWUxJGhjH0hA1DAJDLKs7Hyc83xw8ErxFLokq5VuL8l13atrGjMa2+41EXA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/2021 11:48, Ævar Arnfjörð Bjarmason wrote:
> Improve the support for invalid UTF-8 haystacks given a non-ASCII
> needle when using the PCREv2 backend.
> 
> This is a more complete fix for a bug I started to fix in
> 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
> 2019-07-26), now that PCREv2 has the PCRE2_MATCH_INVALID_UTF mode we
> can make use of it.
> 
> This fixes the sort of case described in 8a5999838e (grep: stess test
> PCRE v2 on invalid UTF-8 data, 2019-07-26), i.e.:
> 
>     - The subject string is non-ASCII (e.g. "ævar")
>     - We're under a is_utf8_locale(), e.g. "en_US.UTF-8", not "C"
>     - We are using --ignore-case, or we're a non-fixed pattern
> 
> If those conditions were satisfied and we matched found non-valid
> UTF-8 data PCREv2 might bark on it, in practice this only happened
> under the JIT backend (turned on by default on most platforms).
> 
> Ultimately this fixes a "regression" in b65abcafc7 ("grep: use PCRE v2
> for optimized fixed-string search", 2019-07-01), I'm putting that in
> scare-quotes because before then we wouldn't properly support these
> complex case-folding, locale etc. cases either, it just broke in
> different ways.
> 
> There was a bug related to this the PCRE2_NO_START_OPTIMIZE flag fixed
> in PCREv2 10.36. It can be worked around by setting the
> PCRE2_NO_START_OPTIMIZE flag. Let's do that in those cases, and add
> tests for the bug.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile                        |  1 +
>  grep.c                          |  8 +++++-
>  grep.h                          |  4 +++
>  t/helper/test-pcre2-config.c    | 12 +++++++++
>  t/helper/test-tool.c            |  1 +
>  t/helper/test-tool.h            |  1 +
>  t/t7812-grep-icase-non-ascii.sh | 46 ++++++++++++++++++++++++++++++++-
>  7 files changed, 71 insertions(+), 2 deletions(-)
>  create mode 100644 t/helper/test-pcre2-config.c
> 
> diff --git a/Makefile b/Makefile
> index 4edfda3e00..42a7ed96e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
>  TEST_BUILTINS_OBJS += test-parse-options.o
>  TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
> +TEST_BUILTINS_OBJS += test-pcre2-config.o
>  TEST_BUILTINS_OBJS += test-pkt-line.o
>  TEST_BUILTINS_OBJS += test-prio-queue.o
>  TEST_BUILTINS_OBJS += test-proc-receive.o
> diff --git a/grep.c b/grep.c
> index efeb6dc58d..e329f19877 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -492,7 +492,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  	}
>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> -		options |= PCRE2_UTF;
> +		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> +
> +	if (PCRE2_MATCH_INVALID_UTF &&
> +	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
> +	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
                                   ^^^^^^^^^^^^^^^^^^
I assume that this should be s/_MAJOR/_MINOR/. ;-)

> +		/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
> +		options |= PCRE2_NO_START_OPTIMIZE;
>  
>  	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
>  					 p->patternlen, options, &error, &erroffset,

ATB,
Ramsay Jones



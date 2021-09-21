Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A37C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1553610A0
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhIUMWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhIUMWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 08:22:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D1C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:20:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v24so73594378eda.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=syvl8rtBAzJdRE6zFw6ATExh7MfSWl3EPSEkNLHNPko=;
        b=T1L0eIG6gtwlgaMovmATZsjGMwi0MhFCuqC1pieDZzGvRA6wjtAvni+2dx2UZo8PEK
         jjbC5rwQ86kICsnqiFIva9MUUPBiMtjRBvbPmhNPBN6p79MBubuiakjZi4Wnz9heePWc
         HfMSXCdrx0URueXfd0wIlq3PtLvKjjiI4wiuRnqOfB7g/5nC5hjYojRQQZTu4GNno8B9
         kQ23LXQjXROaPFN5hH4tlZI27umdJDpHL1r7AN8YPa1HWYBTmxY5Yq8xEBkYQd+fDnsb
         /mCyjdRMVXZY++6o8iKPoj4oowj5lxtF/VMGXzOyUmoR7U1diq6ED9hcDcwlICqdPKuO
         VaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=syvl8rtBAzJdRE6zFw6ATExh7MfSWl3EPSEkNLHNPko=;
        b=XRpJuBK9dOHH9ZIfC+BKIOhZDkCP6EdyYlgJwCEk3I/5TMqHhOITrxLXQ04AxiX1P9
         TUVqFDMSWZsnCTjCiFMIihC9MgVEMMaQF7mA3Oz3xlVb+ajYShORYsvceXL9l+aSdF7K
         X5IcmCVwjNyz5QMquSOPTO0xd3Y2XyG2MoP6C+z3nmBwKiXhaS01Ih+d1KgLjZmuk3ao
         YlI/omDCQoZcVJCbCralTg+Zamp6at+soemaNllyxjQur3WODCHigVcSkWXHtJN68kD7
         vcP0Q3rSJCnFmSLTDKOX5Dm+16NUuo3vSPqNZrJm9Rrr/jYuZY2T8E5ES0evT7kgvEQr
         89eA==
X-Gm-Message-State: AOAM530JVnrZ0jVbMtatEes4q23O+RytUozlSYwkpHyRf4FRYPS8E2yN
        hneMR2bLa/mmT+oZr6/BL1PR/VCg0z/1QA==
X-Google-Smtp-Source: ABdhPJwHFCFBeEawkmJzsuCffMBU1h1URkcw523V24RjM5NLlR2Kw4nerPG2vzmFR0jzQGsweHSL5w==
X-Received: by 2002:a17:906:79d5:: with SMTP id m21mr30732938ejo.437.1632226844345;
        Tue, 21 Sep 2021 05:20:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u19sm7137955edr.15.2021.09.21.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 05:20:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 0/5] const-correctness in grep.c
Date:   Tue, 21 Sep 2021 14:07:08 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Message-ID: <87czp29l2c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Jeff King wrote:

> While discussing [1], I noticed that the grep code mostly takes
> non-const buffers, even though it is conceptually a read-only operation
> to search in them. The culprit is a handful of spots that temporarily
> tie off NUL-terminated strings by overwriting a byte of the buffer and
> then restoring it. But I think we no longer need to do so these days,
> now that we have a regexec_buf() that can take a ptr/size pair.
>
> The first three patches are a bit repetitive, but I broke them up
> individually because they're the high-risk part. I.e., if my assumptions
> about needing the NUL are wrong, it could introduce a bug. But based on
> my reading of the code, plus running the test suite with ASan/UBSan, I
> feel reasonably confident.
>
> The last two are the bigger cleanups, but should obviously avoid any
> behavior changes.
>
>   [1/5]: grep: stop modifying buffer in strip_timestamp
>   [2/5]: grep: stop modifying buffer in show_line()
>   [3/5]: grep: stop modifying buffer in grep_source_1()
>   [4/5]: grep: mark "haystack" buffers as const
>   [5/5]: grep: store grep_source buffer as const
>
>  grep.c | 87 +++++++++++++++++++++++++++++-----------------------------
>  grep.h |  4 +--
>  2 files changed, 45 insertions(+), 46 deletions(-)
>
> -Peff
>
> [1] https://lore.kernel.org/git/YUk3zwuse56v76ze@coredump.intra.peff.net/

This whole thing looks good to me. I only found a small whitespace nit
in one of the patches. Did you consider following-up by having this code
take const char*/const size_t pairs. E.g. starting with something like
the below.

When this API is called it's called like that, and the regex functions
at the bottom expect that, but we have all the bol/eol twiddling in the
middle, which is often confusing because some functions pass the
pointers along as-is, and some modify them. So not for now, but I think
rolling with what I started here below would make sense for this file
eventually:

diff --git a/grep.c b/grep.c
index 14fe8a0fd23..f55ec5c0e09 100644
--- a/grep.c
+++ b/grep.c
@@ -436,7 +436,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 }
 
-static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
+static int pcre2match(struct grep_pat *p, const char *line, const size_t len,
 		regmatch_t *match, int eflags)
 {
 	int ret, flags = 0;
@@ -448,11 +448,11 @@ static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
 
 	if (p->pcre2_jit_on)
 		ret = pcre2_jit_match(p->pcre2_pattern, (unsigned char *)line,
-				      eol - line, 0, flags, p->pcre2_match_data,
+				      len, 0, flags, p->pcre2_match_data,
 				      NULL);
 	else
 		ret = pcre2_match(p->pcre2_pattern, (unsigned char *)line,
-				  eol - line, 0, flags, p->pcre2_match_data,
+				  len, 0, flags, p->pcre2_match_data,
 				  NULL);
 
 	if (ret < 0 && ret != PCRE2_ERROR_NOMATCH) {
@@ -909,15 +909,15 @@ static void show_name(struct grep_opt *opt, const char *name)
 }
 
 static int patmatch(struct grep_pat *p,
-		    const char *line, const char *eol,
+		    const char *line, const size_t len,
 		    regmatch_t *match, int eflags)
 {
 	int hit;
 
 	if (p->pcre2_pattern)
-		hit = !pcre2match(p, line, eol, match, eflags);
+		hit = !pcre2match(p, line, len, match, eflags);
 	else
-		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
+		hit = !regexec_buf(&p->regexp, line, len, 1, match,
 				   eflags);
 
 	return hit;
@@ -976,7 +976,7 @@ static int match_one_pattern(struct grep_pat *p,
 	}
 
  again:
-	hit = patmatch(p, bol, eol, pmatch, eflags);
+	hit = patmatch(p, bol, eol - bol, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -1447,7 +1447,7 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		hit = patmatch(p, bol, bol + *left_p, &m, 0);
+		hit = patmatch(p, bol, *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)



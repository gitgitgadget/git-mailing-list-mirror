Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD392C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7070220753
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjnVAuMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCTBw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:52:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTBw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 21:52:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id x2so2411304pfn.9
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 18:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1jHXKRlKdC7IEwbsGFUUZQ5/PrDC4Hjcp/sdJir5PYc=;
        b=YjnVAuMJOU3eCz7FE1AiZtut6KhGnxc3kshUgT3kBohZ2uXNZqX79nWKiRFNjvwbkA
         dtQliECFMmmm1mV2GNzN6U0nqYnUx6C6UoN1t+ujnTvyFD5PJ18nrH5WSE0h1C8wYG0U
         zEQaadOS1XinGbD41NiEF2KYhUDq678bwvcTVwRkXlRI7uriekj9m5QfEJJHIq0hOWc5
         6lMCYIgaac0C81Ju3PvL2M2CskgpI58seEbcE7I1MlaBzSWHfGtaEMf9Vb2dwF0X/UYV
         AXKd89FvA+sNzDW98tpGJz8W9Qy240vLhMsmXNtwr/+0UXewbxOfohBdAYT4JlZig6Ql
         rMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1jHXKRlKdC7IEwbsGFUUZQ5/PrDC4Hjcp/sdJir5PYc=;
        b=PSVmvrP5NXKac9/DVIs6HixuXkNTVlWctzydmjEgPco5oWx43m50BBu5RvX2w/BnaT
         n9mCXD3K4US5lD/fMbrRbQq6YxIDOD3S36gLz/jULBr1H9nGAjz2/j4XaisJ/NsYEuea
         o/q4Y7B939y4sWEWrr64qzhf1IDU7OAaUWyCbr6BMaKiOibLPZkcpVEQv0rZ7OwrXyWh
         D9nkRGSe/834jPaQCcNmDI+eNEgqt9ctZNlsSSUKEM7KGLlAbpqZzOqFP5c1HDXe9ZSG
         jl9RFI7LOylrcjxoDsqO+4w8HoKlYpeIjLM9VsdI/WatIHmnfaoy2xU+rXZKJJTjfZP3
         v9Uw==
X-Gm-Message-State: ANhLgQ26ima4pnObKW1y4zv0cREb02Lr4ZgG5afaaIUXCKr+r7UyFr/U
        xRiJzl3LiR8wdhuXJDY4Cpw0VL46
X-Google-Smtp-Source: ADFU+vvX74IlgcFxe89ZhiLKSybaKzCDlQpsaN0/NMvqzPHSWww3vdKIvvxEQL6bo4n0PeokOu0tqg==
X-Received: by 2002:a62:7c8b:: with SMTP id x133mr6887344pfc.229.1584669146503;
        Thu, 19 Mar 2020 18:52:26 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id l6sm3433164pff.173.2020.03.19.18.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:52:25 -0700 (PDT)
Date:   Fri, 20 Mar 2020 08:52:23 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] t4124: fix test for non-compliance diff
Message-ID: <20200320015223.GG1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
 <20200319163334.GG3513282@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319163334.GG3513282@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 12:33:34-0400, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:07PM +0700, Đoàn Trần Công Danh wrote:
> 
> > POSIX's diff(1) requires output in normal diff format.
> > However, busybox's diff's output is written in unified format.
> 
> That's a pretty big difference. I'm surprised this only produces one
> problem in the test scripts. ;)
> 
> > POSIX requires no option for normal-diff format.
> > 
> > A hint in test-lib-functions::test_cmp said `diff -u` isn't available
> > everywhere.
> > 
> > Workaround this problem by assuming `diff(1)` output is unified
> > if we couldn't make anything from normal-diff format.
> 
> I wonder if we could use "git diff" here. We have to be careful about
> circular reasoning in our tests (i.e., making sure we're not verifying
> output with the same code that we're testing), but I think here we're
> checking how "apply --whitespace=fix" works.
> 
> But if this is the only spot, then adjusting to handle unified or normal
> diff isn't too bad.
> 
> > diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> > index 971a5a7512..2a54ce96b5 100755
> > --- a/t/t4124-apply-ws-rule.sh
> > +++ b/t/t4124-apply-ws-rule.sh
> > @@ -52,6 +52,12 @@ test_fix () {
> >  
> >  	# find touched lines
> >  	$DIFF file target | sed -n -e "s/^> //p" >fixed
> > +	if ! test -s fixed; then
> > +		$DIFF file target |
> > +		grep '^+' |
> > +		grep -v '^+++' |
> > +		sed -e "s/+//" >fixed
> > +	fi
> 
> I think those greps could be lumped into sed like:
> 
>   sed -ne "s/^+[^+]//p"
> 
> (at the cost of missing blank lines, but I think that's OK for our
> purposes here; it could be fixed with an ERE).
> 
> Could we then make a single invocation that covers both diff formats? We
> can further observe that the only thing we do with the "fixed" file is
> count the lines, so we can leave the markers. Which means we could ditch
> sed entirely and use grep. Something like:
> 
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 971a5a7512..15cb0c81b7 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -50,8 +50,9 @@ test_fix () {
>  	# fix should not barf
>  	apply_patch --whitespace=fix || return 1
>  
> -	# find touched lines
> -	$DIFF file target | sed -n -e "s/^> //p" >fixed
> +	# find touched lines; handle either normal or unified
> +	# diff, as system diff may generate either
> +	$DIFF file target | grep '^[>+][^+]' >fixed
>  
>  	# the changed lines are all expected to change
>  	fixed_cnt=$(wc -l <fixed)
> 
> seems to work for with both busybox diff and GNU diff.

3 lines after this one:

	?*) expect_cnt=$(grep "[$1]" <fixed | wc -l) ;;

As of now, we could simply replace sed with grep entirely,
because ! "$1" ~"[>+]".

Considering the complicated of:

	test_expect_success "rule=$rule" '
		git config core.whitespace "$rule" &&
		test_fix "$tt$ts$ti$th"
	'

I think it's better to use sed here.

-- 
Danh

Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C0C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A29520637
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUrNeAF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVIMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:12:17 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51613 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKVILM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 03:11:12 -0500
Received: by mail-wm1-f49.google.com with SMTP id g206so6168640wme.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 00:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUHf3HJxYfWJOqzbbBgb9dBffr2rzv3HY1LXTw19Hg8=;
        b=YUrNeAF7RRpcv6c8Lz4+gHrEqHmxXNXl0fPm+4YhnbrzZzVE1b594C2JABRrm8hovb
         CDvdMd6k5YsC2MYHwp9JiitGBcDRXDkuyznd5VBJQvTvzOkqQbk+RFoWaLOv/GAExQvu
         C20RCQLQGwKZEsOJRZjn8ly4IfDRf/Ec+02rhi2n7Eelga9b4ILtGqA2uyKYQMOthfWF
         w0bsHtY3U+B5xGCs0NvHeAnA0g8gkwzT6ED1pPzpSRdLGN7xK8ze8jFVlEAqVdq53o8T
         28fRI8QwjgWo/GTihDxnaJeLA6veYFVBZ4opGDRSeK65rigBZw+Pai1aNuElSCJK6EVF
         up2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUHf3HJxYfWJOqzbbBgb9dBffr2rzv3HY1LXTw19Hg8=;
        b=nZNzpYc6/h9Ye4TF3Y8MaOMjJmGBvkKZroUKA8kv9UwYFmwn6xgyyvkY+yxU4Urxdy
         B0PdNZ5ncniC0Emc1o5S6PKuHyVhuyXjjav8TXU1MKDENtpvursXpnM+kILP6wtPbVs8
         3BZ49aK3i7ldAkrd78fDYzp0eLBwf/8SG/2Ls1vR1sOMi7dlrJhWGDlp3TRBycKDqJLh
         SBXm1Rbr/MuCPZxJMLqCWfegPYkgSccKogUiMIKBAOT9ERLCSc6YNS0DWQObV8XapO7s
         uc5zwbb44f3Hhgv3VSMYd399NjDGLkTaz6vLlo2uimKhyBnXZl+Qu3mNz6kfqjUflxVI
         GXlA==
X-Gm-Message-State: APjAAAW/juFAfage8bwl6RjoI3b0D7n0JRStiaB+I/kaIHr4A1wosyKq
        nvVj2ncwf/FmhKlco7YZ7Yo=
X-Google-Smtp-Source: APXvYqzcAn0W1gOWLzQV4Sb4C/3+HCAnEyoix4/J0V4lBbHunrekM1GuMG7UPllJ+6zvq7pLYSpK3g==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr15865083wmi.113.1574410269399;
        Fri, 22 Nov 2019 00:11:09 -0800 (PST)
Received: from localhost ([46.69.175.162])
        by smtp.gmail.com with ESMTPSA id z11sm7534379wrg.0.2019.11.22.00.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 00:11:08 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:11:08 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf-lib: remove old result files before running tests
Message-ID: <20191122081108.GA38815@cat>
References: <20191119185047.8550-1-t.gummerer@gmail.com>
 <20191121102042.GA2611@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121102042.GA2611@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Jeff King wrote:
> But I wonder if it would be simpler to just always use the same file for
> the test result, overwriting it each time, and let the reader figure out
> the type. The aggregate script's get_times() already uses a regex to
> distinguish the two. That's enough for the two types we have, and we
> could later add a header line if it becomes necessary.
> 
> Something like the patch below. That removes any confusion about cruft
> files being left behind, or which file should be preferred, etc.

Yeah, I like what you have below much more than what I had, thanks!

> The diff would be even smaller if we just kept calling it "times", but
> that's probably unnecessarily confusing.

Yup, I prefer a more readable end result to a small diff :)

> -Peff
> 
> ---
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 66554d2161..112fc23dbe 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -219,13 +219,7 @@ sub print_default_results {
>  		for my $i (0..$#dirs) {
>  			my $d = $dirs[$i];
>  			my $base = "$resultsdir/$prefixes{$d}$t";
> -			$times{$prefixes{$d}.$t} = [];
> -			foreach my $type (qw(times size)) {
> -				if (-e "$base.$type") {
> -					$times{$prefixes{$d}.$t} = [get_times("$base.$type")];
> -					last;
> -				}
> -			}
> +			$times{$prefixes{$d}.$t} = [get_times("$base.result")];
>  			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
>  			my $w = length format_times($r,$u,$s,$firstr);
>  			$colwidth[$i] = $w if $w > $colwidth[$i];
> @@ -267,7 +261,7 @@ sub print_sorted_results {
>  		my ($prevr, $prevu, $prevs, $prevrev);
>  		for my $i (0..$#dirs) {
>  			my $d = $dirs[$i];
> -			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
> +			my ($r, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.result");
>  			if ($i > 0 and defined $r and defined $prevr and $prevr > 0) {
>  				my $percent = 100.0 * ($r - $prevr) / $prevr;
>  				push @evolutions, { "percent"  => $percent,
> @@ -327,7 +321,7 @@ sub print_codespeed_results {
>  			my $commitid = $prefixes{$d};
>  			$commitid =~ s/^build_//;
>  			$commitid =~ s/\.$//;
> -			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
> +			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.result");
>  
>  			my %vals = (
>  				"commitid" => $commitid,
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index b58a43ea43..13e389367a 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -214,7 +214,7 @@ test_perf_ () {
>  	else
>  		test_ok_ "$1"
>  	fi
> -	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
> +	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".result
>  }
>  
>  test_perf () {
> @@ -223,7 +223,7 @@ test_perf () {
>  
>  test_size_ () {
>  	say >&3 "running: $2"
> -	if test_eval_ "$2" 3>"$base".size; then
> +	if test_eval_ "$2" 3>"$base".result; then
>  		test_ok_ "$1"
>  	else
>  		test_failure_ "$@"

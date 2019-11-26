Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10392C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 07:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BD1206BF
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 07:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kHsHeFzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKZHLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:11:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42498 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZHLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 02:11:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so8688346pfh.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 23:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01XBZY9HpjKGpE3/gb+N5ev1nAIkYTuCr5UtIdMZh/k=;
        b=kHsHeFzBftTBnGE7liUg6Ri9wiyXxsMkMDc2GBI63SwhDUmvzXrMGSCWSqP2XpGt8w
         uuRGp1mNsacmH+SDWIo7Uwwny6+gEFmV1yFYXUUUFxiwP1WlSZLBzdukzbJJdzTjuBeS
         glm/XdQDoKT0K6QGOGc0PV3Atl9/R+v7UCmFX51mIvid7E5/C+dmNTqc5ULiFlHyMdyP
         BmZcJpNAG7okqNjHZPlncsGYSXS4cB2P85CvCLmNxVH6wegAXyL0r07z5jhWRT9+S28e
         9CKjk18ytXOleSOQAoYhlUsswExLENuc/4d7KmTmSlH0rUgIgHuG1v8VEfbuqx+Z0j74
         TTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01XBZY9HpjKGpE3/gb+N5ev1nAIkYTuCr5UtIdMZh/k=;
        b=U9UyJvZym6kERzu2mhweTMLW122QHjrBJ6hznN6a3aiijbF8VAXjhhvWCmcVOsukBd
         WC/Dx5+iAPKGuZNdd5IjmWvOPOwlG/8JN75TTvbCISmYbTq47owV91MIvCzwKF1N+nuF
         pEyLo0p4PBm1d7FxNvskW6CIYZlpw0hBbBwS267JYsR93kU/ha7jqUDKZ7RoqqyM8jrD
         69rqKHgNH1c9IK/mAb2BSLFHHwzx0mBcmle2kRelCzy+nfQhYk26ungj1zFXSWy1X5VN
         GcWRbtozquDKR7697uXmIiI+8nAUUiU/pTVM+UXk1OIHv50lwdXA+88deDDdLSQWCn6e
         9+ZQ==
X-Gm-Message-State: APjAAAWbcn096v+L2xW480SzSb1LfOE1cdZSbMtmCZlF/4EZ2xNNgawo
        5PS7oIAbsemUtITTpLHl8SZzNw==
X-Google-Smtp-Source: APXvYqzrnAWfAoH3V/9YI0iZWJlufICbNgp5ou4NeX/8pNYeQcil9CT0+q4n5cd3wMo3jKNu6dQ/9Q==
X-Received: by 2002:a63:d958:: with SMTP id e24mr21036051pgj.31.1574752270432;
        Mon, 25 Nov 2019 23:11:10 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:8032:bea0:f624:3251])
        by smtp.gmail.com with ESMTPSA id i70sm10853219pge.14.2019.11.25.23.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 23:11:09 -0800 (PST)
Date:   Mon, 25 Nov 2019 23:11:08 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/perf: don't depend on Git.pm
Message-ID: <20191126071108.GA75059@syl.local>
References: <20191125164720.GA18080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125164720.GA18080@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, Nov 25, 2019 at 11:47:20AM -0500, Jeff King wrote:
> The perf suite's aggregate.perl depends on Git.pm, which is a mild
> annoyance if you've built git with NO_PERL. It turns out that the only
> thing we use it for is a single call of the command_oneline() helper.
> We can just replace this with backticks or similar.

Hah, I think I walked right over this issue without even knowing that it
existed.

The backstory is that I was running the 't/perf' suite to test a merge
from upstream into GitHub's fork, which we build with 'NO_PERL'. This
*should* have failed, except for the fact that I had a leftover 'Git.pm'
laying around, which made everything go smoothly, even though I only got
lucky.

So, I think that this is a strict improvement for that case of "I want
to run t/perf" with "I built with 'NO_PERL' for xyz reason". Makes sense
to me (and thanks for addressing a problem that I didn't even know I had
;-).)

> Annoyingly, perl has no backtick equivalent that avoids a shell eval,
> which means our $arg would require quoting. This probably doesn't matter
> for our purposes, but it's better to be safe and model good style. So
> we'll just provide a short helper around open(), which takes its
> arguments as a list.

That seems reasonable, but I'm deferring entirely to your Perl
expertise here, since I'm not myself familiar.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/perf/aggregate.perl | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 66554d2161..a46ef67a2b 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -4,7 +4,6 @@
>  use strict;
>  use warnings;
>  use Getopt::Long;
> -use Git;
>  use Cwd qw(realpath);
>
>  sub get_times {
> @@ -85,6 +84,11 @@ sub format_size {
>  	return $out;
>  }
>
> +sub sane_backticks {
> +	open(my $fh, '-|', @_);
> +	return <$fh>;
> +}
> +
>  my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
>      $codespeed, $sortby, $subsection, $reponame);
>
> @@ -102,7 +106,8 @@ sub format_size {
>  	my $prefix = '';
>  	last if -f $arg or $arg eq "--";
>  	if (! -d $arg) {
> -		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
> +		my $rev = sane_backticks(qw(git rev-parse --verify), $arg);
> +		chomp $rev;
>  		$dir = "build/".$rev;
>  	} elsif ($arg eq '.') {
>  		$dir = '.';
> --
> 2.24.0.716.g722aff65ed

The rationale makes sense to me, so please have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

but do take it with a grain of salt, since your Perl skills are
certainly superior to mine.


Thanks,
Taylor

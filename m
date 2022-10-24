Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA4C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 09:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJXJ5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJXJ5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 05:57:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169F34A817
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 02:57:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so29146800edj.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWsbfxtslFQyVn7P0OFu2mktLvm7VuZ6bt2y3jRDCXM=;
        b=lgh63Zly7SPaauyD2WbZHy3/BkgZWCz72qO2LMB8q7bNOtrTVfbloijgqFY18tv9y8
         YMmAETl5ZzJK4DgFypBrrne2wtSkGospPo5y6KSk0E9ufuWumjKNjuPpwq/UDB1PF5b7
         n78Q14yoyZdfVf5X1oFDCqWoyA29g/a+T5Bpuxr8N3nSPmwuX7dyaLrSochhL205IAOM
         MibSLaM+uK878JNGm33uUAdrqW2i0WMwYgP6ZoFfiglLvIzxEEwcRYBboRMuI0UCJLhr
         hklZEMaXmC8yPIu4yioUKRHimdKm2wq5kj/ahRS4VcpwrxgPYtZXjYIDLqgkvZPu9P9S
         xl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWsbfxtslFQyVn7P0OFu2mktLvm7VuZ6bt2y3jRDCXM=;
        b=w7C9Z8q0sYbVEujJ9efgkuf0P1jWPyxu3GZILte7NNLmeNwYw22ANFVbu7+ajvrV3I
         0y3XPl5k0aeJhgDXLfTaFumF9z7TPzjsMiYJZIve8tk//G6MG2Kn51WClJ+HhgW+kJdR
         w4d6IflWjt/i2/hs0z+FxiyNbRJ+2V4MG0WsFG5NyWkg12yT+suPD56orortokW5qlQ0
         hdZqOxrfBQtJV+c4wbIRbBeqmXRWPumBqu3ustXZlKi12Kow5fxfjMpRzhbGA1JbQrnI
         7fBdW307hRceiQM3DxN+quHYlqdENGrvMA4sehyeV5MTfsA33HB7c66dhKPSeBPUJljh
         PpqA==
X-Gm-Message-State: ACrzQf05xrt7FUMJFtVzOyFirCBfdNFrN+u4r3xrMe3SG3kc8YzMmVM+
        oWRtHxJG2WXw3VUMK7znO2I=
X-Google-Smtp-Source: AMsMyM6Bn6QuWD3+t7v8fAMAFlD5/xL6L24PRl1WJRLqTJ/0F2KFZAeeJbGF+tiiENlrVHP1SiQhQg==
X-Received: by 2002:a17:907:2e0b:b0:7a7:d37e:4650 with SMTP id ig11-20020a1709072e0b00b007a7d37e4650mr3930483ejc.261.1666605424340;
        Mon, 24 Oct 2022 02:57:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b0078db18d7972sm15281569ejg.117.2022.10.24.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 02:57:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1omuCb-007ZgV-2U;
        Mon, 24 Oct 2022 11:57:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] chainlint: colorize problem annotations and test
 delimiters
Date:   Mon, 24 Oct 2022 11:57:00 +0200
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
Message-ID: <221024.86a65lee8i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 13 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> When `chainlint.pl` detects problems in a test definition, it emits the
> test definition with "?!FOO?!" annotations highlighting the problems it
> discovered. For instance, given this problematic test:
>
>     test_expect_success 'discombobulate frobnitz' '
>         git frob babble &&
>         (echo balderdash; echo gnabgib) >expect &&
>         for i in three two one
>         do
>             git nitfol $i
>         done >actual
>         test_cmp expect actual
>     '
>
> chainlint.pl will output:
>
>     # chainlint: t1234-confusing.sh
>     # chainlint: discombobulate frobnitz
>     git frob babble &&
>     (echo balderdash ; ?!AMP?! echo gnabgib) >expect &&
>     for i in three two one
>     do
>     git nitfol $i ?!LOOP?!
>     done >actual ?!AMP?!
>     test_cmp expect actual
>
> in which it may be difficult to spot the "?!FOO?!" annotations. The
> problem is compounded when multiple tests, possibly in multiple
> scripts, fail "linting", in which case it may be difficult to spot the
> "# chainlint:" lines which delimit one problematic test from another.
>
> To ameliorate this potential problem, colorize the "?!FOO?!" annotations
> in order to quickly draw the test author's attention to the problem
> spots, and colorize the "# chainlint:" lines to help the author identify
> the name of each script and each problematic test.
>
> Colorization is disabled automatically if output is not directed to a
> terminal or if NO_COLOR environment variable is set. The implementation
> is specific to Unix (it employs `tput` if available) but works equally
> well in the Git for Windows development environment which emulates Unix
> sufficiently.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>     chainlint: colorize problem annotations and test delimiters
>     
>     This is a re-roll of [1] which colorizes the output of "chainlint.pl"
>     when it detects problems in Git test definitions. During discussion, it
>     was noted that the eye could sometimes glide right over[2] the bold-red
>     "?!FOO?!" annotations, so Junio suggested using reverse video, which is
>     what v2 does.
>     
>     Reverse video certainly makes the "?!FOO?!" annotations pop out and draw
>     the reader's attention. I find that I don't have a strong preference
>     between this version and v1 which merely used bold-red, but I suspect
>     that v2 with its reverse video is probably the better approach.
>     
>     [1]
>     https://lore.kernel.org/git/pull.1324.git.git.1663023888412.gitgitgadget@gmail.com/
>     [2]
>     https://lore.kernel.org/git/CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com/
>     [3] https://lore.kernel.org/git/xmqqo7vkazuh.fsf@gitster.g/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1324%2Fsunshineco%2Fchainlintcolor-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1324/sunshineco/chainlintcolor-v2
> Pull-Request: https://github.com/git/git/pull/1324
>
> Range-diff vs v1:
>
>  1:  d670570e81f ! 1:  acf9183ccc6 chainlint: colorize problem annotations and test delimiters
>      @@ t/chainlint.pl: sub check_test {
>        	$checked =~ s/^\n//;
>        	$checked =~ s/^ //mg;
>        	$checked =~ s/ $//mg;
>      -+	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
>      ++	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
>        	$checked .= "\n" unless $checked =~ /\n$/;
>       -	push(@{$self->{output}}, "# chainlint: $title\n$checked");
>       +	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
>      @@ t/chainlint.pl: if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
>       +# thread and ignore %ENV changes in subthreads.
>       +$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
>       +
>      -+my @NOCOLORS = (bold => '', reset => '', blue => '', green => '', red => '');
>      ++my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
>       +my %COLORS = ();
>       +sub get_colors {
>       +	return \%COLORS if %COLORS;
>       +	if (exists($ENV{NO_COLOR}) ||
>       +	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
>       +	    system("tput bold >/dev/null 2>&1") != 0 ||
>      ++	    system("tput rev  >/dev/null 2>&1") != 0 ||
>       +	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
>       +		%COLORS = @NOCOLORS;
>       +		return \%COLORS;
>       +	}
>       +	%COLORS = (bold  => `tput bold`,
>      ++		   rev   => `tput rev`,
>       +		   reset => `tput sgr0`,
>       +		   blue  => `tput setaf 4`,
>       +		   green => `tput setaf 2`,
>
>
>  t/chainlint.pl | 46 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 386999ce65d..976db4b8a01 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -585,12 +585,14 @@ sub check_test {
>  	my $parser = TestParser->new(\$body);
>  	my @tokens = $parser->parse();
>  	return unless $emit_all || grep(/\?![^?]+\?!/, @tokens);
> +	my $c = main::fd_colors(1);
>  	my $checked = join(' ', @tokens);
>  	$checked =~ s/^\n//;
>  	$checked =~ s/^ //mg;
>  	$checked =~ s/ $//mg;
> +	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
>  	$checked .= "\n" unless $checked =~ /\n$/;
> -	push(@{$self->{output}}, "# chainlint: $title\n$checked");
> +	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
>  }
>  
>  sub parse_cmd {
> @@ -615,6 +617,41 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
>  	$interval = sub { return Time::HiRes::tv_interval(shift); };
>  }
>  
> +# Restore TERM if test framework set it to "dumb" so 'tput' will work; do this
> +# outside of get_colors() since under 'ithreads' all threads use %ENV of main
> +# thread and ignore %ENV changes in subthreads.
> +$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
> +
> +my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
> +my %COLORS = ();
> +sub get_colors {
> +	return \%COLORS if %COLORS;
> +	if (exists($ENV{NO_COLOR}) ||
> +	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
> +	    system("tput bold >/dev/null 2>&1") != 0 ||
> +	    system("tput rev  >/dev/null 2>&1") != 0 ||
> +	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
> +		%COLORS = @NOCOLORS;
> +		return \%COLORS;
> +	}
> +	%COLORS = (bold  => `tput bold`,
> +		   rev   => `tput rev`,
> +		   reset => `tput sgr0`,
> +		   blue  => `tput setaf 4`,
> +		   green => `tput setaf 2`,
> +		   red   => `tput setaf 1`);
> +	chomp(%COLORS);
> +	return \%COLORS;
> +}
> +
> +my %FD_COLORS = ();
> +sub fd_colors {
> +	my $fd = shift;
> +	return $FD_COLORS{$fd} if exists($FD_COLORS{$fd});
> +	$FD_COLORS{$fd} = -t $fd ? get_colors() : {@NOCOLORS};
> +	return $FD_COLORS{$fd};
> +}
> +
>  sub ncores {
>  	# Windows
>  	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
> @@ -630,6 +667,8 @@ sub show_stats {
>  	my $walltime = $interval->($start_time);
>  	my ($usertime) = times();
>  	my ($total_workers, $total_scripts, $total_tests, $total_errs) = (0, 0, 0, 0);
> +	my $c = fd_colors(2);
> +	print(STDERR $c->{green});
>  	for (@$stats) {
>  		my ($worker, $nscripts, $ntests, $nerrs) = @$_;
>  		print(STDERR "worker $worker: $nscripts scripts, $ntests tests, $nerrs errors\n");
> @@ -638,7 +677,7 @@ sub show_stats {
>  		$total_tests += $ntests;
>  		$total_errs += $nerrs;
>  	}
> -	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
> +	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)$c->{reset}\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
>  }
>  
>  sub check_script {
> @@ -656,8 +695,9 @@ sub check_script {
>  		my $parser = ScriptParser->new(\$s);
>  		1 while $parser->parse_cmd();
>  		if (@{$parser->{output}}) {
> +			my $c = fd_colors(1);
>  			my $s = join('', @{$parser->{output}});
> -			$emit->("# chainlint: $path\n" . $s);
> +			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
>  			$nerrs += () = $s =~ /\?![^?]+\?!/g;
>  		}
>  		$ntests += $parser->{ntests};
>
> base-commit: 76d57e004b0391503ca7719c932df2a0bd617d0a


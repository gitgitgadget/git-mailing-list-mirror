Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA9ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 12:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiIAMsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiIAMsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 08:48:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B6760E2
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 05:47:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy31so34043082ejc.6
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=D581l7UUt6eFrdoF4f38yhOjYFa8LBXo4SPqcx2o1+I=;
        b=FI+o6a62xZbxbkSFncVN7TjR1Cwdt4fIPxHhJZh2NPChPtpeSSAWyRSjM9b6Jbrhwj
         HJWQdVVb3S3f8myFzk7XGHrfuH9EJdN5uzC9ELARsgDCp2F7e/V2x1JcNhcQYi5yxYmD
         6lYxRMn5dtvY7xr2BUreXA85mDVT9yxk2SYai6Rr5Fz5mSCANUetf8ZW8kj1tvQdjBmD
         2eNc/Kjm3jvruUPATlHCD52ranvg97labDcRlqVnrZ/n6k5jkpatSlw7ZJaiypaU75q1
         XdRF82hYffr9ZA9ke9hZYXiGt8fE8wbkpDnl8tSIyeC7TJY6TdoKRD65Xl/E67YX1Jow
         xB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=D581l7UUt6eFrdoF4f38yhOjYFa8LBXo4SPqcx2o1+I=;
        b=p7OlEgYA3tAWpC6neCjD8vuPaLmtJ2EVYW8jUHQMvUjvxEUN5kmSAW8u/7BnW77ZrJ
         91a5+iTOh92htweuOzHlDrmjGb0myRAlvw3pK8og2rBWcgdViqCkk8vnoe6p5nq0vv4W
         6CDKboIHzPrP7NdhJZU3lN32ZaBHwXqox263MaBk8Cg3Xb1JoGDX+XK02HArWjlzMSD9
         VxkvYMXKBFEClRsPQ+Zikp3gTsKl9Gvi75AxkSuBHHgD7e8LP+mG+1e4xe6CISK/GaDk
         v+LyDUhjWrvUyuxyhyWkvgj4Sc4o+hCZT1YSPcoKQw/cO5w8b3JpLjf6e2x7TbN3+3jO
         WE+Q==
X-Gm-Message-State: ACgBeo34TN9xblyUx393wTN5dWWmE1/95mdJBXVqzw2eL3+S0wJKWVx1
        lled7CUX+h9/x55DQ9V6qRciCg+7PDIlPg==
X-Google-Smtp-Source: AA6agR6Z4NyOR+xRHSypPc3bNzzUGKqmFYgmfRFLWaFytSKf9MupdbA6vCWFA6V+GM1cfD+W+n6Z0Q==
X-Received: by 2002:a17:907:2ceb:b0:741:6115:a57 with SMTP id hz11-20020a1709072ceb00b0074161150a57mr15976995ejc.423.1662036474699;
        Thu, 01 Sep 2022 05:47:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906304d00b0073c8d4c9f38sm8575791ejd.177.2022.09.01.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:47:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTjbt-000AGm-1J;
        Thu, 01 Sep 2022 14:47:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Date:   Thu, 01 Sep 2022 14:36:57 +0200
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
Message-ID: <220901.86bkrzjm6e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Although chainlint.pl has undergone a good deal of optimization during
> its development -- increasing in speed significantly -- parsing and
> validating 1050+ scripts and 16500+ tests via Perl is not exactly
> instantaneous. However, perceived performance can be improved by taking
> advantage of the fact that there is no interdependence between test
> scripts or test definitions, thus parsing and validating can be done in
> parallel. The number of available cores is determined automatically but
> can be overridden via the --jobs option.

Per your CL:
=09
	=C3=86var offered some sensible comments[2,3] about optimizing the Makefil=
e rules
	related to chainlint, but those optimizations are not tackled here for a f=
ew
	reasons: (1) this series is already quite long, (2) I'd like to keep the
	series focused on its primary goal of installing a new and improved linter,
	(3) these patches do not make the Makefile situation any worse[4], and (4)
	those optimizations can easily be done atop this series[5].

I have been running with those t/Makefile changesg locally, but didn't
submit them. FWIW that's here:

	https://github.com/git/git/compare/master...avar:git:avar/t-Makefile-use-d=
ependency-graph-for-check-chainlint

Which I'm not entirely sure I'm happy about, and it's jeust about the
chainlint tests, but...

> +sub ncores {
> +	# Windows
> +	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
> +	# Linux / MSYS2 / Cygwin / WSL
> +	do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor\s*:/=
, <>)); } if -r '/proc/cpuinfo';
> +	# macOS & BSD
> +	return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
> +	return 1;
> +}
> +
>  sub show_stats {
>  	my ($start_time, $stats) =3D @_;
>  	my $walltime =3D $interval->($start_time);
> @@ -621,7 +633,9 @@ sub exit_code {
>  Getopt::Long::Configure(qw{bundling});
>  GetOptions(
>  	"emit-all!" =3D> \$emit_all,
> +	"jobs|j=3Di" =3D> \$jobs,
>  	"stats|show-stats!" =3D> \$show_stats) or die("option error\n");
> +$jobs =3D ncores() if $jobs < 1;
>=20=20
>  my $start_time =3D $getnow->();
>  my @stats;
> @@ -633,6 +647,40 @@ unless (@scripts) {
>  	exit;
>  }
>=20=20
> -push(@stats, check_script(1, sub { shift(@scripts); }, sub { print(@_); =
}));
> +unless ($Config{useithreads} && eval {
> +	require threads; threads->import();
> +	require Thread::Queue; Thread::Queue->import();
> +	1;
> +	}) {
> +	push(@stats, check_script(1, sub { shift(@scripts); }, sub { print(@_);=
 }));
> +	show_stats($start_time, \@stats) if $show_stats;
> +	exit(exit_code(\@stats));
> +}
> +
> +my $script_queue =3D Thread::Queue->new();
> +my $output_queue =3D Thread::Queue->new();
> +
> +sub next_script { return $script_queue->dequeue(); }
> +sub emit { $output_queue->enqueue(@_); }
> +
> +sub monitor {
> +	while (my $s =3D $output_queue->dequeue()) {
> +		print($s);
> +	}
> +}
> +
> +my $mon =3D threads->create({'context' =3D> 'void'}, \&monitor);
> +threads->create({'context' =3D> 'list'}, \&check_script, $_, \&next_scri=
pt, \&emit) for 1..$jobs;
> +
> +$script_queue->enqueue(@scripts);
> +$script_queue->end();
> +
> +for (threads->list()) {
> +	push(@stats, $_->join()) unless $_ =3D=3D $mon;
> +}
> +
> +$output_queue->end();
> +$mon->join();

Maybe I'm misunderstanding this whole thing, but this really seems like
the wrong direction in an otherwise fantastic direction of a series.

I.e. it's *great* that we can do chain-lint without needing to actually
execute the *.sh file, this series adds a lint parser that can parse
those *.sh "at rest".

But in your 16/18 you then do:
=09
	+if test "${GIT_TEST_CHAIN_LINT:-1}" !=3D 0
	+then
	+	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
	+		BUG "lint error (see '?!...!? annotations above)"
	+fi
=09
I may just be missing something here, but why not instead just borrow
what I did for "lint-docs" in 8650c6298c1 (doc lint: make "lint-docs"
non-.PHONY, 2021-10-15)?

I.e. if we can run against t0001-init.sh or whatever *once* to see if it
chain-lints OK then surely we could have a rule like:

	t0001-init.sh.chainlint-ok: t0001-init.sh
		perl chainlint.pl $< >$@

Then whenever you change t0001-init.sh we refresh that
t0001-init.sh.chainlint-ok, if the chainlint.pl exits non-zero we'll
fail to make it, and will unlink that t0001-init.sh.chainlint-ok.

That way you wouldn't need any parallelism in the Perl script, because
you'd have "make" take care of it, and the common case of re-testing
where the speed matters would be that we woudln't need to run this at
all, or would only re-run it for the test scripts that changed.

(Obviously a "real" implementation would want to create that ".ok" file
in t/.build/chainlint" or whatever)

A drawback is that you'd probably be slower on the initial run, as you'd
spwn N chainlint.pl. You could use $? instead of $< to get around that,
but that requires some re-structuring, and I've found it to generally
not be worth it.

It would also have the drawback that a:

	./t0001-init.sh

wouldn't run the chain-lint, but this would:

	make T=3Dt0001-init.sh

But if want the former to work we could carry some
"GIT_TEST_VIA_MAKEFILE" variable or whatever, and only run the
test-via-test-lib.sh if it isn't set.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388EC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2EA6500E
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhCLJVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhCLJVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:21:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B69C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:21:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id e19so52084764ejt.3
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZbgfLT6dhitd1y/QDI29pv5l+eS0lOj8pSxWr8ppUYA=;
        b=gC3RfexNESa4NWOhZtdkM+d+xBjLq0sTLiLRWcYIGedTegfOWKjaPK/nDJCbuG7tcH
         0nRzdDOfiJBJE6uaZzgPI45NtBXZx2iWx/t9BmK+N6EOz3rX+vCJ4YZnMwnmKWvTwq5t
         mqAR4LWl6/p5NF0KfB2pXJUlpY8sQeMUEjDCbFOqQ0hJIjfnDHX7o1CA2q/BalUBWX+b
         Q1uV1LVQG79QGD7ImZnJCc/D9+Y3m5SPBkd4B3FeOM8CYI8Dz1ZpWtLrNTunotp2qabL
         Zh1eNN4KHOZUVlbOFbrg6qNLqhcr7kIqrcdgXCynCgPhVCeRs3969Ysdo83Z/mttQEBz
         UYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZbgfLT6dhitd1y/QDI29pv5l+eS0lOj8pSxWr8ppUYA=;
        b=TCtlN70kdjROgNHpIay60+4pvvsW4LklY4RKhokHJTAcgZv1gktb2zbTWojMlFbDnT
         6lXRGXDP9YU3V5Vrztcjr8OhrBgobu/gp58FVwze6d7Gm0gyeWCISb9ZF6LR1472HIA0
         qZ8vBuASbCkET/kvmxG94tk62aevyIcP5+LmvL1feEgEZfS7DPp7agUCOwMLgRz5cP8T
         WrcUwW/+JYKDKKYdP4w6UIN6/kATOxESkAsyCaGDX1V3KPk2oFBi3vbwSNNfhLQSM+BB
         KhvcJj3B7N1HFxgsal9ADubhZCEcrjZQuViKYKaOBoc20VTFfMVY+cIlTRobMEMNXAQE
         3FOg==
X-Gm-Message-State: AOAM533XQrFHnDK+HUGj9h6OCikXW/ur8rMP3wXwAQpFvcUjCaS2vV+d
        LS9A0tByAHMn5lnGY57rBXwQisIQ17Tzug==
X-Google-Smtp-Source: ABdhPJx0B+BK1e6yubSkOvNa45Pf9MjHl6ZG+0Vk+u7rnAloRjH9IHKBPl3eQTt+vJ2BLmvBpqUo/g==
X-Received: by 2002:a17:906:a155:: with SMTP id bu21mr7532681ejb.400.1615540869519;
        Fri, 12 Mar 2021 01:21:09 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bi26sm2468824ejb.120.2021.03.12.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:21:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-36-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-36-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:21:08 +0100
Message-ID: <87y2esg22j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> By using the new 'git hook run' subcommand to run 'sendemail-validate',
> we can reduce the boilerplate needed to run this hook in perl. Using
> config-based hooks also allows us to run 'sendemail-validate' hooks that
> were configured globally when running 'git send-email' from outside of a
> Git directory, alongside other benefits like multihooks and
> parallelization.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  git-send-email.perl   | 21 ++++-----------------
>  t/t9001-send-email.sh | 11 +----------
>  2 files changed, 5 insertions(+), 27 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 1f425c0809..73e1e0b51a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1941,23 +1941,10 @@ sub unique_email_list {
>  sub validate_patch {
>  	my ($fn, $xfer_encoding) = @_;
>  
> -	if ($repo) {
> -		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
> -					    'sendemail-validate');
> -		my $hook_error;
> -		if (-x $validate_hook) {
> -			my $target = abs_path($fn);
> -			# The hook needs a correct cwd and GIT_DIR.
> -			my $cwd_save = cwd();
> -			chdir($repo->wc_path() or $repo->repo_path())
> -				or die("chdir: $!");
> -			local $ENV{"GIT_DIR"} = $repo->repo_path();
> -			$hook_error = "rejected by sendemail-validate hook"
> -				if system($validate_hook, $target);
> -			chdir($cwd_save) or die("chdir: $!");
> -		}
> -		return $hook_error if $hook_error;
> -	}
> +	my $target = abs_path($fn);
> +	return "rejected by sendemail-validate hook"
> +		if system(("git", "hook", "run", "sendemail-validate", "-a",
> +				$target));

I see it's just moving code around, but since we're touching this:

This conflates the hook exit code with a general failure to invoke it,
Perl's system().

Not a big deal in this case, but there's two other existing system()
invocations which use the right blurb for it:


	system('sh', '-c', $editor.' "$@"', $editor, $_);
	if (($? & 127) || ($? >> 8)) {
		die(__("the editor exited uncleanly, aborting everything"));
	}

Makes sense to do something similar here for consistency. See "perldoc
-f system" for an example.

>  
>  	# Any long lines will be automatically fixed if we use a suitable transfer
>  	# encoding.
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 4eee9c3dcb..456b471c5c 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2101,16 +2101,7 @@ test_expect_success $PREREQ 'invoke hook' '
>  	mkdir -p .git/hooks &&
>  
>  	write_script .git/hooks/sendemail-validate <<-\EOF &&
> -	# test that we have the correct environment variable, pwd, and
> -	# argument
> -	case "$GIT_DIR" in
> -	*.git)
> -		true
> -		;;
> -	*)
> -		false
> -		;;
> -	esac &&
> +	# test that we have the correct argument

This and getting rid of these Perl/Python/whatever special cases is very
nice.

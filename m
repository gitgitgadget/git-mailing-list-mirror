Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AE7C433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B648264F8F
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhCLX3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhCLX3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:29:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A326C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:29:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso11797800pjb.4
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fyxu6l2ZtaFNVbCrYKjPUHk05X6HngpfmTGVG5T8kn8=;
        b=RjYiX2BJQFfZsHvXUkLqydDtKadnJlu0fTIA+nZhSmRjvkX0rJDypFQTQ+e7q3M1Fi
         W4zp8OXbnlX4ioxnwf5QoBpTgzHltqu2EhWqpLjRzQWUeIsV+lKOGTycFaQCfLMmqWLc
         vusKK8R+VuguX+17RIdAhLEGqOIMd4qS8ErEHl3Y1/FpvUcUivMohh/PPMTzASqC+qKB
         b4CIS6Sh0t2jvUClUSuo6W7uUmRHscsAX/Y6BJDiYO0XLua9vrXJy3cROqcVWwF+8Nzr
         jycurmOUrjD5r4URks2fjYi7z5Niqko1y/j7g8PJ+NejhqOOHRg/P45eiHStEdsQqvyF
         kITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyxu6l2ZtaFNVbCrYKjPUHk05X6HngpfmTGVG5T8kn8=;
        b=KTqt16WjjGMXaIYGjYSMQIEXhWpa2wOy0XL7+sdf6u5s3B5+QE0pe7xs3Q7ySdxhVO
         LvhvQItvhjXBNOCE/47v5IC3w5GjaSlmUHQ5PqFaqBV9J5hs/5Tr2FOL5j5ovI3CKjyv
         ezy3L0DcjT45X/JoWX8ABD+HTK7C2KRVTLzGWYCG5dLETLkiD2Xa84LjhOvMHppkKItJ
         j+LT/mkjr3jC6PiIYgxKkRjoWGU+cZUPpDHrtZhLD3PVAajwbRB5g8BCcnydfsWojjJ6
         S67zs4E2v2tJx4kPBt9uSkq1MXmX/yUeUEG5sHoNs1cTNH/hGVSfmnMxUwMaEclnPTEi
         Z9zw==
X-Gm-Message-State: AOAM531ILOn/vCkDtFONeEurPdZmf1nfRyTYMq2f1PEcE3bQ54fbcIsq
        2DymC2LCIQAtFdTSH+8T4F3/YUp5nhsjpA==
X-Google-Smtp-Source: ABdhPJyJKad97lu8tjOnhbkp86zk2YZXNYZTrjNkDfrzj5dnR9pHVmn3ohQb7McX6elD+V+Rhyi+Mg==
X-Received: by 2002:a17:90b:e08:: with SMTP id ge8mr660074pjb.130.1615591762031;
        Fri, 12 Mar 2021 15:29:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:b463:c495:6445:6cb3])
        by smtp.gmail.com with ESMTPSA id z2sm6539283pfc.8.2021.03.12.15.29.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:29:21 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:29:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
Message-ID: <YEv5TJFjtbnP1gG7@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-36-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311021037.3001235-36-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 06:10:35PM -0800, Emily Shaffer wrote:
> 
> By using the new 'git hook run' subcommand to run 'sendemail-validate',
> we can reduce the boilerplate needed to run this hook in perl. Using
> config-based hooks also allows us to run 'sendemail-validate' hooks that
> were configured globally when running 'git send-email' from outside of a
> Git directory, alongside other benefits like multihooks and
> parallelization.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

Without having had time to look at reviews to this (or the rest of the
series) yet - it occurred to me that this hook should be run in series
instead. That is, I should invoke 'git hook run' with '-j1'.

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
>  	test -f 0001-add-main.patch &&
>  	grep "add main" "$1"
>  	EOF
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 

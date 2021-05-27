Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B4C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C94613D3
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhE0MDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhE0MDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 08:03:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4DC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:01:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j10so530175edw.8
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NOGbeQLPZkE1zH+BOnBBSbryUdmYsBDzPzdxHtRyGas=;
        b=OqVpyYK+Zojv4zhWGTGbY7SEU3p+DLWDH4AYRtyzgyyF8SpEptlXFo6pUeCOS/QpXa
         2hmGn7V6/SI8lQhjN85oJXS2kxZesbk1nmyTbA0fZA+j8qRdXW/cOoDFXSXJXmq8vzHD
         oNg2/+UEmsQUhYTAVQK/J/IxUShfk73JAMRlaij8Y9L0c/2A03yiydm/j6qi8Ib0xbim
         jVzeNhv4bfcTW7C2m4Bg2/yiU2g5EnvGp7LZKc1MkZ7xF/2P+SyjAEHrRgH7ohsOoFdK
         ngUruCYWMU7zGVqdbKW/WELsqsI6xuAOoRuNLAckkV7IVz9qvHvka7TFgV57H/i41ncc
         nU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NOGbeQLPZkE1zH+BOnBBSbryUdmYsBDzPzdxHtRyGas=;
        b=gELhxu4s6/UkHCYAaUdyW+Gjg0ytfo0gH0ydYqJ47pU+S3UyMh24woW3JSTcLYc9bu
         QnIaOwIZCw6uViop2+iZnzjt8gPjeHu1kbxaO69SwaEOdhrbVr3bBCDb98g+X2QV7wkK
         GNQzz6ZxZDTAQWiHRkEYTyCJ69ySTcvNt00XySu9qMPfWkyvI2zhQfSn38IjVeSBtf5b
         2n0jMFqhautu9bHGOQQRXp4gsdXV6osm9eKVxec5IV4RPwp6Pdzg9XuTF220zWn3ZS5d
         XoUpp9dtu1+PX5O1owtTj8J1QNs0B0md4kQ1gKuOgdneida7oEwhAIidi0Nxb6rORjEU
         Mrvg==
X-Gm-Message-State: AOAM533FQ8ozO/cqOIkvuN6NU8C1+GiQ7yB+1fMPePKANXJHHHSwoGwu
        Eg6fWUWKDVe7yqi2KT5kF8g4L1LYESadcg==
X-Google-Smtp-Source: ABdhPJwsD9ffbSU2vXZGSnDEwDkJUE+7NDe2TcUjr/V3YFOnx/3uM84ojbIVepjsSyPFZX+eP1z9Zw==
X-Received: by 2002:a05:6402:2786:: with SMTP id b6mr3857707ede.20.1622116909528;
        Thu, 27 May 2021 05:01:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l19sm1048879edv.17.2021.05.27.05.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:01:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 34/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
Date:   Thu, 27 May 2021 13:56:24 +0200
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-35-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-35-emilyshaffer@google.com>
Message-ID: <87wnrkl70z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> By using the new 'git hook run' subcommand to run 'sendemail-validate',
> we can reduce the boilerplate needed to run this hook in perl. Using
> config-based hooks also allows us to run 'sendemail-validate' hooks that
> were configured globally when running 'git send-email' from outside of a
> Git directory, alongside other benefits like multihooks and
> parallelization.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  git-send-email.perl   | 26 ++++++--------------------
>  t/t9001-send-email.sh | 13 +------------
>  2 files changed, 7 insertions(+), 32 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 170f42fe21..b55687453e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1958,26 +1958,12 @@ sub unique_email_list {
>  sub validate_patch {
>  	my ($fn, $xfer_encoding) = @_;
>  
> -	if ($repo) {
> -		my $validate_hook = catfile($repo->hooks_path(),
> -					    'sendemail-validate');
> -		my $hook_error;
> -		if (-x $validate_hook) {
> -			my $target = abs_path($fn);
> -			# The hook needs a correct cwd and GIT_DIR.
> -			my $cwd_save = cwd();
> -			chdir($repo->wc_path() or $repo->repo_path())
> -				or die("chdir: $!");
> -			local $ENV{"GIT_DIR"} = $repo->repo_path();
> -			$hook_error = system_or_msg([$validate_hook, $target]);
> -			chdir($cwd_save) or die("chdir: $!");
> -		}
> -		if ($hook_error) {
> -			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
> -				       "%s\n" .
> -				       "warning: no patches were sent\n"), $fn, $hook_error);
> -		}
> -	}
> +	my $target = abs_path($fn);
> +
> +	system_or_die(["git", "hook", "run", "sendemail-validate", "-j1", "-a", $target],

How do we get the "benefit[ ... of ...] parallelization" here if -j1 is
hardcoded as parameter. Shouldn't that be removed so it'll use the
hook.jobs config like everything else?

> +		sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
> +			   "warning: no patches were sent\n"),
> +		        $fn));
>  
>  	# Any long lines will be automatically fixed if we use a suitable transfer
>  	# encoding.
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index aa603cf4d0..bdf6472871 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -539,7 +539,6 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> @@ -557,7 +556,6 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual

Wouldn't it be better to keep the "died with exit code N" here. I.e. something like:

	fatal: longline.patch: rejected by sendemail-validate hook, 'git hook run' died with exit code %d

I.e. isn't that exit code carried forward by "git hook run"?

> @@ -2170,16 +2168,7 @@ test_expect_success $PREREQ 'invoke hook' '
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

We don't want to or need to check $GIT_DIR at all? Maybe not, but the
commit message doesn't say anything about it...

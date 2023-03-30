Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B582C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjC3O5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjC3O5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 10:57:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22BCDCF
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 07:57:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso22272550pjb.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680188230;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTqbvaK3Y4TQFFn4SByPhZJS9w1TKMPFR9N5MvLblj8=;
        b=gbJGrbMD8TSdCIGs80e7RZDEvaFRboMrzQudRbTbLyO1485oszDvWeHq2FIVmdV6KC
         H+Wd4f1dZHNPt10graIStX903v0PwQTgIVeMa4vCIlV/DxeDRLBLx+BzG9qnOmRN79jU
         x6JjxOgpj7F+NLLNcPVxt11J9p5FMJro2L1PClod83boEBNJfV18tpSl+FXlKcL9Bbbp
         +Z++0UhxnZTntqzsli0dgGi5LPWerQxqSrsokmyTpKiNujnxiknc7TnESLtAQLszym6v
         81qzLhbKT3RqO2zXN0dDNsMSeknydlgM33/Lnc3YRISZb1wS2JeXErzULzcHvxulZ+Cp
         qgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188230;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTqbvaK3Y4TQFFn4SByPhZJS9w1TKMPFR9N5MvLblj8=;
        b=RFZCmwJ8qxS1/3EdVTvgoayshKLBtWs3aQXKCzX1BZevIxS5pUJc0I2S2fk+iUzuf1
         xnOuDeK5On3Dz6VZJozJi+9dqaeqn9oaXkfpvJGNE+WwMlIipO9bG/YxA8J+C9B1Kcr8
         vNmNFMh72PP4ZWh+ilBAThKnW8t214lti6BrVGe181OZtt3iqeSebHzLtAS9vQioHVw2
         tU7Mp8x9avgvqyVaCk6+118s7PbuAAGOxmXIWRgvOULVVqiueTNIwAptg1+aR2h5UbWi
         Gpxqwj7LhiQSe8QQNsFfxr11gklFQHe5vhQs2EP0eLDaAA5IomD43NlpB5swl7cs/nLA
         9tsA==
X-Gm-Message-State: AAQBX9fAJ8AifTGN7g3uqMW1PjIv+OwCNOrbbs3724fiemjv0KKF5Uwd
        GbTgrIGu/+r2cLWD0+lL6ZIitDX6wWg=
X-Google-Smtp-Source: AKy350ZgPB5FhhqzOqhR4w9TofmFbSj+jneC1FXkM8hBmTCqjE/r1seVbm7h1eHpYHxQUz1fCVmbow==
X-Received: by 2002:a17:902:da8a:b0:1a2:8c7e:f31f with SMTP id j10-20020a170902da8a00b001a28c7ef31fmr2735403plx.11.1680188230349;
        Thu, 30 Mar 2023 07:57:10 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b001a1860da968sm24794207plo.178.2023.03.30.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:57:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH v3] describe: enable sparse index for describe
References: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
        <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
Date:   Thu, 30 Mar 2023 07:57:09 -0700
In-Reply-To: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
        (Raghul Nanth A. via GitGitGadget's message of "Thu, 30 Mar 2023
        05:59:16 +0000")
Message-ID: <xmqq1ql64796.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Raghul Nanth A <nanth.raghul@gmail.com>
>
> Add usage and performance tests for describe

I think this sentence can easily go.

> Describe uses the index when it is run with --dirty flag, which uses the
> run_diff_index commmand. The command is sparse-index aware and hence we
> can just set the requires-full-index to false

End the sentence with full-stop.  More importantly, it would be
nicer to have something to substantiate the "this is sparse aware"
claim here, something like "since commit X" or "as shown in the test
tXXXX.YY".

Updated tests do look good, and the code change is of course minimal
and to the point, which is also good.

Thanks.

> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a0..db7887470f9 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
>  	done &&
>  
>  	git sparse-checkout init --cone &&
> +	git tag -a v1.0 -m "Final" &&
>  	git sparse-checkout set $SPARSE_CONE &&
>  	git checkout -b wide $OLD_COMMIT &&
>  
> @@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git describe --dirty
> +test_perf_on_all 'echo >>new && git describe --dirty'
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e1..8bc35c51426 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1514,6 +1514,24 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	ensure_not_expanded stash pop
>  '
>  
> +test_expect_success 'sparse-index is not expanded: describe' '
> +	init_repos &&
> +	# Add tag to be read by describe
> +	git -C sparse-index tag -a v1.0 -m "Version 1" &&
> +	ensure_not_expanded describe --dirty &&
> +	cp sparse-index-out sparse-index-dirty &&
> +	ensure_not_expanded describe &&
> +	cp sparse-index-out sparse-index-normal &&
> +	# Check describe has same output on clean tree
> +	test_cmp sparse-index-dirty sparse-index-normal &&
> +	echo "test" >>sparse-index/g &&
> +	ensure_not_expanded describe --dirty &&
> +	echo "v1.0-dirty" > actual &&
> +	# Check describe on dirty work tree
> +	test_cmp sparse-index-out actual &&
> +	ensure_not_expanded describe
> +'
> +
>  test_expect_success 'sparse index is not expanded: diff' '
>  	init_repos &&
>  
>
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e

Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1915CC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 22:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B31206B7
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 22:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5IBJZob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLWWAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:00:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWWAa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 17:00:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so15044444qkk.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 14:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vtIE+LCH5ksLtkFYIB7XZ8doJHqfbrVJlqoJOHGwf5s=;
        b=Z5IBJZobWOWLqTaBj3kAdnbxY7Wu1R45laPuYZretdluOleRseYKFUja3RprLUeZvW
         OBxk4Mu/RZzcCX2p+7iNeZbxAb2CKFFiKE96MakiDGgsEMr8+Qt45CMU0OAaWTObiBFB
         wcDYudkh9KAB/AIusY9LUBKG5RGJfPJsGLEX4qjVfzLu2cmzg036vqGawgSHth9WKmgE
         0cO9qySc8fFujH2ItorqjgwlltwyBMSreQ5GOjKaStaI+7E6ES6WArCSo+UE03zqfPiF
         ou6aNnWnflAS6GByzgJrViea3ZKQmNyo5dBM2w8jEq8bLGWEbWq8cDTcOdcfyGicSSS3
         O1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vtIE+LCH5ksLtkFYIB7XZ8doJHqfbrVJlqoJOHGwf5s=;
        b=XaJcNDxEpVhM8ggONvqEOX56Z4s796GZumdwBH1eZJiZgFou5RDFQ6R6lcC7vIXAJK
         VebUxiTMWZBEG/zqb/EAJ3FDSBHPK1tnMeqAqZV4QnoaBluocah3jqZgcINBIHbfzgJv
         XSimVe+7DxzK0tH9j6fJz4TlQjJIsCuUGB+piaIrs/E7ybBQlfKoHQmnzVzCeRI0mwTl
         lxdQaGR/EJr0S6ahwsj/C3Ui70SpvKQAOUwO6WnpkB9wlMCPl94nKsD4glyCA4yXbnuC
         MXIgxydwYh/svk2m8vqGDBmpmOyJenjuT98hcfbtWYWDBXaok27XDR3s0q3XCJC2D7jw
         ecYA==
X-Gm-Message-State: APjAAAXNIblO4I797XxvZB1jn5fDjlevKsUC20FTppr0RJ9YlYQC6EZI
        JYH9EdAqgV8B2nfWu0RlACY=
X-Google-Smtp-Source: APXvYqxkCnXhUpdQ4yXZDlP+XWA5MsuiykCcmdU+RRHKuPAgmHvYZWADajQDoE6jWCGxscLfPINLFA==
X-Received: by 2002:a37:9402:: with SMTP id w2mr28381481qkd.310.1577138428827;
        Mon, 23 Dec 2019 14:00:28 -0800 (PST)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id r28sm6828413qtr.3.2019.12.23.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 14:00:28 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:00:24 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/15] contrib: change the prompt for
 interactive-based rebases
Message-ID: <20191223220024.GA2152949@generichostname>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <94b5a3051d743e8f54c21bc4cd0413f3c0dd05fa.1577127000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94b5a3051d743e8f54c21bc4cd0413f3c0dd05fa.1577127000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> Subject: contrib: change the prompt for interactive-based rebases

I'll also echo Gábor's comments and suggest that you use "git-prompt"
for the change area.

On Mon, Dec 23, 2019 at 06:49:55PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In the past, we had different prompts for different types of rebases:
>    REBASE: for am-based rebases
>    REBASE-m: for merge-based rebases
>    REBASE-i: for interactive-based rebases
> 
> It's not clear why this distinction was necessary or helpful; when the
> prompt was added in commit e75201963f67 ("Improve bash prompt to detect
> various states like an unfinished merge", 2007-09-30), it simply added
> these three different types.  Perhaps there was a useful purpose back
> then, but there have been some changes:
> 
>   * The merge backend was deleted after being implemented on top of the
>     interactive backend, causing the prompt for merge-based rebases to
>     change from REBASE-m to REBASE-i.
>   * The interactive backend is used for multiple different types of
>     non-interactive rebases, so the "-i" part of the prompt doesn't
>     really mean what it used to.
>   * Rebase backends have gained more abilities and have a great deal of
>     overlap, sometimes making it hard to distinguish them.
>   * Behavioral differences between the backends have also been ironed
>     out.
>   * We want to change the default backend from am to interactive, which
>     means people would get "REBASE-i" by default if we didn't change
>     the prompt, and only if they specified --am or --whitespace or -C
>     would they get the "REBASE" prompt.
>   * In the future, we plan to have "--whitespace", "-C", and even "--am"
>     run the interactive backend once it can handle everything the
>     am-backend can.
> 
> For all these reasons, make the prompt for any type of rebase just be
> "REBASE".
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 4 ++--
>  t/t9903-bash-prompt.sh           | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 1d510cd47b..8f8a22ba60 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -430,9 +430,9 @@ __git_ps1 ()
>  		__git_eread "$g/rebase-merge/msgnum" step
>  		__git_eread "$g/rebase-merge/end" total
>  		if [ -f "$g/rebase-merge/interactive" ]; then
> -			r="|REBASE-i"
> +			r="|REBASE"
>  		else
> -			r="|REBASE-m"
> +			r="|REBASE"

We should just drop the if here since both arms are the same..

Thanks,

Denton

>  		fi
>  	else
>  		if [ -d "$g/rebase-apply" ]; then
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 88bc733ad6..7ca35d358d 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -163,7 +163,7 @@ test_expect_success 'prompt - inside bare repository' '
>  '
>  
>  test_expect_success 'prompt - interactive rebase' '
> -	printf " (b1|REBASE-i 2/3)" >expected &&
> +	printf " (b1|REBASE 2/3)" >expected &&
>  	write_script fake_editor.sh <<-\EOF &&
>  		echo "exec echo" >"$1"
>  		echo "edit $(git log -1 --format="%h")" >>"$1"
> @@ -180,7 +180,7 @@ test_expect_success 'prompt - interactive rebase' '
>  '
>  
>  test_expect_success 'prompt - rebase merge' '
> -	printf " (b2|REBASE-i 1/3)" >expected &&
> +	printf " (b2|REBASE 1/3)" >expected &&
>  	git checkout b2 &&
>  	test_when_finished "git checkout master" &&
>  	test_must_fail git rebase --merge b1 b2 &&
> @@ -189,11 +189,11 @@ test_expect_success 'prompt - rebase merge' '
>  	test_cmp expected "$actual"
>  '
>  
> -test_expect_success 'prompt - rebase' '
> +test_expect_success 'prompt - rebase am' '
>  	printf " (b2|REBASE 1/3)" >expected &&
>  	git checkout b2 &&
>  	test_when_finished "git checkout master" &&
> -	test_must_fail git rebase b1 b2 &&
> +	test_must_fail git rebase --am b1 b2 &&
>  	test_when_finished "git rebase --abort" &&
>  	__git_ps1 >"$actual" &&
>  	test_cmp expected "$actual"
> -- 
> gitgitgadget
> 

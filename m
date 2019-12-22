Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA89C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 05:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10906206B7
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 05:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEtsUTXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfLVFLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 00:11:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39274 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfLVFLL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 00:11:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so5971334pjb.4
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 21:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZzJ3NRpa9F4mADyUneSAcGgm3qpeL2xG0JF7OpWigQM=;
        b=qEtsUTXD3gRuqQSGid8+Uk25/Pm/dI95NlH2CGgeeY1AfzN3BPZZmW92z1uO3RlUst
         Ftd6MrpxXDqF9pIL5tZx6eotVTsw4XyFBt6+nK5La65rt3/KD0OtKVEw2anWXpWSGJZh
         5i/JcwDwKFQIkx+xXLZXksNyHgbjipL5uf1wqM4JHY5Jr30YtUsKgvrOB/c8rPrOmz5r
         JjdJkXvzRwSSP5fxpAW6b/G61IozNRTUM13Qbyz3aWXbfbwhRhNZOmGyLfL/lvxN62Ld
         Ty24Z1+Uop9xVP+79DA0Ijm8P7ZxGqeJtIeLp68bxr8gvKx0yv8BHPT9N/lQPgjHm5C5
         04hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZzJ3NRpa9F4mADyUneSAcGgm3qpeL2xG0JF7OpWigQM=;
        b=GYL7+EU8msqU+vaRheBI91jscngGmIuk6xLCkrWiETgWiew48rbKBu1nOW3ShmqPHe
         tzJH+PQt/VFZKt5XHh/Oe7Kvuk2Dq2RiaK/XjmJ7p/oOte/sxYtk1j80WbQJnvyMHyyC
         bpP2PRLRY7yPoZ7exa2kHI1lasL48HA0Xgv5+IK55sszPrY5CbpNygwVTs434H+sia35
         avXFOXbMmS+MVJNwKp2n725RdE/6nQFGOjIHF1WDsSvZIMEVzc29HbG4+acYGA7rIOAy
         eYGBGv+IJfQszJ39pxjlHoYgcnG12OSNJUioBi4tmv5e6Gq0AsYTnNMLL986pu8MOb/Q
         Mpww==
X-Gm-Message-State: APjAAAXCfXq1PsW0OTxO6usqJnwbSJiPOGv2d3r4l2/NzmGTrhCC4vso
        bFx4zrfwNMKyWT2fWbPcyBs=
X-Google-Smtp-Source: APXvYqwUj1fvyXQZ+8R+ew2ISkh7SQLbrF38IlbbpMK7YpP42PdRtik0QRrIWBASoVH2ZdT0bPwPdQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr20704205plt.116.1576991470978;
        Sat, 21 Dec 2019 21:11:10 -0800 (PST)
Received: from generichostname ([172.58.27.61])
        by smtp.gmail.com with ESMTPSA id s24sm19664893pfd.161.2019.12.21.21.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 21:11:10 -0800 (PST)
Date:   Sat, 21 Dec 2019 21:11:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, gitster@pobox.com, plroskin@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 06/15] t3432: make these tests work with either am or
 merge backends
Message-ID: <20191222051106.GA28890@generichostname>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <9b1ad46c58b7f8397acbf2a8339e150dfb04c956.1576861788.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1ad46c58b7f8397acbf2a8339e150dfb04c956.1576861788.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, Dec 20, 2019 at 05:09:39PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
> index 92f95b57da..3879a43fa0 100755
> --- a/t/t3432-rebase-fast-forward.sh
> +++ b/t/t3432-rebase-fast-forward.sh
> @@ -44,19 +44,16 @@ test_rebase_same_head_ () {
>  	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
>  		oldhead=\$(git rev-parse HEAD) &&
>  		test_when_finished 'git reset --hard \$oldhead' &&
> +		cp .git/logs/HEAD expect &&
>  		git rebase$flag $* >stdout &&
>  		if test $what = work
>  		then
> -			# Must check this case first, for 'is up to
> -			# date, rebase forced[...]rewinding head' cases
> -			test_i18ngrep 'rewinding head' stdout
> +			wc -l .git/logs/HEAD >old &&
> +			wc -l .git/logs/HEAD >new &&

Are the above two lines some yet-to-be cleaned up leftovers? I can't see
where `old` and `new` are being used elsewhere.

> +			test_line_count '-gt' $(($old + 2)) .git/logs/HEAD
>  		elif test $what = noop
>  		then
> -			test_i18ngrep 'is up to date' stdout &&
> -			test_i18ngrep ! 'rebase forced' stdout
> -		elif test $what = noop-force
> -		then
> -			test_i18ngrep 'is up to date, rebase forced' stdout
> +			test_cmp expect .git/logs/HEAD
>  		fi &&
>  		newhead=\$(git rev-parse HEAD) &&
>  		if test $cmp = same

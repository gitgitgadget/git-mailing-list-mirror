Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1029BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiDAQ4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349793AbiDAQzx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:55:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D038EE
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:54:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so4263193pjb.4
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u0hjkaZ2LyucoludSGCxPwmJsVhzqO0Zo4Oj/k2gMxw=;
        b=mHQAnQpU0A+XyTwx4FtusbvWEufTR0+4zE1VIcBa9Q2ttpeJLtlL25aChcFZCQ/cHm
         DQ1qcllxZB8onodrVZiDnTVVaOKgEV18NRQIkfJOyE+ydlYyZz+jXiMq7Bv5lBBG4BF1
         NLsC/y4TReuTm4tWPJd7RI2awkCBf1yqyCGW+ombd5nALtOhYnMV8yBj7sKOK9+gXH4a
         yUZ3T3s3Trhu2oonfA+QzZLfGi5K53Drrea6RKTzwUuaqfBypf6IOfYlFaM3vCpfNM6/
         367pp05Il/gkQvohqe0YJr2ZTtHTwJoIRySD9rb0Dr/zNBQ5MTyVVRcW01zdiMfmL6tb
         oqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u0hjkaZ2LyucoludSGCxPwmJsVhzqO0Zo4Oj/k2gMxw=;
        b=a0RAVSRfkAZb55pf1M6VtEBTf68H6L1WgEKxmxsfIXUCbJKHern7CPMCLCncD75G+D
         4Ca4G/ztBYElVIKZHxiCyXRYYHX8qxG2IqeyBehoLAw1XBhn5M5/el1H+KiGoHGUUbX4
         6JKiPU0UCtq2R3SJZfQBjAkyANE97DI3PjNSA+aCLfAgoAl10ieWJwGKvMxM3O97HbRU
         NcO1aMH1cVM12nBaH7j+R2PRsSIv+WqgWhvaVR+QlGjWBID12UMx1fOaCuWPz72eJgxv
         41Farza5vKWTL1mCMcvThZZaJxWfBUOqof5xiKk+NVyDFPKIqKYyWJA6I9w5xU/JjXVM
         sifQ==
X-Gm-Message-State: AOAM533dsOWE7EjG5w4YfllF0RU37Y3yrSKI7Dqwqy09Tbm+FlFk/ldC
        pRLv6he9hA2EyJn8MFgZC6u8LYBButnOJA==
X-Google-Smtp-Source: ABdhPJze9jNzNi5sxfkhAm1fdZwwZ69EQHRWIs4BgCcGFizRDgyq5SJi5pR4fZWW9mVaYXxCiPsfbJKZXqhNvA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP
 id oo14-20020a17090b1c8e00b001bf364cdd7amr12610701pjb.103.1648832039786; Fri,
 01 Apr 2022 09:53:59 -0700 (PDT)
Date:   Fri, 01 Apr 2022 09:53:57 -0700
In-Reply-To: <pull.1183.v7.git.1648793113943.gitgitgadget@gmail.com>
Message-Id: <kl6lmth4sq1m.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> <pull.1183.v7.git.1648793113943.gitgitgadget@gmail.com>
Subject: Re: [PATCH v7] tracking branches: add advice to ambiguous refspec error
From:   Glen Choo <chooglen@google.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/branch.c b/branch.c
> index 6b31df539a5..182f1c5a556 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -18,17 +18,31 @@ struct tracking {
>  	int matches;
>  };
>  
> +struct find_tracked_branch_cb {
> +	struct tracking *tracking;
> +	struct string_list ambiguous_remotes;
> +};
> +
>  static int find_tracked_branch(struct remote *remote, void *priv)
>  {
> -	struct tracking *tracking = priv;
> +	struct find_tracked_branch_cb *ftb = priv;
> +	struct tracking *tracking = ftb->tracking;
>  
>  	if (!remote_find_tracking(remote, &tracking->spec)) {
> -		if (++tracking->matches == 1) {
> +		switch (++tracking->matches) {
> +		case 1:
>  			string_list_append(tracking->srcs, tracking->spec.src);
>  			tracking->remote = remote->name;
> -		} else {
> +			break;
> +		case 2:
> +			/* there are at least two remotes; backfill the first one */
> +			string_list_append(&ftb->ambiguous_remotes, tracking->remote);
> +			/* fall through */
> +		default:
> +			string_list_append(&ftb->ambiguous_remotes, remote->name);
>  			free(tracking->spec.src);
>  			string_list_clear(tracking->srcs, 0);
> +		break;
>  		}
>  		tracking->spec.src = NULL;
>  	}

Ah I see, on the first iteration, we set the first remote's name to
tracking->remote, and on the second iteration, we copy that value to the
list before copying the _current_ remote's name to the list.

> -test_expect_success 'avoid ambiguous track' '
> +test_expect_success 'avoid ambiguous track and advise' '
>  	git config branch.autosetupmerge true &&
>  	git config remote.ambi1.url lalala &&
>  	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
>  	git config remote.ambi2.url lilili &&
>  	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
> -	test_must_fail git branch all1 main &&
> +	cat <<-EOF >expected &&
> +	fatal: not tracking: ambiguous information for ref '\''refs/heads/main'\''
> +	hint: There are multiple remotes whose fetch refspecs map to the remote
> +	hint: tracking ref '\''refs/heads/main'\'':
> +	hint:   ambi1
> +	hint:   ambi2
> +	hint: ''
> +	hint: This is typically a configuration error.
> +	hint: ''
> +	hint: To support setting up tracking branches, ensure that
> +	hint: different remotes'\'' fetch refspecs map into different
> +	hint: tracking namespaces.
> +	EOF
> +	test_must_fail git branch all1 main 2>actual &&
> +	test_cmp expected actual &&
>  	test -z "$(git config branch.all1.merge)"
>  '

And this test shows that this indeed does what we think it does. Nicely
done.

I notice that we there is an instance of test -z "$(some git command)",
which IIRC is discouraged because it would mask a failure in the git
command, but that's not new and I don't think it needs to be fixed in
this series anyway.

Reviewed-by: Glen Choo <chooglen@google.com>

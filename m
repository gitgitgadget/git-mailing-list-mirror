Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D9C7EE2E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 01:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjB1BDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 20:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjB1BCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FEA2B624
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 17:02:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id cp12so3980170pfb.5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 17:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poM6L4bZcTyc31hQzs6SZkNul2F4ol6isN7OUSOvGls=;
        b=TjmfcSm+cbD6CiXMh4geg+DIbYjA9mM+mSwnD0GTI0JnHCBazkxIsxbjfRKjhkn6lu
         p2LQzWKgAJmgHirRll+5t/G3opWiwqk8A7ZGoHFTDhnumDLi7l5yrgJg5hoMvwjgtnbi
         54xh0nsa1CYiEkNdq8TeXNxYGg7Gp8M2zQQ2/1TLJHCFTYk/aBFE72e9ef58Vo1foc+X
         6fgZ9JaNg8UvpigA5WO0JbshjlH30Aa9tBoI+wVpwrK52cDiKuwBwGk4kVm5sQXRECua
         jWSDqcSaW4lXpF70wxSudBaTcSw4DOpxC8ITrS541pcC7vdD/quvztBOpmsdSbVS0Fro
         c3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=poM6L4bZcTyc31hQzs6SZkNul2F4ol6isN7OUSOvGls=;
        b=ly2tl4H1LAGTZvYIzeiv1Q8J4GV3/XWBwp+XLzcF5FFEipMZysLk15AvHcJjIgBvI1
         4G3CF7p91V3onA/UD3QiXx+ISoTxlUfMdVsO7WZ2aCJMd1+UFfk7veuFeVS3rK01XMZS
         wYIW79WIIURnOrcTpBeWWDgM9WtWDs+Lkk4YJ3rKKeyOCHX9fAJak0RpymWMSSOG4LSB
         7yFarRfWzAnAjFyasFQqyxLORNyTMXhsLJCeaYb6xZxmTNA6tKs1g6fzMIRVRd1oKrxC
         Hzgi6OuYP3zLSvX9xD9pb1xUCMdRjzzqcbU58aHMGHyR3bO1icj3CEYMyN2HNsLKyfZw
         wQew==
X-Gm-Message-State: AO0yUKUmAFdhUNU8g3Heewuns983LUcy+HPPDJvBkYXjBRxsgttJGVgq
        WDuUorcgGUbklpxcigbW8RU=
X-Google-Smtp-Source: AK7set82q/HgNuQIAyf9Q2lo6MgsJyMHBXjcvSWs8j0zXGMbD5lkL4xDuY8B548ljOLPRet+Q1486g==
X-Received: by 2002:a62:1dc6:0:b0:5e0:316a:39ce with SMTP id d189-20020a621dc6000000b005e0316a39cemr870826pfd.27.1677546144437;
        Mon, 27 Feb 2023 17:02:24 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j23-20020aa783d7000000b005ac86f7b87fsm4771466pfn.77.2023.02.27.17.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:02:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] restore: fault --staged --worktree with merge opts
References: <xmqq356xcn5z.fsf@gitster.g>
        <20230226184354.221-1-andy.koppe@gmail.com>
Date:   Mon, 27 Feb 2023 17:02:23 -0800
In-Reply-To: <20230226184354.221-1-andy.koppe@gmail.com> (Andy Koppe's message
        of "Sun, 26 Feb 2023 18:43:54 +0000")
Message-ID: <xmqqmt4yr49s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> +	/*
> +	 * Reject --staged option to the restore command when combined with
> +	 * merge-related options. Use the accept_ref flag to distinguish it
> +	 * from the checkout command, which does not accept --staged anyway.

Understandable.

> +	 * `restore --ours|--theirs --worktree --staged` could mean resolving
> +	 * conflicted paths to one side in both the worktree and the index,
> +	 * but does not currently.

Understandable, especially with an understanding that "does not
currently" hints our wish to eventually support it.

> +	 * `restore --merge|--conflict=<style>` already recreates conflicts
> +	 * in both the worktree and the index, so adding --staged would be
> +	 * meaningless.

And from the same line of reasoning, I do not know if this is a good
idea.  If "--merge|--conflict=<style>" should recreate conflicts in
both when given to "restore --staged --worktree", and if it does so
already, then shouldn't it be simply allowed?

Why would it be meaningless?

Now, it may be understandable to say that it is meaningless to ask
merge conflict recreated only in the working tree file but not in
the index, or done only in the index but not in the working tree,
and erroring out such a request might make sense, but even then, if
we do not plan to change the behaviour in the future when "restore
--staged --merge" without "--worktree" from what we currently do, I
am not sure if it makes sense to error out such a "meaningless"
request.

Or perhaps I misunderstood the conditional below?

> +	 */
> +	if (!opts->accept_ref && opts->checkout_index) {
> +		if (opts->writeout_stage)
> +			die(_("'%s' or '%s' cannot be used with %s"),
> +			    "--ours", "--theirs", "--staged");
>  
> -	if (opts->checkout_index && !opts->checkout_worktree &&
> -	    opts->merge)
> -		die(_("'%s' or '%s' cannot be used with %s"),
> -		    "--merge", "--conflict", "--staged");
> +		if (opts->merge)
> +			die(_("'%s' or '%s' cannot be used with %s"),
> +			    "--merge", "--conflict", "--staged");
> +	}

> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 7c43ddf1d9..c5d19dd973 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -137,4 +137,20 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
>  	test_must_fail git rev-parse HEAD:new1
>  '
>  
> +test_expect_success 'restore with merge options rejects --staged' '
> +	for opts in \
> +		"--staged --ours" \
> +		"--staged --theirs" \
> +		"--staged --merge" \
> +		"--staged --conflict=diff3" \
> +		"--staged --worktree --ours" \
> +		"--staged --worktree --theirs" \
> +		"--staged --worktree --merge" \
> +		"--staged --worktree --conflict=zdiff3"
> +	do
> +		test_must_fail git restore $opts . 2>err &&
> +		grep "cannot be used with --staged" err || return
> +	done
> +'

It is quite clear what cases are (and are not) being tested here
when written this way.

Thanks.

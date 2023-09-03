Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992ACA0FE9
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 18:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbjICSkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjICSkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 14:40:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999F106
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 11:40:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so7272055e9.3
        for <git@vger.kernel.org>; Sun, 03 Sep 2023 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766409; x=1694371209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3TnL0zveyI2VT8ubxCT4tv+u9K+dL1sS3elYm68LbWo=;
        b=jxKT9Cl3n1RrrjgQDj4xjST6oNppAhZsYmBY6ZWABYlgtoKmXUsD25wOHEYxfzZhI+
         MThf1+cULju1o60w24PecwQwzDyHHneRUx3Bas15+FSPXsmkn/B22kKA/1oyXyaKoafz
         SO/KA7VVT2jLs1BUKHe4SYM88Ae9dnrzQ6694ro/uSmQgmPpzoM17nRTVxR1lknXBzaB
         bNuijyzBnm016mwdZj1z0qnUO+t+wMKh5OYte5QoSVob6Ae1QkovUd+oCnJAw6l08nv5
         wQhSKSb8n9x41c5yZ7iceOIqU9lDBo6RKBw7wAxPJ1vVvQCNQJE6NyU0ffqevUuVhztd
         uNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766409; x=1694371209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TnL0zveyI2VT8ubxCT4tv+u9K+dL1sS3elYm68LbWo=;
        b=huoQJHGmzEwX5N8GpwE+yfEE6nIVHkYRDoyZ9pcs7Kw19MTVQcYIeD+opMThK6sOUi
         jHGJ9RnxjSgtaIvCWzeoGjbL0/x2E58cMp1VBPUoNHO0DWSqMwTAxfs+ofcvn0gz/ChR
         kpFP+zzl0/wtuq2JZ3MICIIaJlPmXgnqJVgeUS5DUekw6KE9C/wHJNHAbhhD6dfpWQ5X
         /vyRw8SumIu334+3UO9skiuSVXozpvWhYsvdnLM1gmBI6vtmIMuQsulyGgJg9C+S+WaD
         1VB1wzKoU3YQVZnDMBsgR/ldyAnKgZYGrAGLcUhm30uwN8tsgKDotqOYoX2ubXQwaDvW
         I0UA==
X-Gm-Message-State: AOJu0YzpLPuvYNVg72GM4IO9t8ASzlh+Rn2AHKTDPbVAA4Jtq1XVH3Ab
        cMd3fn6aY1CUEJz2PGWydlY=
X-Google-Smtp-Source: AGHT+IGmBgyLDEkwJvyMdmD/thIjQ7JoMYGGtTyVcgL2EiA7CKi9tZliAIUx0jmvVuLuS7qWUdSFLA==
X-Received: by 2002:a05:600c:2488:b0:3fc:3e1:7105 with SMTP id 8-20020a05600c248800b003fc03e17105mr5826652wms.24.1693766408868;
        Sun, 03 Sep 2023 11:40:08 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm12359936wrq.59.2023.09.03.11.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 11:40:08 -0700 (PDT)
Message-ID: <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com>
Date:   Sun, 3 Sep 2023 19:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 03/09/2023 16:11, Oswald Buddenhagen wrote:
> The only situation where the file's content matters is --continue'ing
> (after a multi-cherry-pick merge conflict).

I don't think "cherry-pick --continue" consults the abort safety file, 
it only matters for "cherry-pick --skip" and "cherry-pick --abort".

> This means that it is
> sufficient to write it in a single place, when we are prematurely
> exiting the main workhorse.

I think this introduces a regression because the safety file will not 
get updated when "cherry-pick --continue" stops for the user to resolve 
conflicts.

> This is much easier to reason about than the
> three dispersed calls originally introduced in 1e41229d ("sequencer:
> make sequencer abort safer", 2016-12-07). We now can also remove the
> inefficient file-based check whether the file needs writing, which
> wasn't even reliable: a single pick executed during an interrupted
> sequence would bypass the safety.

An alternate view is that the abort safety file exists to prevent the 
user losing commits that have not been cherry-picked and it is desirable 
to be able to abort after cherry-picking a single pick in the middle of 
a sequence of cherry-picks.

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> Cc: Stephan Beyer <s-beyer@gmx.net>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>   sequencer.c                     | 9 ++-------
>   t/t3510-cherry-pick-sequence.sh | 9 +++++++++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index a66dcf8ab2..716384cc7b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -575,10 +575,6 @@ static void update_abort_safety_file(void)
>   {
>   	struct object_id head;
>   
> -	/* Do nothing on a single-pick */
> -	if (!file_exists(git_path_seq_dir()))
> -		return;
> -
>   	if (!repo_get_oid(the_repository, "HEAD", &head))
>   		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
>   	else
> @@ -618,7 +614,6 @@ static int fast_forward_to(struct repository *r,
>   	strbuf_release(&sb);
>   	strbuf_release(&err);
>   	ref_transaction_free(transaction);
> -	update_abort_safety_file();
>   	return 0;
>   }
>   
> @@ -2435,7 +2430,6 @@ static int do_pick_commit(struct repository *r,
>   	free_message(commit, &msg);
>   	free(author);
>   	strbuf_release(&msgbuf);
> -	update_abort_safety_file();
>   
>   	return res;
>   }
> @@ -5269,8 +5263,9 @@ int sequencer_pick_revisions(struct repository *r,
>   		return -1;
>   	if (save_opts(opts))
>   		return -1;
> -	update_abort_safety_file();
>   	res = pick_commits(r, &todo_list, opts);
> +	if (todo_list.current < todo_list.nr)
> +		update_abort_safety_file();
>   	todo_list_release(&todo_list);
>   	return res;
>   }
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 3b0fa66c33..170b664c33 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -318,6 +318,15 @@ test_expect_success '--abort does not unsafely change HEAD' '
>   	test_cmp_rev base HEAD
>   '
>   
> +test_expect_success '--abort after single pick does not unsafely change HEAD' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick picked anotherpick &&
> +	git reset --hard &&
> +	git cherry-pick unrelatedpick &&
> +	git cherry-pick --abort 2>actual &&
> +	test_i18ngrep "You seem to have moved HEAD" actual
> +'
> +
>   test_expect_success 'cherry-pick --abort to cancel multiple revert' '
>   	pristine_detach anotherpick &&
>   	test_expect_code 1 git revert base..picked &&

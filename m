Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5921F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeILBqF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:46:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILBqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:46:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so27449204wre.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XHnGVCJca2P2IvkXVKpbAZ8RmByDlRDeBRGrw/WOHQU=;
        b=no0v1Xfb/UymS65xHDdqYI8sfxwkYzl4C2/OuVEiLm9YF/XgAqE1X3BTyru8syTxp3
         f5bqIBmmGFx6xAy7B2U6lqIdmmkkoUayC87V799ZR1pkcsyKka6GjA2Ck8s5aPEQt45J
         hC93rxebFjhsvLFo8ixEtp9mSqpZQ/5iYergHOMRi16ueRWVHkux/+SxvuUbuYYyS3zP
         VU+Le6hamv2b4pJU3o+UQn132h/ogUtsKRlKciQiWiZ6fT9QT2X0sHdzm/O+rxMDtpg4
         1OSc23wm3cqINGOre6jFnZrYdv5C5mglSrWUvoSfR0y78klQP1MQCSIu3adwZsrgUXiY
         wqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XHnGVCJca2P2IvkXVKpbAZ8RmByDlRDeBRGrw/WOHQU=;
        b=CCB4WIYsBebkXEVDW1AUVGlcIGNVq6s4YDvWrg1TbzvmVP7o+8xZQA6a/zLAFdi6f1
         2Lh6cETygQbLiJgdL9tsndysH0XQgUhO+2TKM/znYekZ9IxI/LfI2irxtj0PxWG5IpK5
         fzrRMweTSWAW9RrcCCtEUiraipEjlmEtf1M2A1dz5Qy8rmM3PH4Z2GaWApWOm/WXdfAb
         czKPRIrh3qnLvMZGQ+0Lwv4w46C7Ii7SfYtthGdibaAt08iipsttC93vNFyqlkfnxDAm
         YKo+36qx9Ju9/7X/rg52UjvLpsb0MxmRWaAVupQeZJffVXpjg9aW7f03YYfswwGf7qPY
         21+A==
X-Gm-Message-State: APzg51CsGIaAHh2ssBWYP9cd50ybk3rkQcimfHcbMf0OG1H+UIlNVxv0
        Z4s71OUn2arVdm2rBOeoznN7sCWM
X-Google-Smtp-Source: ANB0VdZhC73tqN48/BzJ/53kHRhY8yuGqVC8t3YKGehtdfKpY3fNvV+K8ZGjDEptyBjhEZ26W/Tvwg==
X-Received: by 2002:a5d:6243:: with SMTP id m3-v6mr20874612wrv.179.1536698701413;
        Tue, 11 Sep 2018 13:45:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z11-v6sm26209061wrm.94.2018.09.11.13.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:45:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2 2/2] rerere: avoid buffer overrun
References: <20180905175605.12341-1-newren@gmail.com>
        <20180911185546.10449-1-newren@gmail.com>
        <20180911185546.10449-3-newren@gmail.com>
Date:   Tue, 11 Sep 2018 13:45:00 -0700
In-Reply-To: <20180911185546.10449-3-newren@gmail.com> (Elijah Newren's
        message of "Tue, 11 Sep 2018 11:55:46 -0700")
Message-ID: <xmqqd0tjojar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> check_one_conflict() compares `i` to `active_nr` in two places to avoid
> buffer overruns, but left out an important third location.
>
> The code did used to have a check here comparing i to active_nr, back
> before commit fb70a06da2f1 ("rerere: fix an off-by-one non-bug",
> 2015-06-28), however the code at the time used an 'if' rather than a
> 'while' meaning back then that this loop could not have read past the
> end of the array, making the check unnecessary and it was removed.
> Unfortunately, in commit 5eda906b2873 ("rerere: handle conflicts with
> multiple stage #1 entries", 2015-07-24), the 'if' was changed to a
> 'while' and the check comparing i and active_nr was not re-instated,
> leading to this problem.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Thanks.  Looks good to me.

>  rerere.c          | 2 +-
>  t/t4200-rerere.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index c7787aa07f..783d4dae2a 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -533,7 +533,7 @@ static int check_one_conflict(int i, int *type)
>  	}
>  
>  	*type = PUNTED;
> -	while (ce_stage(active_cache[i]) == 1)
> +	while (i < active_nr && ce_stage(active_cache[i]) == 1)
>  		i++;
>  
>  	/* Only handle regular files with both stages #2 and #3 */
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index f9294b7677..313222d0d6 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -596,7 +596,7 @@ test_expect_success 'setup simple stage 1 handling' '
>  	)
>  '
>  
> -test_expect_failure 'test simple stage 1 handling' '
> +test_expect_success 'test simple stage 1 handling' '
>  	(
>  		cd stage_1_handling &&

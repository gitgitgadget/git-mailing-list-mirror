Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7636C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E6610A3
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 14:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhITOCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhITOCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 10:02:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC7C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:00:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y197so8554357iof.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qomtlYdvdNcgttT9jaaJqswPtfOSjxWVGjJOpbuQiRM=;
        b=MEYPInLs9Nq6rNL7rIlLAybHGxYPZlbZg58KzaHx2WE+UeFW/uRMTfaGzbiQ48uST3
         AJtVoiGki4zbrVWAZF+OansQJ1pULAb1EHODOD3aV0GvKOKbqSpWBA6iZMYjHr3FgRmk
         EiJnQBsVwNMWP72RhIV5tyj//C59gUcPKys06pufzZ1iaIX8RxPlyQaSL8y++gKERs5P
         9eXu6Fjav6s9GW8R08jbt42xDppZzGtEtBx903D/3okqRZljzQCGyNPvrfQSKlHUJdpE
         0+pw4nVM6M2gyIcCn/YajGu3V1FeRZ7yrgxoRsYUkg7qnLUVluS41u90Hxq12scJ582t
         CzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qomtlYdvdNcgttT9jaaJqswPtfOSjxWVGjJOpbuQiRM=;
        b=1wqjq9tpg2vhCU6mEr4Uw+lHoyR65fd6BwGBrtJaxwPixaprgcOUpe/fHHwej2iTGS
         jOldN1v69ADlmUhDsaeQ+retkEbw+9/a/448v6+G/zUnHGf40y0Y6Q4EyXGepR1s5fjC
         F7K1jhAxjbLbk67fgAz6mZUDXMGp2TL5prxQyEnzxkKr52SzmXJHs5ygpYy0ytsNbr8W
         L+3FePXlvr6t9LO/SL1qmOxrQcQf5leJqIu6LB4Rugd/y/Sk3ykwmQjsd3gkRbOT92b7
         L2aDtjOjAz0+BSASHbcsPCGF7J39KqGoD3TM4RKajaK/51clYP9TLw60qZWjR073da14
         WnmA==
X-Gm-Message-State: AOAM532srK35Ld0zAX+PWL8AzFNjN6h2MHQzEUoTgae8rw1O/JW0D5vp
        yuITdd+DbAp4pbBMx5Au3hXneXN1BUXhCw==
X-Google-Smtp-Source: ABdhPJylDyasTUunoTq95iVIh6p5zOWB7KecoacorDm6qCzXdYyNSuV/dWjUlWoERjunsHt4iH3rHw==
X-Received: by 2002:a5d:8d06:: with SMTP id p6mr18695251ioj.7.1632146453939;
        Mon, 20 Sep 2021 07:00:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id b3sm8857221ile.37.2021.09.20.07.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 07:00:53 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2021, #05; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlf3ug3q7.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <922bdab1-c521-84b5-51c1-a0413fd67394@gmail.com>
Date:   Mon, 20 Sep 2021 10:00:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqlf3ug3q7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/2021 7:52 PM, Junio C Hamano wrote:
...
> * ds/add-rm-with-sparse-index (2021-09-12) 14 commits
>  - advice: update message to suggest '--sparse'
>  - mv: refuse to move sparse paths
>  - rm: skip sparse paths with missing SKIP_WORKTREE
>  - rm: add --sparse option
>  - add: update --renormalize to skip sparse paths
>  - add: update --chmod to skip sparse paths
>  - add: implement the --sparse option
>  - add: skip tracked paths outside sparse-checkout cone
>  - add: fail when adding an untracked sparse file
>  - dir: fix pattern matching on dirs
>  - dir: select directories correctly
>  - dir: extract directory-matching logic
>  - t1092: behavior for adding sparse files
>  - t3705: test that 'sparse_entry' is unstaged
>  (this branch uses ds/mergies-with-sparse-index and ds/sparse-index-ignored-files.)
> 
>  "git add", "git mv", and "git rm" have been adjusted to avoid
>  updating paths outside of the sparse-checkout definition unless
>  the user specifies a "--sparse" option.
> 
>  Will merge to 'next'?

I plan to send one more version in response to Elijah's comments.
It should be ready later today.

Thanks,
-Stolee

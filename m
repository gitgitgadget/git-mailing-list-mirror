Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7291F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeGCV0r (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:26:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35158 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCV0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:26:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id v3-v6so49516wmh.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+1cGsOEhuOcGsD5W/9En9SjCeqy907sAvEVDa3tH0es=;
        b=JU0Wfo6H8AXYb91mymWTrXnNoUnyTGJwrhjOC9M6ZKKZYFEBiDiwYQSEl9eRpC/TJp
         ePs1vGAz5KCFF+nAIcvEqj+L2JmeZCW8h6duaOdyMQX4OUY67Al++SsFZjsoKufFDRIn
         LqdiicQys0DaSqPPAknAqv8RLXNNtsT2/uPwvWggdz0HNAu4PFzcR8ohA0ggmeE9tYRe
         AB1k89DfP0+UpU+aQLwAzb+qTQT+3ksMtys9852iPArbjOr6KI23DOQ2LNuw37eYnq6O
         zlVK+WShfGqMllxK3i+k/LnUyWenNakyXKXTcBuL9oGrgvEmx1b3wGb/VAYQF0Y+85L3
         95kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+1cGsOEhuOcGsD5W/9En9SjCeqy907sAvEVDa3tH0es=;
        b=LrjlGJSL4AAMfk5d/sc1cf2uzraXTIM4SPZArNgcMpTHtc3vsOJNJ89yXxQsktBTbg
         ExsiqUR5sBTSXRT3zL1E1AerCKjd+ZNeRq16XOZ2PeKduj35mDnihKbtk8qyEUiqPbar
         mRCH2WSSKTVa6C1pknmvIuSVJEN4twVdMXl2wUdrSWaEmKWhQyR+lIpvyAfI2LFZsN2t
         dU5PhR7PEe7Hb2i+uo45922nkVCb3uDnhM5oHi7CucBT5cyKozBqKdj28jnGpg/P8k9s
         jXfY5hsS0yxlSeh9qPkvaNv06YXVsebjlhUW8JgE1ZWZLnHoV1cIRa1J4MLjenWqqvl0
         MZSA==
X-Gm-Message-State: APt69E1Ty3OsjLa9o/75zC5DPaY9WACjmzFy7wRzADyDNhHaLEgshmFl
        W9Z1z7Exxb8sg4K2XsFDMOc=
X-Google-Smtp-Source: AAOMgpcHWyxQEBzUbCaeGtdseRGjJp6S2KElFekCDyUfk1pdOaDuxu4Q/vTUxj68hFRMXgSS3G0Phg==
X-Received: by 2002:a1c:7d58:: with SMTP id y85-v6mr11686252wmc.91.1530653205468;
        Tue, 03 Jul 2018 14:26:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u4-v6sm2658017wro.12.2018.07.03.14.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:26:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v2 3/4] sequencer: refactor the code to detach HEAD to checkout.c
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180702091509.15950-1-predatoramigo@gmail.com>
        <20180702091509.15950-4-predatoramigo@gmail.com>
Date:   Tue, 03 Jul 2018 14:26:44 -0700
In-Reply-To: <20180702091509.15950-4-predatoramigo@gmail.com> (Pratik Karki's
        message of "Mon, 2 Jul 2018 15:00:08 +0545")
Message-ID: <xmqqmuv8nh7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> The motivation behind this commit is to extract the core part of
> do_reset() from sequencer.c and move it to a new detach_head_to()
> function in checkout.c.
>
> Here the index only gets locked after performing the first part of
> `do_reset()` rather than before which essentially derives the `oid`
> from the specified label/name passed to the `do_reset()` function.
> It also fixes two bugs: there were two `return error()` statements in
> the `[new root]` case that would have failed to unlock the index.
>
> The new function will be used in the next commit by the builtin rebase,
> to perform the initial checkout.

I like the split of do_reset() into this "detach-to" part that is
less specific to replaying an existing commit and the rest, which
as you said incidentally corrects the locking issue.

It is not clear to me why checkout.[ch] is a better place to house
this function, though.

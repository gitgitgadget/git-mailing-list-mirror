Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23507C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0006D2075A
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly1E81lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404389AbgE1Paf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbgE1Pae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:30:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D8CC08C5C7
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:30:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c12so3397944qkk.13
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pfr8NgfQ3KnWWSEX8+aJrjdpDd8iIeLEE2sHclRmu+w=;
        b=ly1E81lX4nOrEGXItqBqWvX0jW0DDj+YCyiewPbtuXGNHiEcANNc1bYCGPmT8eTQ8w
         kx5kkqMlYx1fWX4Q0/5ZyUM9P/sVxy9RBcI/mKr1bf0XojGYSfFeG1mQtpZ51XRqWMVO
         OdgE8DkZevCwfq+mNBUweW5MB9HK6+SWlAauxy3zztwwCzNJ+a/wNV01sB3uNvg/mLiU
         bAUEUVHf5RRXJVyPqDRlYpirkGbhdSVLI8Bs95o+wR4uyVodMNkS6du+16Od7fzqlT4i
         avUph/8pz0ZmwUjj9DnnTnc+FqKFOGbAU/6gqYnRCPlRb9/E1a2nBR8qnuSyBZXmvu/o
         2gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pfr8NgfQ3KnWWSEX8+aJrjdpDd8iIeLEE2sHclRmu+w=;
        b=AdYtFkYCglVOTicil2eI36TRSwm+VOk4tN4fN4PpOhpnRfQuoD/MJV4WspJR30vQ35
         f6XjDXCsmRLRODzLR1fLWyeJIFzmzac8gllIbKAEmeKSj4tYRw2HdrsPT9DBX/S8ua0Q
         wNaYvFekOGHqcYHhVq05YzaXK6ZHo3FKjEHLhG8xP8JOwbdcjjPn3XcKOzY48Z0YvGGO
         fxEc+HglSG52mMN1wsasthu0zEs7imcK4tCGxFU810bgMLdO7FjJhHZ7cnp1TTwpNOoQ
         H9XnkzZRG5eTyl97V3MwEHFZbhLVutKpKaLW/ANqZdBfO7XpeMwRkUV+P3HY1Nmi8kcR
         5H2A==
X-Gm-Message-State: AOAM533l8m185Wwko9zZ5U4XFsmeHTClDeO/As82UorJdN9g8ZgVk5//
        l4XL+RtyBL2LyCIeat+Ydjw=
X-Google-Smtp-Source: ABdhPJyGuByV5HrjXbtnc8iTExKJYh/LRhPe+xD0NFURcQl0Ina3gHJE+uetzf9bzZNt92S76WkJBg==
X-Received: by 2002:a37:a056:: with SMTP id j83mr3634924qke.329.1590679833216;
        Thu, 28 May 2020 08:30:33 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b185sm5304473qkg.86.2020.05.28.08.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:30:32 -0700 (PDT)
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407014829.GL6369@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
 <20200408000149.GN6369@camp.crustytoothpaste.net>
 <20200527223907.GB65111@google.com> <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
 <20200528145018.GA58643@google.com> <xmqqwo4w3y4s.fsf@gitster.c.googlers.com>
 <20200528150340.GB58643@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <980f76bc-c28e-42cd-a85e-acb70861c9a7@gmail.com>
Date:   Thu, 28 May 2020 11:30:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200528150340.GB58643@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2020 11:03 AM, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>>                              The real question is, do we consider the
>>> existing "git gc" infrastructure such a lost cause that we should
>>> touch it as little as possible?
>>
>> I am fine with that, as long as the "new" thing will take over what
>> "git gc" currently does.
> 
> Good reminder, thank you.
> 
> Yes, as long as we end up replacing the old thing, making a parallel
> new thing (e.g. with a config option for switching between during a
> transition period) can be a fine approach.

Thanks for the discussion, everyone. I'm sorry that I'm very late in
providing a new RFC that takes this approach, but yes I intend to create
the "single entry point" for maintenance activities, and incorporate
auto-GC as a default option there.

Something that is a good long-term goal is to have the new maintenance
entry point replace the "git gc --auto" calls, so we have better
customization of post-command "automatic" maintenance. This can be done
without any of the "background" part of my original RFC.

I've just been to busy with other tasks to devote the deep focus that
this feature deserves. Thanks for your patience.

-Stolee

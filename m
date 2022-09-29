Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4DC4332F
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiI2UwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiI2UwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 16:52:22 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A2A177377
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 13:52:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 203so3000377ybc.10
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fBblR2NuvxYP786tnkxG4oDd0YissiE4uXMobDEVOy0=;
        b=ZW1JhzMA2ssHC0PlobYQJdFEZbOVGwqIUX6oSO0jMD/lDRoJSeASlFtkQYOmmSlouZ
         Vz5PWX3mYcvayUwbp42uav81p+MbNQZkL6ru+SG5haFwg6Fjftg02dQ/xJGNTN5knaoO
         OsFaGKwfqvLdBTsAE8T3UzFs/lSzwGpvpYU0q/hTYhKeF60/c+2ffkeczyPi/ioCavYw
         hvDgCL/OE3ZnAQNFai2trhHUi1Xn/BZo8qlSesA23BK8eexKqnomzajcOX9UBnlyfGSz
         k4vdjHAnywA7QRV40HedfxMs2xew1O3bPkEfHsu78a/78guPLmoikRXNqGO4XeXuB2r9
         /51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fBblR2NuvxYP786tnkxG4oDd0YissiE4uXMobDEVOy0=;
        b=VBqr07i5G+J7R6XPUqhHIt3mAHTZ0iUivS7T2BP8ncL63e37Py38IAaiXIk2OXXJub
         gruKxAMceBus7wlcw3y8Qez1GeQYSdqGxSn23JkXpAq4j3VfGi3r0ltG3a4Kj4W06JVJ
         sz7YQUKTONT9xuMkgtG8ZBmyqBuO0j3virvXEd24+DbWBUlCyp4VVPZ0YEp22gwcT9jA
         AeWoj2QXt2EwasPG8qPGxO+OOipp7ZFAU/SH7cWOc+999L0czMn85wufOlRiVPWUunJL
         CR4VwgOnnwZ3A88n6acOd7KhnhqyFmVUQ2kFvr4Jt+/1jZdeJdRnSDQ+1DyEaU9foHtX
         wzJg==
X-Gm-Message-State: ACrzQf0v+wI/pqCgPzmUqbtFUtKy63gx23g/r8LcYwtunWonJb58k8Ik
        mCS9XKmn/kYUPT8wfHNqeJTdqOjMRs6dOhx7izanDH5eKbo=
X-Google-Smtp-Source: AMsMyM6c3paDWKou1rP8uK9ssjWpAZFIt/j52Kk6oS/oXNI+CXU95xPYfIpMq/ZIaTU/c3eImKrvQkHMkiumHJNExuQ=
X-Received: by 2002:a25:a42a:0:b0:6a9:82d4:147 with SMTP id
 f39-20020a25a42a000000b006a982d40147mr5364055ybi.417.1664484740575; Thu, 29
 Sep 2022 13:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g> <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
 <220927.86ill9yymv.gmgdl@evledraar.gmail.com> <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
 <220927.86fsgcy5j9.gmgdl@evledraar.gmail.com> <CAFySSZB3hp2WWk0bL77FBR91ueJ1eJFtuVCoyE-ooVT77Vo_vw@mail.gmail.com>
 <220928.86bkr0xd9w.gmgdl@evledraar.gmail.com>
In-Reply-To: <220928.86bkr0xd9w.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 29 Sep 2022 13:52:09 -0700
Message-ID: <CAFySSZDF_nxGJCjhi38nb5R3jtPBVqZbMCqKxmTagUqCbwx7rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You mean the internal "struct parallel_processes"? How do you get the
> parameter there, presumably by passing it to
> run_processes_parallel{,_tr2}() as a new parameter?

Yea I added it as a new parameter...

> The reason for why the "ungroup" wasn't added as a parameter at the time
> was to avoid the churn of changing every single caller of the API.
>
> But it should really be a "parameter", and doing it via a struct means
> adding such parameters doesn't need to change every single caller.
>
> Then we have outstanding WIP patches for the hook.[ch] API which needed
> to add two other parameters...
>
> So I think first ripping off the band-aid of making it painless to
> extend the interface is the right thing to do, unless I've missed some
> way of doing it that you've just discovered...

In that case my patch does depend on yours for resubmission, so
it sounds like if I want to quickly resubmit then I should cherry-pick
the relevant commits from your WIP branch.

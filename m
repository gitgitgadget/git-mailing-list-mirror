Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C8C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CA1206DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 00:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqPt7Qnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgE1AsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 20:48:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63459 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgE1AsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 20:48:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6905C6726;
        Wed, 27 May 2020 20:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IPZ2GOs9HRSYVOd7ryFAOZp9fWQ=; b=vqPt7Q
        nlK/z5z+bx2HhOlpobIk7xQkQ15Iab6w5YxcXKdEC+OfxMTl4ocgEO59QtxBTvv4
        mM2CuciKuBH8UlMtyORt8Ws6VRy43pX0OdUeg0RWQj+To3uTX5W3468NPi6lVw9n
        IFZgFR0JFnZkOkn05Bc3SGkoiylC2D688qtCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DysuI0YMGnWoFSAI+RMvDI7ATWtBmwDd
        sLwx+n7fHfHPWkTaITZUbmve3tuh4H9DGxvxheCmCXiRojcJTgl7Of3XxtRu1Jlu
        SmhzJi8g0NeWsSSy5NxKZSEo9/HjtNNGwbw24/lPa2t+LYsZ9N/uIwj93Xr4Ldvk
        9ljb5IefMMg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEE02C6725;
        Wed, 27 May 2020 20:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5D03C6724;
        Wed, 27 May 2020 20:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
        <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
        <20200407014829.GL6369@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
        <20200408000149.GN6369@camp.crustytoothpaste.net>
        <20200527223907.GB65111@google.com>
Date:   Wed, 27 May 2020 17:47:55 -0700
In-Reply-To: <20200527223907.GB65111@google.com> (Josh Steadmon's message of
        "Wed, 27 May 2020 15:39:07 -0700")
Message-ID: <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF0FB0B6-A07C-11EA-93C4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Regardless of what happens with the job-runner, I would like to see a
> top-level command that performs a single iteration of all the
> recommended maintenance steps, with zero configuration required, on a
> single repo. This gives an entry point for users who want to manage
> their own maintenance schedule without running a background process.
> ...
>> Unix users will be unhappy with us if we use our own scheduling system
>> when cron is available.  They will expect us to reimplement those
>> features and they will complain if we do not.  While I cannot name
>> names, there are a nontrivial number of large, enterprise monorepos that
>> run only on macOS and Linux.
>
> Speaking purely as a user, I agree with this point. This is why I want a
> single-iteration top-level maintenance command.

Yes, well said.  

It exactly is what "git gc" was meant to be.  To put it differently,
if you asked any non-novice end-user if there is one single command
that s/he would use to keep a repository healthy, it is very likely
that the answer would be "git gc".

And having such a single point of entry would be a good thing.

Thanks.



Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573EC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E256C22314
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H9ouX+vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgJSRXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:23:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgJSRXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:23:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDD8EEF480;
        Mon, 19 Oct 2020 13:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ro/hv+Z2bzFYFouKkdIHZT9XdN8=; b=H9ouX+
        vlozdTGGwBVK4jNSfSaPBfHnxw+MpqaMLslzmMx6VjWAo7ZJZU9VHpV6d3GXTfTI
        6l3uuIO0iunsxOuZYExPo3dz3NOJz2OmTPAXLcn00Oq+Ilo5vQgsMmxSMKWz2G4m
        R5POR/WuiU4gRGEpFa76YfsWiJjYdFzMiPVvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kKyr8h6IBVUuCAah4xvMUWCSEQLvvkeg
        IwLfamWzlW72zkOYch/90A0caY3ZeGvpyKJoAA0TeY3fu4cpFJz/SxYVg+Yj6V6d
        0WGYM8g3AI0CUYiqfIuUc4Aup5GBRB0toWp5TA2YNPj01Jl70mKCxw4S2wy4JlNX
        tKIuPLkrvpY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C77B8EF47F;
        Mon, 19 Oct 2020 13:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 193D2EF47E;
        Mon, 19 Oct 2020 13:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
        <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
        <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
        <20201018041642.GB2262492@nand.local>
        <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
        <20201018234344.GC4204@nand.local>
Date:   Mon, 19 Oct 2020 10:23:26 -0700
In-Reply-To: <20201018234344.GC4204@nand.local> (Taylor Blau's message of
        "Sun, 18 Oct 2020 19:43:44 -0400")
Message-ID: <xmqqr1puuo35.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD3FBCD0-122F-11EB-BB02-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > There is some overhead to invoke the hook and talk to watchman, but
>> > I'd expect that to be dwarfed by not having to issue O(# files)
>> > syscalls.
>>
>> "invoke the hook"---is that a pipe+fork+exec, or something else that
>> is far lighter-weight?
>
> The former; see 'fsmonitor.c:query_fsmonitor()'.

It brings us back to the "overhead of how many lstat(2) takes us
closer to the overhead of a single pipe+fork+exec plus reading from
the pipe", doesn't it?


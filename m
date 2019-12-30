Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D59C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A547206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X6Qf5vO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfL3V55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:57:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53974 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3V55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:57:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B59B95E31;
        Mon, 30 Dec 2019 16:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HtKyp8Tmf6b9C3BmORSwmXOSmSo=; b=X6Qf5v
        O5RRLQSIdSV4nbCmHkadN49aiQLQmn2tqPEEyj5kP4h3/naGDs+UU/KzZVMpswp5
        edWVbqQdV+pgnkNbFg4BBotekYzEyb2XAAopAXZoqqvVEPHthebD8cL8bj0NllEM
        uUxz1pcFR30ajwhFaj0v4oyEa/nZpYXIm1I+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yFhFA9RVUrArNH+xf77FBH36eNCgUUSO
        hK4Iv/MPB43QR16wrwa4NifioUON3iLKyKY+eQ0WtuY9ZJX3+zi9TQ+vRK/n+jfg
        ukA20V44fhS/teLGdfqgM8c7msH1DSv7lh7aG6dEdPoYlTKvm2S6QXBZhHLJE3M+
        PaCTKqVsK5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03A5A95E30;
        Mon, 30 Dec 2019 16:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2741E95E2F;
        Mon, 30 Dec 2019 16:57:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not tree entries
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
        <xmqqr20qlxtz.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912262209190.46@tvgsbejvaqbjf.bet>
Date:   Mon, 30 Dec 2019 13:57:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912262209190.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 26 Dec 2019 22:16:15 +0100 (CET)")
Message-ID: <xmqqk16dfpcy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D24DDAC-2B4F-11EA-BF46-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Turns out that this inconsistency is only in Git for Windows v2.24.1(2)
> but not in current `master` of Git, so I simply struck that part from the
> commit message.
> ...
> I rephrased it to:
>
>     So let's loosen the requirements: we now leave tree entries with
>     backslashes in their file names alone, but we do require any entries
>     that are added to the Git index to contain no backslashes on Windows.
> ...

We are in -rc so there is no real rush, but I take these to mean
that I should just leave this loose end hanging untied, and wait
for an updated version to replace it sometime early next year.

Thanks and happy new year.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C70C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5838613F9
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhFOCgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:36:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60621 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOCgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEF4F1250BF;
        Mon, 14 Jun 2021 22:34:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHj0tAvACO3lws7l3gIvWIPsSqi8YIKXU8DK4v
        uSDxU=; b=V+uLl09p+hwSMB2FavdU5DEl8QyLKxIy3UlLhxOnIBwg/Bnu/B+M6M
        U6oRugoL9uvZF/2ypR0MzUtzpjNiSQYaIVOpoVQNyBLK2FMvVZmrc7WufoGC5C8+
        VNlwQo6h9SK+2ElVEDQIsWGUTdfrSyq21PZEm3S2mIorKxH7By1A8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E81DC1250BD;
        Mon, 14 Jun 2021 22:34:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AF1E1250BA;
        Mon, 14 Jun 2021 22:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
        <87bl8d6xoq.wl-lukeshu@lukeshu.com>
        <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
        <875yyk7c3j.wl-lukeshu@lukeshu.com>
        <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
Date:   Tue, 15 Jun 2021 11:33:58 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 14 Jun 2021 13:56:07 +0200 (CEST)")
Message-ID: <xmqqtulzyhyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24403BA0-CD82-11EB-B5C9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> `test FILE1 -ef FILE2` checks wether the inode is the same.  And it's
>> POSIX, so I'm assuming that it's sufficiently portable, though I
>> haven't actually tested whether things other than Bash implement it.
>
> It's not POSIX. From
> https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html:
>
> 	Some additional primaries newly invented or from the KornShell
> 	appeared in an early proposal as part of the conditional command
> 	([[]]): s1 > s2, s1 < s2, str = pattern, str != pattern,
> 	f1 -nt f2, f1 -ot f2, and f1 -ef f2.
>
> Having said that, it appears that Bash implements it (what non-standard
> behavior _doesn't_ it implement ;-))
>
> And since Git for Windows ships with Bash, we can actually use it!

So,... is contrib/subtree for Windows only?

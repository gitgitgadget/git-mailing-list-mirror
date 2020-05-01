Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE9C35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27A72073E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vwMIOQM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEAUBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:01:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgEAUBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:01:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8F0DC4187;
        Fri,  1 May 2020 16:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4hO+WGXVVP2A3gFLUu77cHLtTT4=; b=vwMIOQ
        M3SaArJGn3dhyENK7egYIY1kpv0PAx+SsXyzmZa6yDyVXFvxraVt7m8ViDZP2C9x
        oT4bJOIRMPz4gGhYBau2xt5WjpYA9XSpugwREqaX4SMeTulM3JLEDje9/SpvKRdl
        2bE+DBOZdo1IK+yxyMfPxjRedbCQ+vQvksl9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oLxivkhnie0urPipAF/ODWx2SXEYMC+s
        NnsUxPYRdoV+NB3mO2UCGfCgsilRoxMuMJIHvBALtHD6n5brSJSFudBLwVLtm/NV
        A7TPJ9AJIdcpvNXJkcVPFsdEiZDVAe/vnikGtn8NvG6AD3tgZtgfEmfqeDuai3mq
        sPL0PBc0wJc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 147A4C4186;
        Fri,  1 May 2020 16:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 310CCC4184;
        Fri,  1 May 2020 16:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>` again
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
        <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet>
        <xmqqr1w7yzjc.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004291657220.18039@tvgsbejvaqbjf.bet>
        <xmqq8siez4m2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005012156220.18039@tvgsbejvaqbjf.bet>
Date:   Fri, 01 May 2020 13:01:11 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005012156220.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 1 May 2020 21:58:49 +0200
        (CEST)")
Message-ID: <xmqqo8r7l914.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 823FCECA-8BE6-11EA-A1ED-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would obviously prefer more reviews.
>
> Having said that, GitHub Desktop rolled out a new release this past Monday
> with the MinGit backport I prepared with these here patches, and the only
> additional report at https://github.com/desktop/desktop/issues/9597 talks
> about macOS (and the MinGit backport is Windows-only). Which I take as
> good news for the robustness and correctness of the fixes.

Good.  My preference actually is to fast-track this down to 'master'
without the usual 'at least about a week in next' gestation period.

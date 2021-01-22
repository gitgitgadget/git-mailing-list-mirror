Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F0C43381
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C195823AF8
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbhAVSKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:10:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59005 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbhAVSDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:03:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B32A2A6D7E;
        Fri, 22 Jan 2021 13:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FD48z3ZatMXLfB4UO0Bumu80XN8=; b=iwjybQ
        Fp3C18FOv4CSsoDNTawsRFRXFGGY9j9CM5zIR3ravr5cjWcHh8vSAzjuxZgTI1dJ
        6J1eQFtuekb5hgbb42SI4TcuUYjRpM7T3ma1TrOulLHlr4657FTB5/RqOKv4LHh8
        xuO2d746OYqKPBCM6qNJw8v2uTHWhaa4TybKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Guv93mJ1jCfBMVVRteePMz3vMd87F9bb
        4OCfGDJ+w/iesDLm0dGHZGE75QFuIsAyUcOPa0Juh8RTm6AN0mW26QYz9KSC+PC6
        MVIT6KMRT8JYlyspcrzeHr1Jm7gBXVl42guIOSKlS+eipv3tuXiSUiUEgp+MhvSN
        PZhdX2xvAP4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AABDDA6D7D;
        Fri, 22 Jan 2021 13:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25BB4A6D7C;
        Fri, 22 Jan 2021 13:02:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
        <xmqq7do7fggn.fsf@gitster.c.googlers.com>
        <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
        <xmqq1reec943.fsf@gitster.c.googlers.com>
        <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
Date:   Fri, 22 Jan 2021 10:02:40 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 22 Jan 2021 17:04:55 +0100 (CET)")
Message-ID: <xmqq8s8kalz3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0504E28E-5CDC-11EB-95A3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And should I still use gitgitgadget PR on my origin branch "dedup"or
>> send patch on branch "zh/ls-files-deduplicate"?
>
> The way GitGitGadget is designed asks for contributors to adjust their
> patch(es) via interactive rebase, implementing the suggestions and
> addressing the concerns while doing so, then force-pushing, optionally
> amending the first PR comment (i.e. the description) with a list of
> those changes, and then submitting a new iteration via `/submit`.

Thanks for clearly explaining the rules.

As I suspect many people are afraid of forcing their pushes, it
would assure them to explain that it is OK to force when them
restart the series from scratch by replacing the commits.

And it would very much help on the receiving end when the
description gets updated.

Just being curious, but when a series hits 'next', would the way in
which the user interacts with GGG change?  With or without GGG, what
is done on the local side is not all that different---you build new
commits on top without disturbing the commits that are in 'next'.
Then what?  Push it again (this time there is no need to force) and
submit the additional ones via `/submit`?

Thanks.

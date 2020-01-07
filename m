Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41AFC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007C2080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gUkzWOGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgAGULL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:11:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54312 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGULL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 15:11:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C41A98238;
        Tue,  7 Jan 2020 15:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8+5coq1Rh9ze+tvhxzO9gRFbgt0=; b=gUkzWO
        GM/PYgO+AnMpnVC8iFXwjpnnk2zD/Nza1BbX6wFbka18titoFz45+BEso6MTce5q
        sLaWiYRL/mamjk3hhqKlHROB96z7bRObZvU6pQTJzhRqBB/ah6FUUI2RvlK+oKZI
        vU49FjxhZRtuMpWAfoK7G+dD8fZ3n/NGmOTHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kmdjul6oNP1cTORkFUVgzJm/AQm47xRt
        tyhFpze6EtPajjASIyOA9PvTOcJ9yTVLHQsmq7086yThIAEGxUCRBOjHzC+930bT
        yjykZt6+WhtETGha4k2ItPNXtj0SFXPBN88FT1Mhohc3yUvUwvRSuhblCZT3Zzn4
        z5KqSatgGjQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 326A898237;
        Tue,  7 Jan 2020 15:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FD1C98236;
        Tue,  7 Jan 2020 15:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
        <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
        <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
Date:   Tue, 07 Jan 2020 12:11:05 -0800
In-Reply-To: <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 7 Jan 2020 11:26:58 -0800")
Message-ID: <xmqqy2uj3u3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E8D492-3189-11EA-94F1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, I thought of this option before Junio suggested a
> rebase.backend config setting, so we could just rely on that instead.
> Thus, getting rid of the "--am" flag in detail would mean:
>   * I need to redo the test changes in this series to use "-c
> rebase.backend=am" instead of "--am"
>   * It will be slightly harder for users to use the escape hatch in
> one-off cases during the transition
>   * We need to figure out the right way to reword the documentation
>
> The first two are pretty minor, so that probably means I just need to
> come up with some good wording for the documentation (suggestions
> welcome...)

It probably is a good idea to keep --am (and possibly --[no-]am) as
long as rebase.backend option exists.  A configuration variable that
changes behaviour without allowing it to be overridden from the
command line is not a good idea.

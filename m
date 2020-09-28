Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF76C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB972100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bXVtU6SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1RBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:01:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65139 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1RBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 13:01:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B69E2ECB89;
        Mon, 28 Sep 2020 13:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4pfUyo2tRmy78rapuz13Rs/uhS0=; b=bXVtU6
        SK+l13VZFeqS3V7FI0JPf4mZRCG+aaBoPk4yM4Qv4i2C3pWVpQKFF008uVhPfm27
        dfgxAOJ/CWDlgimwDjBhNQlRj3YuTjXDobZRkoNsMWL97AgdKgD9ZYRdEZYUMfRG
        /aqNDeTkRnF2Ali0guAzDDrFPJwh8ZaZMUWgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZSL5ocmMMGbWYQCAa1ptVS3l0coNHQxa
        c4l8AxubiMim0dougroWwPUeNX+8No2QNjPWDAdiqQprvfq3lKCgtNX72jPrAc5x
        X2V+kh379/4/wNcQzAls0rXqq/KXF4/glGTT8fXa4S1LBVQCSM42VfRbhAUyWHr9
        Aw6YpncmgjM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE8CBECB86;
        Mon, 28 Sep 2020 13:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5A52ECB85;
        Mon, 28 Sep 2020 13:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 4/8] shortlog: match commit trailers with --group
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084004.GD2465761@coredump.intra.peff.net>
        <xmqqlfgvngkw.fsf@gitster.c.googlers.com>
        <20200928031752.GA3059492@coredump.intra.peff.net>
Date:   Mon, 28 Sep 2020 10:01:41 -0700
In-Reply-To: <20200928031752.GA3059492@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 27 Sep 2020 23:17:52 -0400")
Message-ID: <xmqq1rilomx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48A26420-01AC-11EB-B5BA-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if this might confuse people reading the series, and almost
> called attention to it in the cover letter. Now that you've presumably
> read through and figured it out, is it worth going back and amending the
> commit message? It's more of a point for reviewers, I think, but perhaps
> somebody reading the commits later would care.

When I read history older than the immediate past, I usuall start at
the point 'git blame' found and then go back---going forward is much
less natural operation.  If my "git blame" session happens to hit an
earlier part of this series, perhaps the future-me would get a wrong
impression that originally the feature was in a limited form and was
extended later in a separate series?  I dunno.

I did wish the log message said what was going on while reading, but
that is a perfectionist in me speaking, and not a complaint that log
messages that did not say the future plans in the series were
offense that deserves a rejection.  A good summary in "What's cooking"
report would become a merge commit log message, and we can teach
users to go from 'git blame', find where the entire series was merged
to the mainline and then read from there---and it would be sufficient
if the summary of the topic described the endgame well.



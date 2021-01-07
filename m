Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33907C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14AE23125
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 08:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAGIUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 03:20:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57600 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbhAGIUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 03:20:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89547A6355;
        Thu,  7 Jan 2021 03:19:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9Z7hYT237ICE
        3xwavnnQSrQQzwA=; b=fJxhmEqmI4BgG4mPjS6QWW2kvM1ig+N+q/1qlK+MUKwa
        nGtpPNdmihxuNIaCiqHpE9nRo2Eva735nhp1jyAtkiGvsAgG2QfOYtXzF8WtIdfQ
        TQ0zaRKeISSAgpzTBGuNqGXGUO+kUddc9R3uayvYgoKCw2K+MuY3o9WV3lP2iM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xifMz+
        YgJhlR7mal6yTc2wispK4WNTKRI7cc9Bbks9HCoFagbUjYJsSQcnNoBQOz+xbsph
        PwEkNqlK7WzDNEjb76w4wVpVBUAVuMByNxOdUp4/mVXZV2vRU7DsrOYvXWBLsB91
        3Pr7Ex+InJDY5tPdXmOkwRI5JJNX685De4waM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81E9CA6354;
        Thu,  7 Jan 2021 03:19:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FFA2A6351;
        Thu,  7 Jan 2021 03:19:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
References: <cover.1609874026.git.martin.agren@gmail.com>
        <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
        <xmqq5z4as2j9.fsf@gitster.c.googlers.com>
        <xmqqim89pu9k.fsf@gitster.c.googlers.com>
        <8ae92e79-ef13-3faf-2fc2-d4b107e73c36@gmail.com>
        <CAN0heSqdphJWgG6gLM4a8mrDLh6qGUVq5w2FYAr7g8uePrcd2w@mail.gmail.com>
Date:   Thu, 07 Jan 2021 00:19:51 -0800
In-Reply-To: <CAN0heSqdphJWgG6gLM4a8mrDLh6qGUVq5w2FYAr7g8uePrcd2w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 7 Jan 2021 08:55:32
 +0100")
Message-ID: <xmqqft3dma54.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D9F4C3E-50C1-11EB-B389-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> To be perfectly honest, I just grepped around. I just tried your
> suggestion and it seems like I really did catch everyone who looks at
> `->tempfile` or `.tempfile`.

That's wonderful ;-)

> I could add a remark in the commit message of the last patch along the
> lines of "After this commit, renaming the `tempfile` field only trigger=
s
> compilation errors in lockfile.[ch] and this one instance that we're
> intentionally leaving here.".

It would be a nice addition to the log message to help readers to
feel confident about the conversion.  It is OK if you want to add
one, and certainly a good trick to have in your toolbox for your
next conversion, but it may not be worth rerolling only to update
the log message with such a remark.

Thanks.

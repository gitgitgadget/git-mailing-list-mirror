Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB17B20A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 08:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdJAI3O (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 04:29:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64305 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750950AbdJAI3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 04:29:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB4DAC057;
        Sun,  1 Oct 2017 04:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pjmYTmYIiROI
        g53tSv87aCrmYxI=; b=f4pnKEpZfoFeWMgPNvzc85t08Zv3okLqYAUoe8c4LRP2
        3/CJvr8YQgozu1MQtXSmBjnTSX/dt6yNP6OtdvbEuLfjjRoQhF04l8emKCw2yzM9
        xs0Bkzp0U+rardr8kG8M8cJsRZKoPVDNQFjE+64chjthXH17nfuZsAvrYiXFV2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pSqY2A
        rkOZNOW0TcnQeqtym+B0JofvymkgeIOgWpw0tfenE48rQlSTAcLwu0UKa6QD1J5T
        Ejt9ZlBYJ10Ll+ntO9Ro2ZQcRJhuanyrL6HY5WhPn8+gHtG9aTyrZTCWxDo636oX
        +uOxG9e4+ot1IhRKs69+0ZZckTVGUbI3/kiAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5ACFAC056;
        Sun,  1 Oct 2017 04:29:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14A0BAC055;
        Sun,  1 Oct 2017 04:29:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/3] refs: pass NULL to resolve_refdup() if hash is not needed
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
        <c18156ec-4c59-eb96-3177-0b1085b0a5c1@web.de>
Date:   Sun, 01 Oct 2017 17:29:10 +0900
In-Reply-To: <c18156ec-4c59-eb96-3177-0b1085b0a5c1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 1 Oct 2017 09:29:03 +0200")
Message-ID: <xmqqfub3uv8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A31C7AA-A682-11E7-96CD-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> This allows us to get rid of several write-only variables.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/checkout.c     | 3 +--
>  builtin/receive-pack.c | 3 +--
>  ref-filter.c           | 7 ++-----
>  reflog-walk.c          | 6 ++----
>  transport.c            | 3 +--
>  wt-status.c            | 4 +---
>  6 files changed, 8 insertions(+), 18 deletions(-)

Both patches looked good to me.

It's a bit surprising that we care so much about where a symbolic
ref points at, but it is understandable from the list of files
affected.


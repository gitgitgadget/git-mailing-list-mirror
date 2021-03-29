Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED3EC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E831161996
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhC2WVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:21:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62047 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhC2WUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:20:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FFD7C67B8;
        Mon, 29 Mar 2021 18:20:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BfwCnTrMOg9y
        FnVaDQ8AqLOgW5Y=; b=ZESJIR+F1kJwQdqB0mPGYSONQ9QuO16GvD9TD56PBanq
        rXdkZ9bP1ZP+zMPOCYnGc2LFdechDHW0RWTtdnb9BXrWuZ0GJDNJu1t9hnY/aoso
        t+ecT2o48SetZNFiWeK/bfyAlJldXKUPzqLwr/NwNpQUTWx74+m6C1HGCQ69+co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rqDIkw
        CYPlN6mfEJ1SGVExyF6hVGdH0iq8SGjY0kkkxJCk5jE3JFGsYPBTqag2r/7hZYJF
        QgWRu7cP8BMrDDOJCMJG1PjcSYhCU9z3asfBdIBfbSLuaHduk047XTrktf7NRjXJ
        detSBbxw6DZPBSEGQBCZRh5fDttxQb8Z7yF1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37078C67B7;
        Mon, 29 Mar 2021 18:20:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6CCDC67B6;
        Mon, 29 Mar 2021 18:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] Makefile: begin refactoring out "ln || ln -s || cp"
 pattern
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-2.7-5f59121dd0f-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:20:50 -0700
In-Reply-To: <patch-2.7-5f59121dd0f-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:40 +0200")
Message-ID: <xmqqwntpha9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04CD7D5A-90DD-11EB-ACE5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Begin refactoring out the "ln || ln -s || cp" pattern in the Makefile
> into a script. For now this is trivial, but in subsequent commits
> it'll simplify things a lot.

I agree with the approach.  The precedence glitch I commented on in
my review of [1/6] (e.g. how would I say "I never ever want symbolic
links---just use hardlink and fall back to copying") would be much
easier to solve if a single helper is used consistenly---that would
give us a single place to centrally fix.


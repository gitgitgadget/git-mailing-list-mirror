Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE0C8300F
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01EE2087C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBNicTa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLAW2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:28:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63426 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgLAW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:28:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 286858FC98;
        Tue,  1 Dec 2020 17:28:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SX8T55F7N4ZMBe7agAZw9+xNNUo=; b=fBNicT
        a052R0ZvjgSWyA+GNjkLUa6pbcEmUmorI+Zv0U0aYDh9zKhN8H25n1qMbT2Dlftr
        /Td1TY2J5I0VXqf/JybqCaZJZTrABHOL6GVqunc1AnPebY4HHdi6fzyeNhNtjeDz
        i9A5yUlrEBBHMxZkD8GXA6GvI9MbU/JluMbKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j3mS2mg0aJDy6SJE0lQA9hx5xvQPIn42
        fyoPdD5MomGsW/gEgcZj3Roc10wEkm0/o/v5xOG0h2r39wMIPxcnrtcgoQcxM7Y2
        5bQfjHTLHlrggOq/x7TMrcCS+zQWwZSNidZj+ZBB/Uy3kp4bPQkWQNTNeP12k+6D
        /+tLqaSWyNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 204908FC97;
        Tue,  1 Dec 2020 17:28:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0A608FC95;
        Tue,  1 Dec 2020 17:28:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 09/10] mktag: use fsck instead of custom verify_tag()
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-10-avarab@gmail.com>
        <xmqqk0u1nthg.fsf@gitster.c.googlers.com>
Date:   Tue, 01 Dec 2020 14:28:09 -0800
In-Reply-To: <xmqqk0u1nthg.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 01 Dec 2020 12:47:55 -0800")
Message-ID: <xmqqv9dlma9y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E43B746-3424-11EB-90AC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not see the "we do not want more than one blank line after the
> header" in the original, which was one thing I was looking for after
> seeing what 08/10 did.
>
>> +	fsck_options.extra = 1;
>> +	fsck_options.error_func = mktag_fsck_error_func;

Hmph, recent "released" versions of Git seems to be fine when

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
object 72ffeb997eaf999f6938b2a7e0d9a75dcceaa311
type commit
tag tester
tagger Junio C Hamano <gitster@pobox.com> 1606860947 -0800


a message after a blank
--- 8< ------ 8< ------ 8< ------ 8< ------ 8< ---

is fed to their "git mktag".  If I am not mistaken, we definitely
want to drop the EXTRA_HEADER_BODY_NEWLINE check from 08/10, even
though EXTRA_HEADER_ENTRY may be something we want to retain at
least for some releases for backward compatibility.




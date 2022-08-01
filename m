Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473FBC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiHAQpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiHAQpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 12:45:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EE3F32C
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 09:45:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D691150EA5;
        Mon,  1 Aug 2022 12:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9hGCERtLKPQi
        VbVcddsb3GhD2Y4IS9e36yAvkaw3Cxc=; b=wu/8fd0+TWnwUs4VKcUwc62r7zpG
        rBy5fo9MEJBqNr5fWPKtRB3qPK2Twgf6JZ856r7djUSwZiKind+Q8M7ZNqpaLPtN
        7oP+WzypshkLqVUtzHzPGfrD0K8GDPpU5rByGEjiHillnZundiT3hF16fmWLSiTg
        jzSeyw7c7RakXzc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C6E6150EA4;
        Mon,  1 Aug 2022 12:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AB52150EA2;
        Mon,  1 Aug 2022 12:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v6 1/9] help.c: BUG() out if "help --guides" can't
 remove "git" prefixes
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
        <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <patch-v6-1.9-f3588319057-20220728T164243Z-avarab@gmail.com>
        <xmqq35ej313l.fsf@gitster.g>
        <220801.86czdki3ad.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 Aug 2022 09:45:00 -0700
In-Reply-To: <220801.86czdki3ad.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 Aug 2022 13:55:11 +0200")
Message-ID: <xmqqbkt3zzeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A40B1E6-11B9-11ED-B778-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So I can remove this stricture entirely, or make the BUG() stricter and
> remove the "git" (or "git-" requirenment. Whatever you prefer after
> reading the above..

My preference is that you do not have this patch at all.

We do not need it now, and we do not know, and more imoprtantly, we
do not have to decide, what we want to do when we add a guide whose
name does not want to begin with "git".  It would only locally be
one patch we do not have to discuss out of 9, but things add up.

If you switch to the attitude of not churning what you do not have
to touch right at the moment, hopefully it would save reviewers'
time.  It unfortunately probably make you spend more time thinking
about everything you do if that is essential or unnecessary churn
after writing but before sending them out.

But hopefully the original author spending more time and effort on
the quality of the primary part of the changes, without getting
distracted and without distracting reviewers by what is not
necessary yet, would contribute positively to the quality of the end
product?

THanks.




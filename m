Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075CC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiC1UFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiC1UFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:05:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27315F25E
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:03:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC25710EC9A;
        Mon, 28 Mar 2022 16:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nE4gO9G645yV
        7kqtGa8bLlGr1qLhR6TRotNuzNuRuU8=; b=AAVUCDpBDG8JWV+gSjnBop1Qj8vS
        +LdeTvHPSbwu8tLGv06oFHGqVdp6ysRlKtRCM/bOpKgw6G+N3dmH9Ve5Z+Qn4DX3
        8eL+VFmlm0Z9/khqvCw4tjc7CANh2grCapkxeTzzkVysY8jk5bs+MuQFg/eOiPXa
        Dub0juAx5YZaX60=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3B6510EC99;
        Mon, 28 Mar 2022 16:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2871B10EC98;
        Mon, 28 Mar 2022 16:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
        <xmqqtubl93n3.fsf@gitster.g>
        <220326.86ee2pleua.gmgdl@evledraar.gmail.com>
        <xmqqee2p70c1.fsf@gitster.g>
        <3bb95e8b-4977-ddca-225c-5afe28d8ac20@github.com>
        <220328.86tubh3nmx.gmgdl@evledraar.gmail.com>
Date:   Mon, 28 Mar 2022 13:03:54 -0700
In-Reply-To: <220328.86tubh3nmx.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 28 Mar 2022 20:55:31 +0200")
Message-ID: <xmqq5ynx3kut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 324BA43C-AED2-11EC-9D44-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Junio, would you be OK/prefer to basically have the v2 verison, with
> just a dummy macro like this in revision.h?:
>
>     #define REV_INFO_INIT { 0 }

FWIW, I do not see that as "dummy" at all.  We may further extend it
in the future, but it is what is minimally required to safely pass
revs to init and release, and what I have been saying since the
previous round of the review,
https://lore.kernel.org/git/xmqqwngji72a.fsf@gitster.g/



Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C35CC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42166610FB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 03:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhEDDCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 23:02:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDDCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 23:02:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D676611DE44;
        Mon,  3 May 2021 23:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fm9+rV07gzsA
        m3OXNpeSFHQcdwWT5A+7+fje2dS0DC4=; b=mSoNGgBY0J1OByzynmm/y8zNh7II
        9LXdVLipPFHyIDExaENO/LcEqok7mkDg/6Vd89JHHMqRIZUPOWZQr8MSenqLNKG1
        DfMWhPbqWTHWT7J1cw03fd2t1kYOI01smkOWcS8eG9OEHziwUKSM54xQuCjHuxQi
        6bbO2uDz4TTujT4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF52311DE43;
        Mon,  3 May 2021 23:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13B6111DE42;
        Mon,  3 May 2021 23:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
References: <xmqqfsz4a23x.fsf@gitster.g>
        <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
        <xmqqsg348k9j.fsf@gitster.g> <xmqqo8ds8k6r.fsf_-_@gitster.g>
        <877dkgxk9p.fsf@evledraar.gmail.com>
Date:   Tue, 04 May 2021 12:01:38 +0900
In-Reply-To: <877dkgxk9p.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 03 May 2021 11:01:27 +0200")
Message-ID: <xmqqpmy76w31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D6F7968-AC85-11EB-81B1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Is there any portability reason to avoid "local" in the porcelains? I
> don't have any plans for using it, but I don't see why we'd explicitly
> forbid it.

Things that are not even in POSIX are forbidden unless explicitly
allowed.

In general, he way we encouraged people to think has been "don't use
it, it is not even in POSIX" and "even if it is in POSIX, we know
the support by platform/implementation X is broken, so let's not use
it".  It has been successfully helped us to stay out of portability
troubles.

There may be a few tiny cases where we said "practically everybody
we care about has it, even though it is not in POSIX, and it makes
our life so vastly be better" to explicitly allow some feature,
though.

And "local"?  Not absolutely essential, unless you are doing a
library that you want to avoid stepping on users' toes.  Besides, we
are no longer adding scripted Porcelains left and right---rather,
people are actively rewriting them.

Thanks.

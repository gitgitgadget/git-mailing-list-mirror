Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B60C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiBAWMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:12:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64052 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 17:12:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC5D105417;
        Tue,  1 Feb 2022 17:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2rvjwOkD8sTR
        LgaWSG9RmzeCnlgpZ4tQWPt8Jd+u91w=; b=El7ADKn2+GZGlhmMNC3AtExeFG7C
        Wmi3iKPQXj8RMx9FlMbsAlc+zIVrR5uA6cwVuwtLmpxpEuxCQ5cKQe4tTPO7phi/
        NMnzlODZK9Vy7r/5KvuyLohYxPcEbqFv7h3nOhBUbOhpCSVa63eoXp/0hXRHyeVI
        zcWSeZc89V0N8Hc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20CAC105415;
        Tue,  1 Feb 2022 17:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84416105414;
        Tue,  1 Feb 2022 17:11:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        <xmqqa6facn9i.fsf@gitster.g>
        <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
Date:   Tue, 01 Feb 2022 14:11:58 -0800
In-Reply-To: <220201.861r0m9t8n.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 01 Feb 2022 22:22:00 +0100")
Message-ID: <xmqqsft2b5jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9D22172-83AB-11EC-BAE2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We could surely add magic record types, but how would such a dance be
> performed while keeping compatibility with existing JGit clients?

Yes.  It is exactly the point of the question I asked.  If it is
simple and easy to add such a new type that is ignored/skipped by
existing clients, then we can go that route.  If it is simple and
easy to add a new bit per ref that existing clients would not barf,
we can use that as an alternative implementation strategy.

And if neither is possible, and there is no other viable third way,
then what I wrote in the part you omitted from your quote still
stands, which was:

>> It is probably a lot more sensible to fail refs_create_reflog() and
>> safe_create_reflog() (which is a thin wrapper around the former), if
>> we cannot implement "a reflog can exist and have no entries yet"
>> semantics.

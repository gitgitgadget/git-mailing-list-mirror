Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5A81FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 00:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbdJVAqR (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 20:46:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56924 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932266AbdJVAqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 20:46:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AE9D9B52A;
        Sat, 21 Oct 2017 20:46:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCA+EAPH+cbZuPs4Sc5hn/MAMsQ=; b=uSxn89
        aKAJ7kyg4syQbtzwTOeb6OgzZpzn9FbhX4rv+S+83w+/yQhfayt0yscBB3uD4kYM
        B3p3LsGFW7caML94DALdWPwCTvB4zaPpOh25gYmzgFKfGdyuc0tnTHtZ87UHwQhd
        rIGCkT+03Kw8yhN7zImDftWUEIl+BdRjiAqK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VDeOu6724wPusmhr5UkE2g3Nq68PG+Hi
        YN3NYhKQjN2IQhFyHdg5fDHX2WVbIFVqASN1OxU9OnefksEECheycpclyBl2fQtr
        7oZvTUm3A+3JWEUZu1zA4adNXesGPaHt9N+VQFXh4HW+Ic2GKvTal7MuqJooT1Fe
        KRaczqQhNPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 717D79B528;
        Sat, 21 Oct 2017 20:46:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD93E9B527;
        Sat, 21 Oct 2017 20:46:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Andrey Okoshkin <a.okoshkin@samsung.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH 4/4] worktree: handle broken symrefs in find_shared_symref()
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
        <20171019174936.izojvrh5w35s3adi@sigill.intra.peff.net>
        <CAPig+cT3=BNcM+WZWhpAq6Ch=5xC47oW_S-9=YfEQL7rRkyPhw@mail.gmail.com>
        <20171021192601.2nvkmzsctujzxjbm@sigill.intra.peff.net>
Date:   Sun, 22 Oct 2017 09:46:13 +0900
In-Reply-To: <20171021192601.2nvkmzsctujzxjbm@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 21 Oct 2017 15:26:01 -0400")
Message-ID: <xmqqd15gf1re.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68580BAE-B6C2-11E7-81B6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 21, 2017 at 06:49:15AM -0400, Eric Sunshine wrote:
>
>> On Thu, Oct 19, 2017 at 1:49 PM, Jeff King <peff@peff.net> wrote:
>> > The refs_resolve_ref_unsafe() function may return NULL even
>> > with a REF_ISSYMREF flag if a symref points to a broken ref.
>> > As a result, it's possible for find_shared_symref() to
>> > segfault when it passes NULL to strcmp().
>> > [...]
>> > We can fix this by treating NULL the same as a non-matching
>> > symref. Arguably we'd prefer to tell know if a symref points
>> 
>> s/tell//
>
> Right, thank you.
>
> -Peff

Thanks.  Already tweaked in.

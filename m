Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F930C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC6A2395C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZ4uw3Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgIXRWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:22:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54881 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgIXRWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 13:22:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B3F8DE7D;
        Thu, 24 Sep 2020 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E+riIzjiq2GX
        XCbpvW/olSEYAGA=; b=iZ4uw3Fud0r90D0hm7+MgecsKeYDUdVjYwn74g238CCi
        THjF9UUl9rpwItghNpkTRADSBFKZo9pnN4lRQ50AzOP/QfZE/1EXR7BMwEA7HPve
        e6QIQbPEMGnS+bqhKwbFYlIKVk2NxTqE6I8nbu8zk42Anf8uhYqEQXx3pePr1aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ryR3n+
        sx3KtWiivmf0Uv2tjxozmWMF99rEzqptAM52s9NXtrlPHbwCwjUNsFUl4MMCQApS
        CqCZSPzrqV68hi6wyfxMo3H/IOWAG47pqOEhXogJJ/WFv7c9IrRMq9HiPJ26BO8l
        RhpbnVjxzwbrLXZiJa9IGQLiEJH+3d1PxSZmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB4608DE7C;
        Thu, 24 Sep 2020 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D1798DE7B;
        Thu, 24 Sep 2020 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic
 record type.
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
        <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
        <CAFQ2z_M9uBc+VArOVXg-hwTY8bu-gQQSL9JC6TJ5MuTCtxx=EQ@mail.gmail.com>
        <20200924072151.GC1851751@coredump.intra.peff.net>
        <20200924073125.GD1851751@coredump.intra.peff.net>
Date:   Thu, 24 Sep 2020 10:22:20 -0700
In-Reply-To: <20200924073125.GD1851751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 24 Sep 2020 03:31:25 -0400")
Message-ID: <xmqq3637gkdv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 811D4A56-FE8A-11EA-A366-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Then I did the same, but building with -DNO_UNALIGNED_LOADS. The latter
> actually ran faster, by a small margin. Here are the hyperfine results:
>
>   [stock]
>   Time (mean =C2=B1 =CF=83):      6.638 s =C2=B1  0.081 s    [User: 6.2=
69 s, System: 0.368 s]
>   Range (min =E2=80=A6 max):    6.550 s =E2=80=A6  6.841 s    10 runs
>
>   [-DNO_UNALIGNED_LOADS]
>   Time (mean =C2=B1 =CF=83):      6.418 s =C2=B1  0.015 s    [User: 6.0=
58 s, System: 0.360 s]
>   Range (min =E2=80=A6 max):    6.394 s =E2=80=A6  6.447 s    10 runs
>
> For casual use as in reftables I doubt the difference is even
> measurable. But this result implies that perhaps we ought to just be
> using the fallback version all the time.

I like that one.  One less configurable knob that makes us execute
different codepaths is one less thing to be worried about.


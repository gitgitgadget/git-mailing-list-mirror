Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2386BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhLUHdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:33:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50059 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhLUHdd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 02:33:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6271B10045C;
        Tue, 21 Dec 2021 02:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K6KPVuzbDWmP
        UBIAT6WiYdVcY2Cc2ScscO/G4j16NyU=; b=sUgDjrwlxvJM9WxHTxPgMdr3AePR
        Veq4A2gMMIGba3jH0CgcAxWJl76xz8DSpMXbKLJrqkD6Kzo19KrRFJ1/XFEF/+C0
        tolpOxBhV4FAKcFFApO4z9eGG3gmEPPJPn27xDk1/rBBt9W2oQECKYlpimJJqED2
        mkRJ/HV11xfoKa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59DF610045B;
        Tue, 21 Dec 2021 02:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFF2910045A;
        Tue, 21 Dec 2021 02:33:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
        <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 23:33:30 -0800
In-Reply-To: <211220.86pmprutbz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 20 Dec 2021 17:31:27 +0100")
Message-ID: <xmqqfsqmqunp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C331A4A-6230-11EC-A683-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  struct tr2tls_thread_ctx {
>> -	struct strbuf thread_name;
>> +	char *thread_name;
>>  	uint64_t *array_us_start;
>>  	size_t alloc;
>>  	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
>
> Junio's suggestion in the linked E-Mail was to make this a "const char =
*".

Sorry, but in that linked E-Mail, I wasn't picking between "const
char *" and "char *" at all.  What I cared was *not* to keep a
long-term constant string in a member whose type is "struct strbuf".

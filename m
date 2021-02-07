Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC7AC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7064E30
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBGSUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:20:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57135 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBGSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:20:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7DF8119D1B;
        Sun,  7 Feb 2021 13:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ONiNgIwcr0HUzncjHIME6leypqU=; b=SHFL1f
        J6Bhy7YZ9iR3a9qimnaB5EV1E8T1Hjx0FrIJF9rneLu7/FvMXZQslWKde+CzPIDB
        r//Jj7h6kbso3pDj9VIdc37zyF4N78Pu3ND2ATig2BEUe+68u90L/OIo+mMN4Hbr
        dlEMKsqzVVm/5NJnjwEf2h02xIMlTq0ORDdls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iv6uuT6qBzNtDUcVjkKQA0Wa5LgsVQaF
        /l1YgBrdO3hN3A2DMqexEmls6a5pIXNMYrgbgCbV9PGh7x825r1Y9QnM3YvIkpRZ
        jGHS8aEMwWX0FilbB4CqxfPAcHKPHNgNC8Bf7F6A5m47V25/X4Hy1T1WOjv7ElFB
        HBkERluXhig=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D07C3119D1A;
        Sun,  7 Feb 2021 13:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2383D119D19;
        Sun,  7 Feb 2021 13:19:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
        <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
        <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
Date:   Sun, 07 Feb 2021 10:19:25 -0800
In-Reply-To: <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
        (Hariom verma's message of "Sun, 7 Feb 2021 17:36:45 +0530")
Message-ID: <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 033F3DB8-6971-11EB-A1F7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> So this isn't about the patch series. Question still remains the same.

Thanks for digging the history.

> Why extra blank line?
> Let's dig a bit.
> Ah. I guess I found the reason. It's due to `putchar('\n');` in
> `show_ref_array_item() [1]`. It puts a new line after each ref item.
>
> Do you want me to include a patch to get rid of this "extra blank
> line" for trailers in "for-each-ref"?

I do not know the answer to the last question, because we haven't
learned the original reason why we decided to add the extra blank
line after the trailer output.  Even though I find it unnecessary,
the code that adds it must have been written with a good reason to
do so, and I do not want to see us remove the "\n" without knowing
that reason.

Thanks.


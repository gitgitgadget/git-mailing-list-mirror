Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF7C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiAGVj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:39:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55605 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiAGVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:39:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC378F9A97;
        Fri,  7 Jan 2022 16:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NedtdWcKPbow
        IV3nBJOk6l5uewNpSimOlVChBfv4aEs=; b=ZjbP8x8bJK3J0T8xfSI0nxtePaRJ
        z8a19ExJOWCtxYWg+9EjqkrMlwi7ZslKyhqjM50nwGadfm99UBlCfM4VDn1h8ugH
        Ou52WKOSXMhIGgZrxbPr4GoP3xPD7kskae67/GPSHyVqEHdaiTys0tO9YgG7TIW5
        qOX1KJyqedq0y4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D41C0F9A95;
        Fri,  7 Jan 2022 16:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42465F9A94;
        Fri,  7 Jan 2022 16:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Issam Maghni via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Issam Maghni <issam.e.maghni@mailbox.org>
Subject: Re: [PATCH] hook: test -a|o is not POSIX
References: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 13:39:53 -0800
In-Reply-To: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com> (Issam
        Maghni via GitGitGadget's message of "Fri, 07 Jan 2022 04:03:41
        +0000")
Message-ID: <xmqqr19j6x92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 59F21412-7002-11EC-AF88-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Issam Maghni via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "Issam E. Maghni" <issam.e.maghni@mailbox.org>
>
> I faced `test: too many arguments` when building using sbase [1]

Building "git" with sbase?  It is curious how a loosely written
sample hook script can cause build failures on a platform with a
more strict userspace.

> This is due to a non-POSIX syntax `test ... -a ...` and `test =E2=80=A6=
 -o =E2=80=A6`.

That's all correct.  The formatting of the above line feels a bit
off, though.

>> The XSI extensions specifying the -a and -o binary primaries and the
>> '(' and ')' operators have been marked obsolescent.
> [2]
>
> [1] https://core.suckless.org/sbase/
> [2] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.htm=
l
>

Perhaps...

	The sample update script in the templates directory uses the
	`-o` and `-a` binary primaries of the "test" command, which
	are marked obsolescent in the recent versions of POSIX.

...would be sufficient, as 'sbase' would not be the only source of
the userspace whose 'test' lack the -o/-a primaries.

Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5665CC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1686E2068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QXDI2mz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFIXOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:14:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51776 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgFIXOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 19:14:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EF71C1EC0;
        Tue,  9 Jun 2020 19:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tDcHm161odNC+jnI9A/nlKkd8Oo=; b=QXDI2m
        z8yBS2RO5q5AUPL6ZQn5lEEjAKbjHrG4t/jxx2vzBBZmkWrBDGDyn7VAuZz6nVkE
        RpYE2GYyJM/wljlwh09uN9GkX+d6ppSxjbHeNTQUO5ZNtujFNy76hXRDMnVgAhNE
        j/XVaRwTV/K/QCM9YDU0xhYpnokgcBvD2THc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLw7FNpOR6f0fF+mL9SWtm0Q9bljG0uE
        iVg4GrlzLr0Il06rJg0TS1xh5epz8yk2Okec/Bu4bAu1V3qjVfdogJiZjB8VbTf4
        BFfY3dxI4EluNC3HCdi5PWw4mgq15VP+bvxaYnEtQdsGOcb48DTMr0WL8G7Y60Ue
        pDoUMFAlOSg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 580F8C1EBE;
        Tue,  9 Jun 2020 19:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3E69C1EBD;
        Tue,  9 Jun 2020 19:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 16:14:26 -0700
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Fri, 05 Jun 2020 18:03:04
        +0000")
Message-ID: <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F733888C-AAA6-11EA-9700-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend. Based on
> hn/refs-cleanup.
>
> Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1
>
> Summary 20479 tests pass 1299 tests fail

Thanks.

> Some issues:
>
>  * many tests inspect .git/{logs,heads}/ directly.
>  * worktrees broken. 

Are these with or without GIT_TEST_REFTABLE=1?

The patches (with the fix-up I saw today) applied on top of your
refs clean-up topic seems to pass the tests (without setting
GIT_TEST_REFTABLE) as the whole, but when merged at the tip of 'pu',
many tests fail (please see [*1*], for examples).  I suspect that
there may be some topics in flight that add more direct access to
the .git/refs/ hierarchy, and/or there may be stupid mismerges (I'd
especially appreciate it if you can spot any).



[Reference]

*1* https://travis-ci.org/github/git/git/builds/696638569

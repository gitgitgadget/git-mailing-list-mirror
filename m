Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E5C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107582086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RsV0xvY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgKXUOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:14:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54657 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKXUOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:14:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B92DEF1F93;
        Tue, 24 Nov 2020 15:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CbVvWIW0s/XCPAYlOITxFp9pSKU=; b=RsV0xv
        Y26Csf5pl926nWMLa4PJq3J3NmevrT8DQX+i+NTVvd+pqy6ZCmkbiWD4xByDhdES
        pTnYQFVKFEDuZPJWmodIaDxeRbLNsdWchPT/wFTAWniNUnLs78TxFWSMqsrX679K
        qUee6qk4GEgh3Ls5nEh0GMIFIHO/sJOVYYbFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ctnFMWLDDMDirxV6fNVR4GhnSRrw+uqf
        Nxhy6udMk8RrxL1+/PZSsF6YlsN6LIyYhpFAXqEKiTj0edPsYvU4MgJL89dkW3Jy
        +LuyZOAq45pIl0MUuB9BmUbtD0rhAYn9jnVfkqG1V/dF2JIRM9wFKEgBHsOsYkKh
        m8QuiEY2uUA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1535F1F92;
        Tue, 24 Nov 2020 15:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A177EF1F91;
        Tue, 24 Nov 2020 15:14:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] branch -m: allow renaming a yet-unborn branch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <8de0c0eb228c8d9608d3a78c992cbd6829cb9329.1606173607.git.gitgitgadget@gmail.com>
        <xmqqd003ljru.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011240551050.56@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Nov 2020 12:14:29 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011240551050.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Nov 2020 06:47:20 +0100 (CET)")
Message-ID: <xmqqd002jyvu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A914B440-2E91-11EB-B299-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > -	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
>> > +	if (!copy && (oldname != head || !is_null_oid(&head_oid)) &&
>>
>> It always makes readers uneasy to see pointer comparison of two
>> strings.
>
> Even if it was on purpose ;-)

FWIW, for fun I dropped "oldname != head ||" and tried to run the
whole testsuite (plus the "branch -m src dst" form test I gave
earlier), and it almost passed all of them except one, which was
surprising.

> +	if (!copy && !is_unborn_branch(oldname, oldref.buf) &&
>  	    rename_ref(oldref.buf, newref.buf, logmsg.buf))

Yeah, a helper function makes it much more clear what is going on.

> Having said that, I fixed the `git branch -m <current-unborn> <new-name>`
> use case; the fix will be part of v3.

;-)

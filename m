Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1FC432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5322075C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 18:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rf5xsiTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK3SEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:04:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54388 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3SEd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 13:04:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEDEF3CB94;
        Sat, 30 Nov 2019 13:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q6INp2lv4qyq/DiXAxGy1Tg1nKY=; b=rf5xsi
        TRZveI3LzzYwwt9IJZouth9x+g/uJ+L+Q9R3w0iNjlQ3gTp1M3Dg3vGz1xnuvu/i
        be4OL5m4eFXCbUeBuOdrJ3qg+HmUsLEEDjVIGtdoEdQE9+jDj7WgWKCbGCum+IeM
        B3hu4LcjLTfCGU/7+MSLP3KAP30e3b98u8ILc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fFPDR2Unil7DzRBWAmJdkPPWfBOfPqVE
        KZxKF8K/1Tf06kUR9oC2QjOPKIAdFTV51vrlsRVvldoj/I31uk0o+j1yuNrBTy/S
        n6DcZwEZyNfWmBCGaM6E5vQxC0ANPVZkuoSirV8fJgZqJM42AhY9blQuqGNLp3iC
        J7r4ujQ8Jt8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5CE93CB93;
        Sat, 30 Nov 2019 13:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F24A3CB92;
        Sat, 30 Nov 2019 13:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
Date:   Sat, 30 Nov 2019 10:04:29 -0800
In-Reply-To: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 30 Nov 2019 10:36:38
        +0000")
Message-ID: <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAEDDFBC-139B-11EA-BB1A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * We now assign errno only when the call to CreateProcessW() failed.

Meaning the global variable 'errno' is left as it was (instead of
getting cleared) when a system call succeeds?  That I think is the
correct behaviour people who use the variable expect.

>  * For good measure, we teach the err_win_to_posix() function to translate 
>    ERROR_SUCCESS into the errno value 0.

So, I am not sure if this is a good idea---who are the callers of
this function and why do they call it?  I would imagine that a
caller who makes a system call, upon seeing a failure from the
system call, calls this helper with the Windows error code it
received from the system call so that errno can be updated with a
POSIXy value.  If my imagination is correct, such a caller should
not be assigning anything to errno if the underlying system call
succeeds, i.e. returns ERROR_SUCCESS.  So a better solution might
be for the function to BUG() when fed ERROR_SUCCESS to point fingers
at the caller, no?

If my imagination is not correct, then ignore the whole paragraph
above ;-).

Thanks.

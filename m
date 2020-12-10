Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B292EC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 21:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6321423340
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 21:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393965AbgLJVQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 16:16:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54287 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgLJVQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 16:16:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DB04A75BD;
        Thu, 10 Dec 2020 16:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mAwXErbX2bgd/GWOP8ehploLJRw=; b=Vzw7l9
        8VJlrBS8DDx/XAnKFP0mJeeGswq5sGa11bn+V7PJY8Opd7Mrn1xOkO5sUpPbPupa
        YHqRuG2nGWtN9mQgY184Osc4TzueDUhSM7s4FojE8u8fEHLfUoZdy5KBxfJh8rdB
        DaUB1IJ303HcilonpkoeQJRhwRc4FwMS6R9kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/803qOHgz3jteU0UlEHK+R7YjvEFGPp
        0BR2CAOZNrRh4wi7zYlzfz/3q2D/kMReCnVmtD92wFyi37tGyFkzzxyWFq3ZzISI
        hZczS5UBy2cXvXeneaWh6ulR5i4bbMjpegE+eyYKpFUL9okZpx8QnZ5pcqVd+FdZ
        Rzp6jkm7b4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14FA8A75BC;
        Thu, 10 Dec 2020 16:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FFDAA75BB;
        Thu, 10 Dec 2020 16:15:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com> <87k0tqdasa.fsf@osv.gnss.ru>
        <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
        <87tust777o.fsf@osv.gnss.ru>
Date:   Thu, 10 Dec 2020 13:15:19 -0800
In-Reply-To: <87tust777o.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        10 Dec 2020 23:10:35 +0300")
Message-ID: <xmqq4kktuzvc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF37890C-3B2C-11EB-9EDC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Well, I did a crush-test: commented-out entire if() at the beginning of
> the log_tree_diff() and ran all the tests.

Meaning "if we are not told to show diff and if we are not told to
indicate with the exit code whether there was any difference, we do
not have to do any of the following" was skipped?  

For most cases we do use the absense of "diff" as an optimization,
but I wouldn't be surprised if a caller of log_tree_commit() that
does not set "we want diff" bit leaves the other members of rev_info
that need to be set correctly for the body of the function, which is
essentially a repeated call into diff_tree machinerly, in order to
work correctly.


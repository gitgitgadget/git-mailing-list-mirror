Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75783C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC023BAC
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgLIUy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:54:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56243 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLIUy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:54:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EA4F881D5;
        Wed,  9 Dec 2020 15:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=etkwj7kMTbVu8q+h0qimhZTZ9aM=; b=e5LzCe
        de3SeB9N6mR92ADIsOn5KqR17y33NTHvZwPo6xIGmZA8y2fb0Al6XKQJ/4D6jc6p
        NAYNFay+JhzqhyFbhfCjFg5oL3vRuIzlCFR1cxHp9UBe/5mlPK2o2Eh9wGzlCCig
        smB3ZAdQexqRt/6lK+E18DIabkqdSLVoXnNlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qFa/+HfcIDl1KwUtFkFWhHuNwe+uvBhw
        9Jzlt69guuagdMc0izlAts/REIkseY+RyU1mEiVs1YIrfSw6R1T8QVchRzUvBKAP
        Ify+4rWxrFMmLd8Jlyc5T1QMgwNUTpx040Va2vFFCwvtfOGFNB4UFY/Ayf5DadvO
        /LcOzhoI9Yc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14367881D4;
        Wed,  9 Dec 2020 15:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 961AE881D3;
        Wed,  9 Dec 2020 15:53:41 -0500 (EST)
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
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com> <87v9dbf4xd.fsf@osv.gnss.ru>
Date:   Wed, 09 Dec 2020 12:53:40 -0800
In-Reply-To: <87v9dbf4xd.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        09 Dec 2020 17:08:14 +0300")
Message-ID: <xmqqo8j21z1n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E8E6E0A-3A60-11EB-99ED-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>> If I were to decide now with hindsight, perhaps I'd make "--cc" and
>>> "-m" imply "-p" only for merge commits, and the user can explicitly
>>> give "--cc -p" and "-m -p" to ask patches for single-parent commits
>>> to be shown as well.
>>
>> After "now with hindsight", I need to add "and without having to
>> worry about backward compatibility issues" here.  IOW, the above is
>> not my recommendation.  It would be the other way around: "--cc"
>> implies "-p" for both merges and non-merges, "-m" implies "-p" for
>> both merges and non-merges.  It is acceptable to add a new option
>> "--no-patch-for-non-merge" so that the user can ask to see only the
>> combined diff for merges and no patches for individual commits.
>
> OK, so, do we decide that -c/--cc must continue to imply -p and thus
> request diffs for everything?

My vote goes to keep the above behaviour as-is for compatibility,
and probably match what happens when -m is given instead of -c/--cc,
if somebody cares enough about "-c/--cc/-m discrepancy".

> That said, -m is useless, period. It'd likely have some merit in
> plumbing, but definitely not in porcelain. So I'm inclined to let it
> rest in peace indeed, dying.

That is fine by me as well.

I do not speak for others, though ;-)

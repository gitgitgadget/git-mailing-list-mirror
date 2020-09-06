Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE66C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BBB2078E
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 17:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4b8mQiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIFRKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:10:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51900 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFRK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 13:10:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 939AFFAA52;
        Sun,  6 Sep 2020 13:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r6SrXiJW4W2O3JRhPKpCqjkhH8M=; b=A4b8mQ
        iHa+vejRzbyHuQrptesfjnyMZnvyZvjsok9YHWczMeJX6AjKFyaYXUaPXIYFFmak
        +rgGkjy5XQgCKMK7fCo4S3ehu2ovUak0Jg5k7jgXftGthEshpFaScyM3aoCDzTl4
        EnOiadkv61HNr3cSYmfzKhdEahrGx1tiwwSXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CvIwDbgAwIE3fAdFaCTr0mZPnl76fMyF
        9rT8kYqhUjn02OgciDML8C8hURymjlN5XA0bYrlGCZtYixDXiwGWSU7uEOO4TFvp
        oFqMXjRgm18MzlEoQWPNQS/V9AqWzMJ8FjXYcjF/7U1MXMuPKxGYV/jtgQRsqNGc
        XixZOBus7lo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 898F7FAA51;
        Sun,  6 Sep 2020 13:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDEB1FAA50;
        Sun,  6 Sep 2020 13:10:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
Subject: Re: git add intent-to-add then git add patch no longer allows edit
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
        <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
        <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
Date:   Sun, 06 Sep 2020 10:10:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 4 Sep 2020 08:56:35 +0200 (CEST)")
Message-ID: <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA080AF0-F063-11EA-81E5-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks for reminding me, I did not really think about it anymore. The
> built-in `git add -i`/`git add -p` has been available since v2.25.0. Since
> v2.26.0, we also respect that flag in the `-p` modes of `checkout`,
> `stash`, etc

That is 9a5315ed (Merge branch 'js/patch-mode-in-others-in-c', 2020-02-05)

> And from the way at least _I_ read the commit log, it seems that the code
> has been pretty stable (except for that bug fix where `e` was allowed by
> mistake).

As long as it has been widely used, that is.  I do not think we
deeply mind a bug like the `e` one that does not affect the utility
or the correctness of the command that much.  If we do not flip the
"use the built-in variant" for those with feature.experimental we
really should do so to widen the canarying population immediately.

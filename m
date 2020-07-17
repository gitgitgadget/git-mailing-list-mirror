Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98007C433E5
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783EE20737
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SX/vRRrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGQRIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:08:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63617 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgGQRIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 13:08:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 447BEEE419;
        Fri, 17 Jul 2020 13:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YGMl+Xj+VP4jxGy8wSzkJ9UNdCs=; b=SX/vRR
        rXqyEyDfPmIrR8dql+CjNXCxKhG1xq1TfiOgp0Pk3LA4mbzKgPmwHbsZ6ShV/QK8
        npkhC5/AA4q0fEHBnXAIfO3rP6to4JnK1C9suhUrXNyNWgdCeRVAkgjwz6YmGiqW
        9IjAFzlUx5yQT0HZd5rbWFJQRRtwuD8yruj5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FPcjdS1W//vaaUc+PXYWAKqhZ5fIUzeR
        eg3hstDZ0rbGAtk2YHJIixu2z+WlBdqv25e6zfSd+GMTlHW3xvwdnLeS8tOT8fPo
        VQs/kiRmufvPqmySOoO+QvibtSQ4gabovaG7z1r8Up0ZqoVbk9LYEP1y42Cu7Vb9
        qvEGsIpv+cY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C77FEE418;
        Fri, 17 Jul 2020 13:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82608EE417;
        Fri, 17 Jul 2020 13:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
        <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
        <20200716110007.GD376357@coredump.intra.peff.net>
        <xmqqd04vigpy.fsf@gitster.c.googlers.com>
        <20200716223719.GA899@gmail.com>
        <xmqqh7u7f29h.fsf@gitster.c.googlers.com>
        <20200717152744.GB1224964@coredump.intra.peff.net>
Date:   Fri, 17 Jul 2020 10:07:55 -0700
In-Reply-To: <20200717152744.GB1224964@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 17 Jul 2020 11:27:44 -0400")
Message-ID: <xmqqr1tadq8k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FC1CE7E-C850-11EA-AC0F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Anyway, if we move to "v1" as the default for "git init" anyway, then
> the number of people being helped would become much smaller.

Yup. So in that sense I do not think I care too deeply either way.

>> > My preference would be to move forward in 2.28 with the first two
>> > patches in that topic branch (i.e., *not* the third yet), since they
>> > don't produce any user facing behavior that would create danger for
>> > users or clash with this plan.
>> 
>> Yup, I agree.  I'd give another name to the third commit and then
>> rewind jn/v0-with-extensions-fix by one to prevent mistakes from
>> happening.  Thanks.
>
> OK. I was confused to see it still at the tip in the latest What's
> Cooking, but I think we're just crossing emails. :)

Yes.

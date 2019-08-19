Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFEA1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 19:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfHSTyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 15:54:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51935 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSTyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 15:54:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AC7216BA9B;
        Mon, 19 Aug 2019 15:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/dn/7cevypn/TlXGOZryI3Ez4KM=; b=WF4Xro
        OhGF1qFTyvAy/FQWH0QyLvEOpkKAApdXztvRyqCU+4ip8vBL9DfLDWGAxBRy79bG
        j0827Qgg2P2jue53b/RceqnGef86yYDSHISlW5i/ZmZyenvXfPfBznjWfq8kfgLS
        VUzyHYJZ180BYBwtV5hhs9611ZxF70+3mZDRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lUf1mavgBTDApYtFn0aZaAisXrVs/mzT
        C0fTC9h6VXuPGpnT36YMb5YHXLgL083anLIH8CMdeqH6PxPHbsUF0fYjBCCc2+l/
        ukhIo7P7oVbq1oSKfBEQndd/YBjcWfYvXJrEwPLlJS+yygVg2XfQjEOGMHn29t14
        OCzK5aQ8Vhg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6282F16BA9A;
        Mon, 19 Aug 2019 15:54:36 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB49D16BA97;
        Mon, 19 Aug 2019 15:54:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
References: <20190813160353.50018-1-vcnaik94@gmail.com>
        <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
        <xmqqr25o7qmf.fsf@gitster-ct.c.googlers.com>
        <CAK_rgsGSfL2zQLP59O+PUCLGz0X8c4UQ3Zg=9M+nCww5C+X_gA@mail.gmail.com>
        <xmqqtvai4cc4.fsf@gitster-ct.c.googlers.com>
        <CAK_rgsHKaLkO_wputOKcHBTDTnyvOUNTABUKK3fKc3ddiaNzQQ@mail.gmail.com>
Date:   Mon, 19 Aug 2019 12:54:34 -0700
In-Reply-To: <CAK_rgsHKaLkO_wputOKcHBTDTnyvOUNTABUKK3fKc3ddiaNzQQ@mail.gmail.com>
        (Varun Naik's message of "Mon, 19 Aug 2019 08:35:58 -0700")
Message-ID: <xmqq5zmtx75x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BA65E48-C2BB-11E9-B0FB-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

>> Either is fine as the implementation of the same semantics; I
>> however am not sure if two I-T-A entries should compare "same" or
>> "not same", or if we are better off catching the caller that feeds
>> two I-T-A entries to same() with a BUG().
>
> I'd argue that two ita cache entries should be a BUG. Since we believe
> that a cache entry in the tree can never have the intent-to-add bit set,
> it suffices to show that no call to same() ever passes two cache entries
> from the index.
> ...
> The same argument probably extends to the conflicted bit, but changing
> that is probably out of scope of this patch.

Yup.  I think the patch as-posted is fine.  I also agree that
tightening the validity check of parameters to same() is better done
as a separate topic.

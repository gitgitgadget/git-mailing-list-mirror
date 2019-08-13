Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A271F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 16:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHMQmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 12:42:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60353 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMQmi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 12:42:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3582E716D3;
        Tue, 13 Aug 2019 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nkQ/PULYuPwI
        nY/eCigM1y1aDZg=; b=AGsy6Y/KuMsUKfX8oYQhJqdFLCcvW0/Zu0mdwMJgqdoo
        Evgsq6GyAzz4Q1U8/fxPyJLtnP3+ukvLEYBFV/Hjn3Jbpw3j1+30WrqenAkUmdUf
        EqZThPXQ2OCgIVBkFAWQ3BxrHTuPKVDyaTi4DK/+b5T/4cLpNcD6nUirbCFDvZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dfHXnD
        GWVNhpqbclSm64/UiaAJZBb5Xn722VpRPf3gpSf7VQrgEi+50VrQEmNuvJOhHXfm
        AYdGRq6DgUCHTChlYWo45H2j4FvnzVW2vaoTx9ocqHSeF58XadzcbPP5siY8BVPe
        /51f+LCBHXFsLLIboTiunmpNTkX2L18tiFy0Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D7BF716D2;
        Tue, 13 Aug 2019 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CE85716D1;
        Tue, 13 Aug 2019 12:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-2-sandals@crustytoothpaste.net>
        <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
        <20190812011054.GA9180@genre.crustytoothpaste.net>
        <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
        <20190813063618.GO20404@szeder.dev>
Date:   Tue, 13 Aug 2019 09:42:31 -0700
In-Reply-To: <20190813063618.GO20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 13 Aug 2019 08:36:18 +0200")
Message-ID: <xmqqzhkd81ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5940AA24-BDE9-11E9-8DEF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> ...  And that function must be able to handle multiple path
> components, becase there is this callsite:
>
>   exec-cmd.c:         !(prefix =3D strip_path_suffix(executable_dirname=
, GIT_EXEC_PATH)) &&
>
> and the build sets '-DGIT_EXEC_PATH=3D"libexec/git-core"' by default.

OK, that answers my earlier question.  We do want to support such a
caller with one or more components at the end.

Thanks.

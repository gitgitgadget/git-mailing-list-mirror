Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BE21F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 03:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJHDXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 23:23:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65146 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfJHDXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 23:23:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7DBA2F7BF;
        Mon,  7 Oct 2019 23:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sMTrHBji/1EH
        sWu7/nvAOESRQPg=; b=ZRxvRlbwXHcE1Ht9vZqksXJ6V3D6LkTgaBs0WKsIVbS6
        Jo41ZfAwqGLDBbhyh25XoY5nWRHZB5XvyAJd/vgxXajgwsTWAXVBpbx7zGrTgQEU
        kd6rPYqqH4Aad/ERhV6KnnV5PmaI0a+JfyqlsRiGRpc4kFMJnt8uZHvzGkY+gt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R0AzTt
        NLYTFAUt8SH+i7uJhAuYukOz3KC2ntRhpyE/qYdtyohunZrY2PUJjid2hghDyOFL
        LnGZvhduxH4aZdfCbx6QhbyD+4Q7xRpEBND3pZurWzALe6pfSXZceNM2KWNGZ2E2
        St9KoGjVFshQWG5gpyGxf/UW2nuHVPJ8J35wg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E03B32F7BE;
        Mon,  7 Oct 2019 23:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54C662F7BD;
        Mon,  7 Oct 2019 23:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 1/2] format-patch: create leading components of output directory
References: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
        <20191007210306.GF11529@szeder.dev>
Date:   Tue, 08 Oct 2019 12:23:41 +0900
In-Reply-To: <20191007210306.GF11529@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 7 Oct 2019 23:03:06 +0200")
Message-ID: <xmqq8spvor7m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0743A4DE-E97B-11E9-9B20-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On one hand, these object ids won't mean much to anyone who might have
> to debug such a test failure in the future, and on the other these
> tests are about 'git format-patch', not about 'git rev-list'.  If the
> check were written like this:
>
>   count=3D$(git rev-list --count master..side) &&
>   ls patches >list &&
>   test_line_count =3D $count list
>
> then the error message on failure would look something like this:
>
>   test_line_count: line count for list !=3D 3
>   0001-first.patch
>   0002-second.patch
>
> which, I think, would be more useful.

That's nice attention to the detail ;-)

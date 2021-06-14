Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA18C48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9BC61055
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhFNDEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 23:04:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhFNDEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 23:04:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6189ED7A27;
        Sun, 13 Jun 2021 23:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WKBI3CQxmGYS
        PZn7dWhmcRCzJVyr+uynGRN2O53cNJw=; b=JU8p+Yz1OR+nxyZM6Dl32u7z5GQE
        KLf8t43Z7lz3NB2X3XX6ARIANHK/q98Cc6ro8EmAuH8Wnh7Z+9i3VBF2FAicijf1
        w1l/U1UvdsBCvtAB/d/FtNSf+6MtnTKfeaCjCVp/0MLnBKKG4n+Qrh2cVq2M5Sqv
        M/I8W3bIrNebC+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5787ED7A26;
        Sun, 13 Jun 2021 23:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA83FD7A25;
        Sun, 13 Jun 2021 23:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
References: <20210612042755.28342-1-congdanhqx@gmail.com>
        <20210612042755.28342-2-congdanhqx@gmail.com>
        <878s3d286c.fsf@evledraar.gmail.com>
Date:   Mon, 14 Jun 2021 12:01:57 +0900
In-Reply-To: <878s3d286c.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 13 Jun 2021 15:36:11 +0200")
Message-ID: <xmqqtum1ywre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E1CC7E34-CCBC-11EB-866A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> More generally speaking we have a bunch of helpers that have this
> potential issue/bug, in practice it's not a big deal.  A test that's
> being overly specific and doing a test_cmp on unbounded "find" output o=
r
> whatever is likely buggy anyway.

Unless we are testing ".gitignore", "ls-files -o", or "git status".
Carving out $TRASH_DIRECTORY/.git/trash/ directory to store these
throwaway files would be less error prone from that point of view.

>> +		case "$1" in
>> +		--out)
>> +			outop=3D"$2"
>> +			outval=3D"$3"
>> +			;;
>> +		--err)
>> +			errop=3D"$2"
>> +			errval=3D"$3"
>> +			;;
>
> It looks like the end-state of the series leaves us with no user of the
> --err option; Maybe it's good to have it anyway for completeness, or
> just skip it? ...

I'd rather not to see --out added if we have not yet any use for the
other one.  When the time comes that we want to validate the error
stream, we may find that we want to check _both_, and we'd have to
discard dead code and replace with what we want, instead of just
adding what we want to a working code without dead code.

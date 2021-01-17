Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE2C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D694D22B37
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbhAQEiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:38:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60986 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAQEin (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:38:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 479F693DF0;
        Sat, 16 Jan 2021 23:37:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+5mhlgazUCQC
        7f1c82kellfidzc=; b=HA6SjrPUmnI+nSw0R1BkKpc5So7DTDycvWmaiKHEn5v0
        Ur6PWJe/jU1ULE2/5ERNM/ZifwzI6dhq3fbJAFf15WgjbbFnnNS5TdkezDvKZVMJ
        D3nph1RoHAuQRyvjA4Y6P3CRYQI6H4nLO/0fqAl1l0bWsmY9E/jnwLwxHL6AlqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S5O/b1
        c4o6716kKOT5Zb7LdmacpJW+zpVLbSOI5vvWrgih49noKQ0DlFPJi1VRJS1Z8kGo
        2kE6GUvScRwNHKrxy8Q5GCgh8seopG+rxkc4PnNmsSUle97fvXqBxJVG3K+h/CGI
        K+v2iRJGirI3Ucz6XrFGDku9Z1ouwLXdwiWnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F76D93DEF;
        Sat, 16 Jan 2021 23:37:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C30AD93DEE;
        Sat, 16 Jan 2021 23:37:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
        <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <xmqqczy7vwub.fsf@gitster.c.googlers.com>
        <CAOLTT8RQWm-tpkj1aO1rPTCJApP5i+niQtNm_zMycSo5YT0B_w@mail.gmail.com>
Date:   Sat, 16 Jan 2021 20:37:58 -0800
In-Reply-To: <CAOLTT8RQWm-tpkj1aO1rPTCJApP5i+niQtNm_zMycSo5YT0B_w@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Sun, 17 Jan 2021 11:45:25
 +0800")
Message-ID: <xmqqzh18mb4p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C66D2BA6-587D-11EB-B2A9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

> Here I may disagree with your point of view:
>                  if (errno !=3D E_NOENT)
>                          error_errno("cannot lstat '%s'", fullname.buf)=
;
> With this sentence included, the patch will fail the test:
> t/t3010-ls-files-killed-modified.sh.
> the errno maybe ENOTDIR when you try to lstat a file`r` with `lstat("r/=
f",&st);`
> So I temporarily removed the judgment of errno.

I didn't mean to give you a solution that is ready to be
cut-and-pasted without thinking ;-)=20

If NOTDIR needs to also be excluded, then you can exclude it just
like the above illustration excludes NOENT to solve the issue,
right?

>>  #2: consolidate two for loops into one.
>> ...
>>      This changes the semantics.  The original iterates the index
>>      twice, so you may see the same entry from --cached once and
>>      then again from --modified.  The updated one still will show
>>      the same entry twice but next to each other.
>>
> Well,This does change the semantics. I think people who used two
> for loops before may want to separate different outputs.
> Now, if you don=E2=80=99t use "--deduplicate", You may see six consecut=
ive
> items under a combination of multiple options.

Yes, and that is intended and is a vast improvement from the current
behaviour, which shows 3 in the first loop, bunch of unrelated
entries from the rest of the first loop, yet another bunch of
unrelated entries from the early part of the second loop and then
finally shows 3 from the second loop.  With the "single loop"
update, at least, the entries are sorted by their path and it would
make it easier to see (if the user cares to trigger both --cached
and --modified, that is), no?

Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22497C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D1220661
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iv/QgZ/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEIRdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:33:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60057 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIRdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:33:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF5E0C1872;
        Sat,  9 May 2020 13:33:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ugKZyelbTpTN
        p/5/Xde4lkLyFmk=; b=iv/QgZ/LMOFPm/TICvEVg/URRmxG/OH/hM72w034LEYE
        CYgK5JWGYGcD15XOjtjT/WBNWGcHWnEox5gUid0eU5x22wgFLz0tugVeC9CO/BVB
        tJ7omCKVJ/TUkh0K+7vtmZqL3ik1+KR/yrrKk+6mO3qpacWrpm5Eb6CfDblzJhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tthth1
        2mw2s6sCSACP4UuckhvfQYFSKzR5NZkduJx94XdiGoETpma2I8g7rVARc1nqKeP5
        KzRZR8ZjcVSX78lyjKCL04Tt1nY+A44u00anAoRzzFA0+lHSCVAreNrtuX7q0raA
        8hXEpiA6keEUnS589mgTKVkmJDMXaa8bfbLJc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7C5CC1871;
        Sat,  9 May 2020 13:33:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B984C186F;
        Sat,  9 May 2020 13:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/3] multi-pack-index: respect repack.packKeptObjects=false
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
        <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
        <20200509161159.GA15146@danh.dev>
Date:   Sat, 09 May 2020 10:33:30 -0700
In-Reply-To: <20200509161159.GA15146@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Sat, 9 May 2020 23:11:59 +0700")
Message-ID: <xmqqlfm1ui6t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33F90FF2-921B-11EA-9AD1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-05-09 14:24:29+0000, Derrick Stolee via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>=20
>> +test_expect_success 'repack respects repack.packKeptObjects=3Dfalse' =
'
>> +	test_when_finished rm -f dup/.git/objects/pack/*keep &&
>> +	(
>> +		cd dup &&
>> +		ls .git/objects/pack/*idx >idx-list &&
>
> I think ls(1) is an overkill.
> I think:
>
> 	echo .git/objects/pack/*idx
>
> is more efficient.

When there is no file whose name ends with idx, what happens?

    $ ls *idx && echo OK
    ls: cannot access '*idx': No such file or directory
    $ echo *idx && echo OK
    *idx
    OK

>> +		test_line_count =3D 5 idx-list &&
>> +		ls .git/objects/pack/*.pack | sed "s/\.pack/.keep/" >keep-list &&
>
> Likewise.

Likewise.

>> +		for keep in $(cat keep-list)
>> +		do
>> +			touch $keep || return 1
>
> Is this intended?
> Since touch(1) accepts multiple files as argument.

Good suggestion, but doesn't .keep file record why the pack is kept
in real life (i.e. not an empty file)?

>> +		done &&
>> +		git multi-pack-index repack --batch-size=3D0 &&
>> +		ls .git/objects/pack/*idx >idx-list &&
>> +		test_line_count =3D 5 idx-list &&
>> +		test-tool read-midx .git/objects | grep idx >midx-list &&
>> +		test_line_count =3D 5 midx-list &&
>> +		THIRD_SMALLEST_SIZE=3D$(test-tool path-utils file-size .git/objects=
/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
>
> This line is overly long.
> Should we write test-tool's output to temp file and process it?
>
> And I think either
>
> 	sed -n '3{p;q}'
>
> or:
>
> 	sed -n 3p
>
> is cleaner than
>
> 	head -n 3 | tail -n 1

"sed -n 3p" is the only valid way to write it ;-)


Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA9C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12120716
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FFN5aJJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLAScO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 13:32:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56478 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfLAScO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 13:32:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77FC83E033;
        Sun,  1 Dec 2019 13:32:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=kk9DNmBnpNKHK
        6gp/4VnKj49r+4=; b=FFN5aJJfWNG4zq/Siw8uLSIZoiybeSfC+hYPrtdDZuuOS
        o7BD5tF5YkglbdMRl7/iSjoWioOkIv7QA9p5Ov1JA9KnKIIC5B5ULIgzicXp0dUH
        8ghYgD/gSRwO2+WfOMZ2cX8vMo8xANb24i3F4agxsTBODlchtgTWud/hLTB2QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=HCnEMTq
        Qg4eUiOYLuM4n3bScqDM9FCD1ZhzW9NdMvTxSnAYsJ220ymFmcvU2CRNqKdmW32r
        KtBlxL310eI7BtXzaxvfnBX3tqBi+F3s7H+3hPDCTTT6OkJt7J7mzBW+kwlKRbdv
        fQRIFh1l4iUOyneYSg1uKWDttJ8azxjDpwWE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 509283E031;
        Sun,  1 Dec 2019 13:32:06 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FE193E030;
        Sun,  1 Dec 2019 13:32:05 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sun, 1 Dec 2019 13:32:03 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
Message-ID: <20191201183203.GC17681@pobox.com>
References: <20191130004653.8794-1-tmz@pobox.com>
 <87a78ddc9o.fsf@hase.home>
 <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com>
X-Pobox-Relay-ID: E00BF588-1468-11EA-8390-D1361DBA3BAF-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
>=20
>> On Nov 29 2019, Todd Zullinger wrote:
>>
>>> When the 'grep with invalid UTF-8 data' tests were added/adjusted in
>>> 8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019-07-2=
6)
>>> and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
>>> 2019-07-26) they lacked a redirect which caused them to falsely succe=
ed
>>> on most architectures.  They failed on big-endian arches where the te=
st
>>> never reached the portion which was missing the redirect.
>>
>> It's not about big vs little endian, it's only about JIT vs non-JIT.
>=20
> So, which one of JIT / non-JIT sides did the test fail unexpectedly?

On s390x, the initial:

    test_might_fail git grep -hi "=C6" invalid-0x80 >actual

fails to produce any output in actual, but since we use
test_might_fail, the test happily continues to:

    test_cmp expected actual

which fails.

The test output from and s390x build:

    expecting success of 7812.11 'PCRE v2: grep non-ASCII from invalid UT=
F-8 data with -i':
        test_might_fail git grep -hi "=C6" invalid-0x80 >actual &&
        test_cmp expected actual &&
        test_must_fail git grep -hi "(*NO_JIT)=C6" invalid-0x80 &&
        test_cmp expected actual
    ++ test_might_fail git grep -hi =C6 invalid-0x80
    ++ test_must_fail ok=3Dsuccess git grep -hi =C6 invalid-0x80
    ++ case "$1" in
    ++ _test_ok=3Dsuccess
    ++ shift
    ++ git grep -hi =C6 invalid-0x80
    fatal: pcre2_match failed with error code -22: UTF-8 error: isolated =
byte with 0x80 bit set
    ++ exit_code=3D128
    ++ test 128 -eq 0
    ++ test_match_signal 13 128
    ++ test 128 =3D 141
    ++ test 128 =3D 269
    ++ return 1
    ++ test 128 -gt 129
    ++ test 128 -eq 127
    ++ test 128 -eq 126
    ++ return 0
    ++ test_cmp expected actual
    ++ diff -u expected actual
    --- expected    2019-10-19 21:56:08.634252012 +0000
    +++ actual      2019-10-19 21:56:08.714252012 +0000
    @@ -1 +0,0 @@
    -=E6var
    error: last command exited with $?=3D1
    not ok 11 - PCRE v2: grep non-ASCII from invalid UTF-8 data with -i
    #
    #               test_might_fail git grep -hi "=C6" invalid-0x80 >actu=
al &&
    #               test_cmp expected actual &&
    #               test_must_fail git grep -hi "(*NO_JIT)=C6" invalid-0x=
80 &&
    #               test_cmp expected actual
    #
    # failed 1 among 11 test(s)

After Andreas' missing redirect fix, that still fails on
s390x (not surprisingly).  But now systems with JIT enabled
fail at:

    test_must_fail git grep -hi "(*NO_JIT)=C6" invalid-0x80 >actual &&
    test_cmp expected actual

Though we say that the command must fail, so we shouldn't be
surprised that 'expect' and 'actual' don't match.  It would
be more surprising if they did. :)

> Should I do s/on big-endian arches/with PCRE with JIT disabled/
> while queuing the patch?

Here's how I changed the commit message locally.  I was
going to wait a day or so for any other feedback on the
actual test changes, being a holiday weekend in the US (and
more generally a weekend).

1:  d9aeaf0c98 ! 1:  d0c083db78 t7812: expect failure for grep -i with in=
valid UTF-8 data
    @@ Commit message
         8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019=
-07-26)
         and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed match=
ing,
         2019-07-26) they lacked a redirect which caused them to falsely =
succeed
    -    on most architectures.  They failed on big-endian arches where t=
he test
    -    never reached the portion which was missing the redirect.
    +    on most systems.  The 'grep -i' test failed on systems where JIT=
 was
    +    disabled as it never reached the portion which was missing the r=
edirect.
    =20
    -    A recent patch add the missing redirect and exposed the fact tha=
t the
    -    'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' test f=
ails on
    -    all architectures.
    +    A recent patch added the missing redirect and exposed the fact t=
hat the
    +    'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' test f=
ails
    +    regardless of whether JIT is enabled.
    =20
         Based on the final paragraph in in 870eea8166:

Thanks for pointing out the proper reasoning to use in the
commit message Andreas.  I hadn't looked at the Fedora pcre2
package to see that it explicitly disables JIT on s390x.

I'm not sure if s390x is supported upstream or not -- it
doesn't appear to have a specific entry in the sljit config
header=B9, so it seems likely it's not well-tested at the
least.  (Not that any of that is our concern here.)

=B9 https://github.com/zherczeg/sljit/blob/master/sljit_src/sljitConfigIn=
ternal.h

Thanks for the follow-up Junio.

--=20
Todd

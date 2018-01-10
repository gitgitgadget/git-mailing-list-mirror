Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518711F404
	for <e@80x24.org>; Wed, 10 Jan 2018 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeAJWJQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 17:09:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60257 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeAJWJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 17:09:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED1C0B8C7C;
        Wed, 10 Jan 2018 17:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d3d9rkT1nq0x
        VXEwDGXbIALTxls=; b=hBjhsfBfmL5Utq1vDVdnHGQh4es7LNBlEVo0frUgbhpa
        JR+6vSBxKmXGzwfcoJig5FcqHe/R2E2smUTfvWrjYpjsZU0yz7DaqRaULQdkFORN
        Kkbm91+DFy95wLPROiW+fG+9i1MC3X6HSYKTwKF/PUoXVpTFb0ZtFFihQkNcLA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Q3Zofl
        cigyAitqwlITP3REbXqsPURAodcijN3+ENgeaJPZWDhml6zGpgNRj6+RrlMxv/6+
        4SumAjueW2Yc4eYonAYI7XJHWbgwF1PETQhMUri6GNM30Ppi76ftHka2d/yRg3Ej
        QsOL8d69RPK7scqVm5SErPy2EnxPcjFKrWfLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5934B8C7B;
        Wed, 10 Jan 2018 17:09:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59DD7B8C7A;
        Wed, 10 Jan 2018 17:09:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] cat-file doc: document that -e will return some output
References: <20180110125554.12582-1-avarab@gmail.com>
        <20180110125554.12582-2-avarab@gmail.com>
        <xmqqtvvtz95g.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 10 Jan 2018 14:09:13 -0800
In-Reply-To: <xmqqtvvtz95g.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 10 Jan 2018 13:38:51 -0800")
Message-ID: <xmqqk1wpz7qu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4C31F60-F652-11E7-A410-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The -e option added in 7950571ad7 ("A few more options for
>> git-cat-file", 2005-12-03) has always errored out with message on
>> stderr saying that the provided object is malformed, currently:
>>
>>     $ git cat-file -e malformed; echo $?
>>     fatal: Not a valid object name malformed
>>     128
>>
>> A careful reader of this documentation would be mislead into thinking
>> the could write:
>>
>>     if ! git cat-file -e "$object" [...]
>
> It is arguable if such a reader is careful or careless.  I'd rather dro=
p
> s/careful // there ;-)

Actually the phrasing around here was a bit strange, and I ended up
rewriting a bit more.

    cat-file doc: document that -e will return some output
   =20
    The -e option added in 7950571ad7 ("A few more options for
    git-cat-file", 2005-12-03) has always errored out with message on
    stderr saying that the provided object is malformed, like this:
   =20
        $ git cat-file -e malformed; echo $?
        fatal: Not a valid object name malformed
        128
   =20
    A reader of this documentation may be misled into thinking that
   =20
        if ! git cat-file -e "$object" [...]
   =20
    as opposed to:
   =20
        if ! git cat-file -e "$object" 2>/dev/null [...]
   =20
    is sufficient to implement a truly silent test that checks whether
    some arbitrary $object string was both valid, and pointed to an
    object that exists.
   =20
    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12356C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10E920825
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mmkk+mbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgKPTji (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:39:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51413 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgKPTji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 14:39:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B9D195E7B;
        Mon, 16 Nov 2020 14:39:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1qN2Y9B3ZDCT
        h5y9K9jSsW3Dn/U=; b=mmkk+mbHWBr60ZZge1g1gVJI1GVybOp6y3Cu6sCdrWaC
        Qj3eXWoJK+aulPGez7yFtr0JbNtsRPJYn7Er3JNHUZKCyvXRuseb77VCCFN2IRJo
        zbWMakRfxcdJ2fTSErYhqq5cHocbodF2iulKUkCp4Sol2iP6DWIQT57sjvsWTtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nvjaIK
        cnA2bi/3SpxD1Grsa/kWGokpdadO+v+gR1qAjzdga5AqH4qBqtaCe6wlzCuAIs8f
        b+g/T784Q70ONM3KjOVzdZlm1OwVyzLC4A6JiJzfZorrh7T/i44LuThe989tUd5o
        AZ04m3NqDd7X/Q1lc6dijy+1FBXu2hpiqy0OE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71F2995E7A;
        Mon, 16 Nov 2020 14:39:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF2A195E79;
        Mon, 16 Nov 2020 14:39:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
References: <cover.1605269465.git.ps@pks.im>
        <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
        <87mtzlflw7.fsf@evledraar.gmail.com>
Date:   Mon, 16 Nov 2020 11:39:35 -0800
In-Reply-To: <87mtzlflw7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 13 Nov 2020 14:04:40 +0100")
Message-ID: <xmqqy2j1851k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 753F7762-2843-11EB-BB26-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Nov 13 2020, Patrick Steinhardt wrote:
>
>> While not document, it is currently possible to specify config entries
>
> "While not documented..."
>
>> +		strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
>> +		if ((key =3D getenv(envvar.buf)) =3D=3D NULL)
>> +			break;
>
> The convention in git.git is to avoid explicit NULL checks. So maybe
> something like this, which also avoids the assignment inside an "if"
>
>     key =3D getenv(envvar.buf);
>     if (!key)
>         break;

All good suggestions, but...

"While not documented" yes, for sure, but we do not document it for
a good reason---it is a pure implementation detail between Git
process that runs another one as its internal implementation detail.

I especially do not think we want to read from unbounded number of
GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
script cleanse its environment to protect itself from stray such
environment variable pair?  Count up from 1 to forever?  Run "env"
and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
some environment variables have newline in its values?)


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5392C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7089823B51
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgLJAAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:00:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52464 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgLJAAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:00:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8ADB8998A;
        Wed,  9 Dec 2020 19:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FtPXhU3D0CxF
        bP1d9AzUzX4i9oo=; b=eHtVIUvZiz+Rcqgul5f3mSQ1HLxIVi3WYO9GB0YWAqyq
        +XrnDjJLBoCzXgQUYTBhK01Zj9Wawrnbp42kZEaLkaGFEb8e3XLLBMBsyE2W4Jgo
        srCLMtztTsmFrZRyvIhLIWtSz4MR55npprYK8xJh6uu/14SwjWkOPK6yORQ/V/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EPrjYg
        ZUKbMzYqN9M6QL9w5PFePQnsAX3CCP5j2zVg0kPsXrHEi/uGrT0f1gNEMTBJqNyl
        e/oHvmM6V8GGn0T3DJYbsP9uW41um5cPYPzZeM7TfZVlTmkBM9/8J+3sXchbu3vi
        RiqwXeMTEpEu5qX/uO97fDQTS20OOUBDEv8d8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2E7B89985;
        Wed,  9 Dec 2020 19:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F9A789981;
        Wed,  9 Dec 2020 19:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im> <cover.1607514692.git.ps@pks.im>
        <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
        <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
Date:   Wed, 09 Dec 2020 16:00:08 -0800
In-Reply-To: <X9D23LQv34A5Q5DC@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 9 Dec 2020 11:10:04 -0500")
Message-ID: <xmqqy2i6zg1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC077062-3A7A-11EB-906F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 09, 2020 at 12:52:26PM +0100, Patrick Steinhardt wrote:
>
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> In case we want it, this is also:
>
>   Signed-off-by: Jeff King <peff@peff.net>
>
>> +--config-env=3D<name>=3D<envvar>::
>> +	Pass a configuration parameter to the command. The <envvar>
>> +	given will be replaced with the contents of the environment
>> +	variable of that name. In contrast to `-c`, an envvar must
>> +	always be given and exist in the environment. Passing an
>> +	environment variable with empty value will set <name> to the
>> +	empty string which `git config --type=3Dbool` will convert to
>> +	`false`.
>
> I agree with =C3=86var that we probably should keep an empty variable a=
s the
> empty string. I think some options use an empty string to clear a list
> (e.g., push.pushOption), and I'm not sure how they'd react to a bool
> instead. It would be nice to also have a way to do the implicit-bool
> thing, but I don't think it's strictly necessary (it's always correct t=
o
> put the string "true" into the variable instead).
>
> I think we should also document that <envvar> can't contain an "=3D" si=
gn.
> Of course using strrchr() here doesn't help much with just this patch,
> because we flatten the string before stuffing it into
> $GIT_CONFIG_PARAMETERS, so the reading side would mis-parse it.
>
> But here's a fix for that. I built it on top of your whole series, sinc=
e
> you touched some of the related functions, but it could easily be
> rebased onto just this part.

Hmph, so=20

 (1) Patrick's 1 & 2 are about adding --config-env,

 (2) These three patches can come on top to make it more robust to
     pass key=3Dvalue with GIT_CONFIG_PARAMETERS (including what is
     added via the --config-env=3Dname=3Denvvar), and

 (3) The remainder of Patrick's 6-patch series is to further add the
     pairs of environment variables to pass keys and values?

I am still not sure if we want the last part, but whether we take
(1) or (3) or neither or both, (2) sounds like a good thing to do.
And (2) would not shine without (1).  In the traditional use of -c,
we do not know which =3D from the end user separates key and value,
but when (1) places a =3D to separate the <name> and the value in the
environment variable, we know where that =3D is and can quote
accordingly.

But these three patches are done on top of (1) and (3), at least for
now.

The above is my understanding of the state of these patches.  Am I
getting it right?

Thanks.

>   [1/3]: quote: make sq_dequote_step() a public function
>   [2/3]: config: parse more robust format in GIT_CONFIG_PARAMETERS
>   [3/3]: config: store "git -c" variables using more robust format
>
>  config.c          | 118 +++++++++++++++++++++++++++++++++++++---------
>  quote.c           |  15 ++++--
>  quote.h           |  18 ++++++-
>  t/t1300-config.sh |  60 +++++++++++++++++++++++
>  4 files changed, 183 insertions(+), 28 deletions(-)
>
> -Peff

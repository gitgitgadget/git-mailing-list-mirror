Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A3C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C4820728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPz/i2SE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgDXAkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:40:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65473 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:40:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75208CC173;
        Thu, 23 Apr 2020 20:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bnS28HmZSGme
        5jfCh9/NaVO3Hnk=; b=VPz/i2SEX1hAK+YUuWKn4kLIY5lK8xqklhu1tV2Gkb8F
        01FEuOkOU2r231ZKOO2W08SaPEoRvntnHlNjjuWfvWgTHFH8BjAH6r+TxBXkJKf3
        6Q7nEMzW+bMlJ7ewgkr7wKPBWlDnB61rzLjqDyw/Nep93OFelYabbDWkP1AOdDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Yyoe6E
        BjYPbyXfXE0WUwHc7iSm1gnz+/sWPTRN28Ps9CC4bJx4hPs0TS3lLlDPH7I3TpzC
        8++whtX5GRCsdPmIqdMR3d1tYV4Vx4kEmWl1dUNwjVMRB7Z6S5qsMW+pxFWUOcrA
        2K2xpd4tSQPMLl9mBR/QVgaP3XtHeOgcY1QCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CAF0CC172;
        Thu, 23 Apr 2020 20:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7763CC171;
        Thu, 23 Apr 2020 20:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] credential: handle `credential.<partial-URL>.<key>` again
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>
        <20200424000558.GB20669@Carlos-MBP>
        <xmqqpnbxen6h.fsf@gitster.c.googlers.com>
Date:   Thu, 23 Apr 2020 17:40:07 -0700
In-Reply-To: <xmqqpnbxen6h.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 23 Apr 2020 17:34:46 -0700")
Message-ID: <xmqqlfmlemxk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 261BF1FA-85C4-11EA-B912-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
>> On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via GitG=
itGadget wrote:
>>> diff --git a/credential.c b/credential.c
>>> index 52965a5122c..3505f6356d8 100644
>>> --- a/credential.c
>>> +++ b/credential.c
>>> @@ -53,7 +53,13 @@ static int credential_config_callback(const char *=
var, const char *value,
>>>  		char *url =3D xmemdupz(key, dot - key);
>>>  		int matched;
>>> =20
>>> -		credential_from_url(&want, url);
>>> +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
>>
>> definitely not worth a reroll, but just wondering if would make sense =
to call
>> credential_from_url_gently(!quiet) here, just for consistency?
>
> Speaking of which, it is not clear which one of "...url, 1, 0)" is
> the "quiet" bit.  I somehow thought that somebody suggested to roll
> these two into a flags word and give quiet and the other bit a name,
> and after seeing this line, I tend to agree that would be great for
> readability.

Ah, I should have checked before opening my mouth.  It was this
message <20200422233854.GE140314@google.com> from Jonathan Nieder.

I also am OK with his "two thin wrappers around the underlying
helper that takes two separate arguments", if that makes the
resulting code easier to follow.  I have a feeling that the caller
knows (from the context, or the reason why it calls the
credential-from-url code) if it wants strict or nonstrict variant
and that is not something the caller is told from its caller.  And
if that is the case, "two thin wrappers" approach does make a lot of
sense.

Thanks.

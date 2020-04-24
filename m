Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C08C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB18D21473
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P7ZatrdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgDXAex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:34:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60586 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:34:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 595EFCEC1D;
        Thu, 23 Apr 2020 20:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ucAFIplbBDUZ
        WCxQzifVdiygFNc=; b=P7ZatrdHTyg2P4cU3bYHJd7IlBQ7XRBtfMvVkUfdpbFa
        fymK9SA7ADlx7ZgNGy+/VJGOXnrmZjLrKTRvlULbwf8NAJ8ZNVJ7SJUojoIrV2nr
        8CDB1O1p+PaHyt8sBSdnFf5DhlqYycyLjcLoQHXleB6d0U1eSQuxryAQhha2HXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kLoXJ2
        eQWB4J7k46f1gX5EkxQfmb+iYg5CRd3roweVmVDDnXsjQ1XRLdkU/Unrv8qnL2JQ
        FUYvk9nJtqfnxAI2WVZdsISlpXhh2+4UT52cS01YELHc1qsw7C/higFYenS39fcE
        mfmCpNwAWuDmHrHj3mGF4zBUvalcN6H2bdxjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 511C5CEC1C;
        Thu, 23 Apr 2020 20:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CAF1CEC1B;
        Thu, 23 Apr 2020 20:34:48 -0400 (EDT)
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
Date:   Thu, 23 Apr 2020 17:34:46 -0700
In-Reply-To: <20200424000558.GB20669@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 23 Apr 2020 17:05:58 -0700")
Message-ID: <xmqqpnbxen6h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 674F035C-85C3-11EA-804E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via GitGi=
tGadget wrote:
>> diff --git a/credential.c b/credential.c
>> index 52965a5122c..3505f6356d8 100644
>> --- a/credential.c
>> +++ b/credential.c
>> @@ -53,7 +53,13 @@ static int credential_config_callback(const char *v=
ar, const char *value,
>>  		char *url =3D xmemdupz(key, dot - key);
>>  		int matched;
>> =20
>> -		credential_from_url(&want, url);
>> +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
>
> definitely not worth a reroll, but just wondering if would make sense t=
o call
> credential_from_url_gently(!quiet) here, just for consistency?

Speaking of which, it is not clear which one of "...url, 1, 0)" is
the "quiet" bit.  I somehow thought that somebody suggested to roll
these two into a flags word and give quiet and the other bit a name,
and after seeing this line, I tend to agree that would be great for
readability.

> other than that this series is looking great, under the assumption that=
 there
> is going to be some more followup with non essential changes.
>
> will chip in with an test helper for that series so we can hopefully ke=
ep our
> sanity next time someone touches that function again.

Thanks, everybody, for help polishing this topic.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9FB1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfEOBM0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:12:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfEOBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:12:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EC7B69021;
        Tue, 14 May 2019 21:12:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=z3BpYfhHfVvbi
        JUnXsG2p+7hLRs=; b=ZnCeSoaIuWQfSxUManzdAXww5ejSXuwelf97q8zA4XRGY
        o8RIJpz7UCyPNjbsG2wbeDHpy5MbTwmSKkAdT7fgIZ3z2M9liKxklKZc9PeeQJ+1
        7JbhHNjc6ArxwsvWQVbvdOpPClPT4F2ZuGw+oAz6hM0ax9yDmKU6gPY4fvq/Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=AJyYalv
        wyR8N5/qp6ZVAJYAmts9uWET6gqdT38zO9kCTSADnP4YKiwVcrH24ih/3xMfZUcv
        0U7dmWzcJkKZXPwVaaEEz7nMwdh/dSdx2VU0TW0l3imYg/+L858p5Izh5EnXZMWe
        QaPCmQ4hC+4NHrbykGyzazm6vpKjRVO6hTm8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4824569020;
        Tue, 14 May 2019 21:12:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE0AC6901D;
        Tue, 14 May 2019 21:12:20 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 14 May 2019 21:12:18 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190515011217.GN3654@pobox.com>
References: <20190514020520.GI3654@pobox.com>
 <20190514021419.GI7458@genre.crustytoothpaste.net>
 <20190514084534.GA9567@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190514084534.GA9567@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 7D834DF6-76AE-11E9-A4A9-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, May 14, 2019 at 02:14:19AM +0000, brian m. carlson wrote:
>=20
>> On Mon, May 13, 2019 at 10:05:20PM -0400, Todd Zullinger wrote:
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 908ddb9c46..599fd70e14 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -1522,7 +1522,7 @@ test_lazy_prereq NOT_ROOT '
>>>  '
>>> =20
>>>  test_lazy_prereq JGIT '
>>> -	type jgit
>>> +	jgit --version
>>>  '
>>=20
>> I think this is an improvement, not only because of the reasons you
>> mentioned, but because we remove the use of "type", which is not
>> guaranteed to be present in a POSIX shell.
>
> Isn't it?

I wondered the same thing, but I know I am not nearly as
familiar with the POSIX rules as any of you.

> I have always treated it as the most-portable option for this
> (compared to, say, `which`).  It is in POSIX as a utility (albeit marke=
d
> with XSI), which even says (in APPLICATION USAGE):
>=20
>   Since type must be aware of the contents of the current shell
>   execution environment (such as the lists of commands, functions, and
>   built-ins processed by hash), it is always provided as a shell regula=
r
>   built-in.
>=20
> All that said, I think Todd's patch makes perfect sense even without
> wanting to avoid "type".

Yeah, `which` surely isn't a portable option.  I presumed
`type` must be fairly widely available since it was in the
test suite since you added it way back in 212f2ffbf0 ("t:
add basic bitmap functionality tests", 2013-12-21).

I usually make use of `command -p -v $foo` in scripts that
need to be portable across systems.  But I don't have access
to many esoteric systems.

Based on Junio's follow-up, I think we can avoid adding
anything to the commit message about the use of `type` here.
That way no one will take it as a sign that we should remove
other uses of it just for conformance.  (I will send a
follow-up with an update based on Jonathan and =C6var's
comments.)

Thanks to all of you.

--=20
Todd

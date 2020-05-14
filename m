Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21174C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66502065C
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bn6NB+/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgENXEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 19:04:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgENXEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 19:04:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82B54C6D09;
        Thu, 14 May 2020 19:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V7W/0JALAF8v
        clTZK6gHVhUlP3A=; b=Bn6NB+/+slvRedEywHiumLhW1KfTtUyDON0/k0n4pEpE
        rz7eb2+16Dji6DWoJxA0d+1A0x3T+Le1D4SOZb2DM23/JVoBvzatdgW1dkE8m/9E
        LLzaLtU8sa07NcqG3EcTB35HXbkuQApLDNbb8w6okrOmHDBDvXBTcg575zfqOnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sEAjPt
        8QSgs45Sfw1USPXS5sFGxOjzfXv5RT2Mc7r8GV235TprZkSe4SgVKqUTiwXZEM9Y
        QnfLLaQ0m5vMQihjYLPg1OWJ4GorKI44ArJjUr31p2aiuDEP/pNFQM2u0SxQTHSD
        XwzU5NK1QS/B9a21VnYkDvGbRHNcLIxRfvSgE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79F91C6D07;
        Thu, 14 May 2020 19:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6DB2C6D06;
        Thu, 14 May 2020 19:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
References: <20200514210518.56101-1-carenas@gmail.com>
        <20200514225514.GA6362@camp.crustytoothpaste.net>
Date:   Thu, 14 May 2020 16:04:39 -0700
In-Reply-To: <20200514225514.GA6362@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 14 May 2020 22:55:14 +0000")
Message-ID: <xmqq5zcyp188.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4AA13DB8-9637-11EA-AA03-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-14 at 21:05:18, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> 4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
>> 2020-04-14) introduces check_host_and_path to t0300 and some tests tha=
t
>> use it, but fail in at least FreeBSD 9.3.
>
> From FreeBSD's website, it looks like the production releases are 11.3
> and 12.1.  9.3 is EOL and has been since 2019.  Since FreeBSD is not
> supporting this release with security updates, nobody should be using
> it.  In light of that, do we need this patch?

Perfect comment given on the day I am cutting -rc0---the fewer
patches I need to worry about, the better ;-).

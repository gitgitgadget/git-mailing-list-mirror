Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701EF20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbdASS05 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:26:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64162 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753966AbdASS05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3C9D5EE2C;
        Thu, 19 Jan 2017 13:22:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6G1BBQMq9hyf
        sgy+7d0PJq6MTfU=; b=EiqaicmjIMJTjHDcOjwVe1o8bM25sQ7rsBsRoIzOKOQT
        0kcFlEMAOeSD4CmC6AuxrMgRo81+Cbcu/LQh3eV29vepAsvryZdixA9+2lbF/dcI
        GUYSZeP9cKpAF4GmoBhMqaHjO3m8ecwCwpqWaiQNMfvVLULNzKp8eSJU8IqEvgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=swisTT
        9u8KLVTHDprEjCHDq7bUlMrCKX9gLNuVnCYapCnY20TUAeqBJTXH1gAsUXEIas3V
        jJsm9bNHCwI10G161mCu6EiksCtvInmHxdKRYWwUdvScCVLaT83aKzdHz5zzIhsw
        yhGT5hs0VuY0d7IosjrXbz29jbA+OxDwJslNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5385EE2B;
        Thu, 19 Jan 2017 13:22:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31FFC5EE2A;
        Thu, 19 Jan 2017 13:22:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] color.c: trim leading spaces in color_parse_mem()
References: <20170109103258.25341-1-pclouds@gmail.com>
        <20170119114123.23784-1-pclouds@gmail.com>
        <20170119114123.23784-3-pclouds@gmail.com>
        <20170119164157.mvoadhxxwwynedoz@sigill.intra.peff.net>
Date:   Thu, 19 Jan 2017 10:22:53 -0800
In-Reply-To: <20170119164157.mvoadhxxwwynedoz@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Jan 2017 11:41:57 -0500")
Message-ID: <xmqq60la3o5e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BE50E3A-DE74-11E6-B4E3-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 19, 2017 at 06:41:22PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> Normally color_parse_mem() is called from config parser which trims th=
e
>> leading spaces already. The new caller in the next patch won't. Let's =
be
>> tidy and trim leading spaces too (we already trim trailing spaces befo=
re
>> comma).
>
> What comma? I don't think that exists until the next patch. :)
>
> I think just trimming from the front is OK, though, because
> color_parse_mem() trims trailing whitespace after a word. So either you
> have a word and we will trim after it, or you do not (in which case
> this will trim everything and hit the !len case you added).
>
> So maybe a better commit message is just:
>
>   Normally color_parse_mem() is called from config parser which trims
>   the leading spaces already. The new caller in the next patch won't.
>   Let's be tidy and trim leading spaces too (we already trim trailing
>   spaces after a word).
>
> -Peff

Yeah, my reading stuttered at the same place in the original, and
your rewrite looks a lot more sensible.

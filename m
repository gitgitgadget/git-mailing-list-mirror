Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DE1C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3AE2166E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KcLfp9aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXUUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:20:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59299 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUUo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:20:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BC26D5709;
        Fri, 24 Apr 2020 16:20:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g5vNPIn6iZUi
        dUlSA0ImYjmq5IQ=; b=KcLfp9aLBfsn7jkoWavUlwWEr52t4P3gsNc5iK72h6rH
        3wl3y8ufdO/uaemTkpJX1jZMD1aosQqeg/wnMsWha9nq8+GMOafIORPeLibtNfgk
        bXneFJxqUcok6C5gCVkuuMwTPHRIVk1OLWp7XTfBoPnKPwxVV812K4+onNxEyWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tCeFFZ
        vsiyCtBm1HTxjpWmoEGtVRnncxGEhLyfvq54MSxJmYa5VTFxu/IDhRLETiKAABb+
        R4F3AQrvPjoFVSwlygYi2h8f7cEC4cto8PDIK6GhlYMtHurZmVZREVaWdfAsPV3p
        rdhoekl5D8wO91cXZk2Z5pbeicdeR5ieNldPE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 431F2D5707;
        Fri, 24 Apr 2020 16:20:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D5B6D5706;
        Fri, 24 Apr 2020 16:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v2] credential: fix matching URLs with multiple levels in path
References: <20200421225837.GB3515235@coredump.intra.peff.net>
        <20200422195109.2224035-1-sandals@crustytoothpaste.net>
        <20200424045030.GA44448@Carlos-MBP>
Date:   Fri, 24 Apr 2020 13:20:37 -0700
In-Reply-To: <20200424045030.GA44448@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 23 Apr 2020 21:50:30 -0700")
Message-ID: <xmqqeescd4a2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1092D10A-8669-11EA-9D04-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Wed, Apr 22, 2020 at 07:51:09PM +0000, brian m. carlson wrote:
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -378,11 +378,15 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
>>   */
>>  void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strb=
uf *src);
>> =20
>> +#define STRBUF_PERCENTENCODE_PATH 1
>> +
>>  /**
>>   * Append the contents of a string to a strbuf, percent-encoding any =
characters
>>   * that are needed to be encoded for a URL.
>> + *
>> + * If STRBUF_PERCENTENCODE_PATH is set in flags, don't percent-encode=
 slashes.
>>   */
>
> wouldn't it be better to call this STRBUF_PERCENTENCODE_SLASH instead?,=
 since
> it is actually not applied to path?

I was about to say the same thing.  Can we phrase it a bit shorter
than PERCENTENCODE, by the way?

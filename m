Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72BEA20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbdHQRIC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:08:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54837 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbdHQRIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:08:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4ED7A69EF;
        Thu, 17 Aug 2017 13:07:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2Zb6vi/VUL4m
        SWbmIYS2gcN/yZI=; b=E0wlv/FGzRtjZzQWeUID9C6bThVbSGzLIvZJN4DCb3as
        CVqsQzSzfEHRiyRLP3k2TTexWfCLHCZWDz0WBbwtLyMKmDHGnQSxXY9ScUYXpzEI
        zbg58GylonTeXgtU8242a7RasuEta3VEiFCjIVN6e/0AeZQHUZ/w+gGj2AWQmDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hIm3ha
        87GXxK5DHxwbgy82IJZgzHsaFVnJfNXvuhtu9uGKt+cWlvTTnpTSKTZ1HT2sYA7M
        1UP96g3LLDp4GZaYgjN4CvfHOTq4IlkeH37nRIsUtFGVKUX9jdwlkuW4I0CzcsDw
        hnlWC4QtFBO+513QT9KwdK2XU8LjX4ZJPlr7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADD0DA69EE;
        Thu, 17 Aug 2017 13:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12A8EA69ED;
        Thu, 17 Aug 2017 13:07:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about no-index case
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
        <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
        <20170817062450.GA28592@tor.lan>
        <xmqqbmneis63.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 17 Aug 2017 10:07:53 -0700
In-Reply-To: <xmqqbmneis63.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 17 Aug 2017 00:12:36 -0700")
Message-ID: <xmqq7ey2i0ly.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9C5A92DC-836E-11E7-9CC9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Unless we re-define the meaning of "NULL" into "don't do CRLF conversi=
ons,
>> like SAFE_CRLF_KEEP_CRLF does.
>
> My preference is not to use NULL as any hint.  Instead, the "flag"
> parameter we already pass to convert_to_git(), just like the updated
> read_old_data() uses SAFE_CRLF_KEEP_CRLF to tell it that it should
> not disturb existing CRLF without looking at the istate, should be
> used to tell convert_to_git() to do the opposite, but do so without
> looking at the istate.
>
> Perhaps SAFE_CRLF_FALSE should be such a flag.  Or perhaps we need
> to invent another flag.  I dunno.

I grepped for SAFE_CRLF_FALSE and found only two callers that
explicitly pass it down the callchain, both of which essentially
says "if we are writing the object out, use core.safecrlf, but if we
are merely hashing, do SAFE_CRLF_FALSE thing". =20

I think their use case is quite similar to the codepath we are
discussing---they have a data that come from the outside world, and
they know the index entry that happens to be at the path has nothing
to do with the data they are asking convert_to_git() to massage
(i.e. it is _wrong_ if the contents of the blob that happens to be
in the index at the path affected the outcome of the conversion).

So I think the fix to convert_to_git() can just use SAFE_CRLF_FALSE
as such an instruction that tells the function not do the "safe
crlf" thing, which looks at the contents in the index and decide if
the CRLFs in the contents being converted should be turned into LFs.
And because the function is told not to look at the index, it should
be made safe to pass istate=3DNULL.  There does not seem to be a need
to invent another flag.

Thanks.




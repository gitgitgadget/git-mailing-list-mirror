Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771CC433E2
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A95E61A3B
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCYSQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:16:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCYSQO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 14:16:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E00A010D406;
        Thu, 25 Mar 2021 14:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lCxDBbKU+b/r
        VO01fajbGaUElx4=; b=cm28YDkwucL7BYqHOAZwvKIQvpSrPnUzxvIqwwiGSUzo
        SiysGi3CnVbh2LBPBpN7tGob97qjslYx+I8i4xV3yQRpJrYj8xFwXQjcwWoErDKm
        dGAXiO4w+0XWTXQX/9EbRjC49S3KsHhixmQ1vvjGRfh+jNzroKQ5PVZnljX5kRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fvP6yZ
        3sNH5/PR+hKusyJ0xAhpDKQhRffMEOUimaTcnuKmx7zWqzQLa/IZV2L7POePzAJ8
        /UVlXeqJOsOc3rriEsL3WdEPUOC0jDiD8dmvkYEEWD0J7tqsz3lWTfABWVIe7aRr
        brEKwnF6A10+qDkPOBeEWLlCPQwz7K9XeegWg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D80C410D405;
        Thu, 25 Mar 2021 14:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E71210D403;
        Thu, 25 Mar 2021 14:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
        <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
        <YCwJ8tORQg2Air4r@nand.local>
        <xmqqmtw3pzu3.fsf@gitster.c.googlers.com>
        <YCwhPG6RaAhU9ljg@nand.local>
        <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
        <xmqqsg4l3h32.fsf@gitster.g>
        <CAP8UFD0rRff7oCMH=DeTQ-tZw7STLwSHLecWxRr_rQVyHuxJuA@mail.gmail.com>
        <CAOLTT8TFTcw9fkfPk-vi3REtZqCWYS28LEP5jfy-TmYuWf747g@mail.gmail.com>
Date:   Thu, 25 Mar 2021 11:16:08 -0700
In-Reply-To: <CAOLTT8TFTcw9fkfPk-vi3REtZqCWYS28LEP5jfy-TmYuWf747g@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 25 Mar 2021 17:33:23 +0800")
Message-ID: <xmqqmturw13r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CDA930E-8D96-11EB-B377-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:54=E5=86=99=E9=81=
=93=EF=BC=9A
>>
>> Maybe it's not enough, but the doc already has the following:
>>
>> ------
>> Existing trailers are extracted from the input message by looking for
>> a group of one or more lines that (i) is all trailers, or (ii) contain=
s at
>> least one Git-generated or user-configured trailer and consists of at
>> least 25% trailers.
>> The group must be preceded by one or more empty (or whitespace-only) l=
ines.
>> The group must either be at the end of the message or be the last
>> non-whitespace lines before a line that starts with '---' (followed by=
 a
>> space or the end of the line). Such three minus signs start the patch
>> part of the message. See also `--no-divider` below.
>>
>> When reading trailers, there can be whitespaces after the
>> token, the separator and the value. There can also be whitespaces
>> inside the token and the value. The value may be split over multiple l=
ines with
>> each subsequent line starting with whitespace, like the "folding" in R=
FC 822.
>> ------
>
>
> Maybe I don't have enough right to speak on this issue, but I always th=
ink that
>  the empty line is intentional by the designer, especially when I test =
it.

People like you, who is relatively new to the system and the list,
are valuable source of information for us to learn where in the
current system and documentation we have room to improve and
clarify.  You do have right, and we welcome your input.

Care to clarify what you mean by "the empty line is intentional by
the designer"?  The designer of the current "trailer" intended to
make the "last paragraph" (where "paragraph" is defined as a run of
lines without an empty line in it, so that one or more continguous
empty lines separate "paragraphs") where the trailers sit in the log
message.  Is that what you mean?  Or something else?

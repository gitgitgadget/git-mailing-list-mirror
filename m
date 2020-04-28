Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F3C83007
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A178208FE
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+i+BweN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgD1SSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:18:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52118 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgD1SSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:18:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17933CED46;
        Tue, 28 Apr 2020 14:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JDKu9BddZ9hB
        cOwTx5oW1zx949I=; b=n+i+BweNgSZy2DdzWykgxnVpAosU4pId5P/BMYM+GduN
        hyUUXoYWCBuVMM8yhWW32vsKk2+k/VX5ATSzYEwjZta02mfdRmhxQExf7UJfUg6i
        4LaaBkngafMNn1tEYaF4sMykJ+tyfQ6wd8lzMTy351bo1XelnHPD0z3Xg23+zXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=im/FZR
        WQDc61+cFbY8wWWpq0brZllIt2IaKB9802VOeM8aKGM6B21/OJttEBvV6udmVEll
        NT2WHdR7vt+npRTUy+cqY5ue8yPv8JJSJIlwpESY/1vg22g0lfWgL1zaf1ywPl0r
        uBbeXobmFJQL1i2WoUH9V1HRplMhpGSqE9nAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FADECED45;
        Tue, 28 Apr 2020 14:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CDA4CED43;
        Tue, 28 Apr 2020 14:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/4] credential-store: document the file format a bit more
References: <20200428104858.28573-1-carenas@gmail.com>
        <20200428105254.28658-1-carenas@gmail.com>
        <CAPig+cSJDHhUDQ3PGQRen32w9-8xVVFijDDoC5nqzioBHSL7Yw@mail.gmail.com>
Date:   Tue, 28 Apr 2020 11:18:09 -0700
In-Reply-To: <CAPig+cSJDHhUDQ3PGQRen32w9-8xVVFijDDoC5nqzioBHSL7Yw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 28 Apr 2020 12:06:55 -0400")
Message-ID: <xmqqh7x3325a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9E510D66-897C-11EA-91CF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
>> Reading a malformed credential URL line and silently ignoring it
>> does not mean that we promise to torelate and/or keep empty lines
>> and "# commented" lines forever.
>>
>> Some people seem to take anything that is not explicitly forbidden
>> as allowed, but the world does not work that way.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/Documentation/git-credential-store.txt b/Documentation/gi=
t-credential-store.txt
>> @@ -94,6 +94,10 @@ stored on its own line as a URL like:
>> +No other kinds of lines (e.g. empty lines or comment lines) are
>> +allowed in the file, even though some may be silently ignored. Do
>> +not view or edit the file with editors.
>
> I suggest dropping the "even though some may be silently ignored" bit
> since it's both mysterious (providing no concrete information) and
> unnecessarily confusing since it flat out contradicts the earlier part
> of the sentence. The fact that the implementation has accidentally
> been loose in its parsing doesn't warrant introducing such ambiguity
> into the (newly-added) documentation.

I do not think it is an ambiguity.  The phrase is there just to
remind the readers that they are not allowed to take a loose
implementation in the past as an excuse to throw in crufts and
expect the result to continue working.

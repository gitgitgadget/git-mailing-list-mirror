Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486DDE93713
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJEUZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjJEUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:25:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33CE7
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:25:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB9421A312D;
        Thu,  5 Oct 2023 16:25:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=qtoUZwJA/7qm/achCpuo3lptUN6k1YjDuRy0FW
        zEYyk=; b=bLJeRAjS48qVYt4aTg+v605OohgYp9V5dC3xQtlBdn8/f9KanVPwx7
        OH7VTcl7HwRQFRCv10Y1Z8iq3D0Fnk5u81QUPeIvNVIvUY+LhaHFpnP6kSpIozwJ
        dMZl/xQseQVyoUiOfoHF18N3idA88DJbVmYAm+heqxT5X3jt3fNy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E08A31A312C;
        Thu,  5 Oct 2023 16:25:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 449BE1A312A;
        Thu,  5 Oct 2023 16:25:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] builtin/repack.c: implement support for
 `--max-cruft-size`
In-Reply-To: <ZR6nKzflu_18JnoG@tanuki> (Patrick Steinhardt's message of "Thu,
        5 Oct 2023 14:08:11 +0200")
References: <cover.1694123506.git.me@ttaylorr.com>
        <cover.1696293862.git.me@ttaylorr.com>
        <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
        <ZR6nKzflu_18JnoG@tanuki>
Date:   Thu, 05 Oct 2023 13:25:28 -0700
Message-ID: <xmqq4jj4izpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53EC0A40-63BD-11EE-B745-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:
> [snip]
>> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
>> index 90806fd26a..fa0541b416 100644
>> --- a/Documentation/git-gc.txt
>> +++ b/Documentation/git-gc.txt
>> @@ -59,6 +59,13 @@ be performed as well.
>>  	cruft pack instead of storing them as loose objects. `--cruft`
>>  	is on by default.
>>  
>> +--max-cruft-size=<n>::
>> +	When packing unreachable objects into a cruft pack, limit the
>> +	size of new cruft packs to be at most `<n>`. Overrides any
>
> We should probably mention the unit here, which is bytes.

Good suggestion.  I'll tweak "at most `<n>`" to "& bytes" or
something.

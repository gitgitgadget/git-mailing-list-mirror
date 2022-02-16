Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB9C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiBPRpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:45:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBPRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:45:24 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E32B100F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:45:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DBE51041B2;
        Wed, 16 Feb 2022 12:45:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/l4ZPP5jWQ0P
        0N2G9OkhXvCL/dWBYFN95NT+BUCBrfI=; b=iIMSpAAUklvXZVEdaCyK3J/5g5nE
        EYyLPMH8V3JmOIEkCQSlvh8yd3LDK9PWn9FGJ+MoDmk2O51fZX+oE3xANPDL3ojc
        TPntRUjP2vFSfKM9l2Mzuc6BEh4gEVQDg0IubZfaadKGmYjc6TeZc1w9LF0I1kwp
        SbxGzTCdKACSOW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68EC91041B1;
        Wed, 16 Feb 2022 12:45:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E02211041B0;
        Wed, 16 Feb 2022 12:45:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] date.[ch] API: split from cache.h, add API docs,
 stop leaking memory
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
Date:   Wed, 16 Feb 2022 09:45:07 -0800
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 09:14:00
        +0100")
Message-ID: <xmqqr182u2n0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EF1D3FC-8F50-11EC-A244-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> 2:  96c904d0b9a ! 2:  f73aa601e95 date API: create a date.h, split from=
 cache.h
>     @@ Commit message
>          use the "DATE_MODE()" macro we now define in date.h, let's hav=
e them
>          include it.
>     =20
>     +    We could simply include this new header in "cache.h", but as t=
his
>     +    change shows these functions weren't common enough to warrant
>     +    including in it in the first place. By moving them out of cach=
e.h
>     +    changes to this API will no longer cause a (mostly) full re-bu=
ild of
>     +    the project when "make" is run.
>     +

If this step were to include the new header in "cache.h" to reduce
the patch noise, and there were a follow-up step to update the *.c
files to include the new header while removing the inclusion of the
header from "cache.h", then the above would make a fine draft for
the log message that justifies that follow-up step.

But if we are doing these two things in a single step, the paragraph
would not make a very useful comment to help readers of "git log".

> 4:  3f70b1aa4c5 ! 4:  5c244960133 date API: add basic API docs
>     @@ date.h: struct date_mode {
>       struct date_mode *date_mode_from_type(enum date_mode_type type);
>      =20
>      +/**
>     -+ * Show the date given an initialized "struct date_mode" (usually=
 from
>     -+ * the DATE_MODE() macro).
>     ++ * Format <'time', 'timezone'> into static memory according to 'm=
ode'
>     ++ * and return it. The mode is an initialized "struct date_mode"
>     ++ * (usually from the DATE_MODE() macro).
>      + */
>       const char *show_date(timestamp_t time, int timezone, const struc=
t date_mode *mode);

OK.

> 5:  60dbadacb16 ! 5:  b1ee9a30913 date API: add and use a date_mode_rel=
ease()
>     @@ Commit message
>          release_revisions() in "revision.c", as they have to do with l=
eaks via
>          "struct rev_info".
>     =20
>     +    There is also a leak in "builtin/blame.c" due to its call to
>     +    parse_date_format() to parse the "blame.date" configuration. H=
owever
>     +    as it declares a file-level "static struct date_mode blame_dat=
e_mode"
>     +    to track the data, LSAN will not report it as a leak.

Ah, it is not even a leak, then.  Is blame the only thing that uses
parse_date_format() outside the revision walkers?

Thanks.

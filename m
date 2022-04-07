Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E814C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 20:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiDGUmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiDGUlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 16:41:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98020A388
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 13:27:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ECEE17E476;
        Thu,  7 Apr 2022 16:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JVI8SP3zjCU8
        dZlNsErMa80MslUU5bsIV2u5LL5xFi4=; b=EiEj4txCFQW4Tyz5L1g8hPZkgKZA
        wEsJeDK0wsjSjH3xcdsoYWJNNRT70+PCF5CwQ5w0lOJd35tIipAasctn0Dvl6XEb
        VZ/NJFQg7FLmvzSpUYV44AzPliUbLpOO6eQ51stmTRip+o/K7L4vVNl7hklt9gX1
        USQsUb3VD14MrJY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 480FC17E475;
        Thu,  7 Apr 2022 16:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98DCD17E474;
        Thu,  7 Apr 2022 16:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] doc txt & -h consistency: fix recent "cat-file"
 inconsistency
References: <patch-1.1-79404e05d73-20220407T185645Z-avarab@gmail.com>
Date:   Thu, 07 Apr 2022 13:27:42 -0700
In-Reply-To: <patch-1.1-79404e05d73-20220407T185645Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 7 Apr
 2022 21:08:59 +0200")
Message-ID: <xmqqv8vkr64h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2DDA8148-B6B1-11EC-8223-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH] doc txt & -h consistency: fix recent "cat-file" in=
consistency

IOW ...

> -'git cat-file' (--batch | --batch-check) [--batch-all-objects]
> +'git cat-file' (--batch | --batch-check | --batch-command) [--batch-al=
l-objects]

... we forgot to add "--batch-command" to the documentation, even
though we added it to the usage text in the source.

And explained that way, this change makes quite a lot of sense.

It could be a worthwhile longer-term goal to make it consistent
between the synopsis and the usage text", but we are far away from
such a goal.  I'd rather keep such a topic outside this focused fix.

Given that we have been pushing to stop listing individual options
in SYNOPSIS, and instead using <option> placeholder, and also list
different operation mode of a single command on separate lines,
between

    $ git commit -h 2>&1 | sed -e '/^$/q'
    $ git commit --help | sed -ne '/^SYNOPSIS/,/^$/p'

we would want to pick the one we have from the command (i.e. the
former) and update the documentation source for the latter.

    Side note: and no, we do not want to tie the documentation to a
    particular build too tightly, and it is a no-no to generate the
    documentation source from 'git cmd -h' output.  Even when an
    option is conditionally excluded from a particular build, I'd
    like to be able to build and publish documentation for wider
    audience than just to myself.

Somebody needs to go through the comparison of individual
subcommands and present a good plan.  I find that, in comparison
between the -h and --help output, neither is quite satisfactory for
"git bisect", for example.  It would be a huge task and would be a
distraction during the pre-release period.

Thanks.

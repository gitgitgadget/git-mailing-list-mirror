Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D48C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiFHQKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbiFHQKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 12:10:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D73AA7A
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:10:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40108190835;
        Wed,  8 Jun 2022 12:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9pSV8JU4QsVI
        N17d94sg0NZ2Kqz1RXrB4YQPOh//pfU=; b=ZHdqSFqJBjbS5akjuP9/5Hfyq49w
        JCiGZ3DqP99XJKRDTTaYxcptSMejhM8bt1lCCNaW9KsuLd8/syK+cb6Skyf+xmNR
        ojCyRzX38T+s3dxmc56faxQy/sYVyg/rv4hrnu6OVdZfj5NCOS/jFtlhZl34gE/m
        pD7SpAHDwflw9rw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38955190834;
        Wed,  8 Jun 2022 12:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9323190830;
        Wed,  8 Jun 2022 12:10:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
References: <cover.1654552560.git.me@ttaylorr.com>
        <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
        <220607.86r140vqc4.gmgdl@evledraar.gmail.com>
        <Yp+/eXNg4tjiCn5a@nand.local>
        <220607.86y1y8tb1o.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Jun 2022 09:10:27 -0700
In-Reply-To: <220607.86y1y8tb1o.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Jun 2022 23:31:28 +0200")
Message-ID: <xmqq35gfrv9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83A5647A-E745-11EC-A8F7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 07 2022, Taylor Blau wrote:
>
>> On Tue, Jun 07, 2022 at 10:07:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>>>
>>> On Mon, Jun 06 2022, Taylor Blau wrote:
>>>
>>> > diff --git a/Documentation/git-show-ref.txt b/Documentation/git-sho=
w-ref.txt
>>> > index ab4d271925..28256c04dd 100644
>>> > --- a/Documentation/git-show-ref.txt
>>> > +++ b/Documentation/git-show-ref.txt
>>> > @@ -10,7 +10,7 @@ SYNOPSIS
>>> >  [verse]
>>> >  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
>>> >  	     [-s|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
>>> > -	     [--heads] [--] [<pattern>...]
>>> > +	     [--heads] [--count=3D<n>] [--] [<pattern>...]
>>>
>>> In addition to what Junio noted, the SYNOPSIS is now inaccurate per y=
our
>>> documentation. I.e. if this option is incompatible with --verify and
>>> --exclude-existing we should use "|" to indicate that, e.g.:
>>>
>>> 	[ [--verify] [--exclude-existing] | --count=3D<n> ]
>>
>> Good catch. Should this be squashed into the first example in the
>> SYNOPSIS, the second, or a new one?
>
> Personally I really don't care if the end-state is good :)

Heh.  I actually do think that the proposed documentation is
correct; the implementation that excludes these two options
from the "count" feature is buggy.

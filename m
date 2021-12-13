Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB55C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhLMJCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:02:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLMJCn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:02:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59E7415D700;
        Mon, 13 Dec 2021 04:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=yYijfiRaOdJbnLd7+MAA1GjYP
        Mil2zM6P/hnIas+RZo=; b=PAog1aibqVi96ajDBY8rfiYy8q9O/CQgYT/HHqF9b
        Lnh9TECAFgxbcknNuR36y2/4HXBTgJ1MduroIFrQplW+QObQgFFcPFZCO9jskOga
        PAvzPIfPHZj/Ta6ifslxWMZxLAphMPPtWDgoXFPBCIQtEI+Xw4uJnPAyAIspMYTJ
        lU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44BD915D6FF;
        Mon, 13 Dec 2021 04:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9202615D6FD;
        Mon, 13 Dec 2021 04:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: ms/customizable-ident-expansion
References: <xmqqilvvluoa.fsf@gitster.g>
        <211212.86fsqxa19o.gmgdl@evledraar.gmail.com>
Date:   Mon, 13 Dec 2021 01:02:37 -0800
Message-ID: <xmqqbl1kg9n6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BD7F93A-5BF3-11EC-B009-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Dec 10 2021, Junio C Hamano wrote:
>
> [CC-ing Maksym, the topic author]
>
>> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>>  - keyword expansion: make "$Id$" string configurable
>>
>>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>>  used as an in-blob placeholder for keyword expansion.
>>
>>  Will discard.
>>  Stalled for too long.
>>  cf. <xmqqfsuosvrh.fsf@gitster.g>
>>  cf. <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
>>  source: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>
>
> I'd like to see this go in, not because I'd personally find it useful,
> but mainly because I didn't find anything wrong with it (per my review
> id [1] linked above), and more importantly because the saga ending here
> seems rather unfriendly to a first-time contributor.
>
> Wasn't the "stalled for too long" mainly a victim of timing? I.e. that
> it happened to be submitted/discussed around the end of the last releas=
e
> cycle?

I do not think timing has much to do with it.

I have been fairly clear from the very first review of the initial
iteration that I do not want us to commit to "per-path" attribute.
It will open can of worms [*], and paint us into a corner we cannot
get out of easily once such an overly flexible system gets to users'
hands.  I also was fairly clear that instead I'd expect it would be
more sensible if it were a single "instead of $Id$, use $FooId$
throughout the tree" configuration.

I also did not want to force a first-time contributor to commit to
deal with a fallout from such a design.  A new feature with a very
limited scope will have better chance to allow us extend it later
without breaking compatibility with the initial version and would be
better suited for first-timers.


[Footnote]

* I have already mentioned that users have to figure out when adding
  a new file which keyword applies to the path.  It also troubles me
  that it is not part of the design what should happen when people
  want to move files around.  Not allowing per-path settings means
  we do not have to worry about the extra flexibility hurting the
  users of this (not "customizable" part but the "ident replacement"
  as a whole) misguided feature that shouldn't have been added in
  the first place.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11631C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiF3Xph (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiF3Xpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:45:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8A57255
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:45:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5698B130C3F;
        Thu, 30 Jun 2022 19:45:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=arQxEFzMybQf
        rSqibIOWCcrejNt9rnY6CPDIJPxfpAU=; b=OYCBqT66XisZFtAoSpai5xV4b9Na
        uw1nBNZgwIhqrS7ho478ilKuCB7LeeV/c2U3kmThdVjtH933EgQ9VSbD2mDw7h3H
        pMVkkJ6yVP98A5z3Am30Rr6Pn+xPWtIdpUsGODPRAnxj/LWLuyaWwDlGrAazFYy7
        bTtHZZ4ghQT9IP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D456130C3E;
        Thu, 30 Jun 2022 19:45:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C2FD130C3C;
        Thu, 30 Jun 2022 19:45:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/11] checkout: add a missing
 clear_unpack_trees_porcelain()
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
        <patch-08.11-94e28aa7ab3-20220630T175714Z-avarab@gmail.com>
        <xmqq35fldc9i.fsf@gitster.g>
        <220701.86wncxbu7q.gmgdl@evledraar.gmail.com>
Date:   Thu, 30 Jun 2022 16:45:29 -0700
In-Reply-To: <220701.86wncxbu7q.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 01 Jul 2022 01:34:00 +0200")
Message-ID: <xmqqzghtaf6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9D8D9BA-F8CE-11EC-A544-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Does refresh_cache(REFRESH_QUIET) depend on the porcelain error
>> messages already set?  If not another way to fix it may be to delay
>> the call to setup_unpack_trees_porcelain() until it becomes needed.
>>
>> But the patch as posted is certainly an improvement.
>
> Yes, that would work too, I can do it that way if you'd like.
>
> I was trying to keep these fixes as narrow as possible, and resist any
> temptations to re-arrange code so as to avoid allocations, which we can
> often do, but then instead of a 1-line diff it's 10, 50, 100... :)
>
> In this case it'll be somewhere around 10, and just a code-move, so
> maybe that's fine...

The ideal answer I was hoping to hear was

    The current implementation of the refresh_cache() function might
    not, but there is no guarantee that it will stay so.  We may add
    more calls that may (or may not) need to access the error
    message table before this early return.  Setting the porcelain
    messages before making any calls to any functions in the API and
    unsetting after we are done is a much better code structure.

;-)


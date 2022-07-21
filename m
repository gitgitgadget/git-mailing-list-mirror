Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E0C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGUSCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGUSCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:02:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827D58C594
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:02:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FC251AD205;
        Thu, 21 Jul 2022 14:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HBc3Ww8tYe90
        s30g+abRnT1Q+Fa4eF9hxVs5xOG5Fsc=; b=K54PVtKOvkpC+R7k0vPP1ZdCSts+
        XcEe4yKTJW30/bwnhDwkyPzD35yHVNXu4FryByf9QDalSYVhs19ds3mYksaZ0hvW
        8ITbFD3kt+g3uCOxI6WEkPtgIVlOlcg7VFsCVUmzllGPI1D9ogOGsrP4H9Ec35J5
        22DOmqAXRX/zt2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67B951AD203;
        Thu, 21 Jul 2022 14:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AAA51AD202;
        Thu, 21 Jul 2022 14:02:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
        <xmqqwnc6idxr.fsf@gitster.g>
        <220721.86a692tkva.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Jul 2022 11:02:26 -0700
In-Reply-To: <220721.86a692tkva.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Jul 2022 19:49:31 +0200")
Message-ID: <xmqqy1wmgx8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47E544B8-091F-11ED-9788-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But this is worse in that "git rebase" will get rid of it by default.

FWIW, I think I like this much better than Konstantin's "there is an
empty commit at the bottom", for exactly the same reason why I like
the original "empty commit at the tip", i.e. simply because we can
strip away the "extra" commit that holds the topic description
without having to change all the "real" commits.

In fact, I thought one of the newer "b4" subcommands that is used to
accept a patch series with a cover letter creates exactly this sort
of topology, when told to apply the topic to the tip of the
integration branch?  I do prefer to see a tool that it can use the
same "format" of data for both input and output, and I think your
"there is a redundant merge commit at the tip, with topic
description" topology can be that input format, which would be
recreated at the receiving end if the receiver happens to have the
same base when applying it and the final integration branch was also
at the same base.


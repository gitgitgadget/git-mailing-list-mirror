Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED7C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHKTn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKTnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 15:43:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A7124
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 12:43:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C265D2610F;
        Fri, 11 Aug 2023 15:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IVMlxWTo0gEYtof6oyu33TIYBNjQLh0ZChxi66
        iHuO0=; b=jjlTgXmQxxE7ZtQ9hIKMK+o4hSGCSM1m0O8CPpkDzu4c2WoFpINbI+
        7iU6mCvvGT6S8M4ghB4JQrv8MKU8QZzWkck0TlJBek1O4UOenVpGRj9vMrZzU1xh
        Vt5kV96RPcCD4xpO8jyuoSVghAtERxLNfHaSQy+jAqwooGodXx/EQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8ED22610E;
        Fri, 11 Aug 2023 15:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED8352610B;
        Fri, 11 Aug 2023 15:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Linus Arver <linusa@google.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com> <xmqqsf8ptsqf.fsf@gitster.g>
        <xmqq5y5ltqwd.fsf_-_@gitster.g> <ZNZ7GhVkLuwYOPij@ugly>
Date:   Fri, 11 Aug 2023 12:43:16 -0700
In-Reply-To: <ZNZ7GhVkLuwYOPij@ugly> (Oswald Buddenhagen's message of "Fri, 11
        Aug 2023 20:16:58 +0200")
Message-ID: <xmqq1qg9s6uj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51D38D78-387F-11EE-854B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> make this fully orthogonal to reverting reverts in particular (note
> that i attached it to the generic "discussion" patch rather than the
> "reverts of reverts" one).

I viewed that as a patch to add "discussion on how to explain
revert" (not necessarily "revert of revert", but how "revert" in
general should be explained).

> i didn't think about the integration with existing options yet.

Now I did ;-).  

The discussion of what the right way to present and justify a revert
was done before, and I think revert.reference and the "--reference"
option came out of it.  It aims the same "do not just describe the
fact what was reverted, but you should explain why" spirit.  While
what I showed in my illustration patch was not meant as "integration
with existing options", it is inevitable that reuse of existing code
that was written earlier for improving the workflow in the same
spirit may get involved.

Perhaps we should also tweak the commit log template to give a
gentle knudge to the user to use revert.reference and then enhance
the help text we give.

Instead of

    Revert "doc: revert: add discussion"

    This reverts commit 7139d1298993b0148ad429cd7cb4824223b7f420.

you may see something along the lines of ...

    # Consider retitling to reflect WHY you are reverting.
    # You may also want to set revert.reference configuration to
    # help encuraging a better title for revert commits.
    Revert "doc: revert: add discussion"

    This reverts commit 7139d1298993b0148ad429cd7cb4824223b7f420
    because <REASON OF REVERSION HERE>

I ran out of time budget for today to think about a topic that is
not releant to the current release, so I'd stop here.

THanks.

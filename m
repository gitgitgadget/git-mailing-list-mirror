Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5011F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 04:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfJPEAr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 00:00:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfJPEAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 00:00:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C4D6380F7;
        Wed, 16 Oct 2019 00:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7OGsuS8Lf2RkUWAUq4I476fqGfI=; b=b8z90B
        ATkf6v0xTa0HlYKveEyZi8Dplg0rVWXRcgPiJEhKdnnqSjQTCoPKM4yt6H9JZtMJ
        xp8eVw/hrl5fo5wdzaDc0fP5XNR6kCRYI28IkyjFgZjw+HQGh+HWawJaJ4+8ZAVO
        Li/Yr9TU8BEVbBmW3e8XqymbKRdxZJGWjpEPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kffC+p1tr5z/rWt0Vp+vAHxBqHQWdZfF
        I3Z/ORxZ5+mHjKUrry5fsPmCCkKajFegzkThMb6DkqkYay2yxymX8SV7JpscdxEQ
        NfBW5ZNjm5GiGKqQYPhw/tCyMwyxSCvBxo2av9TB13PqlDs5qm9KD5asep6Fanr1
        QkUCXGkaCjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54895380F6;
        Wed, 16 Oct 2019 00:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2C86380F5;
        Wed, 16 Oct 2019 00:00:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 08/13] graph: tidy up display of left-skewed merges
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
        <c34a5eb160310613cbde6313cda6cff753d6d7fd.1571183279.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 13:00:42 +0900
In-Reply-To: <c34a5eb160310613cbde6313cda6cff753d6d7fd.1571183279.git.gitgitgadget@gmail.com>
        (James Coglan via GitGitGadget's message of "Tue, 15 Oct 2019 23:47:54
        +0000")
Message-ID: <xmqqsgnt8hlh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86A7C800-EFC9-11E9-A710-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Coglan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This effect is applied to both "normal" two-parent merges, and to
> octopus merges. It also reduces the vertical space needed for pre-commit
> lines, as the merge occupies one less column than usual.
>
>         Before:         After:
>
>         | *             | *
>         | |\            | |\
>         | | \           | * \
>         | |  \          |/|\ \
>         | *-. \
>         | |\ \ \

Looking at these drawings reminded me of a tangent that is brought
up from time to time.  We do not do great job when showing multiple
roots.

If you have a history like this:

      A---D---E
         /
    B---C

drawing the graph _with_ the merge gives a reasonable representation
of the entire topology.

    * 46f67dd E
    *   6f89516 D
    |\  
    | * e6277a9 C
    | * 13ae9b2 B
    * afee005 A

But if you start drawing from parents of D (excluding D), you'd get
this:

    * e6277a9 C
    * 13ae9b2 B
    * afee005 A

and the fact that B and A do not share parent-child relationships is
lost.  An easy way to show that would be to draw the bottom three
lines of the full history output we saw earlier:

    | * e6277a9 C
    | * 13ae9b2 B
    * afee005 A

either with or without the vertical bar to imply that A may have a
child.

This is not something that has to be done as part of this series,
but I am hoping that the internal simplification and code
restructuring that is done by this series would make it easier to
enhance the system to allow such an output.

Thanks.

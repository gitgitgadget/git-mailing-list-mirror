Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF930C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FFD61453
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhDUQ4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:56:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50464 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbhDUQ4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 12:56:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAA1311ED12;
        Wed, 21 Apr 2021 12:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pIePXvkNTZz9
        10Dw5KhCCt0Sc18=; b=ONwDoVr3zd8KX7vxjWjpbubvbns8DgqR5iCUXjuR6HBh
        zP5yz4jK0tiD/a9SwKmO8R1pCZhrvbCGmb1VMa/Gb35AIhRDvqA3iY6LJ0CFLq+M
        UNbRVHtWpByW1PzTGTRCnGvp1ea+zDpt9KY/fuchSZ0wEhFgtV4hpAzZcc+OMS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XjQS5d
        tph97RULFvttN1918IKBuDz35+rQJ1vpIcmurFrsAFmsCSonNunX6I+DE4s2UXFp
        8VctZU1c7o4mps7Y1rG29+kLG+22WLya0uSAUA2/uU/nBhijYy3ZGRclphT4TVpC
        SZEYFJHT/f//6pPaZqj6F3q/8D6F+vejDR6nk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A14EA11ED11;
        Wed, 21 Apr 2021 12:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E379311ED10;
        Wed, 21 Apr 2021 12:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Subject: Re: reflog existence & reftable
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
        <87im4f3l62.fsf@evledraar.gmail.com>
Date:   Wed, 21 Apr 2021 09:55:40 -0700
In-Reply-To: <87im4f3l62.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Apr 2021 13:57:09 +0200")
Message-ID: <xmqqim4fzier.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6823C232-A2C2-11EB-9716-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So for that case somewhere in the guts of the reftable integration we'r=
e
> losing the distinction between asking for a log that can't exist
> v.s. one that's empty, maybe the reftable code is returning "yes I have
> logging on" or "yes I have some entries somewhere" in that case?
>
> And in "E", related to "C" isn't in unambiguous to not write it if
> there's no existing entry for the branch in question and
> core.logAllRefUpdates=3Dfalse is in effect?

So, in short, we can rely on the fact that if reflog exists it will
have at least one element? =20

But the original "turn logallrefupdates to false and touch the
reflog files for refs you care about" (which I recall I did for my
own use case) allowed an empty reflog in preparation to have new
entries to be appended, so in its initial state an existing reflog
can have zero element.

Is there a documented way to just "enable" a single reflog via any
Git command?  That "if a file exists, append" code dates back for
more than 15 years and I do not remember if in the target use case
I was happy enough to tell people to just "touch" the reflog file
of interest, or if I bothered to add a command support (e.g. "git
reflog create 'refs/heads/next'").

If there isn't, then we could do either one of these two things.

 (1) we could add "git reflog create <ref>" and the reftable can
     record the fact that "reflog exists for the ref, but no ref
     movement recorded yet".  Then the condition C can be checked.

 (2) we could declare that there is no way to create an empty reflog
     supported across ref backends, and make the tests that rely on
     the "feature" conditional on REF_FILES prerequisite.

I have no strong preference.  In the early days I found the ability
to limit which branches get logged convenient, so if reftable
backend can learn the similar trick, we would want to go route (1)
(the convenience largely came from the fact that there was no need
to add one configuration item per branch, so I do not think we would
want to bother with branch.<name>.reflog=3Dbool configuration---that
won't be an easy-to-use substitute).  On the other hand, logs are
useful, and dormant logs are not costing anything (other than holding
onto stale objects we may no longer want), so it could be that it
may not be as convenient as it used to be to be able to turn logs on
only on selected refs, in which case approach (2) is fine.





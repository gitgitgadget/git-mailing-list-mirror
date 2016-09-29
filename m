Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0435C207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934401AbcI2V4j (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:56:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933081AbcI2V4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:56:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C846F430C0;
        Thu, 29 Sep 2016 17:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mHFfIgj0PWHAldTOZG4gCLRF7wk=; b=w8Y6PH
        8ynl5SS+9j7fi/n+9HGrPKjMQ2s3WC/RaG06Zces5IgcGx3BqJ5xBxyirhIk4NZ7
        IQDcQZ5Si7U4AoduqwNk+LwlNF8bZVZSQl48IKWt8Bu7JS/OWVT8gU71O6RKDtP4
        9jSCclkCvIoPtfWNEnPmQcWsvC0ckFDIB51mE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M6fnym8Vy05tJWjUv9RVmMYSJZnmDQYp
        Cn0tLgRaJwtScPuNLrQy2EuuwJsVb1Qb9OyMtkBQHm4Qp1SRaZrRn6xBj28axCeJ
        qpFuanvmeN1SuTCX0HIintDAbpyl6mZXkuKfJFBXJuBux0jHxZAVHZnaDwpSqO9Q
        Hx9ymFwNEuY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF162430BF;
        Thu, 29 Sep 2016 17:56:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D9AC430BD;
        Thu, 29 Sep 2016 17:56:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
Date:   Thu, 29 Sep 2016 14:56:34 -0700
In-Reply-To: <cover.1475176070.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 29 Sep 2016 12:21:36 -0700")
Message-ID: <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9790CFB4-868F-11E6-B505-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is somewhat of a follow-up to my previous e-mail with subject
> "[PATCH] sequencer: support folding in rfc2822 footer" [1], in which I
> proposed relaxing the definition of a commit message footer to allow
> multiple-line field bodies (as described in RFC2822), but its strictness
> was deemed deliberate.

It does not necessarily mean we can never change it when we did
something deliberately, though.  With a good enough justification,
and with a transitition plan if the backward incompatibility is
severe enough to warrant one, we can change things.

I vaguely recall that there were some discussion on the definition
of "what's a trailer line" with folks from the kernel land, perhaps
while discussing the interpret-trailers topic.  IIRC, when somebody
passes an improved version along, the resulting message's trailer
block may look like this:

    Signed-off-by: Original Author <original@author.xz>
    [fixed typo in the variable names]
    Signed-off-by: Somebhody Else <somebody@else.xz>

and an obvious "wish" of theirs was to treat not just RFC2822-like
"a line that begins with token followed by a colon" but also these
short comments as part of the trailer block.  Your original wish in
[*1*] is to also treat "a line that begin with a whitespace that
follows a line that begins with token followed by a colon" as part
of the trailer block and I personally think that is a reasonable
thing to wish for, too.

I recall that I was somewhat surprised and dissapointed to see no
change to interpret-trailers when you tried [*1*], which was really
about improving the definition of what the trailer block is, by the
way.

In any case, if we want to improve what the trailer block is, we
would certainly need to make sure what is inserted by "cherry-pick -x"
is also considered as part of the trailer block, so it may be necessary
to change it to "Cherry-picked-from: ..." while doing so.  I dunno.

> Below is a patch set that allows placing the "cherry picked from" line
> without taking into account the definition of a commit message footer.
> For example, "git cherry-pick -x" (with the appropriate configuration
> variable or argument) would, to this commit message:
>
>   commit title
>
>   This is an explanatory paragraph.
>
>   Footer: foo
>
> place the "(cherry picked from ...)" line below "commit title".
>
> Would this be better?

It is not immediately obvious what such a change buys us.  Wouldn't
the current code place that line below "Footer: foo"?  I cannot
think of any reason why anybody would want to place "cherry-picked
from" immediately below the title and before the first line of the
body.


[Footnotes]

*1* http://public-inbox.org/git/1472846322-5592-1-git-send-email-jonathantanmy@google.com/

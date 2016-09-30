Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A6A207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbcI3Te2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:34:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64287 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbcI3Te0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:34:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0F3B42419;
        Fri, 30 Sep 2016 15:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2RLvjJX+EIdWjwzPJ2pA+oI7360=; b=fT0uBl
        256b4+O7o7mmuUgCQIEMdDgLrz2/N9GXmz86LSHnxldM14GfqSxw8EQcwhbBtcNX
        neUeYZ9pmbfMJlP5GoEHgtuskFVtBqFuXEyKAauR3lpTEE4bP0PY/e148kqDn2uy
        p4mwcYLpBvR/0WIKiqQoMTrA1R9WaRqaBC11k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ggEZsfi58oPGPBmcGtZ3mDixqWWqMQUR
        GDj7QGU0MDBTBwTjDr6HyvAJxJIOSm3mAH+vgZlif80bGC7HgUGTmTNorrSvJNps
        qGAr66oeA2pSoevcBOjATUSCjaoKIXNrN12e9YqF4X6rn/i4Owlw87eCUL20Bh6j
        6XFG/Wslux8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F3B42418;
        Fri, 30 Sep 2016 15:34:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A4B742417;
        Fri, 30 Sep 2016 15:34:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
Date:   Fri, 30 Sep 2016 12:34:22 -0700
In-Reply-To: <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com> (Jonathan Tan's
        message of "Fri, 30 Sep 2016 11:22:05 -0700")
Message-ID: <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4944498-8744-11E6-AFCA-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I vaguely recall that there were some discussion on the definition
>> of "what's a trailer line" with folks from the kernel land, perhaps
>> while discussing the interpret-trailers topic.  IIRC, when somebody
>> passes an improved version along, the resulting message's trailer
>> block may look like this:
>>
>>     Signed-off-by: Original Author <original@author.xz>
>>     [fixed typo in the variable names]
>>     Signed-off-by: Somebhody Else <somebody@else.xz>
>>
>> and an obvious "wish" of theirs was to treat not just RFC2822-like
>> "a line that begins with token followed by a colon" but also these
>> short comments as part of the trailer block.  Your original wish in
>> [*1*] is to also treat "a line that begin with a whitespace that
>> follows a line that begins with token followed by a colon" as part
>> of the trailer block and I personally think that is a reasonable
>> thing to wish for, too.
>
> If we allowed arbitrary lines in the trailer block, this would solve
> my original problem, yes.

OK.

> Looking at that, it seems that sequencer.c started interpreting the
> last paragraph of the commit message as a footer and adding an
> exception for "cherry picked from" in commit b971e04 ("sequencer.c:
> always separate "(cherry picked from" from commit body",
> 2013-02-12). So the interpretations of sequencer.c and
> interpret-trailers were already divergent, but I should have probably
> at least discussed that.

It is not too late to discuss it.  I still think it is a good longer
term plan to try to unify the definition of what a trailer block is
and the implementation of the code that determines the boundary
between the log message proper and the trailer block and that allows
us to manipulate the trailer block, that currently is scattered
across multiple places into one.  Historically, "commit -s" had one
(because it needed to decide if it needs to see if the last sign-off
is already the one it is adding, and to decide if a blank line is
needed before the sing-off being added), "am -s" had another, and
"cherry-pick" probably had one, too.  "interpret-trailers" was, at
least originally, envisioned as an effort to develop a unified
machinery that can be called from these codepaths, and to aid the
development and encourage its use, it also had its own end-user
facing command.  Your interest in the "trailer" topic may be a good
trigger for us to further that original vision.

> As for a reason:
>
> 1) I do not have a specific reason for placing it in that exact
> position, but I would like to be able to place the "cherry picked
> from" line without affecting the last paragraph (specifically, without
> making the "cherry picked from" line the only line in the last
> paragraph).
> ...
> 1a) (Avoiding the footer might also be a good way of more clearly
> defining what the footer is. For example, currently, "cherry picked
> from" is treated as a special case in sequencer.c but not in
> trailer.c, as far as I can tell. If we consistently avoided the
> footer, we wouldn't need such a special case anywhere.)

That is one of the numerous shortcomings of the "interpret-trailers"
that is still not finished, I would say.

> 2) The Linux kernel's repository has some "commit ... upstream." lines
> in this position (below the commit title) - for example, in commit
> dacc0987fd2e.

"A group of people seem to prefer it there" does not lead to
"therefore let's move it there for everybody".  It does open a
possibility that we may want to add a new option to put it there,
but does not justify changing what existing "-x" option does.

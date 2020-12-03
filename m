Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4276DC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9026221ED
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLCTam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:30:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54119 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgLCTam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 14:30:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87AFF9A308;
        Thu,  3 Dec 2020 14:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/B/4ejUuY22MWJo/fYeJ/kg7R8c=; b=mUEwC6
        pKnrM1QBKkYRF6AIXaHhxwvH7NSJsRCrisNKpTSpL5eAQeX0OTTt1LRC9fQZwtJF
        RyZaMfkyM9zhSXA53JTVZuRC9jcYaVbxxx+4wuULOVWXNT+x1wo13uEkO0kJSzHH
        9wZ6YeA3+1vvJN5fmGPlM9WkjZYKQdX5qT2tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y7JQttGiT0s1SJn1zknEAVjljNF91Eo4
        u8Gbru+PKljuxUm+LyDGkBCAkztYV3AsCk7QnmugTUXsAncx1s/Bg0Zp/9NGGc+z
        kiFaiECjEZAtJXJB+P+Azgrvq32kM2Y/NQuyrwcY1L9cWb1qTQ9zZaZNTjvmscCB
        1YjBYYIA6Zg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8006A9A307;
        Thu,  3 Dec 2020 14:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1023C9A306;
        Thu,  3 Dec 2020 14:29:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is
 not set either
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
        <20201125020931.248427-2-alexhenrie24@gmail.com>
        <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
        <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
        <xmqq7dpyix1d.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 11:29:57 -0800
In-Reply-To: <xmqq7dpyix1d.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 03 Dec 2020 10:06:54 -0800")
Message-ID: <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDCF2DE6-359D-11EB-8CC6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> That would require changing the semantics of --ff-only, so that "git
>> pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
>> overridden by --no-rebase).
>
> I do not think such a conclusion follows from "we do not want to use
> the 'by default force the --ff-only' when the user chooses between
> merge and rebase".  Specifically, I do not agree with "as --ff-only
> is overridden" in your statement.

Ah, sorry, I mis-read your three lines above.

There are currently two ways "git pull" consolidates your work with
the other history.  By default, you are "pulling" work from your
contributors (and that is what "pull request" means---contributors
ask you to pull, and you take their work at your discretion) and the
only way that makes sense is to merge their history into yours.  The
other is you are updating your branch by rebasing your work on top
of what happend in their history.

And if we introduce a third-way, i.e. "we do not handle the case
where you have your own development at all, this is only to maintain
pristine copy from your upstream", and repurpose "--ff-only" for
that purpose, yes, what you said above does make sense.  At that
point, there is no reason to disagree with "as --ff-only is
overridden" part of your statement---in your new world, "--ff-only"
is redesigned to act that way.

In retrospect, "git pull --rebase" was a UI mistake.  What the other
side means is totally different in the operation from what the other
side is in "git pull".  The former is for you to catch up with your
upstream and the latter is for you, who _is_ the upstream to others,
to take others work in as their upstream.  If we instead introduced
a separate command, say "git update", that is "fetch followed by
rebase" (just like "git pull" is "fetch followed by merge"), to
rebase your work on top of updated upstream, there wouldn't be a
need for us to be having this discussion.

It probably is water under the bridge at this point.  Perhaps if
somebody builds a time-machine for me, I'll go back 13 years and
give my younger self this wisdom ;-)








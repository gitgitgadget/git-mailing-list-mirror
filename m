Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE060C433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE6720737
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="quYZ0TGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICRne (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:43:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59888 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICRnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 13:43:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC210E33E2;
        Thu,  3 Sep 2020 13:43:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z5plILGbJCz3M8U/pn7O0RuEfrU=; b=quYZ0T
        GtgRKqIpopbYUgvwAE5y2xdqG6BwPd1RVZjtJq883bQqALZ65yu3kWVYDwhInz5d
        sRBGWIO5fq/8ly8JBOIoVEFohUnZWd7hOVklV/CqrNawgVfXZ+R+Jy9wIXIbS+QL
        L29sLDkB0EEtLr0AqG3aeF7xBndVJNELSJO9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hJBJrfle/qhcxlFHdUHmypGhpHV4lEZQ
        WSta19niCZMxZB2N911hJJx0skTLO2FAtGPdCnGiGqE3MEzN6DtC/yQ8rMV4aryS
        2dO+RRr0MMHU1f9V6NEngZYkNgHivugaXNzw35yfEXDY9z8g66Nr2eVBrSdDLcsl
        pyUTYr8Mtjk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4872E33E1;
        Thu,  3 Sep 2020 13:43:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39499E33E0;
        Thu,  3 Sep 2020 13:43:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Aborting git rebase --edit-todo
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
Date:   Thu, 03 Sep 2020 10:43:26 -0700
In-Reply-To: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
        (Victor Toni's message of "Thu, 3 Sep 2020 11:39:06 +0200")
Message-ID: <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9946FD4-EE0C-11EA-B142-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

> When doing a commit or choosing what to do for an interactive rebase
> one can just wipe the whole content of the editor, save and close to
> abort the action.
> While doing a `git rebase --edit-todo` I came to the conclusion that I
> would like to abort the edit and did the same. The final `git rebase
> --continue` got me rid of the rest of the commits...
> (Fortunately the "missing" commits could be rescued by looking into
> `.git/logs/HEAD` so thumbs up for that. )
> Unfortunately the behaviour of `--edit-todo` was a bit surprising and
> somehow doesn't feel consistent with the other actions involving an
> editor.
>
> Can this be considered a bug?

It is rather unusual (or almost always wrong) to have a totally
empty commit log or initial todo list, so it is understandable for
Git in these situations to stop without doing anything further.

There is no other sensible interpretations of what you are telling
Git to you by returning an empty buffer---it is extremely unlikely
you want to create a commit with no log message (without explicitly
allowing it with --allow-empty-message, the command is likely to
fail anyway), and it is extremely unlikely that you wanted to just
reset the tip of the branch to the --onto commit.

Once an interactive rebase session has started and you are given the
remainder of the steps to edit and you give an empty buffer back,
however, there are two possible interpretations that are equally
sensible, I would think.

 - One is that you are signaling that you are done with the rebase
   session and all the remaining commits are to be discarded.  

 - The other is that you botched editing the todo list, and you wish
   Git to give you another chance to edit it again.

I think the implementor chose the first interpretation.  The "drop"
insn is a relatively recent invention, and back when it was missing
from the vocabulary, I do not think it was possible to say " discard
all the rest" without emptying the todo list, so that design is
understandable.

Now we have the "drop" verb, the latter interpretation becomes
possible without making it impossible for the user to express the
former.  It might be a good idea to

 (1) save away the original before allowing --edit-todo to edit,

 (2) open the editor, and

 (3) when getting an empty buffer back, go back to step (2) using
     the back-up made in step (1).

Either way, the todo list editor buffer can have additional comment
instructing what happens when the buffer is emptied.

I have no strong opinion on this one myself.  Deferring to Dscho,
who may have a lot more to say on the design issue around this
feature than I do.

Thanks.

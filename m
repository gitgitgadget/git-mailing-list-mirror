Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992EFC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781CB206A3
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ac8NWyU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEJTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 15:39:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52148 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgEJTjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 15:39:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80748CAAA3;
        Sun, 10 May 2020 15:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X4ZvBgnoTXvZRpjKmADKepGBBws=; b=ac8NWy
        U8DDXigAWZEryvd0ZNackC4QdYpU7Q6OM07E2WK6tuDGVToRsauPbU8g6pipb9qh
        mdOVK1oYN6690IxNLCdCA4vQAK3Gu+IICW4FXs0begMoxHNchKwSZRXU5RCXNhHx
        saKuhPt049CNbQPfa4J1wiBf2ypIQRKKeY0kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yZ/B8zzkhZk5cTHTuPDI5lfXGKxgE2cH
        YHAYwDF3f/gd+DE52ikO5641HI8fkcWIxf9hHE1PJMA0bEW+kzWIH0bHezMVaVq1
        H04gFTgdt3HbEyZxAxMnE+vmiHHQL+jGEVLLqdIYF9QeeBnFvnzIAYGTr29vN1ad
        lnKvuW6H06A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A040CAAA2;
        Sun, 10 May 2020 15:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C6506CAAA1;
        Sun, 10 May 2020 15:38:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        <xmqqk11jtxl3.fsf@gitster.c.googlers.com>
Date:   Sun, 10 May 2020 12:38:53 -0700
In-Reply-To: <xmqqk11jtxl3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 10 May 2020 12:10:48 -0700")
Message-ID: <xmqqftc7twaa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2D2083C-92F5-11EA-92A3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Because this is a new feature, instead of breaking existing users
> and forcing them to do something different they did not have to
> (namely, set and export the GIT_JUMP_IGNORE_STDOUT_CHECK environment
> variable), we should instead make this a non-default behaviour and
> those who want it should explicitly opt-in to trigger it, perhaps
> like:
>
>         open_editor() {
>                 if ! test -t 1 && test -n "$GIT_JUMP_AUTO_CAT"
>                 then
>                         cat "$1"
>                 else
>                         editor=`git var GIT_EDITOR`
>                         eval "$editor -q \$1"
>                 fi
>         }
>
> so that existing users won't get affected by this change at all,
> while allowing you and other vim users to set and export the
> environment variable just once.  
>
> Unilaterally breaking, and ignoring when you are told you are
> breaking, possible existing users, without giving them any escape
> hatch, is simply irresponsible, and not something done in this
> project.  But I am sensing that you are not listening to and
> thinking about what you hear before you respond, so I will stop
> spending time on this topic for now, and wait until others chime in.

Well, I lied ;-) 

I somehow doubt that users of vim types "!git jump diff" (or
whichever submode they want) from within vim's command prompt;
wouldn't they typically wrap the invocation in a vim macro?

If my suspicion is correct, with an opt-in feature like the above
(which is designed not to hurt existing users), the vim users can
change their macro definition to not just invoke "git jump
<whatever>", but invoke "GIT_JUMP_AUTO_CAT=yes git jump <whatever>",
i.e. tell "git jump" that you are opting into the "cat the file,
instead of launching GIT_EDITOR".  So with just a one-time setting,
vim (and other similar editor) users would benefit without hurting
others.

For that matter, instead of introducing GIT_JUMP_AUTO_CAT, the same
mechanism can be used to run "GIT_EDITOR=cat git jump <whatever>",
i.e. tell "git jump" that it is expected to run "cat" as its
editor, from such a vim macro ;-)

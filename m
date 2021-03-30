Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933FC433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FFB619E5
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhC3V75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:59:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64093 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhC3V7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:59:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F2E012E315;
        Tue, 30 Mar 2021 17:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=psynKSKuOXIKcmxwiiltRXvn+sI=; b=hn6d33
        xSqICdiY143TByEHC9c51HmoPJYEPCJLlDsyylf5SgIwyhP2DcbsNRr1RRFjS/6K
        Q6RO8uiH7+p7JHH5Kr4VclwMe0tEldS5zjowteXE3N649aIvab3CvOHp0kazCecH
        KCAN0/SGeiPvwBlh/no8wEflp8fYF4rqrW2lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LBZOt1xROfEdrnXZSqR6BUGqmXGi2TO4
        DMCTHhBCM9KPAlVnWAlaVKiEdN+IuFvySoICPV2ffl0mT3Fe+IyqFoHyNuPpJzk5
        JkW8bKfEcNWp5wOlFyqjgr382O7UpKm1uTKjsfyg4SLYSlBaUTGaxsYXvWr5tvIp
        jmem9Y09450=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7719812E314;
        Tue, 30 Mar 2021 17:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A711912E311;
        Tue, 30 Mar 2021 17:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is
 passed
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
        <YGLNBFJv8NKmrbvz@coredump.intra.peff.net>
        <xmqq35wceae6.fsf@gitster.g>
        <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
        <CABPp-BFewHGOx-RCVtDKhn3=0QC9YWdA--Wtbb_MTHQbu3FQcw@mail.gmail.com>
Date:   Tue, 30 Mar 2021 14:59:30 -0700
In-Reply-To: <CABPp-BFewHGOx-RCVtDKhn3=0QC9YWdA--Wtbb_MTHQbu3FQcw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 30 Mar 2021 14:30:56 -0700")
Message-ID: <xmqq5z18cngd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 356D62E2-91A3-11EB-B306-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Mar 30, 2021 at 2:19 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Tue, Mar 30, 2021 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Jeff King <peff@peff.net> writes:
>> >
>> > > ... though if we go that route, I suspect we ought to be adding both the
>> > > original _and_ the replacement.
>> >
>> > So "branch --contains X" would ask "which of these branches reach X
>> > or its replacement?" and "branch --no-contains X" would ask "which
>> > of these do not reach X nor its replacement?" --- I guess the result
>> > is still internally consistent (meaning: any and all branches fall
>> > into either "--contains X" or "--no-contains X" camp).
>>
>> I'm not so sure about this interpretation.  Based on the documentation
>> in git-replace(1):
>>
>>        Replacement references will be used by default by all Git commands
>>        except those doing reachability traversal (prune, pack transfer and
>>        fsck).

This "rechability" sidenote is primarily so that we won't result in
a corrupt repository when replacement is lifted.  When object A is
replaced by object B, and somebody makes A reachable (e.g. a ref
points at deadbeef), we mark both A (and the objects A refers to)
and B reachable, so that "prune" won't lose A.  It would allow the
replacement lifted after "prune".

Tweaking "branch --contains X" to list branches that reach either X
or its replacement would probably have the same effect, so I would
think it would be a good change (and fix to your original issue).

The "the result is still internally consistent" comment was the
result of my attempt to make sure such a change would not introduce
gross incoherency to the resulting system.


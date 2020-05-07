Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41760C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09470207DD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DDRADxhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGEw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 00:52:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52448 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgEGEw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 00:52:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F8A4D3782;
        Thu,  7 May 2020 00:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UlWklMUjy/copWf2YClBjnQCpAY=; b=DDRADx
        hC2eHXWsaWZckP+QQgo5G2w/G7eqfM3jVVxdyXARLF/QgU77Ji+lUdHSds6kKaSv
        QN5we0qkBhgLmmZAnNOwYyE+HzrTCBnu56RWt63gnywKmxdGvpY3FNekF8zx/ExD
        PcmtnoxaELZNM6UaLwnZyuifGAHIuv1j6QcM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fNKMwQT7KEp7XtXHbB7uAwr7cbjmydQ5
        H5++MEePJxu2kzygAcMMEX21f0b6UX1er3i/xTmiwBb5rjF15y+mcyCuroBfb/7k
        5eyzI4p77FkC/QhzOiLo/Uz2jx5FCWxDQ4KpmDpsKtcaWyY0dwKgnTyKOeMqF2K5
        fifOneA55l8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDB75D3781;
        Thu,  7 May 2020 00:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2D63D377F;
        Thu,  7 May 2020 00:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Solomon Ucko <solly.ucko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
Date:   Wed, 06 May 2020 21:52:19 -0700
In-Reply-To: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
        (Solomon Ucko's message of "Thu, 7 May 2020 00:27:16 -0400")
Message-ID: <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88EBB4A0-901E-11EA-B121-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Solomon Ucko <solly.ucko@gmail.com> writes:

> ... It would be much easier
> if there were a mode where any changes to the commit titles in the list
> modified the commits' titles. Maybe `git rebase -i --reword`?
>
> Any thoughts, suggestions, questions, etc.?

It is probably a bad idea, as it encourages a single-liner commit
message without any body.

Equally a bad idea, but perhaps slightly less evil, would be to add
a new verb that can be used to replace "pick" with, say, "retitle",
and teach the sequencing machinery to pay attention to the updated
title line only in that case.

Besides, neither is really workable, as the single line text after
the abbreviated commit object name in the todo list is meant as an
output only "informational" comment on each step, and there are
plans to add more than just the squashed title paragraph there
(cf. *1* for an example).  Even without such a future change, the
material there may not be just the commit title, if I am reading
the code correctly, when rebase.instructionFormat is in use.


[Reference]

*1* https://lore.kernel.org/git/pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com/

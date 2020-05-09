Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3EC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703FA21775
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PyZk58Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEIR3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:29:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53776 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgEIR3F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:29:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0388A55909;
        Sat,  9 May 2020 13:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XzeWcMzQY4+n
        rAZ9wDuyfbigeg0=; b=PyZk58QqkfvJPiZqat4HmG0RgEcuKnwt69XRmYHq1Nbn
        ZCBQUquCOzHRE7IV63euP3JXH3cRP8jnh2s6t/V5SpgiN0uwuObWSYOC9TlHdJSC
        4q0XMtqVqz5srubsWqbtP7jZxr0EuP2AKOMT9NCC9K9bxv4+MGSxXbN6ZSqe7zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MB7Frh
        hlAlO1mx558zFx+odSSc0m6ZZPBl2Qkw9GH1DwyTyZvRa+1xPKvo64POTa80EBpc
        8Rpbhvc8wUWoTLTLGveki0IkztxV1Pl/4Ns8wsDNB0fyaqLSq8wOTI+a3i636dj9
        eiC42jj3UckxuJx6/D68AIPYgSHciozEyDvLU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E173E55908;
        Sat,  9 May 2020 13:29:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05A7055907;
        Sat,  9 May 2020 13:29:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: invalid tree and commit object
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
        <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
Date:   Sat, 09 May 2020 10:28:59 -0700
In-Reply-To: <d963242a-72f3-7f42-7c95-ea5148f74804@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 9 May 2020 12:16:08 +0200")
Message-ID: <xmqqpnbduiec.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91C1E20E-921A-11EA-914F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> So I got curious if such trees might be in popular repos, wrote the pat=
ch
> below and checked around a bit, but couldn't find any.
>
> Is there a smarter way to check for duplicates?  One that doesn't need
> allocations?  Perhaps by having a version of tree_entry_extract() that
> seeks backwards somehow?

I've never looked into seeking backwards in a tree object, but in
unpack-trees, I had to deal with this exact problem that a blob
'hello' sorts before 'hello.c' which in turn sorts after a tree
'hello' because of the "implicit slash after the name for an entry
for a tree object" rule by introducing the "cache_bottom" hack in
the traversal logic to limit how far we must scan back.

We may be able to limit the list of "seen recently" names in a
similar way.

If the tree we are scanning has 'hello' (blob), 'hello.c' and
'hellp', the bottom pointer initially would be at 'hello' (blob),
then stay there when we see 'hello.c' (because the next entry might
be 'hello' (tree) that would crash with 'hello'), and when we see
the entry 'hellp', we know that the entry at the bottom pointer
'hello' (blob) cannot crash with any entry that comes later in the
tree object we are scanning, so we can advance the bottom pointer
forward.  To decide if we can advance the bottom pointer beyond
'hello.c' (blob), we see if 'hello.c' (tree) can appear after the
current entry we are looking at (i.e. 'hellp'), and we know it
cannot without violating the sort order.  So the bottom would move
to point at 'hellp' we just saw.

If we had 'hello' (tree) instead of 'hellp', when we look at it
after looking at 'hello' (blob) and 'hello.c', we scan from the
bottom pointer up to the previous entry, which is still pointing at
'hello' (blob), and notice the crash.


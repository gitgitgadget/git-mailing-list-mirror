Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A2C43460
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BE961432
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEHGZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 02:25:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60545 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEHGZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 02:25:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0623A136E01;
        Sat,  8 May 2021 02:24:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EqNikmUZn05s
        tatgmQrzVHZAY1MagNCKSA70aZwYB1I=; b=kmmxxLrLMWeZNz4G4ZD9grkvHbBB
        R22qs7VDd85vK+eEYzGzp0Kxw8kXkP3XlOPFAd+KkxnLT0ZS7ppyOlZk7kvJlF7a
        MPw/dxZ6/8p8bH2cuERbMOizeZj/uyFrRVdcQtv8GGP1VKi/XrJqSp+g137pBSV3
        im87jXROVg2qU2k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2AEE136E00;
        Sat,  8 May 2021 02:24:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32B1F136DFF;
        Sat,  8 May 2021 02:24:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Will Chandler <wfc@wfchandler.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
        <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
        <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
        <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
        <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
        <YJYa+7yUyt2YD16r@mini.wfchandler.org>
        <1bb65e54-a18d-852d-bb01-130cc57cce1b@gmail.com>
Date:   Sat, 08 May 2021 15:24:38 +0900
In-Reply-To: <1bb65e54-a18d-852d-bb01-130cc57cce1b@gmail.com> (Bagas Sanjaya's
        message of "Sat, 8 May 2021 12:21:23 +0700")
Message-ID: <xmqqmtt5vj2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11D12030-AFC6-11EB-86C2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I ask to you: why did you send v2 patch as reply to v1?

Because it is a natural progression of the ongoing discussion, I
would presume?

> Supposed that I interested to apply only this v2, instead of v1.
> With this situation, I downloaded mbox for v1, which contains v2
> patch as reply to v1. And git-am would instead apply v1 instead.

If you are interested in v2, fetch individual pieces of e-mail for
v2 and not v1 (in this case, a single message that contains v2
only).  If you feed v1 to "am", of course it would happily apply
it.  Or if you grab the whole discussion in a mbox, of couse you'd
need to pick the message you would want to use (e.g. "mailx -f mbox"
and choose individual messages and then tell it to "s"ave).

> So why not send this v2 as separate message-id?

I sense you are somehow upset or frustrated, but I do not see a need
to behave so rudely to your fellow community member(s).

By the way, kostantin, "b4 am" seems to mishandle this thread.  As I
understand it, it is supposed to grab the latest and greatest
iteration given any message in the discussion thread, right?  In
this thread, we discuss a single-patch "series" but with two
iterations.  The original submission is followed by some discussion
messages, that is followed by a v2 patch, and then a few more
non-patch messaages.

Between these two invocations

$ b4 am YJVQpaDwkQH/aCee@mini.wfchandler.org
$ b4 am YJYa+7yUyt2YD16r@mini.wfchandler.org

where the first one is the the original, and the second one is the
improved v2 patch, both requests end up fetching the original one.

One thing curious about the behaviour (see the transcript at the
end) is that it gives this "NOTE" about "trailers", which hints me
that this vintage of "b4" may not understand the in-body header like
"git am" and "git mailinfo" do?  The v2 patch begins with a Subject:
in-body header to retitle the patch.

FWIW, I am using prepackaged /usr/bin/b4 at a work machine, which
identifies itself as

$ b4 --version
0.6.2

Thanks.


---------------------- >8 ----------------------

$ b4 am YJVQpaDwkQH/aCee@mini.wfchandler.org
Looking up https://lore.kernel.org/r/YJVQpaDwkQH%2FaCee%40mini.wfchandler=
.org
Grabbing thread from lore.kernel.org/git
Analyzing 7 messages in the thread
---
Writing ./20210507_wfc_refs_cleanup_directories_when_deleting_packed_ref.=
mbx
  =E2=9C=93 [PATCH] refs: cleanup directories when deleting packed ref
  ---
  =E2=9C=93 Attestation-by: DKIM/wfchandler.org (From: wfc@wfchandler.org=
)
---
Total patches: 1
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Subject: [PATCH v2] refs: cleanup directories when deletin=
g packed ref
     Msg From: Will Chandler <wfc@wfchandler.org>
NOTE: Rerun with -S to apply them anyway
---
 Link: https://lore.kernel.org/r/YJVQpaDwkQH/aCee@mini.wfchandler.org
 Base: not found (applies clean to current tree)
       git am ./20210507_wfc_refs_cleanup_directories_when_deleting_packe=
d_ref.mbx







Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6636C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ACD2080C
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mbUrKM7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH1Vd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:33:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50403 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Vd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:33:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6E88689C5;
        Fri, 28 Aug 2020 17:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YKzOBt0VKPNJmhKi+o9SN2Mghas=; b=mbUrKM
        7cRLd1SuymWDfYtfEBxTvtJj5DwRq8lI5vm95LF4BddPYQWuXPA7GZF0Alik8HjM
        OWTHntiETZIo1ilSzHiUqDQlu8qlX0rczzqUL9AXmfnWdfkCK5STc+tQ7q3ADqKF
        wv677uDAFnOQtTiuEvIvh4Jvspj+dzJH2PWpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=De3LxWqUbZcXYzh+1rEZoQfKTjQ+4P84
        +2XnXxuozjpB/j9VRZQwgjdUYH5fBUfEcb56MKglFvX0MBwPtZM2CdBQsxOUgoRJ
        RaVzEk3dnd7Er+onJxVtaOAaN94ZQagRyzqo7itIR5V15Z3BfoRMzq/NGQxrjX+i
        /TknG8manGs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D808689C3;
        Fri, 28 Aug 2020 17:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25B81689C2;
        Fri, 28 Aug 2020 17:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <C58XLLAE3SMA.3T1C6DXZ4VSWA@homura>
Date:   Fri, 28 Aug 2020 14:33:53 -0700
In-Reply-To: <C58XLLAE3SMA.3T1C6DXZ4VSWA@homura> (Drew DeVault's message of
        "Fri, 28 Aug 2020 17:01:46 -0400")
Message-ID: <xmqq7dtio3pa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BFE6614-E976-11EA-A49D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> This would be better, yeah, but at that point it's pretty weird, like
> why are we prompting for this CLI flag and not any others? The answer is
> just for legacy reasons. There's no inherent justification for it.

I suspect that the legacy reason exists only because it was (thought
to be) (a) common enough to make a series in response to an existing
message than a thread starter and (b) "to:" and "in-reply-to:" are
quite close to make sense to be asked together [*1*], back when the
current behaviour was established, ?  In other words, the "legacy
reson" may have inherent justification for it.

Your primary and only argument to flip the default not to ask about
in-reply-to is, because, in your opinion, more users would want to
send thread-starters than responses.  I haven't seen the numbers,
and more importantly I do not think anybody can expected to produce
numbers that convince everybody (there are biases based on who's
counting and what is counted), so I cannot buy such an argument
blindly.

The weighing done, perhaps in the original author's mind, back when
send-email was written would certainly not be based on any concrete
numbers, either.  But as one undisputable fact we know [*2*] is that
quite many people are already used to the behaviour we currently
have.  While some of them may welcome change, others will complain
if they are forced to relearn what they have committed to their
muscle memory.  

That makes it the safest thing to give users a new choice without
changing the default.  That would allow us at least move forward.



[Footnote]

*1* After all, these two affect where the readers find the message,
    i.e. in the archive or mailbox of which mailing list, and where
    in relation to other messages in the list.

*2* Purely based on how widely git is used.

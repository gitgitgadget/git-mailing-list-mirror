Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B1C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A64E206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pq3hHsc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTTXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:23:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50804 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTTXY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:23:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9449397F2;
        Fri, 20 Dec 2019 14:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GzvK85ehaj0Rh6QsyBHHURn71Xc=; b=pq3hHs
        c3d3tQPrgZoIWNZwvYAUUNzT/r8lYcmV5kj6qzYRLM6EPZAzZ0i5dTmGhbUacvEF
        s+Bffb21qR6sJIphjDzy8Y/FBqEOApm2v/Cypiic3TShOj407safehOKGKhOjLvZ
        PUm+QKsj6oyXc+ev9DlVjEiD9NjGJX6tVle1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wJ2QNfxzOS8qJBtQcm7QAawwiKSj2m93
        xEfvyfuCkV3teY9q1EUDr1K3+DOBaacW+6DAz3voXO3tFW8S/JwWC8993Okpddjk
        t0RZEG+ejgNIfRSjUymk2xXO9Kj8ZqxGSEofIdLx5H2vPLC7uPeWCvPLDqZv9kfc
        J0kwknyPNhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C04A4397F1;
        Fri, 20 Dec 2019 14:23:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05BB8397F0;
        Fri, 20 Dec 2019 14:23:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
References: <20191219015833.49314-1-emaste@FreeBSD.org>
        <20191220153814.54899-1-emaste@FreeBSD.org>
        <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
        <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
        <CAPyFy2AF+zcriUfZnpbXy+9r7hRpNBUe0agMuan-cE1ryqTipw@mail.gmail.com>
Date:   Fri, 20 Dec 2019 11:23:18 -0800
In-Reply-To: <CAPyFy2AF+zcriUfZnpbXy+9r7hRpNBUe0agMuan-cE1ryqTipw@mail.gmail.com>
        (Ed Maste's message of "Fri, 20 Dec 2019 13:34:43 -0500")
Message-ID: <xmqq7e2qajix.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E63E322-235E-11EA-B82D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

> On Fri, 20 Dec 2019 at 13:21, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "This is similar to ls" is not all that important, especially if we
>> then need to say how different from "ls" ours is.  The log message
>> that describes why we needed to move away from "ls" is a good place
>> to say what aspect of "ls" was unsuitable.
>
> Ok, I'm also happy if it goes in with no comment; the reason I added
> it is I could foresee someone coming along in a few years, thinking
> this is just a strange local implementation of ls, and changing it.
> But, perhaps we can assume that any such person would check the
> history before doing so and the comment is not needed.
>
>> If we _were_ to add an in-code comment, we may want to say something
>> like
>>
>>         # Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
>>         # enables "-A" when run by root without being told, and ends
>>         # up including ".git" etc. in its output.
>>
>> to warn future developers against improving and/or cleaning up.
>
> Indeed, that is more direct, although it's not just FreeBSD ls; this
> came from 4.2BSD and is probably common to most/all non-GNU ls
> implementations. In particular, macOS behaves the same way. (Also, the
> replacement would be even simpler, just "ls $1".)

Good piece of info to include.  Final try for the day from me:

    # Do not replace this with 'ls "$1"', as "ls" with BSD-lineage
    # enables "-A" by default for root and ends up ...


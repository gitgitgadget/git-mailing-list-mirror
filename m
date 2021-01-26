Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF1C43331
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F277206A1
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAZWAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62669 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbhAZRlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 12:41:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 163B0113BBF;
        Tue, 26 Jan 2021 12:40:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FV314TFH93q/oOI0srCF0T0JAJo=; b=Lse45d
        ZwI0e/hwfcYk2/lsLFFLcN7irky23uaN4HjnCOw1i5c7O4d1ZJo/7nPna61bV2DD
        YiHBp/sIC4N7QMEgpp8JKdz0bGIxQT9LoPS9JUdxj5Hr6ZlCGdoFheswO+xMSDri
        QXPSoGcPMNqpSrL9SVeidDKl7ZO6QcNrH4hg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MssSnrHGExr+d3UNS5aYHvhTuZXwZE93
        7Rgkuq5u3q5v/ihG6LWy2/I9WKSLwhgA1YgQAcRiJZp3mEO29gWmO1C6/yNY+9ZX
        IYsA06lebYbnS9goabunZ6/pvjLu4NfH3dV7rcZHjnrbr33U5K4pDbMonYG3jO1n
        /XMTIfziqTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F6AC113BBE;
        Tue, 26 Jan 2021 12:40:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 556B0113BB9;
        Tue, 26 Jan 2021 12:40:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] doc/reftable: document how to handle windows
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
        <xmqq35yo459k.fsf@gitster.c.googlers.com>
        <CAFQ2z_PCh2RfWALhAUXm01Xq0o+ibuEGJ2p9sCtvTASQ0FLUag@mail.gmail.com>
Date:   Tue, 26 Jan 2021 09:40:51 -0800
In-Reply-To: <CAFQ2z_PCh2RfWALhAUXm01Xq0o+ibuEGJ2p9sCtvTASQ0FLUag@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 26 Jan 2021 12:38:38 +0100")
Message-ID: <xmqqtur338bg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3285A30-5FFD-11EB-9BB4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> Is this because we have been assuming that in step 5. we can
>> "overwrite" (i.e. take over the name, implicitly unlinking the
>> existing one) the existing 0000001-00000001.ref with the newly
>> prepared one, which is not doable on Windows?
>
> No, the protocol for adding a table to the end of the stack is
> impervious to problems on Windows, as everything happens under lock,
> so there is no possibility of collisions.
>
>> We must prepare for two "randoms" colliding and retrying the
>> renaming step anyway, so would it make more sense to instead
>> use a non-random suffix (i.e. try "-0.ref" first, and when it
>> fails, readdir for 0000001-00000001-*.ref to find the latest
>> suffix and increment it)?
>
> This is a lot of complexity, and both transactions and compactions can
> always fail because they fail to get the lock, or because the data to
> be written is out of date. So callers need to be prepared for a retry
> anyway.

Sorry, are we saying the same thing and reaching different
conclusions?  

My question was, under the assumption that the callers need to be
prepared for a retry anyway,

 (1) would it be possible to use "seq" (or "take max from existing
     and add one") as the random number generator for the ${random}
     part of your document, and

 (2) if the answer to the previous question is yes, would it result
     in a system that is easier for Git developers, who observe what
     happens inside the .git directory, to understand the behaviour
     of the system, as they can immediately see that 1-1-47 is newer
     than 1-1-22 instead of 1-1-$random1 and 1-1-$random2 that
     cannot be compared?

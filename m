Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012EC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C64320663
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gFn1hYvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgGGPdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:33:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52445 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgGGPUo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:20:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74CEC6D9BB;
        Tue,  7 Jul 2020 11:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F+EK4YjKemj0z7nkqyYo7hxIoVc=; b=gFn1hY
        vRz+dE0MRqjf3Pb399dXLa3ZGj/gDZfNkthvakqOWNw5nRbnaMtkGULvFOzbCetL
        gHV8SPH+zsUxoNSz8402KgPX7IjDNNZi46UGjnTxwfMvF0vRHtNKgVHwPm44f7JP
        qGKtK3m5J/Rjwudpy1tAPULJTTEW0t5CMidqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G0lmTi3t+hsuUBeJ12HdKJEocaE1/O1L
        OUJS+T5LZ1xlFCzeIjUII08vL7yMezpQLJwFko8Qp96xmL68AuV8s8RojniacW5G
        MHn8/4KEj+MXpkaZeF3ZNKkcNGZy2Q0B3PvgWWasDdDzZnt03ibTzeFENQ1rZt70
        fcGFWsFW8fY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BCA06D9BA;
        Tue,  7 Jul 2020 11:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3B746D9B9;
        Tue,  7 Jul 2020 11:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
        <xmqqimf09ypc.fsf@gitster.c.googlers.com>
        <CAFQ2z_OPbcX9FGsFnmraAUpTu2eKuf2PZ+DO-CTWvaBZD6WQQQ@mail.gmail.com>
Date:   Tue, 07 Jul 2020 08:20:40 -0700
In-Reply-To: <CAFQ2z_OPbcX9FGsFnmraAUpTu2eKuf2PZ+DO-CTWvaBZD6WQQQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 7 Jul 2020 15:56:38 +0200")
Message-ID: <xmqqv9iz5p2v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B1C909E-C065-11EA-A5DE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> Or the entities that behave like refs and stored in ref backends,
>> with all-uppercase-names but do not sit inside refs/ hierarchy?
>
> I thought these were the same? - see below :)

>> > --- a/t/t1400-update-ref.sh
>> > +++ b/t/t1400-update-ref.sh
>> > @@ -476,7 +476,7 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
>> >  test_expect_success 'given old value for missing pseudoref, do not create' '
>> >       test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
>> >       test_path_is_missing .git/PSEUDOREF &&
>>
>> The reason why I asked what this patch thinks the definition of
>> pseudoref is is because of this thing.  Shouldn't this line be fixed
>> not to depend on the files backend?  Likewise for $(cat .git/PSEUDOREF)
>> in the remaining two hunks.
>
> This patch doesn't introduce reftable yet, so both definitions are
> equivalent for the sake of this patch.

But at the end of the tunnel, we do want to see people stop
expecting that .git/PSEUDOREF file is what PSEUDOREF ref is, no?  I
think that is what "pseudo refs are not just files directly under
$GIT_DIR, but managed by the backend" means, and that in turn is a
valid justification for other changes introduced in this patch.
Expecting the effect of modifying pseudo refs _after_ the code is
changed that such modifications are properly done through the ref
API to appear on the filesystem feels like it goes against the
reason why we are making this change, compared to checking to see if
the pseudoref really got updated as desired via the ref API, at
least to me.

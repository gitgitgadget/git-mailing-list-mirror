Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1873C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1066196C
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCVSgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:36:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62623 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCVSgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:36:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAA03B1AE2;
        Mon, 22 Mar 2021 14:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=248psW4DjXIh
        5H19uY1AZICORhg=; b=i+w9BQwbfQ+rUZO2pdulgb6xCXxNIgSzuPSYeqmtgV9B
        0TgeRka3ES6sXCZsB2SUuGLSEhkUUM9vaLtihH6tIARvCAiUTThUn9w1A9FT7dx2
        zkMVnD6ga/LTjqCbUuFffWSBi73+2rznDGhBEcHONbvX3m1FgXafce738w/v86E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rArG5u
        Y9/ObISJBfJMwOH+U+qDZFkZjzEx3+Ez1TDKNeFUQbnQj/GQVgGF9jrX5gqpHnmv
        qLJzJ1ZWa2pEiICSehBDMGf0OabS7OYil04a3WeBtnrAOrKLFXFNqZHJzImEmsJ6
        5RcLjGCGeDr9QV46KPbbK4f+tN8zVxpqUhllI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1A31B1AE1;
        Mon, 22 Mar 2021 14:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D7CFB1AE0;
        Mon, 22 Mar 2021 14:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
        <87eeg7qpyr.fsf@evledraar.gmail.com>
        <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
        <87blbbqju3.fsf@evledraar.gmail.com>
        <CAFQ2z_ML8s0Gk4Zmg+2mxzkfP1AbL=zkeUG0yKEtoege7it-vA@mail.gmail.com>
        <878s6fqgze.fsf@evledraar.gmail.com>
Date:   Mon, 22 Mar 2021 11:36:10 -0700
In-Reply-To: <878s6fqgze.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 22 Mar 2021 17:40:37 +0100")
Message-ID: <xmqqh7l36nol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7994A2E4-8B3D-11EB-98FF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I'm confused.
>>
>> rows[0][1] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
>> rows[1][0] =3D=3D "0f3a981cbd5be5f97e9504ab770cd88f988fe820"
>>
>> they are the same. I don't understand your argument.
>
> Sorry, I mean same =3D ff update, not the same =3D non-ff. So I flipped
> those around in describing it.

I am confused too.  Are you tacking something else, a gap in a run
of reflog entries?  If I go from commit A to B to C, the first log
entry would record the transtion from A->B, and the second entry
would record the transition from B->C, and the lack of gap does not
say anything about the relationship between A and B, or B and C.  A
can be, and does not have to be, an ancestor of B, and B can be, and
does not have to be, an ancestor of C.  Hopping from A to B to C would
leave the same pair of reflog records and I do not think you can tell
the reachability among A and B and C from them.


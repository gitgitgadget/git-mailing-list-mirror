Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AEC04A6A
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjHAUpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHAUpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:45:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932141982
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:45:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7A3A1B0694;
        Tue,  1 Aug 2023 16:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rFpX8x1Bq5ip
        MGgD6w5tVmBF7uhXPVoFf7RWbNNy+M8=; b=UNBhZ5pUHBMWDRQII19qdM/583RX
        +T/V67SEaThrIKDbvf9dZYKFVLzhGTVFxTVKlQYbvCZU+lsyuGzYbSaZGCGTzCpV
        1zPqsnUSePgVLpBZ3NG+Cux+rx8Iwiuo9o8Qn+DaVUkzD0LpYK/juQGa0bGhSSpN
        xmkHxEL7daZzUBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD6061B0692;
        Tue,  1 Aug 2023 16:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B6731B0690;
        Tue,  1 Aug 2023 16:45:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] status: fix branch shown when not only bisecting
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
        <xmqqedkn3arv.fsf@gitster.g>
        <32997081-62d8-b900-d58a-308e5c773818@gmail.com>
Date:   Tue, 01 Aug 2023 13:45:16 -0700
In-Reply-To: <32997081-62d8-b900-d58a-308e5c773818@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Tue, 1 Aug 2023 22:39:08 +0200")
Message-ID: <xmqqtttia3vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 528D7A74-30AC-11EE-B65C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> When a sequencer is
>> driving a cherry-pick of master..topic1 and the user gets control
>> back in the middle, perhaps due to a conflict, should the user be
>> allowed to do "cherry-pick master..topic2", splicing these commits
>> from the other topic in the middle of the first cherry-pick session
>> the user started?
>
> We already prevent this to happen.  Maybe because we do not want to
> support multiple .git/CHERRY_PICK_HEAD files.  Anyway, to me, sounds
> like a reasonable thing to have: that nesting limit of 1.  The same for
> the other operations.

OK, as long as we prevent such kinds of questionable combinations
("two multi-commit cherry-picks" was merely an example---I did not
mean that is the only problematic case), I do not see much problem
with it.  In any case, teaching "status" how to show such a state
with less information loss, which is the theme of this patch, is not
making things worse---even if some of the states may be nonsense and
should be prevented, "git status" is not the place to do so anyway.

I didn't see if the proposed output from the command makes sense
(yet), but somebody else may already have done so and writing their
reviews on their findings.  Let's see if we get any positive reviews
and move it to 'next' after that.

Will queue in the meantime not to lose it in 'seen'.

Thanks.

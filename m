Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F5C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E29F64F69
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCLGKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 01:10:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64021 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLGJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 01:09:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9175A8769;
        Fri, 12 Mar 2021 01:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AvMH10VQH03f4FsAY4IXx4DOooQ=; b=Z7Hbeh
        PHvQB/oHNilr+tXkAZ/1s37JG9azZoGQhFtGrfhZgiW/5Tglwcf3d2O44dKYutIN
        HSP4NTLTHY3921AMdewtQSw/yooiCyMdjOXlh7AasNc9sWcps2cWyST01aTCaQcd
        u/ACkYarczvMSg+l00opdBvH74NWb2V5IAn5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ETcx08oKV2u/aSEUIsv7LJJ2BQRo5VoI
        bsVjWhtklpQCUvMfUO5Gvix0oyXsxYKF5u2Wn6vzdNf8ZbIx0pltGRZaul4qTrUj
        KJRpmdglJAmnkyrWTLiysmftXQui7q8B0IY50GuVEVRiShiiX0fYm2Bz4dEToQvu
        Staiv64v854=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C14B3A8768;
        Fri, 12 Mar 2021 01:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C7A1A8767;
        Fri, 12 Mar 2021 01:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Subject: Re: [Bug] Stashing during merge loses MERGING state
References: <875z1xwznd.fsf@gnu.org>
        <YEpusE7ZIE5RgOws@coredump.intra.peff.net> <87a6r9o1yo.fsf@gnu.org>
        <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
Date:   Thu, 11 Mar 2021 22:09:42 -0800
In-Reply-To: <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
        (Phil Hord's message of "Thu, 11 Mar 2021 21:00:34 -0800")
Message-ID: <xmqq5z1wc389.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89ADE2AE-82F9-11EB-A4AD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Mar 11, 2021 at 12:45 PM Tassilo Horn <tsdh@gnu.org> wrote:
>> >> Or that popping the stash again would also restore the MERGING state.
>> >
>> > This would make more sense: the stash records that part of the state,
>> > and then we make it available again later when the stash is applied.
>> > However, that feature doesn't exist yet.
>>
>> Too bad.
>
> Consider also what happens when `git stash apply` results in a merge
> conflict because of differences between your current index and the one
> you had when you originally saved the stash.  This results in the
> usual merge conflict markers that then need to be cleaned up.

I agree with you that allowing a stash while a merge is in progress
will introduce many unpleasant corner cases the users wouldn't want
to deal with.  We certainly do prevent "git stash push" from running
when the index is still unmerged (which is a sign that a mergy
operation (like pull, rebase, merge, am -3, cherry-pick and revert
that stops due to a conflict in the middle) is in progress), but
once the end user resolves the conflicts in the index (either
manually, or having the rerere.autoupdate feature in effect), such a
sign of mergy operation still in progress that "git stash" currently
uses will be gone.  We should teach "git stash push" to pay
attention to other such signs like MERGE_HEAD etc. and stop before
creating a stash (and also do the same to "git stash pop/apply").

THanks.

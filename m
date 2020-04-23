Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4FC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54C820780
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B3DA0VoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDWVwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:52:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52102 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:52:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4AA5CDCB0;
        Thu, 23 Apr 2020 17:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EKohlfRvx3vT/dwYBhd/kL6xWwo=; b=B3DA0V
        oS0dPjxKUvxOiFXKriicTJutN2Sw0NBqs9weoP6lgS2qsCvYyVcrpVD8sxX7yZG2
        vSp4nzKcAgpNVvJ2GDNEYSHEH7AEqSKpnF0roRWXYv8q5Qtntj0MtnTdIIqZK3+A
        5YLsif/lsxNCUCSd6sKJIxbV/82XT5oi9L3Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bxUozuWzcno7YI/9DeR1ImFHaVF8VJkQ
        RbFKeYpOhwVdHGUV3DqmIouvqfKoqMC4ch8UV7geI+5T69QYIvwW77KnwxPn+IgZ
        QNbjZsF/ChVr0yOT5YuBigY0Er45TTcZAFEBRDzt2BXRa7ZSsxx4/fTNyGqFjMsP
        usBdMv5CH7A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC608CDCAF;
        Thu, 23 Apr 2020 17:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A7B3CDCAE;
        Thu, 23 Apr 2020 17:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v9 00/10] Reftable support git-core
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <xmqqmu74mwaw.fsf@gitster.c.googlers.com>
        <CAFQ2z_OhWDzc40WMy=bwUKRJQ4rcvnFmYvk-ga_cTtCjviMoBg@mail.gmail.com>
        <xmqqftctg9om.fsf@gitster.c.googlers.com>
Date:   Thu, 23 Apr 2020 14:52:29 -0700
In-Reply-To: <xmqqftctg9om.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 23 Apr 2020 14:43:21 -0700")
Message-ID: <xmqqblnhg99e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB3F6392-85AC-11EA-B2C4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>> For example,
>>
>> not ok 10 - check rev-list
>> #
>> # echo $SHA >"$REAL/HEAD" &&
>> # test "$SHA" = "$(git rev-list HEAD)"
>> #
>>
>> What is the right way to approach this? Should the test use
>>
>>   git update-ref HEAD $SHA
>>
>> instead of writing to the loose ref?
>
> Preferred.  
>
> I didn't bother checking the context, but if the test is checking
> "the history leading to $SHA has only one commit, i.e.  $SHA, and
> rev-list can handle that correctly", certainly that would be a
> preferred rewrite, rather than skipping the check for reftable,
> which may risk not noticing that HEAD is broken with reftable.

Now I have.  The test is about various low-level machineries we have
work correctly even if .git is *not* a directory but is a "gitfile:
$other location" (which is an underlying mechanism for multiple
worktree support etc.), and it is making sure "git rev-list"
understands HEAD in such a repository that uses the gitfile mechanism.

If I didn't know it, I might have said that "if we are interested in
seeing $SHA is a root commit, we should check it more directly,
perhaps by making sure 'cat-file commit $SHA' does not say 'parent'
and that won't need to write to .git/HEAD at all", but the point of
the test is to ensure 'rev-list' works correctly in such a
repository, I think "update-ref HEAD $SHA" would be the right "fix"
for the test.

Thanks.

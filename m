Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6AC433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2664E28
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhAaUyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:54:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56844 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhAaUyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:54:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E729B1D85;
        Sun, 31 Jan 2021 15:53:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q27ev4rT7hsO2wKRZ5pSlezSgVA=; b=ked6qF
        0KwAJgG6QHiOuL109Rvr5WdMk3VY4/6Zn92GkckWJyD074IuhXMyoi6hWYvhbzVs
        t1RNs4pt68G0iGn+qE8Nw9G2TLAvFFyt2xmPoFcYMSSmkwmeZT5GgIvlkI3yaRDH
        CzxM4OlBftVC/3P6uGuQYyzKaADNoTFSepV94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hJQesbMtyA1+weRz9wKnmtYfVZt6+k2n
        uYeplz2jiYQFkj3r4zWCRKPNBCyJTZZNDBkWpC+iyuQDSZY70vqNwgZvyl5vk54k
        tjrCqV9ICRarhUxHa7fiU/ePG9tjHRMRudTPlcewLDfnaRHFV6LiJ0bO2jjlH5iN
        3/rwxs5gvis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 477C2B1D84;
        Sun, 31 Jan 2021 15:53:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C83E6B1D83;
        Sun, 31 Jan 2021 15:53:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <66be51fb-f40c-5712-8e48-346ca53bd9e8@gmail.com>
Date:   Sun, 31 Jan 2021 12:53:30 -0800
In-Reply-To: <66be51fb-f40c-5712-8e48-346ca53bd9e8@gmail.com> (Derrick
        Stolee's message of "Sun, 31 Jan 2021 15:11:34 -0500")
Message-ID: <xmqq35ygomk5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60036CBA-6406-11EB-82A4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/30/2021 7:00 PM, Junio C Hamano wrote:
>> * ds/merge-base-independent (2021-01-28) 3 commits
>>  - commit-reach: use heuristic in remove_redundant()
>>  - commit-reach: move compare_commits_by_gen
>>  - commit-reach: use one walk in remove_redundant()
>>  (this branch uses ak/corrected-commit-date; is tangled with ds/chunked-file-api.)
>> 
>>  The code to implement "git merge-base --independent" was poorly
>>  done and was kept from the very beginning of the feature.
>> 
>>  Will merge to 'next'.
>
> Please hold off until I can push a new version. There were
> some meaningful updates to the new algorithm, but also there
> is value in the old algorithm when the commit-graph does not
> exist (and the heuristic doesn't answer quickly). I'll comment
> more in that thread.

Thanks, will do.

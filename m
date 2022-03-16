Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E771C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiCPTzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiCPTzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 15:55:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D81A399
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:53:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B94571282F5;
        Wed, 16 Mar 2022 15:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CIJG1XqdK6Z9lB3cGhtlvisE5Kz6hknbfriA10
        IVwx8=; b=BYV/QuvtW/ebfHgTvtrg8mrjfhgFUBsggZ+9Z+3D5iEAFM9Ast1kOC
        QWLV2zu+h21x0Dqhf8Bqignc07hKybIvTKXBu9STxNhNcTE6ZHcF7JgpfQtIZOBS
        qT/IffJ/0hTblluVdLnAt8IaUt2RK241jZrDwLUjv7ir67bCp45yg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B11DD1282F4;
        Wed, 16 Mar 2022 15:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2174E1282F3;
        Wed, 16 Mar 2022 15:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: gc/recursive-fetch-with-unused-submodules (was Re: What's
 cooking in git.git (Mar 2022, #03; Mon, 14))
References: <xmqq5yogp6xo.fsf@gitster.g>
        <kl6l5yodyej3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 16 Mar 2022 12:53:47 -0700
In-Reply-To: <kl6l5yodyej3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 16 Mar 2022 10:48:32 -0700")
Message-ID: <xmqqa6dpllmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB850EE6-A562-11EC-8714-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/recursive-fetch-with-unused-submodules (2022-03-07) 10 commits
>>  - submodule: fix latent check_has_commit() bug
>>  - fetch: fetch unpopulated, changed submodules
>>  - submodule: move logic into fetch_task_create()
>>  - submodule: extract get_fetch_task()
>>  - submodule: store new submodule commits oid_array in a struct
>>  - submodule: inline submodule_commits() into caller
>>  - submodule: make static functions read submodules from commits
>>  - t5526: create superproject commits with test helper
>>  - t5526: stop asserting on stderr literally
>>  - t5526: introduce test helper to assert on fetches
>>
>>  When "git fetch --recurse-submodules" grabbed submodule commits
>>  that would be needed to recursively check out newly fetched commits
>>  in the superproject, it only paid attention to submodules that are
>>  in the current checkout of the superproject.  We now do so for all
>>  submodules that have been run "git submodule init" on.
>>
>>  Expecting a reroll.
>>  cf. <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com>
>>  source: <20220308001433.94995-1-chooglen@google.com>
>
> Is 'Expecting a reroll.' accurate? <xmqqr17dp8s9.fsf@gitster.g>
> indicated that this topic would be queued.

"Queuing" is just that.  It may stay there for a while and be
dropped unless it sees a decent progress (if it is expected to be
further worked on).  That's vastly different from merging down to
'next'.

I just re-read the message with "will queue" in it, and I only said
the changes listed as updates from v4 looked all sensible, which
does not mean the changes listed there are sufficient to correct all
problems we may already had in v3.

Downthread in <xmqq4k46nae4.fsf@gitster.g> and its response, I see
we agree that "reading .gitmodules in a particular superproject
commit is just as wrong as reading from the working tree---it should
not be necessary to fetch in the submodule, and the API to get the
necessary parameter to run fetch in the submodule should be cleaned
up" and that "fixing that API can be left outside the scope of this
topic for the sake of expediency".  I would at least expect the two
decisions are described in an updated log message of relevant steps.

Thanks.



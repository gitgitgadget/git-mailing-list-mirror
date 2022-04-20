Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08921C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381266AbiDTRqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381270AbiDTRqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:46:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188F47394
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:43:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7319F115004;
        Wed, 20 Apr 2022 13:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FuDqZsLKJq7rHExETj2eKR6uoj4QktfjZlMtk6
        0ubGI=; b=AuCWyA+J7D0aU4adY0khPCXQxMryYx9m25FnK0zUvD4Id0rNYp4FiF
        vXH9pHUs4cMN+0fGGHgqEdSvWmInTNwOmvahDMJWnPfnT5sJvLVMUf22C42w0zCz
        z84hND44yeobYnL/xTJevIx4iCbzMn9S0A0Ew55aBHQiuVYC4cFwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B9D115003;
        Wed, 20 Apr 2022 13:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA101115002;
        Wed, 20 Apr 2022 13:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for
 matching branches
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
        <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <Yl2qwO0SMPOhb5h9@google.com>
        <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
Date:   Wed, 20 Apr 2022 10:43:24 -0700
In-Reply-To: <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
        (Tao Klerks's message of "Wed, 20 Apr 2022 07:12:06 +0200")
Message-ID: <xmqqczhbr6pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 617B1FCE-C0D1-11EC-BAE9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> However, I
>> wonder how users for whom this may be useful are going to discover this
>> option? I don't expect that such users are going to be watching Git's
>> release notes looking for new features such as this, or carefully
>> reading documentation changes.
>
> Honestly, I was being a bit selfish here - I effectively control the
> gitconfig of "my" users, so I was planning on enabling this by default
> and letting it "settle in" in git at large, eventually proposing to
> change the default.

I am afraid that it is double disservice to your users.  Once they
graduate your organization, they notice that their Git does not work
as they expect and puzzled.

> ...
> To choose either option permanently, see push.default in 'git help config'.
> ---
>
> I would propose to add one sentence at the end along the lines of:
> ---
> To instead avoid automatically configuring upstream branches when
> their name doesn't match the local branch, see option 'simple' of
> branch.autosetupmerge in 'git help config'.
> ---
>
> Does that make sense to you?

Two questions.

 - If a user follows the push.default advice, does it have any
   advantage to set branch.autosetupmerge=simple at all?

 - If a user follows the branch.autosetupmerge=simple advice, what
   happens their "git push" on a branch that the .merge is not set
   due to this configuration?  Shouldn't they have to set up the
   push.default for these branches anyway?

While it might be a good thing to mention branch.autosetupmerge
configuration variable, I am not sure if "To instead avoid" is a
good thing to say here.  It sounds as if the user can ignore
push.default as long as branch.autosetupmerge is taken care of, but
I suspect that is not the case.  Setting the latter to 'simple'
means there are *MORE* branches that do not have .remote/.merge set
up, doesn't it?  Which in turn means that we are relying more on
what push.default is set to, right?

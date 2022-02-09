Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19886C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 23:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBIXhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:37:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiBIXhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 18:37:15 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B1E05046F
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 15:37:18 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3271C190818;
        Wed,  9 Feb 2022 18:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yjasIf4tBHMU0J8SBGDUObkYo8Pj6T3I1bRLco
        TKKm4=; b=FvqIY8mD5R38D1CBU1w3GROlixv3PZpTMv6F3La+FJDCqbhlx3ZqW4
        ZrBcYvFTp1npoR1hPIT0eq/lP0hO8rL0m4d7EKMp75vqYX1gzEyFl60GTkeIPJV+
        /3QEFK8yOyoN7asFxJk3TsCBk5O98y0fc2ox1RdKFDvZtSEqvcLbg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B4CE190817;
        Wed,  9 Feb 2022 18:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85A14190816;
        Wed,  9 Feb 2022 18:37:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH v3] clone, submodule: pass partial clone filters to
 submodules
References: <20220209224406.495563-1-jonathantanmy@google.com>
Date:   Wed, 09 Feb 2022 15:37:14 -0800
In-Reply-To: <20220209224406.495563-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 9 Feb 2022 14:44:06 -0800")
Message-ID: <xmqqfsor628l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3680AFCA-8A01-11EC-94B8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>>  Documentation/config/clone.txt     |  5 ++++
>>  Documentation/git-clone.txt        |  7 ++++-
>>  Documentation/git-submodule.txt    |  6 ++++-
>>  builtin/clone.c                    | 36 ++++++++++++++++++++++++--
>>  builtin/submodule--helper.c        | 30 +++++++++++++++++++---
>>  git-submodule.sh                   | 17 ++++++++++++-
>>  t/t5617-clone-submodules-remote.sh | 41 ++++++++++++++++++++++++++++++
>>  t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++
>>  8 files changed, 175 insertions(+), 8 deletions(-)
>
> Thanks for this patch. "clone" currently calls "submodule update" in
> order to perform the clone in the submodule, and "submodule update" then
> calls "submodule--helper", so I would expect changes in all 3 files.
> Looking at the summary above, that indeed is the case.
>
>> @@ -544,4 +544,45 @@ test_expect_failure 'grep saves textconv cache in the appropriate repository' '
>>  	test_path_is_file "$sub_textconv_cache"
>>  '
>>  
>> +test_expect_success 'grep partially-cloned submodule' '
>
> [snip]
>
>> +		# Verify that we actually fetched data from the promisor remote:
>> +		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log >/dev/null
>
> No need to redirect to /dev/null, but probably not worth a reroll on its
> own.

I can strip it while queuing, then.

> This patch looks good to me.
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Agreed.  Thanks, both.


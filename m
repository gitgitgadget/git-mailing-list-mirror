Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EA8C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6077320737
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHHMo/bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgCKSiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:38:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58926 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKSiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:38:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A1A0C5561;
        Wed, 11 Mar 2020 14:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eCMSgJoAftjU/5GqwCQN+9B1dX0=; b=jHHMo/
        bR5lJeDSLgINYzaauY90tPdsf6No77RXx8oNaMWtwbNyuaWokXD8gYsOms2XfivM
        ggu2N3Y62hCTs+h5plBSVOdNGmUJDcUYcjxjoz1Ot1fQgXOFlVJMf90fybu6tZ/c
        bZgoKuf3ECThmDV7rbKWwDWwoibj8vNm9j1z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z1hBVRn1QzqFdLavJ3hnuZGWx0TKk38b
        ZLLdZU8a00K/4B5iVeQzWE3OHkkCna9efxA3IlSO6B4oTRWd1hCkHYjlVo6qHlGO
        XB7dYhMwn8IFRy7DhArf/lM/QoHXBzub2rcuraHCDSd1J0fDkTxk4zLRPKI1l2qn
        CE+Cok62kx8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22858C5560;
        Wed, 11 Mar 2020 14:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68BDBC555F;
        Wed, 11 Mar 2020 14:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: clear CHERRY_PICK_HEAD upon dropping a become-empty commit
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
        <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
        <94eec36b-581a-17eb-7aeb-2d24c90b8e73@gmail.com>
Date:   Wed, 11 Mar 2020 11:38:18 -0700
In-Reply-To: <94eec36b-581a-17eb-7aeb-2d24c90b8e73@gmail.com> (Phillip Wood's
        message of "Wed, 11 Mar 2020 10:30:43 +0000")
Message-ID: <xmqqwo7qhh45.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B2D8BF0-63C7-11EA-B92E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for fixing this, it needs to clean up MERGE_MSG as well though
>
> Best Wishes
>
> Phillip
>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>   sequencer.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 7477b15422a..8b4e0200c5f 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1957,6 +1957,7 @@ static int do_pick_commit(struct repository *r,
>>   		flags |= ALLOW_EMPTY;
>>   	} else if (allow == 2) {
>>   		drop_commit = 1;
>> +		unlink(git_path_cherry_pick_head(r));

When this fails for whatever reason, do we need to do something
special?  The same question for MERGE_MSG Phillip mentioned.

Thanks, both.

>>   		fprintf(stderr,
>>   			_("dropping %s %s -- patch contents already upstream\n"),
>>   			oid_to_hex(&commit->object.oid), msg.subject);
>>

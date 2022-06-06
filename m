Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A4CCA473
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiFFRQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiFFROx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:14:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3062BB05
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:07:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7E2A11A8D3;
        Mon,  6 Jun 2022 13:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J9pkERg1UnxuQ+nVb8svUlPOVVPbPYc7YZknso
        5b1Y8=; b=u/oskkHCAgIMU39oDFiQHkWjjpPI31CcgLTJliWVvcMJFKVsYX3LAK
        Pn7fIl/5pCfZyqE6NzA1Y9hvjQPXInX35aiIM+3vWfmXuWL3yIhgLxlivchXi4TF
        3ksZ6SOD3MicWWwLLIcTF8Gss/yQ6XzeQe481FTl9zQqrS/UsJTnI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D875211A8D1;
        Mon,  6 Jun 2022 13:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 431BC11A8CE;
        Mon,  6 Jun 2022 13:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/show-ref.c: avoid over-iterating with --heads,
 --tags
References: <3fa6932641f18d78156bbf60b1571383f2cb5046.1654293264.git.me@ttaylorr.com>
        <af32aefc-8184-94ff-fd80-76221dc313b4@github.com>
Date:   Mon, 06 Jun 2022 10:07:40 -0700
In-Reply-To: <af32aefc-8184-94ff-fd80-76221dc313b4@github.com> (Derrick
        Stolee's message of "Fri, 3 Jun 2022 22:33:47 -0400")
Message-ID: <xmqq35ghaffn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CAE8B1E-E5BB-11EC-9202-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> -	for_each_ref(show_ref, NULL);
>> +	if (heads_only || tags_only) {
>> +		if (heads_only)
>> +			for_each_fullref_in("refs/heads/", show_ref, NULL);
>> +		if (tags_only)
>> +			for_each_fullref_in("refs/tags/", show_ref, NULL);
>
> This looks a little silly if these were truly "only" (they
> could not both be true), but indeed they could both be true
> and the names are just slightly misleading.
>
> Indeed, t1403-show-ref.sh tests all combinations of these
> options.

Hmph, that is right. show-heads and show-tags, perhaps.

Thanks, both.  Queued.

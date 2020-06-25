Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D94C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 00:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FDD207DD
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 00:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYS6Erej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbgFYAip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:38:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60189 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbgFYAip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 20:38:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6047C7D73D;
        Wed, 24 Jun 2020 20:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WLZ7MaYFdJg6SidWmmNEcGUVFY=; b=LYS6Er
        ejEXoaEsHihRQekfn21+6JrZqORcXm3FCHqXXW5ORKhaT9zN2NDzQpgZhYfjzKeY
        vSjyTCmPWNKd+Xup0w4SBsbe77m4JRtsXB7geq7VxSD/p06ZdWL4Jq1snmDQsalo
        5m5OcKVLcZeMrfaf37FoJbIAapFmu8A8iqPXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eTrDejxykF233f1q2Z7mrM72059lhdGn
        wSQRZbB0YdMeyahIG5NI9hdsdZGV+8iexMfIbSnCh5tpHVAshi9FLfaQoy2Es3I/
        H62gW36J/IVsIBkaVMdRjw9XiATwPTtawYYomm5be4fOfSE0SgC7BaUdoSZe4/XC
        aujOWe9VJcE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 562E97D73C;
        Wed, 24 Jun 2020 20:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C51A7D73B;
        Wed, 24 Jun 2020 20:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        l.s.r@web.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <xmqqftak5aa0.fsf@gitster.c.googlers.com>
        <429f38a2-9346-f6f7-bd69-2fd63828ae7c@gmail.com>
Date:   Wed, 24 Jun 2020 17:38:42 -0700
In-Reply-To: <429f38a2-9346-f6f7-bd69-2fd63828ae7c@gmail.com> (Derrick
        Stolee's message of "Wed, 24 Jun 2020 19:32:56 -0400")
Message-ID: <xmqq7dvw5699.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 386518A8-B67C-11EA-8E54-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/24/2020 7:11 PM, Junio C Hamano wrote:
>> This does not seem to play well with what is in flight.  Tests seem
>> to pass with topics up to es/config-hooks merged but not with this
>> topic merged on top.
>> 
>>     1b5d3d8260 Merge branch 'ds/commit-graph-bloom-updates' into seen
>>     32169c595c Merge branch 'es/config-hooks' into seen
>>     ...
>> 
>> $ sh t4216-log-bloom.sh -i -v
>> 
>> ends like so:
>> 
>> ok 133 - Use Bloom filters if they exist in the latest but not all commit graphs in the chain.
>> 
>> expecting success of 4216.134 'persist filter settings':
>>         test_when_finished rm -rf .git/objects/info/commit-graph* &&
>>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>>         grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
>>         cp .git/objects/info/commit-graph commit-graph-before &&
>>         corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
>>         corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
>>         cp .git/objects/info/commit-graph commit-graph-after &&
>>         test_commit c18 A/corrupt &&
>>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>>         grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
>> 
>> not ok 134 - persist filter settings
>> # ...
>> 
>> Thanks.
>
> Thanks for letting me know. I'll investigate carefully with the
> rest of the 'seen' branch. This test is a bit fragile due to
> computed values for which bytes to replace, so anything that
> could have changed the length or order of chunks would lead to
> a failure here.
>
> Sorry for the disruption.

Oh, not at all.  Thanks for helping.

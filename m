Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1FC2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:30:11 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3451E206E5
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="anN757Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3451E206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDLWaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDLWaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 18:30:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F5C0A88B5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 15:30:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7197949AB3;
        Sun, 12 Apr 2020 18:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fMg2UvDqO10x8aNGrWuZKWBAtGU=; b=anN757
        PbWFYntaC4GC613Xur3c38N0PBNte/xhteJCqtSD/fP0J59bdrzwF79BShqS6wTX
        MKMCFixQm0NA2glqEg0bTZsa3Ytzz493MF1e1ryunGynEmc+c3eELN4kR2/auCIe
        HJCjFDb8deQQEE6qlSCUkQDmUEtd7NV50a8F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/eC0n/N7IZer/cgoyPqzTm7McDDylLr
        8GJ5kkY6ySqbxZmcRmDr0OPAKrmO9aijCTrHjszVVlb1S4VyEzH1/Tq6hHaogEmd
        Z6xlbGv/HxPQZ3LHZnNQJzdeUUpXXfav2tMygoPVbX9HY4eGhcI4dOr6MFlt/o/O
        Q4j4oKI46vM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50F0049AB2;
        Sun, 12 Apr 2020 18:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9540849AB0;
        Sun, 12 Apr 2020 18:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <20200412222210.GA53057@syl.local>
Date:   Sun, 12 Apr 2020 15:30:07 -0700
In-Reply-To: <20200412222210.GA53057@syl.local> (Taylor Blau's message of
        "Sun, 12 Apr 2020 16:22:10 -0600")
Message-ID: <xmqqa73gcp74.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29C7D716-7D0D-11EA-B3FD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I certainly wouldn't complain about a comment here explaining these
> three checks, but I suppose that the rationale is only a 'git blame'
> away (and I guess that is faster now after this series ;-)).
>
>> +	if (revs->prune_data.has_wildcard)
>> +		return;
>> +	if (revs->prune_data.nr > 1)
>> +		return;
>> +	if (revs->prune_data.magic ||
>> +	    (revs->prune_data.nr &&
>> +	     revs->prune_data.items[0].magic))

This says "any magic", but it is overly pessimistic to disable the
optimization for "literal" magic.  That magic is the one that lets
well written scripts to say "I have in a '$variable' that the user
gave me as a pathname (not pathspec), and it may have a wildcard
letter in it, but please treat it as a literal string" by prefixing
":(literal)" before that user-supplied data, so it is punishing well
disciplined folks.

>> +		return;
>> +
>>  	repo_parse_commit(revs->repo, revs->commits->item);
>>
>>  	if (!revs->repo->objects->commit_graph)
>> --
>> gitgitgadget
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

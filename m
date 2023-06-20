Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144AEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFTShN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjFTShM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 14:37:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1C10DA
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 11:37:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47E9F2A656;
        Tue, 20 Jun 2023 14:37:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JDvIUQ+z4xL/SFZLL6FW/uNh6cRwBJEqi8QPPY
        QlsFQ=; b=oLlycKdN/OMHY8UGHunv2gemt/BIH8EJyD5d0s+bnNBNoqojzPG4eS
        ehKYNF4cRXxV2ht+0LqYw0at0RE7dYPuyc4/NnF2oPKR/3DYlsCDwq+Do9hPhJnD
        y8YfPnJ/87PRVgy39++j9JbEmZRje8QDf0mkq8U9Z/3cMc3DquiDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 407D82A655;
        Tue, 20 Jun 2023 14:37:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61F5E2A653;
        Tue, 20 Jun 2023 14:37:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 4/4] commit-graph: new filter ver. that fixes murmur3
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1686677910.git.jonathantanmy@google.com>
        <5c65bf8a22d657c58b1109928b4298e95ccb56bf.1686677910.git.jonathantanmy@google.com>
        <4c5cadf2-bd70-c56e-3935-fb24b604f411@github.com>
Date:   Tue, 20 Jun 2023 11:37:06 -0700
In-Reply-To: <4c5cadf2-bd70-c56e-3935-fb24b604f411@github.com> (Derrick
        Stolee's message of "Tue, 20 Jun 2023 09:39:09 -0400")
Message-ID: <xmqqilbim14d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75B358AE-0F99-11EE-937D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> However, I think the 'settings->hash_version' is the wrong place
> to look for the condition. We should be getting this value from the
> commit-graph we are reading. (More on this later.)
> ...
>> -	if (hash_version != 1)
>> +	if (hash_version != d->commit_graph_changed_paths_version)
>>  		return 0;
>
> This makes it appear like we cannot read a commit-graph that has
> a Bloom filter version that doesn't match the configured version.
>
> This seems incorrect. If we want to configure to _write_ v2, we
> should still be able to _read_ v1 concurrently until those v2
> filters are written.

Good eyes.  Thanks for carefully reading.



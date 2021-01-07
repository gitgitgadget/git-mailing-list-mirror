Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA98C4332D
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1469522E03
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbhAGGix (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60249 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbhAGGix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 01:38:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3389B69E7;
        Thu,  7 Jan 2021 01:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zI/HAAS5RqJPg14ropoXY1c6Czo=; b=JLRC1o
        ukBtE0KdDyY6P4U1bRgyIJbi1ykjEA6iXyNEenlZAO58rtIyVMv+2x7haVwTKk7b
        9yjrp8UgS7coXywvwFSYKVJjftPUdBrYoDpd7tzkDd7BgeJ1aL6VRzLcrKVrFtIe
        KQkoDKR6+ppqRkPivyqJ3z9e/ouy/UXf4Ez4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qcXoahzkIpYcSDZQYVEP+NmTnL7Q7juy
        V446PkzlnfTxT2EiVkrT+RQbZaGqlRhnnpRXQihEwahKD/5H1OaVEsGO16ntzp7B
        Ylv91XKsYAq+WU6QZedC70FA+p+52Nh7byWyIQ9zSRSjjh+nsQM6JBiNn9OJXcg1
        vteWkZ+OQ0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA938B69E6;
        Thu,  7 Jan 2021 01:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27CF5B69E5;
        Thu,  7 Jan 2021 01:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
References: <20201228045427.1166911-1-seth@eseth.com>
        <20201228192919.1195211-1-seth@eseth.com>
        <20201228192919.1195211-6-seth@eseth.com>
        <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
        <20210107035806.GA530261@ellen>
Date:   Wed, 06 Jan 2021 22:38:09 -0800
In-Reply-To: <20210107035806.GA530261@ellen> (Seth House's message of "Wed, 6
        Jan 2021 20:58:06 -0700")
Message-ID: <xmqqy2h5meum.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E89A8E26-50B2-11EB-8E8F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Tue, Jan 05, 2021 at 09:55:26PM -0800, Junio C Hamano wrote:
>> If the user explicitly says "I want the new behaviour enabled for
>> this particular merge tool", we are better off letting the user use
>> it and take responsibility for the possible breakage.
>
> Good suggestion. Agreed on all counts. I'll roll that preference
> hierarchy into the v10 patch set.

By the way, do you have any idea why we see test breakages only on
macos when this topic is merged to 'seen'?

https://github.com/git/git/runs/1659807735?check_suite_focus=true#step:4:1641
https://github.com/git/git/runs/1659807735?check_suite_focus=true#step:5:2641

Thanks.

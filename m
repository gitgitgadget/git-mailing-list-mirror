Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC90C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BB820787
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKuScrfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438480AbgDOTjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:39:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52176 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438305AbgDOTjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 15:39:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87CE04B435;
        Wed, 15 Apr 2020 15:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+b1y/UMM53XGkhA3b31yZ6HuiU=; b=MKuScr
        fj9OB+L24R5HqIkJH3/lBGqLMJgId9h/ymYRd4FogcgWc6SDlUU7/+jdyjmP+Azk
        z71wpKyYV77kpFAVGxVVXEfLYdY45A+/9L2BojRy+TqTnaLj2f/6+whVjTGg9lZM
        TqtakhVLLhpdIFwucg9eaodJJ2d0OrCAbUiN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BPnRE4rmliLFx+F1M78tct1g7d2ITRNk
        5KoLP7ZyOytK2wF5hGi27sW0x7mW1ML/qm1VInGvrY3WwsrSQgx0sCghM34HhwUq
        iGBOon1nATA1HgNVJv7q1x/oSWstnUPbfUrGH06DPR1g8GfR9Y9mNtjkUjY3OxAG
        HtaqbA7V3Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FECE4B434;
        Wed, 15 Apr 2020 15:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 077384B432;
        Wed, 15 Apr 2020 15:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <xmqqeesthfbf.fsf@gitster.c.googlers.com>
        <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
        <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
        <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
        <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
        <xmqqr1wo5yud.fsf@gitster.c.googlers.com>
Date:   Wed, 15 Apr 2020 12:39:43 -0700
In-Reply-To: <xmqqr1wo5yud.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Apr 2020 12:32:42 -0700")
Message-ID: <xmqqmu7c5yio.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB3C4794-7F50-11EA-8070-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As you are, I am on the fence.  
>
> I do not think :(icase) pathspec is something we want to optimize
> for, but I still like this new hash function primarily because I
> suspect that it will increase the number of paths that you can cram
> into the filter without getting their hashes collided (hence getting
> false positive), under the assumption that real projects won't try
> to store too many pair of paths that are only different in their
> case...

Sorry, but no, I do not think there is such upside.  It may have
effects on the actual hash values to downcase paths that are
originally camelCased, but reducing the entropy of input paths that
way shouldn't have effect on the overall distribution and rate of
collision in any meaningful way (otherwise the chosen underlying
hash function would be broken).  So, sorry for the noise.




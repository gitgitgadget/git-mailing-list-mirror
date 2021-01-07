Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17EC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C6323444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAGV0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:26:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55192 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAGV0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:26:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E01D11DFEF;
        Thu,  7 Jan 2021 16:26:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EbQP4PcA5b0pXhczMZBI38Xi90k=; b=JMjB0/
        aAVHUbEIm5UOMpuFTuBXBokHYS4BvmwxDboNEF7vJtpYUdxF3be0LEmRWSCucwqv
        5Lz6FO4JCzeAvb2EDSLO7MwsxjAVVIbB/TldqYqwZH4ko/sz/Prp+G0A3BOFL0vQ
        hmEnnNUvELsTzb9LBSdabekzP46PDTE3Whbt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dj47Molu2deKHCGibOqyrGg1qOijOfy2
        gjNalhtmKO2jP21CYdi8aDGNEQrYiH6E9t10DDPOcoHCbF+4kVwMHlIEMsgXV1Lj
        AJuiE+h7xszlB2aLXTzmYqsJGN6xI1kiPeJalOk99IEGcEIwxJduIR4mbQp9FFy+
        mNi2FBGxGPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 258D311DFEE;
        Thu,  7 Jan 2021 16:26:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6880511DFED;
        Thu,  7 Jan 2021 16:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree
 extension
In-Reply-To: <5a1a51c1-7ada-6f66-a6d0-2fc01303d334@gmail.com> (Derrick
        Stolee's message of "Thu, 7 Jan 2021 06:51:03 -0500")
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
        <xmqqble1o5sc.fsf@gitster.c.googlers.com>
        <5a1a51c1-7ada-6f66-a6d0-2fc01303d334@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 07 Jan 2021 13:26:03 -0800
Message-ID: <xmqq8s94l9qs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3235AB8-512E-11EB-AD20-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> We later found out that we rather often compare the index against
>> the tree of HEAD (think: "git status"), and diff-lib.c::diff_cache()
>> does take advantage of the fact that an entire directory can be
>> skipped if the tree object taken from the HEAD side exactly matches
>> the tree recorded for the subdirectory in the cache tree extension.
>
> I need to read more about this. traverse_by_cache_tree() seems to
> be a good place to start. Thanks.

Ah, that one I forgot about.

What I had in mind was a different optimization that is far more
aggressive in unpack-trees.c::unpack_callback(); look for a comment
that begins with "Everything under the name matches".  The block
allows us to skip an entire subdirectory hierarchy.


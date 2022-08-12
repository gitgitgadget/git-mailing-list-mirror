Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DAC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiHLVVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiHLVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 17:20:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5187647C
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:20:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDC3D13DD36;
        Fri, 12 Aug 2022 17:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=njvhVwveSu6qnepspBTRuRVZToYAVmaE8CiCXD
        UX8vo=; b=kTOtZ2bifTPU771UnXWBkNh0/S71x0l41htdCIZhLNJz8Fn2iNbWOX
        ttS9IuELoQ05CbYrwlgkb6mdExxh/zydPg2jiauK/AT4uGzrbqeI44qhx2QHR+iI
        CqX5jsBaeYALKsoTQpnMK/P9f+x8NpEIx3DwIwW8k/32eYOn/Ores=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B229D13DD35;
        Fri, 12 Aug 2022 17:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28FF713DD34;
        Fri, 12 Aug 2022 17:20:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] scalar-diagnose: move functionality to common
 location
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
        <c19f3632d4f2f966517a276e7096742c8477125c.1660335019.git.gitgitgadget@gmail.com>
        <xmqq7d3db43z.fsf@gitster.g>
        <a728c894-4e4a-44c3-a1f5-f87c8bfae13a@github.com>
Date:   Fri, 12 Aug 2022 14:20:54 -0700
In-Reply-To: <a728c894-4e4a-44c3-a1f5-f87c8bfae13a@github.com> (Victoria Dye's
        message of "Fri, 12 Aug 2022 14:00:40 -0700")
Message-ID: <xmqqk07d9n0p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A69FFB4E-1A84-11ED-8E63-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> Improved error reporting in 'create_diagnostics_archive()'. I was
>> originally going to modify the "failed to write archive" error to trigger
>> whenever 'create_diagnostics_archive()' returned a nonzero value.
>> However, while working on it I realized the message would no longer be
>> tied to a failure of 'write_archive()', making it less helpful in
>> pinpointing an issue. To address the original issue
>> ('add_directory_to_archiver()' silently failing in
>> 'create_diagnostics_archive()'), I instead refactored those calls into a
>> loop and added the error message. Now, there's exactly one error message
>> printed for each possible early exit scenario from
>> 'create_diagnostics_archive()', hopefully avoiding both redundancy &
>> under-reporting.

Ah, I see.  I probably should have read the cover letter before
responding.  I try to understand the new iteration _without_ relying
on the cover letter first, to ensure that the resulting history is
still understandable; when I see something questionable, however, I
should see if cover letter gives more context and clues.  Sorry for
the noise.


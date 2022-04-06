Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBFBC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiDFQod (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbiDFQmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:42:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB32153AA
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:02:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CC7A19FC2D;
        Wed,  6 Apr 2022 11:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/c3l3Cw8ijN6NcOmpFOEX6M4+O5M00ei40H9jc
        iPwrI=; b=Ice7ygu8jdxhTgUWcFcZJYSmUZQKO+NVx3OTW8f26cbeY+AuAjk4hs
        oR/qedd5NujAyDCMgmNashCjnNs1qIFsKWLMxF5qe3ge7YGI2lvExSQ5Q7g3aT+7
        fS3VtRHHNxNCcnm5vksX2V7vJp/oIW1rgfgugFeBa5pjEVGkDgw+c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3524819FC2C;
        Wed,  6 Apr 2022 11:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8AFF519FC2B;
        Wed,  6 Apr 2022 11:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Git List'" <git@vger.kernel.org>
Subject: Re: ns/batch-fsync (Mon Apr 4, 2022)
References: <xmqqilropo3z.fsf@gitster.g>
        <20220404232014.GA75@neerajsi-x1.localdomain>
        <034a01d8487c$0e067b40$2a1371c0$@nexbridge.com>
        <CANQDOdemQOTLRVkEHBcWtVLPxE_ujzeO0idutD4Zi3zOPzah7A@mail.gmail.com>
        <038101d848e9$a921e3e0$fb65aba0$@nexbridge.com>
Date:   Wed, 06 Apr 2022 08:02:39 -0700
In-Reply-To: <038101d848e9$a921e3e0$fb65aba0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Tue, 5 Apr 2022 08:35:35 -0400")
Message-ID: <xmqq1qya2r1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AB6A230-B5BA-11EC-A244-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On April 5, 2022 12:36 AM, Neeraj Singh wrote:
>>On Mon, Apr 4, 2022 at 4:31 PM <rsbecker@nexbridge.com> wrote:
>>> On April 4, 2022 7:20 PM, Neeraj Singh wrote:
>>> >On Mon, Apr 04, 2022 at 01:53:04PM -0700, Junio C Hamano wrote:
>>> >> * ns/batch-fsync (2022-03-30) 14 commits
>>> >>  - core.fsyncmethod: performance tests for batch mode
>>> >>  - t/perf: add iteration setup mechanism to perf-lib
>>> >>  - core.fsyncmethod: tests for batch mode
>>> >>  - test-lib-functions: add parsing helpers for ls-files and ls-tree
>>> >>  - core.fsync: use batch mode and sync loose objects by default on
>>> >> Windows
>>> >>  - unpack-objects: use the bulk-checkin infrastructure
>>> >>  - update-index: use the bulk-checkin infrastructure
>>> >>  - builtin/add: add ODB transaction around add_files_to_cache
>>> >>  - cache-tree: use ODB transaction around writing a tree
>>> >>  - core.fsyncmethod: batched disk flushes for loose-objects
>>> >>  - object-file: pass filename to fsync_or_die
>>> >>  - bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
>>> >>  - bulk-checkin: rename 'state' variable and separate 'plugged'
>>> >> boolean
>>> >>  - Merge branch 'ns/core-fsyncmethod' into ns/batch-fsync
>>> >>
>>> >>  Introduce a filesystem-dependent mechanism to optimize the way the
>>> >> bits for many loose object files are ensured to hit the disk  platter.
>>> >>
>>> >>  Will merge to 'next'?
>>> >>  source: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
>>> >
>>> >Please expect a reroll today to address the remaining issues in that
>>> thread.
>>>
>>> Does this relate to why I cannot compile with the new fsync code at
>>> 2.36.0-rc0?
>>>
>>
>>I'm sorry I missed the error report.  Could you please share the compiler errors
>>you observed?
>
> Please see this thread: https://public-inbox.org/git/034101d84873$993f96f0$cbbec4d0$@nexbridge.com/

The sentence with the question mark wonders if we want to merge the
topic to 'next' (hinting that it is not even in 'next' yet right
now).  I do not think it affects anybody's build of -rc0.

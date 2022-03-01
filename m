Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36949C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 06:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiCAGp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiCAGp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 01:45:26 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80E70CD6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 22:44:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3BD310CF0D;
        Tue,  1 Mar 2022 01:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iOZoyl2EFOrwu8xyffmiPr98hpIu6jbrcrotoa
        GaUY4=; b=hS4mqQAdDLFJJNtdiP1U2jvoWZhQgq9G6XCqSzfbXSvEE65B8Ah/Mi
        7h5wT7kLcEKjGggWh3AmjyaMYDEcPQ+5uvmKNW91PGOPsHeIdBcEKB0ifq0lqjsS
        G8K+p3gi+wDp4hNIdMHUDXoh+Ce1m9y6oq5hgKK1o4h3fJ++JhN6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A45910CF0C;
        Tue,  1 Mar 2022 01:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDB4F10CF0B;
        Tue,  1 Mar 2022 01:44:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: make informational messages from recursive
 merges clearer
References: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
        <xmqqsfsh5btd.fsf@gitster.g>
Date:   Mon, 28 Feb 2022 22:44:42 -0800
In-Reply-To: <xmqqsfsh5btd.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        17 Feb 2022 15:10:38 -0800")
Message-ID: <xmqqwnheuq79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13F72356-992B-11EC-80DE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> One other thing to note here, that I didn't notice until typing up this
>> commit message, is that merge-recursive does not print any messages from
>> the inner merges by default; the extra verbosity has to be requested.
>> merge-ort currently has no verbosity controls and always prints these.
>> We may also want to change that, but for now, just make the output
>> clearer with these extra markings and indentation.
>
> Yup, I found that the messages on inner conflicts, especially when
> they "cancel out" at the outer merge, are mostly noise that carries
> very little useful information (by being noisy, the user gets a sense
> of how complex the histories being merged are).  Reducing the default
> messaging level would probably be a good idea.

Here is what I just had to scroll through to update 'next' by
merging back 'master', only to grab the updates to the release
notes.  Needless to say, this would have been somewhat baffling
if I didn't know to expect it.

It would be good to squelch it before we hear another complaints
from old-timer power users ;-)

$ git merge -m 'Sync with master' --no-log master
  From inner merge:  Auto-merging blame.c
  From inner merge:  Auto-merging builtin/am.c
  From inner merge:  Auto-merging builtin/blame.c
  From inner merge:  Auto-merging builtin/clone.c
  From inner merge:  Auto-merging builtin/clone.c
  From inner merge:  Auto-merging builtin/commit.c
  From inner merge:  Auto-merging builtin/fetch.c
  From inner merge:  Auto-merging builtin/fetch.c
  From inner merge:  Auto-merging builtin/grep.c
  From inner merge:  Auto-merging builtin/hash-object.c
  From inner merge:  Auto-merging builtin/log.c
  From inner merge:  Auto-merging builtin/log.c
  From inner merge:  Auto-merging builtin/pack-objects.c
  From inner merge:  Auto-merging builtin/pull.c
  From inner merge:  Auto-merging builtin/pull.c
  From inner merge:  Auto-merging builtin/rebase.c
  From inner merge:  Auto-merging builtin/rebase.c
  From inner merge:  Auto-merging builtin/reflog.c
  From inner merge:  CONFLICT (content): Merge conflict in builtin/reflog.c
Auto-merging builtin/reflog.c
  From inner merge:  Auto-merging builtin/reset.c
  From inner merge:  Auto-merging builtin/sparse-checkout.c
  From inner merge:  Auto-merging builtin/sparse-checkout.c
  From inner merge:  Auto-merging builtin/submodule--helper.c
  From inner merge:  Auto-merging builtin/submodule--helper.c
  From inner merge:  CONFLICT (content): Merge conflict in builtin/submodule--helper.c
Auto-merging builtin/submodule--helper.c
  From inner merge:  Auto-merging builtin/worktree.c
  From inner merge:  Auto-merging cache.h
  From inner merge:  Auto-merging config.c
  From inner merge:  Auto-merging config.h
  From inner merge:  Auto-merging diff-merges.c
  From inner merge:  Auto-merging diff.c
  From inner merge:  Auto-merging git.c
  From inner merge:  Auto-merging gpg-interface.c
  From inner merge:  Auto-merging grep.c
  From inner merge:  Auto-merging grep.c
  From inner merge:  Auto-merging notes-merge.c
  From inner merge:  Auto-merging object-name.c
  From inner merge:  Auto-merging pack-bitmap-write.c
  From inner merge:  Auto-merging parse-options.c
  From inner merge:  CONFLICT (content): Merge conflict in parse-options.c
  From inner merge:  Auto-merging parse-options.h
  From inner merge:  CONFLICT (content): Merge conflict in parse-options.h
  From inner merge:  Auto-merging refs.c
  From inner merge:  Auto-merging revision.c
  From inner merge:  Auto-merging sequencer.c
  From inner merge:  Auto-merging sequencer.c
  From inner merge:  Auto-merging sparse-index.c
  From inner merge:  Auto-merging submodule-config.c
  From inner merge:  Auto-merging t/t1091-sparse-checkout-builtin.sh
  From inner merge:  CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
Auto-merging t/t1091-sparse-checkout-builtin.sh
  From inner merge:  Auto-merging t/t1512-rev-parse-disambiguation.sh
  From inner merge:  Auto-merging t/t4202-log.sh
  From inner merge:  Auto-merging t/t4202-log.sh
  From inner merge:    Auto-merging t/t4202-log.sh
  From inner merge:  Auto-merging t/t4202-log.sh
  From inner merge:  Auto-merging t/t4202-log.sh
  From inner merge:  Auto-merging t/t5316-pack-delta-depth.sh
  From inner merge:  Auto-merging t/t6120-describe.sh
  From inner merge:    Auto-merging t/t6120-describe.sh
  From inner merge:  Auto-merging worktree.c
Merge made by the 'ort' strategy.
 Documentation/RelNotes/2.36.0.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)



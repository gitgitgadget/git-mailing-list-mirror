Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27479EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjF3V4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3V4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 17:56:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0D3C0E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 14:56:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99F3B1A5460;
        Fri, 30 Jun 2023 17:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AtXml2ZjT1JHDvjfBbbYikshDvCxkvQrjLoDoK
        3NUh4=; b=vQUn9Wtk90DvxwUgsZGlL6oDg+SfymcZ1sPWu3p+6mSR/f+VVkayBP
        3TINglIo2ghvuongQMOA9cbXe5hzPTTyePLR4rWeqCJo68H6ikjHpW8I1+IsqTq+
        mk5X2HGzLjnM+2LogokCcwJzCthcQgC3tpvKKw0Tccaq/G0ulbn/s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90E3C1A545F;
        Fri, 30 Jun 2023 17:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFEDE1A545E;
        Fri, 30 Jun 2023 17:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 0/6] git-compat-util cleanups
References: <20230606170711.912972-1-calvinwan@google.com>
        <20230630202237.3069327-1-calvinwan@google.com>
Date:   Fri, 30 Jun 2023 14:56:31 -0700
In-Reply-To: <20230630202237.3069327-1-calvinwan@google.com> (Calvin Wan's
        message of "Fri, 30 Jun 2023 20:22:37 +0000")
Message-ID: <xmqqjzvk62cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9DFBCE0-1790-11EE-9A2F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Changes since v3:
>  - Dropped patches 5 and 6 since removing the circular dependency in
>    common.h turns out to be quite difficult
>  - Patch 8 moves the alloc macros to git-compat-util.h rather than
>    common.h since that does not exist anymore

Will queue.

> Note for the maintainer:
>
> I rebased this series onto both seen and next and they rebased cleanly.

Thanks.  It is a very indirect way to ensure if the topic is usable,
though.  What we want is:

 * A series of patches that applies cleanly to 'master'.  Call the
   result of applying them $T (topic).

 * "git checkout next && git merge $T" should give at most trivial
   conflicts.

 * The same for 'seen'.

If the conflicts with topics in 'seen' are only with topics in the
stalled category and/or expecting a reroll category, we may discard
the other topic have _their_ reroll worry about adjusting for this
topic.

FWIW, I did

 (1) tentatively applied these patches to 'next^0', and discarded
     the result.

 (2) applied these patches with "-3" to 'master^0', which saw a bit
     of conflicts in gpg-interface.c (with cw/strbuf-cleanup topic)
     and in strbuf.c (again with cw/strbuf-cleanup topic).

 (3) to cross check the result, merged (2) into 'next^0' to make
     sure that it matches (1).

 (4) merged (2) into 'seen^0'.

As this round has been rebased to a more recent codebase, even with
the conflicts with cw/strbuf-cleanup, (4) indeed merged fairly
cleanly, with the same set of conflicts as (3).

Thanks for rebasing the patches.

Hopefully people will be able to review and give feedback to the
series this time.

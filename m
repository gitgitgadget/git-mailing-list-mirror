Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B3C4361B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F86F20679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAZV7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:59:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52853 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbhAZFt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 00:49:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8E94A67B7;
        Tue, 26 Jan 2021 00:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CghboWFxJOYjCehfXWBw7sFK/yg=; b=keTOvX
        ZoQNubm9Ssa9m3CrmgUUNBVAyCeHFlPPmhXigmH2Th2g+VybEqxgCcKgTafC63Hx
        5hg6d8l3EA7oQ2RxYl7U0ukcfJJtJeA5hbOE05ZovLB2tIxJljwFx8ls7Qa06pUs
        ofeQfSKdAEiKeun3+z02epDgr5MHXvT+5dc+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pj2ing1DWkYtNVtFQNZZOczqhSjjvMmc
        xhRUa+1Xomeaa2p6kwur9qpynetkVTeOl7NMxXJdPpxHXey+nrEakvINES1DDZQ2
        kkHqSsCr+UuHUN/V60mafYDHvCSLjh15IqYePJsl2vKO/YQRVRuvCCRklVQkiHml
        knQEt2/eKuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF4D4A67B5;
        Tue, 26 Jan 2021 00:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70016A67B4;
        Tue, 26 Jan 2021 00:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] doc/reftable: document how to handle windows
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 21:49:11 -0800
In-Reply-To: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 25 Jan 2021 15:38:45
        +0000")
Message-ID: <xmqq35yo459k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3771CB36-5F9A-11EB-9BB4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  $ cat .git/reftable/tables.list
> -00000001-00000001.log
> -00000002-00000002.ref
> -00000003-00000003.ref
> +00000001-00000001-RANDOM1.log
> +00000002-00000002-RANDOM2.ref
> +00000003-00000003-RANDOM3.ref
>  ....
> @@ -940,7 +944,7 @@ new reftable and atomically appending it to the stack:
>  3.  Select `update_index` to be most recent file's
>  `max_update_index + 1`.
>  4.  Prepare temp reftable `tmp_XXXXXX`, including log entries.
> -5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}.ref`.
> +5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}-${random}.ref`.
>  6.  Copy `tables.list` to `tables.list.lock`, appending file from (5).
>  7.  Rename `tables.list.lock` to `tables.list`.

Is this because we have been assuming that in step 5. we can
"overwrite" (i.e. take over the name, implicitly unlinking the
existing one) the existing 0000001-00000001.ref with the newly
prepared one, which is not doable on Windows?

We must prepare for two "randoms" colliding and retrying the
renaming step anyway, so would it make more sense to instead
use a non-random suffix (i.e. try "-0.ref" first, and when it
fails, readdir for 0000001-00000001-*.ref to find the latest
suffix and increment it)?

> @@ -993,7 +997,7 @@ prevents other processes from trying to compact these files.
>  should always be the case, assuming that other processes are adhering to
>  the locking protocol.
>  7.  Rename `${min_update_index}-${max_update_index}_XXXXXX` to
> -`${min_update_index}-${max_update_index}.ref`.
> +`${min_update_index}-${max_update_index}-${random}.ref`.
>  8.  Write the new stack to `tables.list.lock`, replacing `B` and `C`
>  with the file from (4).

Likewise.

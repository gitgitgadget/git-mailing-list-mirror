Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B39C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiDFV3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiDFV3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:29:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCD419894C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:32:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79F33172A07;
        Wed,  6 Apr 2022 16:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=09k8Ox2lzQ3j+xyoo2j1lY8GxlUwmfvQWbUCDK
        dM/CI=; b=KUUZRvbX1xDhEgNuwOdOJa4kBSga/M0Zk3p/f2o0ZxRVrGWnWT6IY7
        HKRUnnNzFc3B5hMer/Qw7G64b+E+12m8FIzITk22BlrW+vmHAE5CqQbdILuZQmcd
        B01HIwbhRiFvhB6wQ/x3PyfeFuOIs9iSjE/WseYaT9UcVGtEqiy2g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 728D9172A06;
        Wed,  6 Apr 2022 16:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D93A8172A05;
        Wed,  6 Apr 2022 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     nksingh85@gmail.com
Cc:     gitgitgadget@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, bagasdotme@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, neerajsi@microsoft.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: Re: [PATCH v6 00/12] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <20220405052018.11247-1-neerajsi@microsoft.com>
Date:   Wed, 06 Apr 2022 13:32:14 -0700
In-Reply-To: <20220405052018.11247-1-neerajsi@microsoft.com> (nksingh's
        message of "Mon, 4 Apr 2022 22:20:06 -0700")
Message-ID: <xmqq7d82x8a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B96E64-B5E8-11EC-974C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nksingh85@gmail.com writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> GGG closed this series erroneously, so I'm trying out git-send-email. Apologies for any mistakes.
>
> This series is also available at https://github.com/neerajsi-msft/git/git.git ns/batched-fsync-v6.
>
> V6 changes:
>
> * Based on master at faa21c1 to pick up ns/fsync-or-die-message-fix. Also resolved a conflict with 8aa0209 in t/perf/p7519-fsmonitor.sh.
>
> * Some independent patches were submitted separately on-list. This series is now dependent on ns/fsync-or-die-message-fix.
>
> * Rename bulk_checkin_state to bulk_checkin_packfile to discourage future authors from adding any non-packfile related stuff to it. Each individual component of bulk_checkin should have its own state variable(s) going forward, and they should only be tied together by odb_transaction_nesting.
>
> * Rename finish_bulk_checkin and do_batch_fsync to flush_bulk_checkin and flush_batch_fsync. The "finish" step is going to be the end_odb_transaction. The "flush" terminology should be consistently used for making changes visible.
>
> * Add flush_odb_transaction and use it in update-index before printing verbose output to mitigate risk of missing objects for a tricky stdin feeder.
>
> * Re-add shell "local with assignment": now these are all on a separate line with quotes around any values, to comply with dash. I'm running on ubuntu 20.04 LTS where I saw some of the dash issues before.

Thanks.  These looked all sensible.

Wil queue.

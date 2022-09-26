Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27589C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIZT2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIZT2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:28:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77F5AC47
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:27:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1DB01C6A7A;
        Mon, 26 Sep 2022 15:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HG8mWUfuFxbjxQHNIj95N3J1GHjtcTmvGvm3G9
        5fj+4=; b=pTyNKH7OQyenUUeQ8K4izRo0HkQVc8M5oPuF9EkVRTvOA4xSn+XSYE
        8scUyPkkzlHeW0Z5O4b5iyRPAs5sClvBKo3np3WKlkhL2wDP9X49TDHyWcrj39e1
        lzdNlGE0CAhYJoPAvE5zRy/67MYBISVjGRJ42007BHaWBn1Id7Rto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA6581C6A79;
        Mon, 26 Sep 2022 15:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95E531C6A77;
        Mon, 26 Sep 2022 15:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/3] gc: replace config subprocesses with API calls
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <260d7bee36e1af2f6a6a8791d293402e97a502e6.1664218087.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 12:27:53 -0700
In-Reply-To: <260d7bee36e1af2f6a6a8791d293402e97a502e6.1664218087.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 26 Sep 2022
        18:48:06 +0000")
Message-ID: <xmqq35cendfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51AFE1F6-3DD1-11ED-896D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'git maintenance [un]register' commands set or unset the multi-
> valued maintenance.repo config key with the absolute path of the current
> repository. These are set in the global config file.

OK.  This step is new but it looks reasonable.  

Embarrassingly sadly, we open, rewrite, and close the configuration
file for each of these "proper API calls", so the IO load is not
reduced, even though we do not have to spawn extra processes ;-)

All three patches queued.  Thanks.

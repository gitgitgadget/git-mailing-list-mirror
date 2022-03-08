Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A356C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbiCHAvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiCHAvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:51:12 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673C28E29
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:50:17 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C16D12F56B;
        Mon,  7 Mar 2022 19:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kWUwK54T6BiOLbu/j5jAvQbpVFWk+BUoIv1KYd
        IrlBw=; b=ahAUf82xa8/FUNnQe3FA8nGnDemF8/fgHEXdvcpyBYdi50da9zGJED
        m3Q8UM6ixntcxAssf7icPr4ZORt5dB2Vh8z3cfEtZdAB+H479zF6FMtNY9vxTqfN
        YI4MZu68rAJFCur2ylkPXiGesh7a5LzMU9Rwdo0ym8V/zntpb5Q7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7456B12F56A;
        Mon,  7 Mar 2022 19:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E102F12F569;
        Mon,  7 Mar 2022 19:50:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220304005757.70107-1-chooglen@google.com>
        <20220308001433.94995-1-chooglen@google.com>
Date:   Mon, 07 Mar 2022 16:50:14 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com> (Glen Choo's message
        of "Mon, 7 Mar 2022 16:14:23 -0800")
Message-ID: <xmqqr17dp8s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B825FF8A-9E79-11EC-A3ED-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>   It's true that we don't need <.super_oid, .path> in order to init the
>   subrepo, but it turns out that recursive fetch reads some
>   configuration values from .gitmodules (via submodule_from_path()), so
>   we still need to store super_oid in order to read the correct
>   .gitmodules file.

OK, but then do we know which .gitmodules file is the "correct" one,
when there are more than one .super_oid?  Or do we assume that
.gitmodules does not change in the range of superproject commits we
have fetched before deciding what commits need to be fetched in the
submodules?

> == Since v4
> - Rename test helpers (s/check_/write_expected_)
> - Test style fixes
> - Update test comments
> - Remove the manual test_cmp in the test that checks sub2 (but we still
>   construct expect.err.super manually).

All of these changes looked sensible.

Will queue.  Thanks.

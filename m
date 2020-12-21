Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2EC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A6322AAE
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgLUTBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:01:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59135 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLUTBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:01:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AAFB107A91;
        Mon, 21 Dec 2020 14:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SK54bhHx6Bw6JX/sRlCinwrVoFg=; b=oto5xa
        APM0A+472m1VRe/iy5jhyYq/cHkyBJeiTQSQGhPE3RO1yJGws7NT7SQ06KPEnzbw
        jMBHXzPqlqoYEjZpoJzQzUAgj55fi5yotO973uUK5TCO4KojJALFzX1+ZVpvlcoQ
        B2sgHmdEp+OfFnS1dHv2s/ld/+Y0k8b/GAkwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ti5bC4oBPVnRD7I/nQF0nxf+QRTul3pv
        +IFdTHV7hNnHRp9EUDHKu4eYl5cUMgwySirBGCtD0kg9DPKDar6mJI/uf3uM6uEU
        uYJQnulcXfeEDY5rD7+yYJ521LaNVfPzb4cEuRT5ePqEvuCWB52RWPaafErBCwBv
        EK4Hamke8QY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22DC6107A8F;
        Mon, 21 Dec 2020 14:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42A11107A8E;
        Mon, 21 Dec 2020 14:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
        <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
        <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
        <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
Date:   Mon, 21 Dec 2020 11:00:21 -0800
In-Reply-To: <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 21 Dec 2020 02:07:31 -0500")
Message-ID: <xmqqa6u7m1bu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7622A94-43BE-11EB-99B5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Finally, as this is a one-off case, it might be simpler just to drop
> this patch altogether and open-code the cleanup in the test itself in
> patch [2/3] rather than bothering with test_config() in that
> particular case. For example:
>
>     test_when_finished "test_unconfig -C two remote.one.push" &&
>     git config -C two --add remote.one.push : &&
>     test_must_fail git -C two push one &&
>     git config -C two --add remote.one.push ^refs/heads/master &&
>     git -C two push one

That would be my preference, too.  Thanks for carefully and
patiently reviewing.


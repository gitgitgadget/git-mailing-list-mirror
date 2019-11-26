Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A8C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D1D2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YN6B4fX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZBME (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:12:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55337 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKZBME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:12:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0674A94767;
        Mon, 25 Nov 2019 20:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5l2OD7TA7oKPNTJ20iuqbhDY18=; b=YN6B4f
        X50wXa6qIKhCecVvYaE5fn6KUShS8jE2XQ0NcjxZk+xHfxidqpM6hztTrXU6WB73
        6KpayK8a3fuaoHoom2n0G0ahmSFOGY03RAgN9X/0LkKSjiBBhSKCOG9WMXYvDhnJ
        tCHywj272pBcMCHWibQmBVXayFSXwVou4MNUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ONMJPVMyhY/PWuEq7wnYaomjiMv/Mlh4
        r8JWgGuf6p+L425zLGzU+VSEJSKXVf99kd2FhR+xpJxH/78CQBEOdNhouTos/nU8
        bZLXGExkUwqSJRTdbiP6Iw1crUGzhKkgJb/VT1PHz93SAyh06Hu8m2vibqDM41mi
        VoqSvHcBtj8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0F7E94766;
        Mon, 25 Nov 2019 20:12:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28FBB94764;
        Mon, 25 Nov 2019 20:11:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
        <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
        <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
        <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
        <94573071-556b-caae-b159-40c168a08f44@gmail.com>
        <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
        <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com>
Date:   Tue, 26 Nov 2019 10:11:56 +0900
In-Reply-To: <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com> (Phillip Wood's
        message of "Mon, 25 Nov 2019 14:23:26 +0000")
Message-ID: <xmqqy2w3wieb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BED7C7B2-0FE9-11EA-9535-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> +test_expect_success 'fixup on orphan branch errors out' '
>>> +
>>> +       test_when_finished "git switch master" &&
>>> +       write_script switch-branch.sh <<-\EOF &&
>>> +       git symbolic-ref HEAD refs/heads/does-not-exist &&
>>> +       git rm -rf .
>>
>> That "git rm -rf ." scares me, though.
>
> I know I'm not too keen on it my self but we need to empty the
> worktree and index if we're going to switch to an unborn branch

"checkout --orphan" takes you to an unborn branch.  If you need to
also be with no contents in the index and nothing in the working
tree, then "git rm -r ." may be needed, but applying a fixup without
the target content does sound like asking for a conflict already.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3937C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC3C22D2B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhAWTwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:52:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58247 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWTwS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:52:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEDD89D9E1;
        Sat, 23 Jan 2021 14:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ULsex2FQgyVESft+WsS9dpft0tg=; b=xXDXTn
        pkLcZRxWjAHAhwxdq/6JxNCHtU0qHeC91selv6jBOBzTK02w+i81SA/KGoo6wN6P
        UnVrV2AI9YfIMlDMh+NM4ou45kLtefJyctkoZkLkAjgVSQXJty9fL2UIuOFTCf9n
        VVc83pJ/uXBeUcHTfXmkjFN0EElIs0KhzWvZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=plpf4pMGuhYrgT576aEEBnBg4nLkSZx6
        FsHbFsh1NHacQK5STVIYyMRhq4YtoPPuf1TQSXCULFYImML5wdhIffPiqIPVo/Ez
        PQuP59YZxNULQB7vbnOSqXiET74RscpSBGRqOmYI1dsq8eR/4q0l5OoHRJIW1Ovd
        dXsW0ryP/sc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 951889D9DF;
        Sat, 23 Jan 2021 14:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0160F9D9DB;
        Sat, 23 Jan 2021 14:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] ls-files.c: add --deduplicate option
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <07b603fd97c0e2d7a70407da552c3c0658a84731.1611397210.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 11:51:34 -0800
In-Reply-To: <07b603fd97c0e2d7a70407da552c3c0658a84731.1611397210.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 23 Jan 2021 10:20:10
        +0000")
Message-ID: <xmqq4kj74ek9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EA090C-5DB4-11EB-A87D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Additional instructions:
> In order to display entries information,`deduplicate` suppresses
> the output of duplicate file names, not the output of duplicate
> entries information, so under the option of `-t`, `--stage`, `--unmerge`,
> `--deduplicate` will have no effect.

That information belongs to the end-user documentation.

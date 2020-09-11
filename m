Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16130C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B477F22208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5f2cX6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgIKTTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:19:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58202 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgIKTTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:19:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C548EC525;
        Fri, 11 Sep 2020 15:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xFM6jtMHY/WZ63FKQEYvjaPnrhQ=; b=x5f2cX
        6Jn1F0Rdx3iHnvfla28haI1apF//K308PSjk7qfATvugSPAhRm/ByTjh7L5dUHrC
        xsdZVIbo9VjV6cQT8Po22ocWpFgD3FDOZ3TCgE72NdXF15YuQYbSz0Qfhxib0fGn
        PJufqYBAFIc3M0ODW322oEb6NGdnGof8RQ3Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fy2bX3ClgHQ4gyM4VaDo6KVMBadPqwQ/
        PFV1nDDqHMLUUEwojKKdUxXOyuLwfX4Kr0LuMZAF0KtnylDX360YgWRvh2bT5CSF
        fbQmMlSYc/3OyJgnD9cP6W6/YvjARbB2K0szjoOVI4JoQ87HabRYTJXGMoKKua4B
        cjzYZ1sKCSw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74B0CEC524;
        Fri, 11 Sep 2020 15:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B47DDEC522;
        Fri, 11 Sep 2020 15:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
        <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
        <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com>
Date:   Fri, 11 Sep 2020 12:19:15 -0700
In-Reply-To: <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com> (Philippe
        Blain's message of "Fri, 11 Sep 2020 09:05:42 -0400")
Message-ID: <xmqqk0x0nmto.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF42C176-F463-11EA-BD35-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I understand, but I would argue that such a user could easily adapt their
> script to add '--no-recurse-submodules' to their ls-files invocation if that 
> is the case, no ?

It would have been quite a different story if we were designing
"ls-files" and adding support for "--[no-]recurse-submodules" and
"submodule.recurse" to the command at the same time.  To those who
write scripts with "ls-files" and complain that the command behaves
differently depending on the configuration, you can legitimately say
"you can use --no-recurse-submodules and you are fine" in that case.

But not after all these years.  The same statement becomes "even if
I broke the command, users could work around the breakage I caused".
That is nothing more than a lame excuse that does not explay why you
think you have the right to break their script in the first place.

So, no, I am not enthused to see this change.  Regardless of which
configuration variable affects the feature.  For those who wrote and
use scripts that run ls-files, it is a regression to invite unneeded
complaints from their end-users who suddenly see the breakage in the
scripts.




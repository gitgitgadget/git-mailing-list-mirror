Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2C9C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E002074B
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQMgE8LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgCKUSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:18:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55424 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbgCKUSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:18:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8694A63695;
        Wed, 11 Mar 2020 16:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ltJKdIEdv9tCVyEeB0pBHKDUJRo=; b=ZQMgE8
        LIkmNg000lqfKvcMFwYiGWi8PGaC6qJlljZthaP02p9Y+YK5MAAcnG4ndzyBRx+X
        fdl3l37SJ7GXdlXBqEhdIEz8uffuhmbwJrx8pj7NlR507Gz5rgwJPk3NLrEl6a3w
        4YXSYUTAQgE1GCdbvr9we97d/wsxpuQ1DyHuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtrZZtniSsPzWj1F8nJgq6eMrJiBl2/E
        rlQn598+PgLicskU+ZUv4UWQ0+t410Xe3s39Ma/xx5efT9ASQv0MuYawpaYMIO6P
        i8k9Tdc0tr1DRvbs6xBfzG4fWjYKVEWnTZMaUAzJKMY8jG5eRYJluKNcjQBpsjlX
        SklAjc2yon4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C82063694;
        Wed, 11 Mar 2020 16:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB5AD63693;
        Wed, 11 Mar 2020 16:18:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: clear CHERRY_PICK_HEAD upon dropping a become-empty commit
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
        <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
        <94eec36b-581a-17eb-7aeb-2d24c90b8e73@gmail.com>
        <xmqqwo7qhh45.fsf@gitster.c.googlers.com>
        <20200311192720.GB27978@coredump.intra.peff.net>
Date:   Wed, 11 Mar 2020 13:18:42 -0700
In-Reply-To: <20200311192720.GB27978@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Mar 2020 15:27:20 -0400")
Message-ID: <xmqq5zfahcgt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80D9AF30-63D5-11EA-8864-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 11, 2020 at 11:38:18AM -0700, Junio C Hamano wrote:
>
>> >>   	} else if (allow == 2) {
>> >>   		drop_commit = 1;
>> >> +		unlink(git_path_cherry_pick_head(r));
>> 
>> When this fails for whatever reason, do we need to do something
>> special?  The same question for MERGE_MSG Phillip mentioned.
>
> I don't think there's much we _can_ do. The other call-sites seem to
> just ignore failures. I suspect turning those into unlink_or_warn()
> would be a good idea (and should be safe; it treats ENOENT as a noop, so
> anything it reports should be an actual error worthy of the user's
> attention).
>
> But probably it would make sense to do that consistently for all of
> those calls, and that doesn't need to be part of the 2.26 fixup.

Yes, I think that is a sensible way forward.

Thanks, all.

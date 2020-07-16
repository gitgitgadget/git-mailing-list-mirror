Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BE8C433E8
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CEB2083B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q3EPR1kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgGPRcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:32:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgGPRcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:32:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA1078405;
        Thu, 16 Jul 2020 13:31:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JcNoZPUqF536uPpllUbLW2wEBoI=; b=q3EPR1
        kAIkox752s74iyJB7eU+e00/XoaVEBZU4IQUMNrCR9xdCtuQ1qjOfGJWUsSYsBgj
        vyFdJKNug/3YHcIn+8ruaaB7lH+TIhs87mDfrAV/t/tLjnbhLa1gLTHC3lKw16VO
        fnXL6L3a/4C8L3yjin+TEaNpQPkI9oCPeWLGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tEUtSW5Fh5kdKyQRaNHWo5AJL0DJWZJ8
        LaziRO2ZqUVtc4I/ZiEyXSB41olW/d9p/3sooZ7gJEyNaGuVweS57tF3EWkSqE+X
        h877WXag78BoWn3Bhx+PXLY5LcY03IhbbL47YIciZcSJ5uieKaKo9fK+4+/vAw/W
        VUVIpX/CTmY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D67FE78404;
        Thu, 16 Jul 2020 13:31:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 562FB78403;
        Thu, 16 Jul 2020 13:31:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alireza <rezaxm@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Request for adding a "clean" merge strategy for a double-commit merge to deal with conflicts separately
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
Date:   Thu, 16 Jul 2020 10:31:56 -0700
In-Reply-To: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
        (Alireza's message of "Thu, 16 Jul 2020 21:45:24 +0430")
Message-ID: <xmqqo8ofgycz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8B14D8-C78A-11EA-954F-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alireza <rezaxm@gmail.com> writes:

> The proposal is that an option like `-X clean` would commit a clean
> merge and leave out any conflicting hunks in the tree for a follow-up
> commit to resolve conflicts.

You need to clarify what "leave out" means to you.  If you and a
side branch started from the same place and you did one thing while
the side branch did something else, you would get a conflict.

What would the "clean" (by your definition) result have in that
block of contents that actually has a conflict?  Do you mean to say
"Pick our version and ignore theirs in the blocks where the changes
conflict"?  If so perhaps -Xours merge strategy option that the
recursive backend offers is what you are looking for?

Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02FAC38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F2F2176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkxINlL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBXVGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:06:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54473 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:06:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08F6A5210F;
        Mon, 24 Feb 2020 16:06:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uqbiNrWUEtC+ZH1Vf8tHmCwn/Kc=; b=TkxINl
        L4Y3a0Ui3Km/XLHuvcL437YD+YSutC8nbVTT2Y2aOkTizr8tVW7xwBLK1wN1Gyyw
        r6D8N/V9PDqwWI2onjy+wDsVTjoSfM/FdMsoI5lMLdzK5hr0UI7Ij/InBltrxZtw
        oHzocoq81QtUOX/JVDJ6/tnjGNx0jUr0ckjQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rLTmY5ta46YPGk5Lf3+cWMFp3y/3yCJn
        PVc27KYLnsYB4xicol8YS+lMZtvkVDJMAhwv8rrwYofE57dAx22yOOZSAriPDkLx
        yCf/63LUgG276tmfdcuQ9kgRNKkZs6iQKOHz+GU8w0fVU7eDTRZ4V36Xjsr9e/sU
        et9K+Hx6gQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 000565210E;
        Mon, 24 Feb 2020 16:06:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61DE75210D;
        Mon, 24 Feb 2020 16:06:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>
Subject: Re: [PATCH 3/3] worktree: don't allow "add" validation to be fooled by suffix matching
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
        <20200224090848.54321-1-sunshine@sunshineco.com>
        <20200224090848.54321-4-sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 13:06:19 -0800
In-Reply-To: <20200224090848.54321-4-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 24 Feb 2020 04:08:48 -0500")
Message-ID: <xmqqv9nvofuc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81728824-5749-11EA-A41F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Avoid the problem of potential accidental matching against an existing
> worktree by instead taking advantage of find_worktree_by_path() which
> matches paths deterministically, without applying any sort of magic
> shorthand matching performed by find_worktree().

Combination of 2/3 and 3/3 makes perfect sense as "fix once and for
all" solution.

Thanks.

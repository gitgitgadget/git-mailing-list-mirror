Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B84C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E505B2078E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tS1rGtEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgFXAJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:09:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXAJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:09:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 899CDD480F;
        Tue, 23 Jun 2020 20:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9NwHomVekM154aApYbJ3PK3FtNU=; b=tS1rGt
        EFH7GlCVQmSHTX0tlGJ+SdahFKK9UtKITjIgykpt2oBWi25xEL8XSgBeEpOdDO72
        kZmmRTuRurHri1dtHNKhiwFDvNBNJmEVHulUlg72nPFrU7M++Ifie9rT6o/fBc7h
        w/mh/DfBhuQstNqcXkPMPMXw3gZDWu8dMRjQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JDwPgXKFwkIRLfoohJkCsXS1IWzDtjJ5
        FRlkEgkTDaMw2XQaYpR6Q0TF2gt4dOz/xBYV+j13xXIy+2vV4QFYkZ7742dvgLY6
        MHe3v0jhKUgRmkKyl3ZJegpuK6yRuo1bXThLHATtAD7iLgX2ONOZA99mNtNFP5zi
        Cb9j4/3XOJI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 816CCD480E;
        Tue, 23 Jun 2020 20:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9187D480D;
        Tue, 23 Jun 2020 20:09:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files correctly
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:09:18 -0700
In-Reply-To: <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        12:48:03 +0000")
Message-ID: <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3428DDC-B5AE-11EA-AFF8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In `run_diff_files()`, files that have been staged with the intention to
> add are queued without a valid OID in the `diff_filepair`.
>
> When the output mode is, say, `DIFF_FORMAT_PATCH`, the
> `diff_fill_oid_info()` function, called from `run_diff()`, will remedy
> that situation by reading the file contents from disk.

The above is true.  What do we do for a path that is actually added
to the index but is stat-dirty or actually modified in the working
tree when we are giving the raw output?  Don't we give 0{40} to mean
"we dunno---you go look at the working tree"?  I think we should do
the same for i-t-a file wrt the object name.  In both cases, the
index does not know what the actual object name is, and we do not
want to run the index_path() and write out a new object in the
object database.

Using the status letter 'A' would also be appropriate, as we would
show "new file ..." in the --patch output in this case, which would
be consistent.


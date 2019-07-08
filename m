Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295701F461
	for <e@80x24.org>; Mon,  8 Jul 2019 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfGHTXH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 15:23:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56541 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 15:23:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C597415A3B1;
        Mon,  8 Jul 2019 15:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wgHqZWPCtKN8U/2iD+1ZlRu4DwM=; b=j2/Zq+
        xd7DjrGgs2xz1drm4tvhTrUTFcfCYwIZ6TTvoDbvbCi0uv7YCEeNvkc+OAfpBH92
        9nGklDjzIzQyEzqa8hJpzNTDwA/BYXdfRBCJ20owiyWkGZlYEuqK9/Lcf6JcBiPS
        Xcp9/RY9rHPCeda2eQLx+FeqpyH9/p/veWuE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y38uhdoUlLvSWVKGvXPDplQ49SquX4FD
        F35ZRRnLZR32egf1ZdcXhJGt/zHpgUefkNrdCE/nfkvL2tc2j6n4Rz+OyXXTWBJ5
        CKtHRdw39OVf6/RHDX5PdFdbkptQl0IOdAAxH8fztYrqb7Y5Shx2Xw/REMMMGiSI
        eugq7mAfJ8w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0EC815A3B0;
        Mon,  8 Jul 2019 15:23:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F41D515A3AF;
        Mon,  8 Jul 2019 15:23:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation on NTFS
References: <pull.216.git.gitgitgadget@gmail.com>
        <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jul 2019 12:23:00 -0700
In-Reply-To: <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Jul 2019
        02:14:40 -0700 (PDT)")
Message-ID: <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD7D15D0-A1B5-11E9-9D28-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> A `+` is not a valid part of a filename with Windows file systems (it is
> reserved because the `+` operator meant file concatenation back in the
> DOS days).

The title of the cover letter had "windows" in it, so calling '+'
illegal was OK, but this patch does not.

I'd rather not to take this patch, because "generate in the target
with plus appended, make sure it succeeds, and then rename it to the
real target" is quite an established pattern not limited to the
Documentation/ directory of this project, if your tooling has been
supporting it and can continue to do so (which was the impression I
got from the cover letter).  Even the top-level .gitignore file
knows about it, so does the top-level Makefile and it uses the same
pattern.


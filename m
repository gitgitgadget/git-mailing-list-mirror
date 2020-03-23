Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B344C10DCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DFD20663
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMP+WSTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCWU0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:26:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51255 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWU0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:26:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF3CC56715;
        Mon, 23 Mar 2020 16:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QQZywkP4I47YA8u2TzBhP+sfN20=; b=vMP+WS
        TSHOmFLY3fL0All/O7Rdm5USqeCgFQTqLrkYXoyTiGRtwbcvM/CbFyKQmdPYxCNO
        nZc4oJkQZxR96iGVjkhWSKG0ZR/pafkrisk8O8M9bsYGPP7FnVwGFG6vmK2d7Lda
        wCRYT8MSi0LFGvz0WhxVkbVi5O8+fVBiR4NMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oUjFjkemNFSNY1K6LQTLpR9UkfNTqU8w
        O5wOFIUR5/EkrcKYT7xxFxLwMzGg7qgZh9w8zyhDaYMQhNSdijkBxQga7Zs5oM+f
        Sj99fGaDmPBrfIKni4187733h7kga6VnpWkzLSKSU3wWJQh/Ip2D1SJmcQWWsXJL
        mlxK/HF44c4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2EDC56714;
        Mon, 23 Mar 2020 16:26:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F164156713;
        Mon, 23 Mar 2020 16:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/18] Sparse checkout improvements -- improved sparsity updating
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <1a58492d-4e09-c12b-ff53-2f2b9cb2e28b@gmail.com>
Date:   Mon, 23 Mar 2020 13:26:03 -0700
In-Reply-To: <1a58492d-4e09-c12b-ff53-2f2b9cb2e28b@gmail.com> (Derrick
        Stolee's message of "Mon, 23 Mar 2020 14:41:49 -0400")
Message-ID: <xmqqh7ye4y3o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85525364-6D44-11EA-95C3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Changes since v1:
>> 
>>  * addressed several cleanups highlighted by Stolee (and I picked 'reapply'
>>    for the new subcommand name)
>>  * added three new minor cleanup commits (patches 2-4)
>>  * several new patches to adjust the warning messages to look like warnings
>>    (patches 11-15)
>>  * display warning messages when paths are unmerged (patch 16)
>>  * also make checkout and other unpack_trees()-using commands not error out
>>    when unable to set the SKIP_WORKTREE bit (patch 17)
>
> I'm very happy with the updates in this version.
> ...
> This is going to help the UX around sparse-checkout quite a bit!
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both of you.  Will queue.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E2C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C081613D3
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDTWwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:52:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63021 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:52:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EA17137D28;
        Tue, 20 Apr 2021 18:51:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QlflMzc1Ee67z19LgSiKiE3sMqM=; b=reJRWr
        ErFshVGoM/a+GNDLJt6rX5HL5WQsr0u6o15pPMUGMrHSZjIjMpv1LeRf1euEAXqz
        HGURe13Wd5pq/rK25KMi+W2fX0k5EEsCTCDUVq+qg0ESeTfZ+qpbL9q/qiQ7X1FI
        SNjXM3nnMH+eeCWHxBwbcelw0ZLezYZ6eof6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pen1i8JxqoEnejVU40+nCzxY8RrINrHi
        91Z61fZWXiTe0cHcQIT05MuZRLGHkcvVsbjFMCn20Q/D2orWF8HT2LvMe4MZ77C9
        8iisc+DUgdk7+KuqCEOPRrKCiV0G8bTtRVkfR/mZatmuprXEY6j1dSEQzbFm3PIJ
        XYUJ562cCbw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8AF7137D27;
        Tue, 20 Apr 2021 18:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE8E1137D24;
        Tue, 20 Apr 2021 18:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 05/18] t1413: use tar to save and restore entire .git
 directory
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <223583594c0089ef259e83f2f10c08fd94f55959.1618829583.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 15:51:23 -0700
In-Reply-To: <223583594c0089ef259e83f2f10c08fd94f55959.1618829583.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        10:52:50 +0000")
Message-ID: <xmqqfszk36z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF17F88C-A22A-11EB-A72D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This makes the test independent of the particulars of the storage formats.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1413-reflog-detach.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
> index bde05208ae6a..b699c2bb7c31 100755
> --- a/t/t1413-reflog-detach.sh
> +++ b/t/t1413-reflog-detach.sh
> @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  
>  reset_state () {
> -	git checkout main &&
> -	cp saved_reflog .git/logs/HEAD
> +	rm -rf .git && tar -xf .git-saved.tar

Unlike GNUism longer option names like "tar --extract", you do not
need a single dash when you ask "tar xf" (see our Makefile).

Looking at t/t5000-tar-tree.sh, we seem to be supposed to use "$TAR"
(with double quotes) to name the tar utility, so that people can say
TAR=gtar on certain platforms.  I suspect that there already are a
few existing violations but let's not make it worse.

>  }
>  
>  test_expect_success setup '
> @@ -17,7 +16,7 @@ test_expect_success setup '
>  	git branch side &&
>  	test_tick &&
>  	git commit --allow-empty -m second &&
> -	cat .git/logs/HEAD >saved_reflog
> +	tar -cf .git-saved.tar .git

Likewise 

	"$TAR" cf ...

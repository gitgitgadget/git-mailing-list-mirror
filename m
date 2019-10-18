Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35F71F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409324AbfJRBXH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:23:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59111 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391934AbfJRBXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:23:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A52A94552;
        Thu, 17 Oct 2019 21:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ql9ZjzC1WIvguAcr6nM1HOlVRkw=; b=rIY5tH
        1XfuAZ1Cr4vsSjhs0+rHqyuRKnD0IWHlesfxc2rmQ5nBnGRwtoB3sQvEZ1XH25zY
        vC2vglofDwOu9tatSSYnwQVCb6wII0QZ3syR9Kp/NJAC1vibZ3yZSTeiiqwIRtoz
        qk1SN8YFRm4BY2ySR/pUX1dnlV7Ileur8DFNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BAvZf+nSVaYwdwx9tyL8OLY4c1W3Z/Jo
        v9UKoaHCVHKCcO9/Z1Xg2zsF2xLUXjNYwmE6eGZjoblIRnYUlMEcKfgDSXIzT/JT
        2LogZpbdnxrjjFnEOQW0HBpa5d1Juyntrh6N5E7HFv7UOa2qsyKmx93vbEGRjH8w
        rpTCZg8ReiY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4227D94551;
        Thu, 17 Oct 2019 21:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 631A79454F;
        Thu, 17 Oct 2019 21:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] git_path(): handle `.lock` files correctly
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
        <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Oct 2019 10:23:00 +0900
In-Reply-To: <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 17 Oct 2019
        22:07:57 +0000")
Message-ID: <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D40D7400-F145-11E9-8A72-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Ever since worktrees were introduced, the `git_path()` function _really_
> needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
> specific to the worktree). However, the wrong path is returned for
> `logs/HEAD.lock`.
>
> This does not matter as long as the Git executable is doing the asking,
> as the path for that `index.lock` file is constructed from
> `git_path("index")` by appending the `.lock` suffix.

Is this still git_path("index") or is it now HEAD?

> Side note: Git GUI _does_ ask for `index.lock`, but that is already
> resolved correctly.

Is that s/but/and/?

> diff --git a/path.c b/path.c
> index e3da1f3c4e..ff85692b45 100644
> --- a/path.c
> +++ b/path.c
> @@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
>  	int result;
>  	struct trie *child;
>  
> -	if (!*key) {
> +	if (!*key || !strcmp(key, ".lock")) {

We only do strcmp for the tail part at the end of the path, so this
should probably OK from performance point of view but semantically
it is not very satisfying to see a special case for a single .suffix
this deep in the callchain.  I wonder if it is nicer to have the
higher level callers notice ".lock" or whatever other suffixes they
care about and ask the lower layer for a key with the suffix
stripped?

Will queue.

Thanks.

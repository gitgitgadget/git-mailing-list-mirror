Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705DCC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353969AbiCPRHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbiCPRHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:07:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6346B2D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:05:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F034126C80;
        Wed, 16 Mar 2022 13:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SCpA+NOYIykHryQflA/rPd+fw1nTYues19dgXL
        zCTCk=; b=YuasBBE8oGuuVUgRZfBDmHxMgHotdL8UoZvAKp8QbmUvsR3ZzoGCaS
        SRmzeVCwN6zXwWuBjXolUUwduhTnthE9q7B/m6GGjDl8CI2j4SlIfMkl6aDTp/5d
        /znp/lPtDZ+IJymE/Zl/bWVBtl0iqK+tFkld6/63QLrg7cU2qQNN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1040C126C7F;
        Wed, 16 Mar 2022 13:05:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61F1E126C7E;
        Wed, 16 Mar 2022 13:05:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to a
 ref
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-5-sandals@crustytoothpaste.net>
Date:   Wed, 16 Mar 2022 10:05:44 -0700
In-Reply-To: <20220310173236.4165310-5-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:34 +0000")
Message-ID: <xmqqk0ctn7yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51BE3E5A-A54B-11EC-80FB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 128f0a01ef..582a04dbab 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -33,6 +33,7 @@ static const char * const git_stash_usage[] = {
>  	   "          [--] [<pathspec>...]]"),
>  	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
>  	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
> +	N_("git stash export (--print | --to-ref <ref>) [<stashes>]"),

If you mean we can take zero or more stash entries, the way to write
it I think is 

	[<stash>...]

cf. a few lines above about <pathspec>.

> +static const char * const git_stash_export_usage[] = {
> +	N_("git stash export (--print | --to-ref <ref>) [<stashes>]"),
> +	NULL
> +};

Likewise.

I think we agreed that it is a better design to reuse the actual
stash entries as one of the parents of the exported chain element
(while using another parent to string the entries together), so I
won't comment on the actual implementation that recreates multi-way
merge commits with no relation to the stash entries, which we won't
see in the next iteration.

Thanks.






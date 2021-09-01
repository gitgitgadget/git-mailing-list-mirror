Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F1AC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16CE6108B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbhIARUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:20:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54117 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbhIARUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:20:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 274DBCE97F;
        Wed,  1 Sep 2021 13:19:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VhUkx7UdUDH9iKYWY233HHvp4xfCHTYRl8NuAk
        BGXI8=; b=F8CPdJaK+EG6shgCXkI0RTyTgvk7xdBPMjzCFtNTzHogw+ce7H8sCJ
        AMV0nKbrEEue2FTPg5dCYcYornigFxTvBB9dhGkFM7n4NDr2DZEbvkDBJKREiboO
        YZ95PWO2rffLWpuE1Kg7BpIT+CXCm81+RzS6YMyG3MoYoxu4mYjf4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09CC0CE97E;
        Wed,  1 Sep 2021 13:19:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29B7BCE97B;
        Wed,  1 Sep 2021 13:19:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 1/7] merge-ort: mark a few more conflict messages as
 omittable
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <df6e2774f1a5560a598dd8b46131bc6b0a261d4a.1630376800.git.gitgitgadget@gmail.com>
        <xmqqzgsxs4rk.fsf@gitster.g>
        <CABPp-BEZjMLGFxSsTfRnAffom9CKRU4if4PsdTh+85L6D=FseA@mail.gmail.com>
Date:   Wed, 01 Sep 2021 10:19:04 -0700
In-Reply-To: <CABPp-BEZjMLGFxSsTfRnAffom9CKRU4if4PsdTh+85L6D=FseA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 31 Aug 2021 17:03:07 -0700")
Message-ID: <xmqqk0k0qkmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B57A3DB0-0B48-11EC-96B8-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Creating this file means you see something like this in the
> remerge-diff (note there are diffs for two files, with the synthetic
> file appearing just before the file it has messages about):
>
> diff --git a/dir/my.fil e.conflict_msg b/dir/my.fil e.conflict_msg
> deleted file mode 100644
> index 2bd215a32f06..000000000000
> --- a/dir/my.fil e.conflict_msg
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -== Conflict notices for my.file ==
> -CONFLICT (modify/delete): dir/my.file deleted in HASH1 (SHORT
> SUMMARY1) and modified in HASH2 (SHORT SUMMARY 2).  Version HASH2
> (SHORT SUMMARY2) of  dir/my.file left in tree.

I do not know if my reaction should be "Cute" or "Yuck" ;-)

Hopefully nobody uses .conflict_msg as a suffix for their files.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95CCD13DA
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjIRQKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIRQJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:09:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B49173D
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:08:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 972781BD988;
        Mon, 18 Sep 2023 12:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=LWLwoSuP+Ylf1yEbzzT9Xb1hHp0DVDzQ2u6Trl
        lrcKM=; b=pcX+xqARXwas9m/0vYVUu2QohGQqtLwPcvDXfBJzWJKVC7inTJiIfU
        y2fkfyJ5JT/rCoGuGfwrGFXTcSS2IRUnETugk5Rsyg/BsAIQvm4/4DrvxO9oKcA1
        VLpNGTuhMalzllvdQQWpGXHgeG04IQmK8DMivUOrExunz2NUBr0rk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F4C91BD987;
        Mon, 18 Sep 2023 12:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 020521BD986;
        Mon, 18 Sep 2023 12:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Izzy <winglovet@gmail.com>
Subject: Re: [PATCH v5] merge-tree: add -X strategy option
In-Reply-To: <67638fd7-ad63-4e20-87e1-bef121fef197@gmail.com> (Phillip Wood's
        message of "Mon, 18 Sep 2023 10:53:48 +0100")
References: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
        <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
        <67638fd7-ad63-4e20-87e1-bef121fef197@gmail.com>
Date:   Mon, 18 Sep 2023 09:08:25 -0700
Message-ID: <xmqqcyyfmpl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99E9E4B4-563D-11EE-8B8C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ...
> This is the right place to call parse_merge_opt() but I think we
> should first check that the user has requested a real merge rather
> than a trivial merge.
>
> 	if (xopts.nr && o.mode == MODE_TRIVIAL)
> 		die(_("--trivial-merge is incompatible with all other options"));
>
> Otherwise if the user passes in invalid strategy option to a trivial
> merge they'll get an error about an invalid strategy option rather
> than being told --strategy-option is not supported with
> --trivial-merge.

I presume that another issue with not having that compatibility
checking with "--trivial" would be when the user passes a valid
strategy option and it would be silently ignored.

> Ideally there would be a preparatory patch that moves the switch
> statement that is below the "if(o.use_stdin)" block up to this point
> so we'd always have set o.mode before checking if it is a trivial
> merge. (I think you'd to change the code slightly when it is moved to
> add a check for o.use_stdin)

That sounds very good.

Thanks for a good "stepping back a bit" review.  Highly appreciated.

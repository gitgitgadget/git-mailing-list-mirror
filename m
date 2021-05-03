Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893EC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248BC61055
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhECFup (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:50:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64138 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhECFup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:50:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87312C3F6F;
        Mon,  3 May 2021 01:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0O4zCcUrO9nAqM2tjDKto8TZ+0c2uoboyZldvh
        BTAMM=; b=vir8gJMn/fJN4O7LA3THQc1Ko7rjjxaKJenzsdm/ZumRDlwQxAnuVB
        ti03Wa4VZJPN7IHm8exSRoTWnfFum7NnUb/LkgUq92ym5hUBuDtWVoV1aGiskIYS
        Qg53Ep0vPHg7xCt2wSeD/fm3k/uwrbQCVIhinILsnsuGyw3gCiawk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CDD9C3F6E;
        Mon,  3 May 2021 01:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 034B4C3F6D;
        Mon,  3 May 2021 01:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bert Huijben via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bert Huijben <bert@vmoo.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: add win32 path translation for diffmerge
References: <pull.1014.git.git.1619696399147.gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 14:49:51 +0900
In-Reply-To: <pull.1014.git.git.1619696399147.gitgitgadget@gmail.com> (Bert
        Huijben via GitGitGadget's message of "Thu, 29 Apr 2021 11:39:58
        +0000")
Message-ID: <xmqqbl9s8iyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61173798-ABD3-11EB-A27A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bert Huijben via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Bert Huijben <bert@vmoo.com>
>
> Use the infrastructure added for finding winmerge to also
> automatically find DiffMerge,
> ...
> diff --git a/mergetools/diffmerge b/mergetools/diffmerge
> index 9b6355b98a71..458ed9a89718 100644
> --- a/mergetools/diffmerge
> +++ b/mergetools/diffmerge
> @@ -16,3 +16,7 @@ merge_cmd () {
>  exit_code_trustable () {
>  	true
>  }
> +
> +translate_merge_tool_path() {
> +	mergetool_find_win32_cmd "sgdm.exe" "SourceGear/Common/DiffMerge"
> +}

c5f424fd (mergetools/diffmerge: support DiffMerge as a git
mergetool, 2013-10-13) explains that

    mergetools/diffmerge: support DiffMerge as a git mergetool
    
    DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.
    
        See http://www.sourcegear.com/diffmerge/
    
    DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
    graphical compare tool.

Now, I would assume sgdm.exe would be something users of Windows
version of the tool may be familiar with, but how would the proposed
change affect users of the tool on other platforms?

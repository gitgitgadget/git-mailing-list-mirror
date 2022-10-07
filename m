Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3CC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJGRCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJGRCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:02:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348E29CA1
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:02:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EFA51A4BFE;
        Fri,  7 Oct 2022 13:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dYAROFhjN+9J6NF+My4KhjP+A9UR8ZVcrb/lyQ
        mEnQI=; b=PeTyv3YfKOywMcHshAbaXhX91IvZCUvrrqVfLAP11VLp/fo93LatS1
        LQFR0WTjAhlhZS/4ZOGbXcpbF9yWhDTOrEyCk91PTnU24prqJra82B//a5js1As0
        AZnygxZvnNt5tuVrOHomkAKRmHZFHMUPGiw8173ojKv38Fi4hBThM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 686411A4BFB;
        Fri,  7 Oct 2022 13:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 876FF1A4BFA;
        Fri,  7 Oct 2022 13:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Michael Schindler <michael@compressconsult.com>
Subject: Re: [PATCH] Update kdiff3 install location
References: <pull.1376.git.1665141449621.gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 10:02:35 -0700
In-Reply-To: <pull.1376.git.1665141449621.gitgitgadget@gmail.com> (Michael
        Schindler via GitGitGadget's message of "Fri, 07 Oct 2022 11:17:29
        +0000")
Message-ID: <xmqqedvjh8ic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7DCB0CC-4661-11ED-A089-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Michael Schindler <michael@compressconsult.com>
>
> newer versions of kdiff3 for windows install the executable for windows
> in a /bin subfolder.
> This change changes the place where the executable is searched to the new
> location if not found in %PATH%

What happens to those who already have kdiff3 on Windows and haven't
upgraded to the ones installed in the /bin subfolder with this
change?

> diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
> index ee8b3a0570e..c26a9573815 100644
> --- a/mergetools/kdiff3
> +++ b/mergetools/kdiff3
> @@ -39,6 +39,6 @@ translate_merge_tool_path() {
>  	then
>  		echo kdiff3
>  	else
> -		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3"
> +		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3/bin"
>  	fi
>  }

Will they lose the access to kdiff3 backend when they upgrade their
Git to a version that includes this change, or is the old location
expected to be on %PATH%?  I find the latter unlikely---the original
would not have bothered to use mergetool_find_win32_cmd if that were
the case.

I am wondering if mergetool_find_win32_cmd should take multiple
candidate directories, not just a single directory, so that users of
old and new versions are both kept happy.

Thanks.

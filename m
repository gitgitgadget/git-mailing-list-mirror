Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFCC04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjHGTBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHGTBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 15:01:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A077173E
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 12:01:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0D56239D2;
        Mon,  7 Aug 2023 15:01:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wl9h2QaxvCruAqtWcKLgHPaMhKcDb01FhB4/Bb
        vgO3w=; b=DPvFU4TXv28qQSPDPnMSWFzv3d0mYJBKZN/9SxfggCKdJt6HehdHgg
        ZsPiP0vN/FBMgHaO1dcqvBVK7X7qnEVFjvPmxMXRFIBXLGkmYJx/rABwxsFKJdNU
        X5furNm80A1qjiVJsLDseY00+UMt6QIWS7P9OmrN7gQY9cagqyEek=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA58E239D1;
        Mon,  7 Aug 2023 15:01:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6DB43239CD;
        Mon,  7 Aug 2023 15:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/3] t/lib-rebase: set_fake_editor(): fix recognition of
 reset's short command
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
        <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336663-2-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 12:00:56 -0700
In-Reply-To: <20230807170935.2336663-2-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 7 Aug 2023 19:09:33 +0200")
Message-ID: <xmqq7cq6fziv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDE75522-3554-11EE-BFCA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> ... in FAKE_LINES.
>
> This has been broken ever since it was introduced in 5dcdd7409a
> (t/lib-rebase: prepare for testing `git rebase --rebase-merges`,
> 2019-07-31), but it's not actually used, so it's a cosmetic defect
> only.

Sharp eyes.  And this makes the list match what is actually used and
defined in sequencer.c which is good.

Thanks.

>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>  t/lib-rebase.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 7ca5b918f0..e6179ab529 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -49,7 +49,7 @@ set_fake_editor () {
>  	action=\&
>  	for line in $FAKE_LINES; do
>  		case $line in
> -		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
> +		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|t|merge|m)
>  			action="$line";;
>  		exec_*|x_*|break|b)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;

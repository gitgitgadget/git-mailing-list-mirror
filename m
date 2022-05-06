Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C018C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442635AbiEFU0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442382AbiEFU0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:26:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78961674EF
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:23:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3CFD186D96;
        Fri,  6 May 2022 16:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pIRvkk8QkNCLL0v0lvT3qn1r2RF7KWKtCf1krP
        lJjYc=; b=livCcPVVZMQ/DKLw5kyHop7AYcNX7r3zFufIeQajLjQiiVtfHdl2UQ
        8DvH9ldOSEqRE6zsYOV3cZxuRppB45NM6rTJPpN9shH9QbGw9vTre9H1c2ijpVFg
        h35LEvwKDUPvFOMUWXrn2LUeFeVtk9TEr65IQg8KsjuoVPVxXBv/4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE4C4186D95;
        Fri,  6 May 2022 16:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D490186D92;
        Fri,  6 May 2022 16:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http.c: avoid gcc warning
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
Date:   Fri, 06 May 2022 13:22:59 -0700
In-Reply-To: <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 6 May 2022 20:04:06 +0200")
Message-ID: <xmqqtua2jtr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5301B024-CD7A-11EC-A0E4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

See previous discussion on the topic and help clarify it for me,
thanks.

https://lore.kernel.org/git/xmqqo8131tr8.fsf@gitster.g/

> Related to -Wdangling-pointer.
>
> In fact, this use of the pointer looks scary and has not created
> problems so far only because the pointer in the struct is not used when
> execution is out of the scope of the local function (and the pointer
> invalid).
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/http.c b/http.c
> index 229da4d148..2f67fbb33c 100644
> --- a/http.c
> +++ b/http.c
> @@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +	slot->finished = NULL;
>  }
>  
>  static void release_active_slot(struct active_request_slot *slot)

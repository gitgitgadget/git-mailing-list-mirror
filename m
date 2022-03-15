Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D8C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbiCORYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350023AbiCORYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:24:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB010FD5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:23:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E4AC185842;
        Tue, 15 Mar 2022 13:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6dc0pOgGDZmr1xLgup7BDg8+cusx3NAVxUmxFm
        eHZGI=; b=P3xyjm3z45I/bMDSRtPX9TDRkwvZLthXevarVkToJ23FzuVRBGE9G8
        4BA32q268otFvD42l3U6iDz0Id360pgHb004XQm+gkTGRyhwQ+awdr9pmDB7gS5Q
        kyD64XhtIreaidstydZRG5oYw3jXXNvd8WhkGEH6wZfy0fUVg+wvM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 371E8185840;
        Tue, 15 Mar 2022 13:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBAAA18583C;
        Tue, 15 Mar 2022 13:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
        <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
Date:   Tue, 15 Mar 2022 10:23:00 -0700
In-Reply-To: <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Tue, 15 Mar 2022 18:01:45 +0800")
Message-ID: <xmqq8rtbf7uz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 910CDF02-A484-11EC-AAB9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                             |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba83..111360ebf5 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -138,6 +138,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +

The command used to be marked as one of the commands that require
full index to work correctly.  Why did it suddenly become not to
require it, especially without any other changes to make it so?

This patch needs a lot more explaining to do in itse proposed log
message.

Thanks.

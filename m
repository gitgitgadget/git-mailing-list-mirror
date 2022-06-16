Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D1C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiFPFCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiFPFCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:02:36 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E4BDA
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:02:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 882D1128C6D;
        Thu, 16 Jun 2022 01:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ChA0k2YcXK2xqbCvIMfSTnZlxgIdC4gkuxP29g
        /Ij00=; b=to7f1mjjfAJgBKA+bpwpnGFX0eQmNI6gcbcmOk8TIsc/GDGJaJ1Vsb
        b4P3dKzesMCzsVK0WfyOVkfZkxl7YqfBGs/bimEjxpvEy6Fn5vQj+n0YPJWOsTH7
        FVtasVgFFlwfySshWr3iSCLBgTyAPklUbpRQkuSwfsba/vCZ1r0B0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD76128C6A;
        Thu, 16 Jun 2022 01:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7469128C61;
        Thu, 16 Jun 2022 01:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] relative_url(): fix incorrect condition
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 22:02:29 -0700
In-Reply-To: <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:44 +0000")
Message-ID: <xmqq4k0lw68q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 873B0CF6-ED31-11EC-80DC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 63e95beb085c (submodule: port resolve_relative_url from shell to C,
> 2016-04-15), we added a loop over `url` where we are looking for `../`
> or `./` components.
>
> The loop condition we used is the pointer `url` itself, which is clearly
> not what we wanted.

8/11, 9/11, and 10/11 are trivially correct.  Will queue.

Thanks.


>
> Pointed out by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 9b9bbfe80ec..bded6acbfe8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2846,7 +2846,7 @@ char *relative_url(const char *remote_url, const char *url,
>  	 * When the url starts with '../', remove that and the
>  	 * last directory in remoteurl.
>  	 */
> -	while (url) {
> +	while (*url) {
>  		if (starts_with_dot_dot_slash_native(url)) {
>  			url += 3;
>  			colonsep |= chop_last_dir(&remoteurl, is_relative);

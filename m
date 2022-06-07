Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF90CCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387576AbiFHAaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583304AbiFGXq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:46:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1BA45B71C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:11:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D93C4189870;
        Tue,  7 Jun 2022 18:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hcU1hlREqTZ1Sw+4s5TXj5MSTsqK5rcy1JFVhI
        q6ySw=; b=qUlLQhrX4x4Qrb6CIW6vNQifWDDoYtT02QFlsumY3eYeTBWkW6be4O
        WO/Www0t0rZZkgx6UEGKd5mv++X9gXBZXYPqSu6oANfIqUUWUpV6lWzQWsYAXVOK
        RyR4CBjm89bXcyz/oFHqtRd3wX5NRLepagPVPfaqQPeV2QvmWc/1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFCBD18986F;
        Tue,  7 Jun 2022 18:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5EADE18986B;
        Tue,  7 Jun 2022 18:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/7] sequencer: define array with enum values
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <9f261c7df2c0a433c6acc46ffefd8d2633fdc3d4.1654634569.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 15:11:08 -0700
In-Reply-To: <9f261c7df2c0a433c6acc46ffefd8d2633fdc3d4.1654634569.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 07 Jun 2022
        20:42:45 +0000")
Message-ID: <xmqqmteot98j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBFA34FA-E6AE-11EC-A343-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The todo_command_info array defines which strings match with which
> todo_command enum values. The array is defined in the same order as the
> enum values, but if one changed without the other, then we would have
> unexpected results.
>
> Make it easier to see changes to the enum and this array by using the
> enum values as the indices of the array.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sequencer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Good thinking.

I love seeing a future-proofing change like this.

Thanks.

> diff --git a/sequencer.c b/sequencer.c
> index 8c3ed3532ac..8e26c9a6261 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1685,20 +1685,20 @@ static struct {
>  	char c;
>  	const char *str;
>  } todo_command_info[] = {
> -	{ 'p', "pick" },
> -	{ 0,   "revert" },
> -	{ 'e', "edit" },
> -	{ 'r', "reword" },
> -	{ 'f', "fixup" },
> -	{ 's', "squash" },
> -	{ 'x', "exec" },
> -	{ 'b', "break" },
> -	{ 'l', "label" },
> -	{ 't', "reset" },
> -	{ 'm', "merge" },
> -	{ 0,   "noop" },
> -	{ 'd', "drop" },
> -	{ 0,   NULL }
> +	[TODO_PICK] = { 'p', "pick" },
> +	[TODO_REVERT] = { 0,   "revert" },
> +	[TODO_EDIT] = { 'e', "edit" },
> +	[TODO_REWORD] = { 'r', "reword" },
> +	[TODO_FIXUP] = { 'f', "fixup" },
> +	[TODO_SQUASH] = { 's', "squash" },
> +	[TODO_EXEC] = { 'x', "exec" },
> +	[TODO_BREAK] = { 'b', "break" },
> +	[TODO_LABEL] = { 'l', "label" },
> +	[TODO_RESET] = { 't', "reset" },
> +	[TODO_MERGE] = { 'm', "merge" },
> +	[TODO_NOOP] = { 0,   "noop" },
> +	[TODO_DROP] = { 'd', "drop" },
> +	[TODO_COMMENT] = { 0,   NULL },
>  };
>  
>  static const char *command_to_string(const enum todo_command command)

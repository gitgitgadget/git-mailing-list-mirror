Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D0C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiCNGJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiCNGJo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:09:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3071C135
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:08:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B1AD121F8C;
        Mon, 14 Mar 2022 02:08:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8FEThmyO0TieqPmM8eF8N3TR7SZes1wCLn6M5y
        Ln8V0=; b=EGCtNKZrtjhH5Ic/al/QpGjkUmwfkpY4Vxj9iI1+t4uieEm/ESXAXH
        Cu3/fuhx4jJ3uzFTABUT9/4QMFu9UcLV4pMJiHLFQH1eRJF1MX7DPJdOIvFlEKx9
        0gU6lAjQNTtPFeWfOWKqEhVULUKA4tHqln+qLRnd6n7TSADnviwjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23718121F8B;
        Mon, 14 Mar 2022 02:08:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AD25121F8A;
        Mon, 14 Mar 2022 02:08:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/16] update-index: convert advise() messages back to
 warning()
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <b120972a441d3081519af0e31bb0c639df148287.1647033303.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 06:08:32 +0000
In-Reply-To: <b120972a441d3081519af0e31bb0c639df148287.1647033303.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 11 Mar 2022
        21:14:49 +0000")
Message-ID: <xmqq5yoht6an.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DA23494-A35D-11EC-A191-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! update-index: convert fsmonitor warnings to advise

Same comment as 01/16 applies here.  "convert ... back to ..." in
the title refers to the fact that builtin-fsmonitor-part2 topic
turned warning() into advise() without a good justification, I
think.  Flipping and flopping between warning and advise, without
giving any justification going either direction, is not a good move.

I only have looked at one eighth of this part 2.5, but it starts to
look that ejecting part-2 and redoing it may result in a cleaner
code that is easier to understand, perhaps?  For example, instead of
applying this patch, we can just get rid of 1a9241e1 (update-index:
convert fsmonitor warnings to advise, 2022-03-01).  As I read more,
my impression will certainly change, I would expect.  Let's see.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/update-index.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index d335f1ac72a..75d646377cc 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1238,18 +1238,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  	if (fsmonitor > 0) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>  		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
> -			advise(_("core.fsmonitor is unset; "
> -				 "set it if you really want to "
> -				 "enable fsmonitor"));
> +			warning(_("core.fsmonitor is unset; "
> +				  "set it if you really want to "
> +				  "enable fsmonitor"));
>  		}
>  		add_fsmonitor(&the_index);
>  		report(_("fsmonitor enabled"));
>  	} else if (!fsmonitor) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>  		if (fsm_mode > FSMONITOR_MODE_DISABLED)
> -			advise(_("core.fsmonitor is set; "
> -				 "remove it if you really want to "
> -				 "disable fsmonitor"));
> +			warning(_("core.fsmonitor is set; "
> +				  "remove it if you really want to "
> +				  "disable fsmonitor"));
>  		remove_fsmonitor(&the_index);
>  		report(_("fsmonitor disabled"));
>  	}

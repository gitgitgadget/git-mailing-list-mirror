Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B9C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiBPVn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:43:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiBPVny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 16:43:54 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B68216179
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 13:43:42 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96242106238;
        Wed, 16 Feb 2022 16:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JiU7xuACCoI3usRnJB9QkekptE1tZfMa02lzCK
        hALWw=; b=xC7qFaop87GL/lSsU4ezD9UkUEvGWG7V0POnEW6ZAh4I3F96y5v9Cv
        n2/xhXduV0rTsl1U0LutdjKXp+Vpw+raxijsRAjeMWYy5cZWU+CaQiUX8ezlA7zK
        UsZsyEEkQvHFPMRaEAIVb1Ane/8+yYZsgbBjcQhCACFdouKwztnZk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D957106237;
        Wed, 16 Feb 2022 16:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFBDB106236;
        Wed, 16 Feb 2022 16:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] add -p: disable stdin buffering when
 interactive.singlekey is set
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <6d8423b6e1e969ffed02b148546b88d118affd09.1645008873.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 13:43:39 -0800
In-Reply-To: <6d8423b6e1e969ffed02b148546b88d118affd09.1645008873.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 16 Feb 2022 10:54:32
        +0000")
Message-ID: <xmqqleyacws4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81996130-8F71-11EC-A60A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/add-interactive.c b/add-interactive.c
> index 6498ae196f1..ad78774ca26 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -70,6 +70,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>  			      &s->interactive_diff_algorithm);
>  
>  	git_config_get_bool("interactive.singlekey", &s->use_single_key);
> +	if (s->use_single_key)
> +		setbuf(stdin, NULL);

OK.  Will queue.  Thanks.

>  }
>  
>  void clear_add_i_state(struct add_i_state *s)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16685C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 19:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiCNTwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiCNTwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 15:52:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75443EA83
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:50:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6567D17A8D5;
        Mon, 14 Mar 2022 15:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7fOE+roPptuzCCoAW+cu/YnzLP3v2McCASy/DQ
        C/gco=; b=th0rG3eLLg3HR5dCs9Vi7g0hcn4k0KXHK0UbU1YCglc0/z46p/KOep
        DMaQBODVjzGecBsGLHF0bk7MGewKIc3VkpeqLwcJLINZDm4wyNmWKVukRCLV1Ayh
        Fwc+i+UWIJO7VlSGDNxGfx6Pbzv307vGqNPefDhndAcriSFqjGZnY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E5B017A8D4;
        Mon, 14 Mar 2022 15:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 430CF17A8CC;
        Mon, 14 Mar 2022 15:49:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 16/16] fsmonitor-settings: simplify initialization of
 settings data
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <432f9ff9d92ff55216555864cb3571c94a2c6db9.1647033303.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 19:49:58 +0000
In-Reply-To: <432f9ff9d92ff55216555864cb3571c94a2c6db9.1647033303.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 11 Mar 2022
        21:15:03 +0000")
Message-ID: <xmqqpmmoqpp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE480102-A3CF-11EC-A03C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! fsmonitor: config settings are repository-specific

I cannot tell the validity of this change alone without the base
commit in part2 to choose between setting s->mode directly or
calling __set_disabled(r).

I've read all the 16 patches here, and I found that the majority of
them (except for "it is hard to tell why we are changing in 2.5; it
needs a better justification" ones like this) are "oops, the part2
patches had these obvious and trivial mistakes that we should have
fixed before we merged them to 'next', or even sending them to the
list in the first place" fixes.

Let's kick part2 out of 'next', and replace it with a corrected set
of patches and have people review them, this time for real, before
merging it back to 'next'.  I just do not get the good feel that the
series was adequately reviewed---if we have this many "oops" fixups
needed after getting merged to 'next'.

Thanks.



> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  fsmonitor-settings.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 3b54e7a51f6..757d230d538 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -22,11 +22,10 @@ static void lookup_fsmonitor_settings(struct repository *r)
>  		return;
>  
>  	CALLOC_ARRAY(s, 1);
> +	s->mode = FSMONITOR_MODE_DISABLED;
>  
>  	r->settings.fsmonitor = s;
>  
> -	fsm_settings__set_disabled(r);
> -
>  	/*
>  	 * Overload the existing "core.fsmonitor" config setting (which
>  	 * has historically been either unset or a hook pathname) to

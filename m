Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268DEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFTVCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFTVCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:02:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58610F4
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:02:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 615E818E505;
        Tue, 20 Jun 2023 17:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OTeGoikU7xQswGkrEgH5DzqpNTcWfU4jkl9qeU
        YYlWA=; b=KIihxdbaLbwSjjagtOhx19dRBgxW8WhW3qkrw4qEUJig2/EECiWmgH
        /beRvKqU1a0HdSV6ahlkTMD/7e0d1df+ChUyVoNf5TAS8N4Dv3IWLJyOp68vJ2j0
        Z2Yb0qGNIJI5Ivj66uWxY1teGxW/41sWzc7WtUqKB8EXh70OHqXEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 578A518E504;
        Tue, 20 Jun 2023 17:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B52A918E501;
        Tue, 20 Jun 2023 17:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 02/12] urlmatch.h: use config_fn_t type
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <1aeffcb13956988dfb7b925f89bbe9c8503cb143.1687290232.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 14:02:27 -0700
In-Reply-To: <1aeffcb13956988dfb7b925f89bbe9c8503cb143.1687290232.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:41
        +0000")
Message-ID: <xmqqfs6llue4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C406A8A8-0FAD-11EE-B73F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> These are actually used as config callbacks, so use the typedef-ed type
> and make future refactors easier.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  urlmatch.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/urlmatch.h b/urlmatch.h
> index 9f40b00bfb8..bee374a642c 100644
> --- a/urlmatch.h
> +++ b/urlmatch.h
> @@ -2,6 +2,7 @@
>  #define URL_MATCH_H
>  
>  #include "string-list.h"
> +#include "config.h"
>  
>  struct url_info {
>  	/* normalized url on success, must be freed, otherwise NULL */
> @@ -48,8 +49,8 @@ struct urlmatch_config {
>  	const char *key;
>  
>  	void *cb;
> -	int (*collect_fn)(const char *var, const char *value, void *cb);
> -	int (*cascade_fn)(const char *var, const char *value, void *cb);
> +	config_fn_t collect_fn;
> +	config_fn_t cascade_fn;

Makes sense.

>  	/*
>  	 * Compare the two matches, the one just discovered and the existing
>  	 * best match and return a negative value if the found item is to be

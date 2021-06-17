Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E8C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507CB6135C
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQH10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQH1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:27:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:25:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gt18so8076727ejc.11
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=li3d+b6ScJjFeHdtvUX/KhFf2MnsDzhHXxckvgF0NyI=;
        b=loytTRXVKvDrMExvxCVFwrPd4DufxaHtQbeYgE/V2aSnzp3tDBtBD8X06QFmVfBtez
         UuIgh5W5POOFWLNNOcUosbFPoCYeTf6ptuC3OZ1WS/0ys5Eo8Aesv6vPTkX87LvsX1x1
         lmTp89ZdnU0kMu5YrfMCd72waF26LKK6xGw98N8YWVjdzrWQ0MNHdY/q/RefC5s+YhT3
         sk14Aoe3RfdX6nXPrN41/S6bh/v+Wor4ssvB3eXvKP1xfdQAogBlfJWtkhkt2Xnt40YS
         DqfUGOLlcuPiH0QOpHSQIP+qwOjgfteYVd9Qo/2+6eRVP7SP3tYl6Ht0o0SiOMDnpWDD
         2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=li3d+b6ScJjFeHdtvUX/KhFf2MnsDzhHXxckvgF0NyI=;
        b=ry52rqKpLb0PPQDVSSmJenSZrO7WQNYhU+M50O/hgmKbU08OAreZQP0J1p/Zowj+6o
         kBTZP4iy+C89N0M7VR24QxbldehUwvTlVQhTfJxfpm5Cpvwrr5iLSdRgAQ5nwZwW2AUE
         p0N7OfCEqa3gPaDzkQQRG1zOnIydLWsk3pp/fhdm1R/HT0iA7SFWd6KHraW75caI5bmm
         ROGdKERksly9hTPCMhCKezBTi2J8HLE0yZ2vSKuU4s5rWc4RRe9UMUvyJ9xlgV87CLfM
         tiD9unXACafrsGwcME0ZeiUxMtbgJfX/vQab7V3pr7b9QvkAQHsQJLCfK0f9ARj90hch
         6gfQ==
X-Gm-Message-State: AOAM533em5hz01czGd7neuWHAe3T/+uBUUy4EG443ZQlK65/vj4jWuUw
        qBZidJLMrv5FqErmP/d/QuKr/kT5UxFVOQ==
X-Google-Smtp-Source: ABdhPJyQiG3oKs1zEcYwraxXPaFCbuFyyKjYcGhGtRPYV+rmn7Us3jGwM1iD61CbtNFXhdhBZCWmYg==
X-Received: by 2002:a17:906:149a:: with SMTP id x26mr3821134ejc.41.1623914715846;
        Thu, 17 Jun 2021 00:25:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gz5sm3121922ejb.113.2021.06.17.00.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:25:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 5/8] [GSOC] ref-filter: teach get_object() return useful
 value
Date:   Thu, 17 Jun 2021 09:22:39 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
Message-ID: <87wnqtvtph.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Let `populate_value()`, `get_ref_atom_value()` and
> `format_ref_array_item()` get the return value of `get_value()`
> correctly. This can help us later let `cat-file --batch` get the
> correct error message and return value of `get_value()`.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  ref-filter.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 8868cf98f090..420c0bf9384f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1808,7 +1808,7 @@ static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
>  static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  {
>  	struct object *obj;
> -	int i;
> +	int i, ret = 0;

The usual style is to not bunch up variables based on type, but only if
they're related, i.e. we'd do:

    if i, j; /* proceed to use i and j in two for-loops */

But:

    int i; /* for the for-loop */
    int ret = 0; /* for our return value */

(Without the comments)

>  	struct object_info empty = OBJECT_INFO_INIT;
>  
>  	CALLOC_ARRAY(ref->value, used_atom_cnt);
> @@ -1965,8 +1965,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  
>  
>  	oi.oid = ref->objectname;
> -	if (get_object(ref, 0, &obj, &oi, err))
> -		return -1;
> +	if ((ret = get_object(ref, 0, &obj, &oi, err)))
> +		return ret;

Maybe more personal style, I'd just write this as:

    ret = x();
    if (!ret)
        return ret;

Makes it easier to read and balance parens in your head for the common
case...

> @@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item *info,
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
>  		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
> -		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
> +		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||
>  		    atomv->handler(atomv, &state, error_buf)) {
>  			pop_stack_element(&state.stack);

... and use that mental energy on readist stuff like this, which I'd
just leave as the inline assignment.

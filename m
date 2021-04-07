Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16381C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B25611C9
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhDGXFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDGXFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:05:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169F8C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:05:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so30309362ejz.11
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=HWofVOcPb6zS/3tKdSzsMe2eeg/UJMnyccLR50+Hktw=;
        b=iWMjlyiFlwRzLQCcO8vM9QIDZhp3quRkaeqJdl3r4i0VMuGnvcOCSvEMqfaRNOavim
         cNu0HaLA2ehi66sTWCQ4wLZ0oRjtKmSsUJIcVG5XXVaKkOwL3MeTIg8th2T/zEg0t0Hl
         flN0wlbQHqKNdtoQDDO0sKJSG15w2Iw+lL321jtG8IJb0Hkm6IQt4mvyonpquYtcAjTa
         +dgRTN7jJxR5ETlZE1BMuump4XrpsIqH2QBhXcIZFylvpPbo6RSpWiECyX0hLce4IrbP
         87WqarA/3jX9/4dxxGOalFaTsBBiuUhiI1quKRYIW5mJ+H9AeO6ewcOvaIJ3CTJgKTI6
         YnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=HWofVOcPb6zS/3tKdSzsMe2eeg/UJMnyccLR50+Hktw=;
        b=DmOJQ80Nd1gkwfjtM/Ss1pO0RpW4pLcllngyjvUGKkFJa3SyJuJrdnELCrJEVuCMX/
         nbG0rBCkoCz2Rkh8bZshsTiuHZnH8LpFsvkEyXwpaNeNXNsiF8H3v/yF5KVWn2V8/15Q
         Z2BYDF4uPqSLF4GgJWdLJgJbyoBX6Zme/2SbfTWMlrRrR6U94XyDK1LDvLuLmkRug7+v
         49xnbST897eCjniQSVcdtOFZ8GFArv59nRj6DyAdH6QGfho81E8etJoxb4szjBbecKQZ
         JcsmTwH5Nv7arIbq67ZcVrw3SWebIw4zwWlULkw8+y/3JOxwAuD+h0JUHq8rsvDqtzNQ
         2Y3Q==
X-Gm-Message-State: AOAM532vvRaMTiAKrma4GWfT6soM7CBu1VLeERvpDHOWsMevOU6aY6J0
        zXQHsD2uZuxhsJIL7P0xCX4=
X-Google-Smtp-Source: ABdhPJwmVC5wxinskTjhoKMGuJ8wMlgmQDPEFA4OTeSltasGPniSYynDQSq8k2g42OLppa6OrCEJjA==
X-Received: by 2002:a17:906:ecb8:: with SMTP id qh24mr6820020ejb.162.1617836707746;
        Wed, 07 Apr 2021 16:05:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nd36sm13171689ejc.21.2021.04.07.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:05:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] t9902: fix completion tests for log.d* to match
 log.diffMerges
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-8-sorganov@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210407225608.14611-8-sorganov@gmail.com>
Date:   Thu, 08 Apr 2021 01:05:06 +0200
Message-ID: <87y2dtitlp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Sergey Organov wrote:

> There were 3 completion tests failures due to introduction of
> log.diffMerges configuration variable that affected the result of
> completion of log.d. Fixed them accordingly.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  t/t9902-completion.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 04ce884ef5ac..4d732d6d4f81 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>  	test_completion "git config log.d" <<-\EOF
>  	log.date Z
>  	log.decorate Z
> +	log.diffMerges Z
>  	EOF
>  '
>  
> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>  	test_completion "git -c log.d" <<-\EOF
>  	log.date=Z
>  	log.decorate=Z
> +	log.diffMerges=Z
>  	EOF
>  '
>  
> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
>  	test_completion "git clone --config=log.d" <<-\EOF
>  	log.date=Z
>  	log.decorate=Z
> +	log.diffMerges=Z
>  	EOF
>  '

Commits should be made in such a way as to not break the build/tests
partway through a series, which it seems is happening until this fixup.

Having read this far most of what you have in this 9 patch series
could/should be squashed into something much smaller, e.g. tests being
added for code added in previous steps, let's add the tests along with
the code since this isn't such a large change.

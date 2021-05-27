Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60271C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4084C613AF
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhE0QjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhE0QjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 12:39:22 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DFC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:37:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so1369951oiv.1
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=c0c7arrlBOBbEVEGUCOA7HAxCcEJJ+/mykMhkmFloxw=;
        b=N1jnDXSzXNhxgW7NqcqLUs7MXOBQ32rp5JA0ZnmwFpkP1+zM9/2YrCNqgBMUkxaJRd
         t0LWhEfBjJjHnMLxV+n2OuoGhKWKjr/az6f1P8mtZNXk2Yo3rdoubLo4K22K7NNJE0j8
         WUYHd9HWIAd+Qo73RBrMT/87ERU8lpSjkbCXCTUdLdKZnkcD0N6VgxRYXBP6r9UPbBwn
         6by7hoF1Eov845Rru5bSU0cXyMHJz3Zg7+Q4X702M5hnYRGJ5BTvCvd3rPBWkinLRpLl
         QMy/4qSJd4BUVnZkoxgBPyyu0pIpteRgH3TetYKFPWpbywCKyL9H668x8EeaOzhJgMUJ
         Z/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=c0c7arrlBOBbEVEGUCOA7HAxCcEJJ+/mykMhkmFloxw=;
        b=oE9iOr3LOU2LsraQUXnieBvmF+8gZfplMkVwnxLNCjmyaWwCSuCJdqEFgAC+SdvO4i
         jBO66FcB8NXC5aayNWpykYKpdwZXKtgXTcMOUnfHECOKWGfGYJpOGNmuUEhe11dPx4XT
         ZyRv+65N5YcHNCWYoV1oh6mOuXQoNfPkOgE5JZg/itBvBROhQlt+cpEa57A7IyYm3RQM
         vlZpccr5R9h7g9edo1ghf17jkocVMAjHJzZZxZtD2hBm0ilywq2cnmIZsXqhTmrOrh7C
         2s/RUGKxUhtYIk+k47cxj6I32eYZg9DUBpLQ0zNj0ztsy/vwzuapTFo42TTY3FZBlxOo
         Gwaw==
X-Gm-Message-State: AOAM531oEAuIqyXG5MkGtDkZHIRpTeoglFDarCwl4uyL8giEllYK+Kl8
        kbgxWdWW4O2YBM2aKRq6d1w=
X-Google-Smtp-Source: ABdhPJzVqMNmY/+Ihcr64+cb3Uial2MUQRu1H8qWqL7Kliwo33F3Kr5zF087x/TMCoD6wornYKC02Q==
X-Received: by 2002:aca:d547:: with SMTP id m68mr2929606oig.116.1622133468362;
        Thu, 27 May 2021 09:37:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l8sm518568ooo.13.2021.05.27.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:37:47 -0700 (PDT)
Date:   Thu, 27 May 2021 11:37:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <60afcada976dc_26530208a1@natae.notmuch>
In-Reply-To: <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 2/2] [GSOC] ref-filter: add %(header) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget wrote:

> @@ -1372,6 +1389,15 @@ static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned
>  				    &bodypos, &bodylen, &nonsiglen,
>  				    &sigpos, &siglen);
>  
> +		if (starts_with(name, "header")) {
> +			size_t header_len = subpos - (const char *)buf - 1;
> +			if (atom->u.header.option == H_BARE) {
> +				v->s = xmemdupz(buf, header_len);
> +			} else if (atom->u.header.option == H_LENGTH)

No need for braces in the if.

> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)header_len);
> +			continue;
> +		}
> +
>  		if (atom->u.contents.option == C_SUB)
>  			v->s = copy_subject(subpos, sublen);
>  		else if (atom->u.contents.option == C_SUB_SANITIZE) {

-- 
Felipe Contreras

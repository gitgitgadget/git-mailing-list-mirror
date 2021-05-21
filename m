Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A9C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F392613EE
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEUWxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhEUWxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:53:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C04C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:52:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t24so5631310oiw.3
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WfBbTbw/BArBBQU0o62uw11b+0fJOu+9cbwKO1tf6DI=;
        b=ABOr+P9n0zXnxRXmNoFtHByasVBjQJWng/sImj9KW3qOVUSMJspun2m7W1v2PsaX9I
         EbTPxk/hUS86UZ2Mqr+aRApbGI4XWOuLEaCFmKkkjf0cs2Ko89d0R4ztv9D+qlnA5y9X
         2LfdYbgTX6OmrOP+RKlNcxwdVHmMsTALCO3oTH213RVlngXTLp5qK1o1rIaEaXJQqEkm
         NgBWTtiiqp8BXHeeeUh3IeGetCdZmzlsruxVkLc2OL34jud+6gGAO3FOXA75bz8tnlSa
         o27ILR5FvLHceeW9Wjfrac+ngcfECp6yMlWKVHlirS2DR7NmY39zquQHrznBzmSxSjIg
         4CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WfBbTbw/BArBBQU0o62uw11b+0fJOu+9cbwKO1tf6DI=;
        b=WsZYekGnFInmoKGwA8jSZaid79ODP5mzFWAH5l/8TID/3S4vHiLgHiELIahL2f81Ij
         by7uQDFaVbpw3TxOROi7btKkB6dB9POy7pxaelnaaTvz6FAexeVsMUYHPjIo/ap/PIAP
         ApGeCDd5/pOhWTDQTSReZNWyhinFRsB2zsE3bpkB2+MAWznZb2XiUt2k3r0/e3QxPuKp
         tR8MW+Pp//bp5KFRhrGLWtsryx3NqXS+qqmU7P7NDgKN5Erb5qOX35lUkoBvSYelqheT
         WQKBWkIqSddaSHGcsQ+XHKmDZ9ArzqjB1iPeGTOFLe9pzV8tVbXUO9/W3QaZ7RZ9mn2e
         NLpw==
X-Gm-Message-State: AOAM531aHZ1vyOb/r8SJAWMkhYwSDVugvCkJO9vTyHdng9e34ls4yV1q
        NcKYHZW6pQ5Jkj5QzsN4t5Y=
X-Google-Smtp-Source: ABdhPJzKU5kIBIfefdC6rcLVRWmJVsSrYOb2ozudD75mqT0LY2ZcRbFylSeODBkLjjUlgfzrnyYNjA==
X-Received: by 2002:a54:4e82:: with SMTP id c2mr3859904oiy.137.1621637533261;
        Fri, 21 May 2021 15:52:13 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u24sm1575503otg.73.2021.05.21.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:52:12 -0700 (PDT)
Date:   Fri, 21 May 2021 17:52:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60a8399b8a0b8_81ac02084c@natae.notmuch>
In-Reply-To: <20210521224452.530852-5-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
 <20210521224452.530852-5-felipe.contreras@gmail.com>
Subject: RE: [PATCH v2 04/11] doc-diff: support asciidoctor man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> From: Jeff King <peff@peff.net>
> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> index 6b6bb444ac..52cf639f4d 100755
> --- a/Documentation/doc-diff
> +++ b/Documentation/doc-diff
> @@ -17,10 +17,14 @@ f			force rebuild; do not rely on cached results
>  c,clean			cleanup temporary working files
>  from-asciidoc		use asciidoc with the 'from'-commit
>  from-asciidoctor	use asciidoctor with the 'from'-commit
> +from-asciidoctor-direct use asciidoctor without xmlto for 'from'-commit
>  asciidoc		use asciidoc with both commits
>  to-asciidoc		use asciidoc with the 'to'-commit
>  to-asciidoctor		use asciidoctor with the 'to'-commit
> +to-asciidoctor-direct   use asciidoctor without xmlto for 'to'-commit
>  asciidoctor		use asciidoctor with both commits
> +asciidoctor-direct      use asciidoctor without xml for both commits

> +cut-footer		cut away footer

Oops. This obviously sneaked by; doesn't belong here.

-- 
Felipe Contreras

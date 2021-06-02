Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EBC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E744F613D2
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFBUON (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:14:13 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45838 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBUON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:14:13 -0400
Received: by mail-oi1-f173.google.com with SMTP id w127so3867613oig.12
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GttcKoDLTs9zjbBpvp42dCEtfQ4zElvtrp+2SHIAJHs=;
        b=uuTtzoEFOAL8iAV664GMlLfwV1atZmE4Eb2dG+XN9Q2YEtNPXE0u9WuziVgu7H8XlX
         nRi6nsZfdExzr1bJhReupiRrud5vi0wYJTj1SmU/DfAO3ot2+p1ZLwcAZ/Hx/cz5Ki2T
         WMD2xNzCHJqKxjetxSC87R2Zave3LpiQ+aQHx01WjmVU1JJh6MW2Pc680yRxxjSl1KLN
         Nfu35FJY7ajVJJSvKTd9SXYgmTLY45X8aDYkmGc2SKAMPp0dni62iz67WT5P1lkbPTKI
         dpCFF6dv2+m7noxdKpzjWEWiMcps4D4dixwJZ5Y/41bnNKQM4KAJgSn9sPM/wbGXswDj
         ErqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GttcKoDLTs9zjbBpvp42dCEtfQ4zElvtrp+2SHIAJHs=;
        b=q+v60lhA2nu0gXhNQKoqx4EKbtFSLHNsnYvFxNKLXRHYHprIBZewldRH0woS8uEM5D
         KpLwSKHqtWEGP/fapEEjheWjsLngOv1DREt6gm8JQfd/b8bv9XBYmbxbQbg5bPMxKyKe
         OV5SSHQvpa5H8UTf0VbE81UNxIGaVdobQvbqz3vJT215K0O2JB+QPs2+iLXGYEhLq3tu
         qpMSXoP/qAIvtxwZ68eU+GKO4ce5cB+7JDOXMdOfhQLZHXIjHvwacVvAsUO5OU6hKcBP
         LsThA1IyJMLILztn5vaTdDtu10jN7HOWmEdeAyCkmDD39yhg+yZycTCMLiUIXC3670Pg
         y9qA==
X-Gm-Message-State: AOAM532+WQvNS6oLu36RdLIAhkKk6wAhwDv+MeyYBWkXnu0FlCwE1LgL
        CECpAoAxx9h8bcGxrXd1iHI=
X-Google-Smtp-Source: ABdhPJyjuiDn276pyNfpYXCftBkMfn/LPnfspHJ1dnHQrB2uvoVKROv3gfWWQIz2z9d0nZH6owxRaQ==
X-Received: by 2002:aca:1805:: with SMTP id h5mr22347884oih.166.1622664676993;
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d19sm185914oop.26.2021.06.02.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:11:16 -0700 (PDT)
Date:   Wed, 02 Jun 2021 15:11:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <60b7e5e1748a5_1690a3208cb@natae.notmuch>
In-Reply-To: <20210521224452.530852-4-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
 <20210521224452.530852-4-felipe.contreras@gmail.com>
Subject: RE: [PATCH v2 03/11] doc: use asciidoctor to build man pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile

> @@ -349,8 +352,13 @@ $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
>  $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
>  	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
>  
> -%.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)
> +ifdef TXT_TO_MAN
> +%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS)
> +	$(QUIET_ASCIIDOC)$(TXT_TO_MAN) -o $@ $<
> +else
> +%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
>  	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +endif

This was a conflict mistake, the manpage-base-url.xsl file is not
present any more, should be:

+%.1 %.5 %.7 : %.xml $(wildcard manpage*.xsl)

I fixed in my local branch.

-- 
Felipe Contreras

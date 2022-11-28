Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C656C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiK1NQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiK1NPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:15:43 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77A91E70A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:14:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vp12so24384260ejc.8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=faLhURa51nMTqvhPKcvWjb+TufyRe19Gxcr1e43ca8E=;
        b=EX2h2JD9pz/CSOWFR7t9mU/eIaGFave6YBxMzqd7oI4i6wzeUcOKVSQCWCxiJu93vG
         rcKRBKOq27+4/jLJ0k3wxurBsToqkU6t3YB4XGqZ+xHlsPeCqwX00faRoHtlYz9cw3Oz
         qlPprd43WtVFc+SoFWJXBG94S7Q7O9sGMFVHHQdeSNEzHZgnmXT+piy3kMjDY1Fxu3ty
         VEFA4pGt65e4OH0UDpkM9JuGMwH3y2yAPK/TTiosWKAmNXx+ILU3lM9bPQQMdIkRZg56
         fG4TkbcPu+Zo8ZyddthrRn8dFGQWCYT40dl3fmJuHhm7MVV31gUhdGDvmZTqUseFdVbg
         LWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faLhURa51nMTqvhPKcvWjb+TufyRe19Gxcr1e43ca8E=;
        b=2WlQf43UBhaKJOFmZp0DknzGaWk+psWaGqJTqj9rx4ui+TFuqU3onTVNUQYRQ3poQ5
         dgX5J0xUH3Q8JrhfQOk5uuUkYOpBEUAxXKQ/GfxjK12uj1wNNUi1mHE+mn9YlwCyp31L
         2RFMwrUR2ovfkDRFc/KwPpAypkagNFYvJZdIKX73C1SILNtxyj7pFEsclvhwhWOCI2Kp
         b9TEUpbBV0mAGoZh0PjUC0yy4Cj/+kXMZrMkGtWc74Vw8CrdXa//hWTz+N87SI6d5PkB
         VgJjWFIq1MOvT3izYF4J/aEZ7P2H0tv8VzTEF2jgBfryJaKENFVPhdst2BL0bKA54zN+
         BDKg==
X-Gm-Message-State: ANoB5pkBGlZpuNFQJuRcfT1YJW6Eo6Z9YfguiXo9JhK7zbSFNnfkD26e
        r1i17olvaxsFJe/WeHhhY9z6aYEfaZJlRw==
X-Google-Smtp-Source: AA0mqf4kuiSPnBQOB+giRCYOMxWVr9sI5u2kERDll970mMgmLyw4BDMN9aIBu4QyDK5PKWIdNxYqNg==
X-Received: by 2002:a17:906:1686:b0:7ba:489e:8489 with SMTP id s6-20020a170906168600b007ba489e8489mr21398191ejd.669.1669641243238;
        Mon, 28 Nov 2022 05:14:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id og14-20020a1709071dce00b007ae035374a0sm5032630ejc.214.2022.11.28.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:14:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozdxS-0013Dv-0u;
        Mon, 28 Nov 2022 14:14:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Paul Smith <psmith@gnu.org>
Cc:     git@vger.kernel.org, Alexander Kanavin <alex.kanavin@gmail.com>
Subject: Re: [PATCH 1/1] Avoid multiple patterns when recipes generate one file
Date:   Mon, 28 Nov 2022 14:08:35 +0100
References: <20221127224251.2508200-1-psmith@gnu.org>
 <20221127224251.2508200-2-psmith@gnu.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221127224251.2508200-2-psmith@gnu.org>
Message-ID: <221128.86mt8bkyqt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 27 2022, Paul Smith wrote:

> A GNU make pattern rule with multiple targets has always meant that
> a single invocation of the recipe will build all the targets.
> However in older versions of GNU make a recipe that did not really
> build all the targets would be tolerated.
>
> Starting with GNU make 4.4 this behavior is deprecated and pattern
> rules are expected to generate files to match all the patterns.
> If not all targets are created then GNU make will not consider any
> target up to date and will re-run the recipe when it is run again.
>
> Modify Documentation/Makefile to split the man page-creating pattern
> rule into a separate pattern rule for each pattern.
>
> Reported-by: Alexander Kanavin <alex.kanavin@gmail.com>
> Signed-off-by: Paul Smith <psmith@gnu.org>
> ---

Thanks for fixing downstream, and for working on GNU make.

>  Documentation/Makefile | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d47acb2e25..21375cd3f2 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -351,8 +351,16 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
>  manpage-base-url.xsl: manpage-base-url.xsl.in
>  	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>  
> -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> -	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +
> +manpage-prereqs := manpage-base-url.xsl $(wildcard manpage*.xsl)
> +manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +
> +%.1 : %.xml $(manpage-prereqs)
> +	$(manpage-cmd)
> +%.5 : %.xml $(manpage-prereqs)
> +	$(manpage-cmd)
> +%.7 : %.xml $(manpage-prereqs)
> +	$(manpage-cmd)
>  
>  %.xml : %.txt $(ASCIIDOC_DEPS)
>  	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<

Whether we use eval/define or not (I just tried to avoid the repetition)
I think referring to $(DOC_MAN[157]) here probably makes more sense if
we're poking at these rules.

I.e. in this case the rest of the Makefile is carrying forward what
manpages we're generating exactly, so rather than a wildcard %.1 to
%.xml we can narrow it down to just the %.1 files we're going to b
generating (but maybe that's best left for later...):

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5e1a7f655c2..7404cead084 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -351,8 +351,12 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+define doc-man-tmpl
+$$(DOC_MAN$(1)): %.$(1) : %.xml manpage-base-url.xsl $$(wildcard manpage*.xsl)
+	$$(QUIET_XMLTO)$$(XMLTO) -m $$(MANPAGE_XSL) $$(XMLTO_EXTRA) man $$<
+
+endef
+$(eval $(foreach n,1 5 7,$(call doc-man-tmpl,$(n))))
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A0C43461
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCD76102A
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhEGXg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEGXg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 19:36:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA78EC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 16:35:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d21so10179879oic.11
        for <git@vger.kernel.org>; Fri, 07 May 2021 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jpTO3gtmP9CQ7rspYd6VI53LapY9PbLEUjeU4eGNKEA=;
        b=kCuG2NehdOEvILuisstF0jSi0EKmCYVQTm6dcHZiXczmkWsoGQGetQFcn4bg5lgxr9
         R+czajSWyPHPEwhxiFdk9EZ41MU/JRBRh6sui2ffjSYCut37G7YVU3AsKgjcegETC3ma
         Z6jlzPEpyj0+N821GfhTj8h81DBkx5qev9o81xL6wjigQ01hYUMYU7642WhKDuIIAqs7
         ed6wx9xDMlARQSR2lUoJpv49Xt1JpkzhrfI+FSuUAidf3lUbXm7O0U2nL8Xu3aPEsfhu
         viBipxuJzYH6utZBmSTfyu5vMtMxPbvp7z6VKzuu40DrLiWmX3mS8qq1Mj9EG8jPMuWx
         bZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jpTO3gtmP9CQ7rspYd6VI53LapY9PbLEUjeU4eGNKEA=;
        b=WiQmmNikW85TzBZLt/dFx+ghg51lyesu6L33Mw5YUqgmiESPLuWv0dVMvwtQpbRDBI
         OoFmwAqqfmjl3lTXSxvVGRV6eumh0ie4p5u/hV2GqlA3QlK2pnxq3rDUHimjCAtmihU6
         QG7YnpXBXW9gg+4z31numr4YSZF2UAulj/XNmtFuOrqCFNH3XmPMz7QKn8gFzF0R5Y9o
         dAjdrDFgn08FcyvC7/9WYXiZK7Js/G4m+iSAEkew0EqVHwwV/HKPVovuvYH87EMr6QwY
         DUT6mTQdbvhIMbzzHpfJUiRPLVu+VJBrq9ZHMc//7TspKdlN+97MKOf5K+sm45c4TWsk
         j6ww==
X-Gm-Message-State: AOAM530eEXZNSayQDj62luy+WA//Sa83IvWl4vp0amvYm3Z79P7vfuxk
        Y97VMZeGOWuF/a6cNBDJKk0EkuJucjRmyw==
X-Google-Smtp-Source: ABdhPJyChpmmHmmSUzRnOqXdS+iOfhhIHTDAe0tr+T8DSj/AVVfccMv/jYOcJAkRZ7nB/rj5oGd1Ug==
X-Received: by 2002:aca:3e05:: with SMTP id l5mr16500552oia.39.1620430526245;
        Fri, 07 May 2021 16:35:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m3sm1511065otk.18.2021.05.07.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 16:35:25 -0700 (PDT)
Date:   Fri, 07 May 2021 18:35:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Message-ID: <6095ceb984401_cfc7208b9@natae.notmuch>
In-Reply-To: <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-07 at 06:06:31, Bagas Sanjaya wrote:
> > So completely migrating to Asciidoctor can eliminate xmlto requirement
> > for generating manpage.
> > 
> > What do you think about above?
> 
> I didn't do this because it makes things very complicated in the
> Makefile and my goal was to minimize the needed changes and divergence.
> I'm not opposed to someone else doing it, but I expect it will be a
> bunch of work.

I don't think it would be that complicated.

This patch seems to do the trick here:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c2baad0bd8..8fa4896d22 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -189,6 +189,7 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -360,9 +361,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(TXT_TO_MAN) -o $@+ $< && \
+	mv $@+ $@
+else
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \

I'm sure this can be improved with some knowledge about intermediary
rules.

> It also doesn't help if you're generating more than just the manual
> pages, since generating the PDFs will definitely require xmlto and
> either dblatex or fop.  I personally prefer fop over dblatex, but folks
> have different opinions.

Huh? user-manual.pdf seems to require DBLATEX, not XMLTO.

Cheers.

-- 
Felipe Contreras

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E4061622
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhELA70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELA7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:59:25 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:58:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so19178697oth.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cwURW/e/da8qgUFgdElK07M3ByW2dh7gs+vCy9fCwWE=;
        b=o7FsemaiYU94o2ZSu3lxduWSN9QoxWhQ6J30Q7Yv5jcEEmmtsN2/7iBUcuSg5Jpdsv
         iPVoV0fdV1CHxZBPMXPu9sejXPmFOv+iDgjiV/ETnCTZqODXx1PdqqVCeqMV+L0/38T5
         r63LkrXQ6CrF8GpYQkLQJSSOYU9TBDetd6fB60m7lyjQ/FDvyMBVIwtsWF775Ng3ZwdK
         jS6M+jWO+R0JYCYjkK45XguYHwtFPWghw7xkPRQhucsq064qdn8ZBYV6WaBD51bzmj4Q
         8mVhodkCQauYJTbtwKKtPRCz4HAUU0KcpVVuweUxGfekhObkHq/SbJufuV93lD78akBY
         p/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cwURW/e/da8qgUFgdElK07M3ByW2dh7gs+vCy9fCwWE=;
        b=KhBelOtCIrztuGQ66J1PYoNMC0X8rrqV56A8DgaPvp3A7avp0MP9HetFQkvmiV9FwN
         /Z6g4awKq2QBl5HdzkjOWpcFnXecRL9hm5Suo5WxEDKzEC/5GOMTSiJLyG9tRRsEPzI9
         vCOxq4sJsY8lC3U3ysLyCQhPmkSmQyd21h50QIyXXaQ/hyKoy/Bm8B/+9f+WNcz6T/z7
         /ZEBSCt6om5g6/RI//AIRP+mdFAV5SMRGmtPEA13v8UcCuW9GhAMUIS0KsSlxk7T/JtS
         ek6B+7raPaOwsIbN7o4Kgca7URvggA9oJLSCjL5SBoHH5WHujJybWyT7JkqJIKA9eYlJ
         uJAA==
X-Gm-Message-State: AOAM531DDb5i8Hj6FILfOEaxj6FaGjU8uCRh89wSCFaCI6mJXSjrwEam
        1jovUaq8oEwluE526jaI7hc=
X-Google-Smtp-Source: ABdhPJx4qBwp6CPc9C8Xv0dmf6jAze39+LnG9mBr5dwfok5utrdj03rLds4z2X2pCmBlEdQxuESdSQ==
X-Received: by 2002:a9d:7096:: with SMTP id l22mr21242411otj.345.1620781098150;
        Tue, 11 May 2021 17:58:18 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id z15sm1155036otp.20.2021.05.11.17.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:58:17 -0700 (PDT)
Date:   Tue, 11 May 2021 19:58:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <609b2828309fc_678ff2082@natae.notmuch>
In-Reply-To: <YJsSuAscwHwRo84R@camp.crustytoothpaste.net>
References: <20210511222754.417371-1-felipe.contreras@gmail.com>
 <YJsSuAscwHwRo84R@camp.crustytoothpaste.net>
Subject: Re: [PATCH] doc: use asciidoctor to build man pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-11 at 22:27:54, Felipe Contreras wrote:
> > There's no need to use xmlto to build the man pages when modern
> > asciidoctor can do it by itself.
> > 
> > This new mode will be active only when USE_ASCIIDOCTOR is set.
> > 
> > Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/Makefile | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2aae4c9cbb..0cfa88a92b 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -196,6 +196,7 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> >  DBLATEX_COMMON =
> >  XMLTO_EXTRA += --skip-validation
> >  XMLTO_EXTRA += -x manpage.xsl
> > +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> >  endif
> 
> As I mentioned elsewhere, this breaks the linkgit functionality since we
> don't have a patch for the asciidoctor-extensions.rb file

That's an easy fix:

--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -15,6 +15,8 @@ module Git
           "#{target}(#{attrs[1]})</ulink>"
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        elsif parent.document.basebackend? 'manpage'
+          "\e\\fB%s\e\\fR(%s)" % [target, attrs[1]]
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \

> and it also doesn't honor GNU_ROFF, which means that copying and
> pasting from manual pages is problematic on systems which use groff.

My system uses groff, I don't see any issues copy-pasting from manual
pages.

How exactly can I reproduce this issue?

> I'd prefer if we put this behind an option so that just because someone
> like me who builds with Asciidoctor doesn't have to get this behavior.
> We may by default enable that option if the issues I mentioned above are
> addressed, but it would still be nice to have an option to enable the
> legacy behavior, if only for those people who may be using older
> versions of Asciidoctor.

Sure, that would be nice, but that's not not an itch I personally have
right now.

At the moment I'm finding too many areas of improvement with the
documentation build system. Perhaps, I'll do this after I've addressed
those. Or somebody else could volunteer.

Cheers.

-- 
Felipe Contreras

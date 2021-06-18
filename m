Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D98C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2A613B4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhFRVKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFRVKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:10:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B15C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:07:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so10994873oth.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ARdpva0ihLoWwJfjbFkwuCOfF3kN8/6PsNQvvVGPvM4=;
        b=UvZHEfhRIfByxJ4e0NkQ2kyEKK6RY/sduOSIKxjKwaZNG3hbPDannjQDcLeWTaynBu
         m3QxitCy1n6HxtpoU5n2Om8O/pRPI8wy274Iv/6ZsofO1BghmtrPb4UbHbA5V9OMAo0O
         TkcWSPsDzPmINXpPLBKQPyXG7rfdM7jZrTdRs35LjLbRBBiiMIiBj5oP9laCv6rsLpd2
         q3yrkYUh8CyS/0aKXmEA0e4Ogf9DkReCiZ7CrRpHIKmfiuQ/SSMsG2mLWUZ6x4LGRZs+
         6vzjeTJhP705FGaaRqL37c/WawfR4ME/GUxoEcddTDeiKOopPgoAJ+l9dsCHh7CwPyfm
         u7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ARdpva0ihLoWwJfjbFkwuCOfF3kN8/6PsNQvvVGPvM4=;
        b=JAVmWZIoKLUMiOQYIKtHsOke0kUuMbyv4v9uD4vTPhAF1gFajmManV7EUPjwSY7ZUz
         3312RyxIlVjwoM4J07iGG/4jwot/kshZXtogjDRiP8uqNO5Kvfl1ykoaLvz/42gNXdCP
         kJKhOa5LTAGJYk275t3EdDG1oAWKIZsgUFej69fCyfRQvc251Q6nICTPYYy6SRQixfRg
         susUMJecGMOuK+BQdis/iJ/B2E3qrrAVyaDt/owVYNjteaGMwA8VaAVevDQUaFBoL+lR
         knjEX/8dK8alncZh6eZKJKvNqJVhnHz0KzsIVmugYgJmAI5EoiOTi8I8TCikY207vf8U
         ptUw==
X-Gm-Message-State: AOAM531pgCoYIrNlveNENwdPoBiOi59XQc+ZQLOU5EWZ1MZRj1NBq9Es
        QKw4JyXefJ3oecgiBPjWydg=
X-Google-Smtp-Source: ABdhPJy+N+NVGtOBl8h9IDTK336pD6dI4sRKW30aD9UT1x2SgKIskVjvAGiO/J2othBI6JPLE9DARA==
X-Received: by 2002:a9d:1b05:: with SMTP id l5mr10736459otl.335.1624050471188;
        Fri, 18 Jun 2021 14:07:51 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n21sm2039785oig.18.2021.06.18.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:07:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:07:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60cd0b255b8b0_c0ff920870@natae.notmuch>
In-Reply-To: <20210618203057.790320-4-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
 <20210618203057.790320-4-felipe.contreras@gmail.com>
Subject: RE: [RFC/NOPATCHv3 3/4] doc: use XML-style escapes only for HTML and
 XML
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -183,12 +183,15 @@ ASCIIDOC_HTML = xhtml5
>  ASCIIDOC_DOCBOOK = docbook5
>  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
> -ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> +TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
> +TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =
>  XMLTO_EXTRA += --skip-validation
>  XMLTO_EXTRA += -x manpage.xsl
>  ifdef USE_ASCIIDOCTOR_MANPAGE
>  TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> +TXT_TO_MAN += -aplus='+'
> +TXT_TO_MAN += -alitdd='\--'
>  endif
>  endif
>  

My version of the workaround [1] is much cleaner, and doesn't mess with
the build system:

  if doc.backend == 'manpage'
    doc.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
  end

Once asciidoctor issue #4059 is fixed [2] and in widespread use the
above workaround can be removed.

[1] https://lore.kernel.org/git/20210521224452.530852-7-felipe.contreras@gmail.com/
[2] https://github.com/asciidoctor/asciidoctor/issues/4059

-- 
Felipe Contreras

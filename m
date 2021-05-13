Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F974C43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E35613CB
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhEMLRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhEMLRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 07:17:04 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4379C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:15:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso23278806otg.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vcKZtadTpYKZ1FBEXiuwoR5NyCESKfSzTVb0feTbVmY=;
        b=PhPhqK54Soy69/nQlb5TGnZvZH1lTA8TN/XZQKEhI1/17oVw8hWWlkGXZyn3/A+pdW
         38y7DImFbI6a0tvzVwUBmzmr+/fs2ywhCHwFWkMnNma+w7kBUciulrHXMhse6qVqlCPt
         JU6SpzK7o+eQJSin/wNo3fq7JXNRAruL9SRj78Z1nSDvn/9JreIVOIcIDFNVmkuRC6Yh
         epXSYz6v7Qt7SSEFTM/kB43GJmxRtfIxN6HjDr5/FFVagCQuKiyiwnbhXzu84CCDnzYp
         t4BhXICXsn30OMKbPEhjHZrixcrxOC/Y/ZFSRMpXD1QTkkQMLOqGvUfSct69TP8wlG+l
         3qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vcKZtadTpYKZ1FBEXiuwoR5NyCESKfSzTVb0feTbVmY=;
        b=Y6pAzWDtahyq5r7qRFlWFldXlPaihZW3Am1CWyCWqKBdN4oByyiuJaOBkKUIh8I2wS
         Q03lYZU53tIzlp0XEE+H0fasV9EQVRmluM1BZGG3Igx3sAOxiCUDfqvrokWZj3hP1Xrf
         uBZO7qefErKjbqUluJ0ew3aIaooT0nC5vNHxSR40lnQPcv3plHJlEVhndoLXr+3RpoPz
         DmSLqmqtph0v4OJr9XoeYAHSRupjyIm1Cp2kwRF7kVkgIvHjdMzDEbkEpRU+N91PeoXq
         FXAeRbI9tflmFPLCht/I+SbTxPqNL8A5QNh0PQf9So1SonMv+leTgqrcVMrL9OZwfpDC
         8+Ew==
X-Gm-Message-State: AOAM533Jl0Y1kGdWMjX0C4gyffDH2jfv1QBEWda0YJEo34dGUGbeXRdf
        VICF06iogGxbXNYAgA1/6nEjTpI8Vhkfog==
X-Google-Smtp-Source: ABdhPJxE6GJ4Pu1JN+8E3uiZBFpDDkqE6z1Q0m3ggWh7LWDXiSiVy/z2On5OOYoo4UnvGIeAT+Kkqg==
X-Received: by 2002:a9d:6106:: with SMTP id i6mr30065867otj.354.1620904554092;
        Thu, 13 May 2021 04:15:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m189sm542223oif.45.2021.05.13.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:15:53 -0700 (PDT)
Date:   Thu, 13 May 2021 06:15:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <609d0a684ece6_271c20831@natae.notmuch>
In-Reply-To: <CAN0heSrWu462h9Ch5K-aMHUgjB-BGqRp9YpWa=vPi_V+MiUwBg@mail.gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-9-felipe.contreras@gmail.com>
 <CAN0heSrWu462h9Ch5K-aMHUgjB-BGqRp9YpWa=vPi_V+MiUwBg@mail.gmail.com>
Subject: Re: [PATCH 8/8] doc: join xml and man rules
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Thu, 13 May 2021 at 00:28, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Will be useful later with asciidoctor that can do both at the same ti=
me.
> =

> > -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> > -       $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $=
<
> > -
> > -%.xml : %.txt $(ASCIIDOC_DEPS)
> > -       $(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
> > +%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS) manpage-base-url.xsl $(wildcard=
 manpage*.xsl)
> > +       $(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $*.xml $< && \
> > +       $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $*.xml
> =

> It does mean that if manpage-base-url.xsl changes, we'll regenerate all=

> the xml files. Before this change, we would just rerun the xmlto step.

True.

> Also, this will break `make info`.

Ahh, I didn't see that dependency on MAN_XML.

> (If you're wondering if anyone is actually using `make info`, there's
> some discussion at [1]. I don't think anyone would be too sad to see it=

> go. Once `make info` is the only reason we need to generate the xml
> files, I think it's a given we should try to drop that stuff.)

Perhaps, but not in this patch series.

> I think we should keep the separate xml targets as long as "asciidoctor=

> without xmlto" isn't the only way we support building the manpages. If
> the only benefit here is "later", I think we should do this patch later=
.
> I could also imagine that the xml target will just go away once all the=

> "old" ways of building the manpages are gone and `make info` is gone,
> i.e., when we simply don't need any of these generated xml files.

Agreed. I will drop this in the next version.

Cheers.

-- =

Felipe Contreras=

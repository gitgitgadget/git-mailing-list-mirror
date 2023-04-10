Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B2C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDJXcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDJXcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:32:17 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3BF1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:32:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c2-20020a056830348200b006a3ab0ba8a2so7434257otu.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681169535;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGpEgoBUUJzJui97swy2qWFg0fDqAaIAGIoBoykojjo=;
        b=B9xW4cVU8jJczSyRd5Y0OjyDvgqsUoaSlByoeyzeBoqJyXHlw/xg5xEkqGNUJrpJyJ
         ZHxZKjDu8qyAdrzh0QdysfbOFzxGol9H8GPBYlMlG0lBUihGDZDVEA/X7/n0OXmPW0eE
         WLOX4kvm2QOAjvcNUhaQ/GRBfdB+Xw4+19U7fxeUkOLttMxihUn+PMscmoHybndbhmtW
         xtRqQMGLd7cuDUEp3Y+3Q3w6fLtetwNsn4xAOHNAl6DMgTc9lJ0amxkx8hSOidvYf3qN
         uzrNHqllJQEVNn5itDXzSAr7lAVyl/h5KMvOsl6k5EElhyAxaKr7KnW1K6fXp6hhryTS
         vq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169535;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VGpEgoBUUJzJui97swy2qWFg0fDqAaIAGIoBoykojjo=;
        b=Ko4U6xIXoYNvBkcKMohBXKuq/KFTg3p1mYBvGcc8p6V8P/eaDK8ScsqHXwcm2ZggOS
         HqE5jXh0jkmRTRJdWfLE7pJPTOzSoL3nhFxMiDm+uhzbnEACVSe24qqIBD8jhShAYpNM
         ju+tJBDhQUgrgP7T/nrx9S1smlFQLGlMA9EcmRFbfuGqZOW2YjNCtODz4FwPKanXCA8b
         AF13CtUD3o66TrcA1L0IOEdeFY4iiIAglnxDn5ISMjo1yXfzu7U3AFJfTrqxRVSxuWOt
         fjVs/ofSSl7utEd3Ctpu3x+IzblJZPFrxg6sPn9+ppFiUuHOzsbPQOsvH5ScqVjKu2iW
         zdww==
X-Gm-Message-State: AAQBX9f0iR8/SzEtR2IV+/odz04hS1CAysbXDmBJsjo8XfGyv/PO58ha
        MGBlbqIDHkyOxL1B1qWvUAo=
X-Google-Smtp-Source: AKy350YEhhdByh0TDRQyoDkUTj95jj5DApUJvJpbHjD8WcHw3zSRPKIAeCPCkyRwUJjkbR4MTae9aQ==
X-Received: by 2002:a9d:7498:0:b0:6a1:7eaa:3836 with SMTP id t24-20020a9d7498000000b006a17eaa3836mr579726otk.5.1681169535329;
        Mon, 10 Apr 2023 16:32:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h11-20020a056830164b00b006a32ba92994sm4866341otr.23.2023.04.10.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:32:14 -0700 (PDT)
Date:   Mon, 10 Apr 2023 17:32:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Message-ID: <64349c7dc4f49_7452943c@chronos.notmuch>
In-Reply-To: <xmqqr0suf0wz.fsf@gitster.g>
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
 <xmqqr0suf0wz.fsf@gitster.g>
Subject: Re: [PATCH] doc: simplify man version
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index a6ba5bd460..4721b000c1 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -150,8 +150,7 @@ ASCIIDOC_HTML = xhtml11
> >  ASCIIDOC_DOCBOOK = docbook
> >  ASCIIDOC_CONF = -f asciidoc.conf
> >  ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
> > -		-amanversion=$(GIT_VERSION) \
> > -		-amanmanual='Git Manual' -amansource='Git'
> > +		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
> >  ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
> >  TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
> >  TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
> 
> Is this a complete patch,

Yes it is complete.

> or will this leave us in an incomplete in-between place?

No.

> We have some references to manversion in "git grep manversion
> Documentation/" in asciidoc.conf and asciidoctor-extensions.rb
> remaining after this ptach is applied, which presumably are no
> longer used.  I would imagine that these leftover references end up
> substituting them with something benign, like an empty string, in
> the output, but it somehow makes me feel dirty [*].

Passing an empty string has the same effect, because as it is explained
in the commit message: DocBook Stylesheets simply join them *if* both
are present (not empty).

> Other than that, I like the simplification of requiring only two
> pieces of information to convey the same information that we are
> attempting to (and to some backends, failing to) give with three
> pieces of information.

Yes.

> [Footnote]
> 
> * If I am not guessing correctly how the result of applying this
>   patch works in the above "I would imagine ..." that led to my
>   possible misunderstanding of feeling "dirty", it would be a sign
>   that the proposed log message is not explaining sufficiently and
>   deserves an update.  Even just saying "... and when they join the
>   `source` and `version`, if `version` is left empty or unspecified,
>   the resulting document would not show any extra whitespace.  So it
>   is safe to do the joining ourselves and stuff the result in the
>   `source` field" or something would be sufficient, I would imagine,
>   in order to help the future readers of "git log" that there is no
>   need to "feel dirty" the same way I did.

I don't know know what could give this impression, given that a link to
the documentation and the link to the source code was given:

  if we have a Name and/or Version, use either or both of those, in the
  form "Name Version" or just "Name" or just "Version"

https://github.com/docbook/xslt10-stylesheets/blob/master/xsl/common/refentry.xsl#L545

The code clearly tests for empty strings:

  test="not($Name = '') and not($Version = '')

And it's not clear to me what else it would be checking for.

asciidoc.py doesn't conditinally add this field: if manversion is not
provided it just sets an empty field (if revnumber isn't provided
either):

  <refmiscinfo class="version">{manversion={revnumber}}</refmiscinfo>

If this works for programs that don't set manversion, why wouldn't it
work for us?

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA34C47094
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B0560FEF
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaINX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaINW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 04:13:22 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC30C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:11:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so11534040oig.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0lAndxS84i8rhBIzuEipv1kSEuSHGU+WG3XXySjWX+A=;
        b=CisTKz1p+8vXev0Hkc0EGj8/7AbrvSOUjEo5y2BL2PIY0JAAXhEZ814eIB0AG2lrW0
         MHLqSkgcUC1N2Ji8gHPWxQhMyugDYOKsEh4/pcrTJtakRqOso/ZvMo7IQ0AFP5QBjN2m
         tBgnuiCkY7oG0vYFJWiKjeStU8o0GIfEyTgHw23cWJIR04Vnq/lda0yDekcNlNpw0Q7Q
         l2VzLSS33bsSMp/Jfv2zZMv8KM2UPKkPxjoqiWfDZxvs/IJbxbPLybx8SDPqs/tQx494
         MxfKXIl4tEpZVt0P7Bo8JQd8q74aswLOWJ9MMzJqlHv7tU12jy8n1abWGF1hx+Onj9d6
         1G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0lAndxS84i8rhBIzuEipv1kSEuSHGU+WG3XXySjWX+A=;
        b=Mk45vtarv9QBqX0TpSFXMXWOB2FLJP5VYCoAyTxrhp6jhyY8tgKuo037lqsVUsmBuX
         cR4/cSRpNuQajH20Ph1ll6xW6m4Wv4c2bwMrqrbHw5mqJ5BMnAjIVsyecEskHid6NTjQ
         Gk1346xYmtLvb9EU87WqNR41oIi0HYN9J4vIG2/hQiUBLLewGLJiZonjxdb36YunB75Y
         Br4ALxjs6u4dqg00Fl9s4DUMi4TggPbuaV8FaUi6hmvCeAxLeJr2rDPj9XgV4vsVZHUI
         jf54qwW838Q78TlFTL0hoy4zOFP/LuD6ryW8tCPbRwxya6lwV2PpCcMbSI0Qq0GnvdHO
         Gsdw==
X-Gm-Message-State: AOAM531z892R6IazMWUAogjDmiZUhRAWJ0bhLTLX/gvEzpVm9UvwO1aK
        jPJwoaSxbl7zd/w1MPRoG5k=
X-Google-Smtp-Source: ABdhPJzPhJHkOHotz0nipJ5W4MccncUq+P2rTbHUxh19tFa4SdfKo5L8riVOphGrUbbepACMIuGdlw==
X-Received: by 2002:aca:34d6:: with SMTP id b205mr13553350oia.151.1622448701183;
        Mon, 31 May 2021 01:11:41 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x65sm2947495otb.59.2021.05.31.01.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:11:40 -0700 (PDT)
Date:   Mon, 31 May 2021 03:11:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <60b49a3ae829b_24d28208fd@natae.notmuch>
In-Reply-To: <xmqqv96zwkl0.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <xmqqv96zwkl0.fsf@gitster.g>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
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
> > +If you are working on a centralized workflow (pushing to the same repository you
> > +pull from, which is typically `origin`), then you need to configure an upstream
> > +branch with the same name.
> 
> I suspect it would be simpler to read and easier to understand to
> bring the parethesized part front, e.g.
> 
>     If you are pushing to the same repository you pull from (which
>     is typically `origin`), then you need to ...
> 
> as it would avoid "the project is not centralized, but I push to my
> own repository and pull from it---what should I do?" questions.

The top of `push.default says:

  Different values are well-suited for specific workflows; for instance,
  in a purely central workflow (i.e. the fetch source is equal to the
  push destination), `upstream` is probably what you want.

We already brought up the central workflow, I think it's fine to reuse
the concept below.

-- 
Felipe Contreras

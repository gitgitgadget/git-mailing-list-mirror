Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA85C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223D46108E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFHFwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:52:00 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37846 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHFv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:51:59 -0400
Received: by mail-oi1-f170.google.com with SMTP id h9so20494381oih.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=esWXXrC2MNyvXfUGzmMWTlnSAr8QY72JHRQFZZiK+zY=;
        b=vb0UYsasQMWtdg0zaYcg0UKpIW8WRp+wkXfe6/bLplM+wRfkpcNMkVk+4HZPDyUDGM
         phVDPU4eY7gMMWNozKiEC6XdJbq5CgWASqToTH+ZOkrNaqiRsvjClOl1Q1M2R5nfQeWz
         jg9yhWpaHTNt/cx6jcESZKKqBo2NQdNpWAv4SYVxtVEitq7aTYBQvTTA4xX2oTLHoCau
         BarmyfRlQhntbIZY09oPIaqOljT+L6J5X0gIzPWaqZcGLxOSGZXgYdOyQVihZ8Kan7MT
         cKbZjI9NxLuzSIQGq9Hf5D4bfh3Wkp4nHrnUEgBXIQJ3mCpiFCHBxnbnoivVkKG2YSkb
         N9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=esWXXrC2MNyvXfUGzmMWTlnSAr8QY72JHRQFZZiK+zY=;
        b=qdnYBn1bztJMskY2sScXiQlXx1KVsEqxxxxH9dQTPpb/tNAbEhk+sVbYhHHhosoO1Z
         t2sOAZSH61Zv18+SwDAOrXokHFoEJx69cZR0c8ZZF1JALizRM/eA6W6Z2tIZvxZeH3lj
         1bTx9vyMnzDOEk/hQ4m01t88yezHDHMDfyzUFqPLPuEZaQJzr8EjbFNQnlE8qbp60BjG
         vPyZpy8nxdiJjcfMOyFpDzhcyE1uD21mA3NZbTQdFvC0YYKTtv2JB/2MXlVCIJBUk1Vp
         pEtJwqh0SOSZWbk44EJJMFSetfk3/d5G2LngPBC6ZH9oFLQqi0O6YN2ci0pzgk323Ii0
         R6Kg==
X-Gm-Message-State: AOAM5316iJliSuC1/Om0KNRJlzxU1fMMu3upe5DktwYJsmdxlDvIYjmQ
        ygGHa0kIrcpvBesIIVKhAkUzHQTeLbuhuw==
X-Google-Smtp-Source: ABdhPJygGEsMVGHMny8uZsa7lx/pOpc2GIf3oE7WKicESMz7v3DNBGG+Jkha5b4yOXZLGA5bbgSauw==
X-Received: by 2002:aca:f5c3:: with SMTP id t186mr259861oih.97.1623131347268;
        Mon, 07 Jun 2021 22:49:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id d8sm1624999oom.37.2021.06.07.22.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:06 -0700 (PDT)
Date:   Tue, 08 Jun 2021 00:49:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Message-ID: <60bf04d176fff_198ddf20859@natae.notmuch>
In-Reply-To: <xmqq35ttq6na.fsf@gitster.g>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210606184726.1018460-4-felipe.contreras@gmail.com>
 <20210607190046.GB6312@szeder.dev>
 <60be6f7fa4435_db80d208f2@natae.notmuch>
 <xmqq35ttq6na.fsf@gitster.g>
Subject: Re: [PATCH v2 try2 3/4] completion: bash: fix for multiple dash
 commands
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> =

> > SZEDER G=C3=A1bor wrote:
> >> On Sun, Jun 06, 2021 at 01:47:25PM -0500, Felipe Contreras wrote:
> >> > Otherwise commands like 'for-each-ref' are not completed.
> >> =

> >> I think you meant that options of commands like 'for-each-ref' are n=
ot
> >> completed.
> >> ...
> =

> > Yes, I meant commands like 'for-each-ref' are not completed correctly=
...
> > by __gitcomp_builtin. Which in practical tearms means what you just
> > described above.
> =

> I couldn't exactly tell if that's a roundabout way to say "yes,
> yours is better and I'll use it in an update, thanks".

I meant that I meant what he said I meant.

But meaning is not saying, and it's better to say what one means
(implied), and since Szeder's version says what I meant, that's better.

> I'll assume that is the case and will mark the topic as expecting the
> final update (as it seemed that all the other patches in the series
> were received favourably).

I think it would be trivial to do s/commands/options of &/ when merging
the series, but fine, I'll reroll.

> Or was it meant as "no, the version you commented on was already
> correct (if you squint your eyes)"?

No, that's not what I meant.

-- =

Felipe Contreras=

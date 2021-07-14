Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7FC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9084B611C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhGNWmc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Jul 2021 18:42:32 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43717 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGNWmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:42:31 -0400
Received: by mail-ej1-f53.google.com with SMTP id v20so5829682eji.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lx6mhypykArPWt298Mq9jhbUp+MaQUnHjUAoNfFWfxs=;
        b=qAE6MR1JN4RIT31oNQmpyUm+6wGiHIrQE3qLKD3H5kFV9cNn3T5M4IzWP0J8nm76L8
         ZDYL1lAUo018Dmon/n/M/RawnnwzIFo1PjFuepCtMp2p999XbbDmIAWyg9bxAiHrE5Z1
         5Qrvb0EX7ld3HV/t2iVKUZgNRhiKLtw0SVwsWPkV5zCA7ORYhFNNj/lGbFXECb/c2gvP
         69y9uGVx9m1XeGiRtgx+VtZx3eAnb7OngovFgr5ToCwQLCaFgWDhSLo2fipOffB1s13U
         aUJXk/0NGUr8itVO1wPIafS+eYeiGUd6dUcJ3JEh8pL8Yo026fA57SMsD0xRiV1ykNAn
         iB+w==
X-Gm-Message-State: AOAM530IyZiA797jWuEiPVTZ8BL8pvoTilpovnYxoOpYWYzQd6oMbZZs
        x0hf0rvFugI2nWuPkDoqib/vpjh3s+9XkhO+hbw=
X-Google-Smtp-Source: ABdhPJz/zxSz1ar6TI0F/PBMSWCPG7Da7KONRk3RbNCLtnyaXhU8+xWgTAIAIH21JrrIhPJZ9MOXEmWDgufUMkX3jFI=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr543645ejb.482.1626302377862;
 Wed, 14 Jul 2021 15:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtqpzosf.fsf@gitster.g> <CAPig+cQfsACHAQhCrXDs==18p1Ds8MtMRZDmSfso9HsO6dF-qg@mail.gmail.com>
 <xmqqlf68yi1z.fsf@gitster.g>
In-Reply-To: <xmqqlf68yi1z.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Jul 2021 18:39:27 -0400
Message-ID: <CAPig+cQjyYGidKA3sNc6Xr3aw0mk_t-s_64qaX13ffv5R_CHLA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 12:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I think this series is ready and gave my Reviewed-by: here[1]. One of
> > the new tests contains an unnecessary but harmless `test -f`[2], but
> > it's such a minor nit that I doubt it's worth demanding a re-roll.
>
> I think having "test -f" is the right thing to do, so [2] is
> probably OK as-is.  test_cmp may want to complain about a possible
> bug in the test when given a missing file.  [...]

We tried relatively recently to have test_cmp() complain about a
missing file[1], but both Ævar[2] and Peff[3] ran into problems in
which tests (presumably) legitimately called test_cmp() on missing
files, so the suggestion was made to revert the check[4], which is
indeed what happened[5].

[1]: https://lore.kernel.org/git/20200809174209.15466-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/20200921104000.2304-15-avarab@gmail.com/
[3]: https://lore.kernel.org/git/20201016001704.GA2937048@coredump.intra.peff.net/
[4]: https://lore.kernel.org/git/CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com/
[5]: https://lore.kernel.org/git/xmqqv9f9ao0v.fsf@gitster.c.googlers.com/

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A4AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E665610D0
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhJUFlh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Oct 2021 01:41:37 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44741 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhJUFlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:41:36 -0400
Received: by mail-ed1-f48.google.com with SMTP id w14so626522edv.11
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 22:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uuF003Wd3res0C21uipAGCC5t+Kgvt1wnqsmX7YizDY=;
        b=f5hEcvCgZXUIui4RDV5f/3KnfDL47TYh5KOyZok+Kg7AEuTQHZPKAuruY6cdl1aFYK
         z/zglv4Im5yZucm5iRR5F3cJmBg61rJKxbXTIinmWPpPQbN//W9T0VSpUkLoBR4nHE+s
         KGRqhejXzPGrp9ogGrR0RAwZQWHNeCleRcVrKk7ydIAb3Ou350fN7paweHSvwDyoRn8A
         e6AXdTnU3unpAKXnGLm9Ov1jgjUrrSloxzGbD4+grV7HGcinUV+r0/CI2ALrttT6MT2E
         NDdThHnOjCsCjlved+SQyRvMDQ+KCW1iQvWvUEL6Zu3BkABhXOJsYitxR4R81QBQylBE
         BXkQ==
X-Gm-Message-State: AOAM531Vcu5aazSVf4DkwRuRow1MwcKyQ85Ly8N4Jua56E0lWqPLnO32
        b+P5mWPVCKaPdwOlhm9YRA9vgWMCA2cUpNpz8yhGY8aGu18=
X-Google-Smtp-Source: ABdhPJzj+nlr4x4ynYWBHOQx+GLHsBS5iJHputzSqpOeWSl9kurPa9vDEiZg8O0YzQx4TKlSxP+NpbEuVmxAwcKyWUM=
X-Received: by 2002:a50:ec0f:: with SMTP id g15mr4700081edr.47.1634794760177;
 Wed, 20 Oct 2021 22:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net> <YXCKqAEwtwFozWk6@nand.local> <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
In-Reply-To: <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 01:39:09 -0400
Message-ID: <CAPig+cTX+zbO6QJeWR1yu6Fe+wmhHFqd-=mp_GpwFMLYBbu5DA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 7:34 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Oct 20 2021, Taylor Blau wrote:
> > But I don't think we even need to, since we could just rely on Awk. That
> > has all the benefits you described while still avoiding the circular
> > dependency on libgit.a. But the killer feature is that we don't have to
> > rely on two implementations, the lesser-used of which is likely to
> > bitrot over time.
>
> Per Eric's Sunshine's upthread comments an awk and Perl implementation
> were both considered before[1].
> 1. https://lore.kernel.org/git/CAPig+cSzKoOzU-zPOZqfNpPYBFpcWqvDP3mwLvAn5WkiNW0UMw@mail.gmail.com/

Thanks for saving me the trouble of digging up that email reference.

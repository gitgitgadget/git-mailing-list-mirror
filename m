Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABCFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2AB611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 05:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhJUFPE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Oct 2021 01:15:04 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43677 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUFPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 01:15:03 -0400
Received: by mail-ed1-f53.google.com with SMTP id i20so330456edj.10
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 22:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nvOzbeJfrIJfLN+m9XQxEjyrvrpbiq3AyWqxj6zDaAU=;
        b=k6YmTF8+GMZ+pbwfd4KMswlAwn5CXZzCVkyzQ7IkVsx9Tq9ljLTv59QUp5gaI9LJ1N
         VlWRE3N/6+5xZsmN8raCwR/mprEyZL1k1Z5VZjs7HjqJjgd7mt4uunPGzzRLbydwAenM
         YVZXOD5CWr9DKS0yY0m4RLwRbaDpvnVTqKYBTnoNEnca8RVozvjH8PmTQe4/G2wMHZXU
         Fhjvaseudv34rnH4ksLXpBqUim7L54rYHlZMCMnCWDck+ckVCP63WCeUlCkl8Kj7Si49
         172XAQQfzvqRyz9QVU1PAUYee8qv/A1B7hrIwWvl3KrUQ8cbGbGbNpiuNRHOa+LHoaqj
         3AVg==
X-Gm-Message-State: AOAM530nzvEcNlkgE1oNhAeV9ouC/3wnTMsmvn+sPezfTeAwe79tdzIt
        ZVgu75luQtLulMab9hjLmizVO5VnCeFxxipUl5KRUhhTVww=
X-Google-Smtp-Source: ABdhPJznPpxVvLmmGBsQCuAeVj7yXw3gwph2GSGi9v3c0nqAYQIlosO0VBQDo1MzjkzTN5iwoMHlw5/dh54jztkw6qY=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr4741007edu.283.1634793167145;
 Wed, 20 Oct 2021 22:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634787555.git.me@ttaylorr.com> <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
In-Reply-To: <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 01:12:36 -0400
Message-ID: <CAPig+cRpw=RhojwhyrEjYK0DVMEQ6xNZDCANecLGX=9mhfpQOw@mail.gmail.com>
Subject: Re: [PATCH 10/11] pack-bitmap-write.c: don't return without stop_progress()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 11:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function.
>
> We could call stop_progress() before we return, but better yet is to
> defer calling start_progress() until we need it.
>
> This will matter in a subsequent commit where we BUG(...) out if this
> happens, and matters now e.g. because we don't have a corresponding
> "region_end" for the progress trace2 event.

Nit: There is no subsequent commit in this series which "BUGS out", so
this comment is confusing.

> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

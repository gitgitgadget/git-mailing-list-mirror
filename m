Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960CE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 07:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJIHqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbjJIHqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 03:46:01 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B9A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 00:46:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d84d883c1b6so4572232276.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696837559; x=1697442359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=275UfiDU9qeeokdEwc1qnEsC2yeDa7UvJB7DZRh3c24=;
        b=lkrDUonld4i/b3nh3muUSF/peLaBxpT8HxIbz20ViV9pWAPkIqjKXQ7SLM+OqQm/FR
         6QuKMY4YC+ntpqzg1owplppi+SyD718ZtHGMpOOsqWfBKxHSFFNyC3oCucmqg4kY1ENC
         kePgMESatvn5Hiv6k1EdKiPpm1NLAOZvIDj33bLQtC7cIe32qcRFu8r9iijJKIDmY3YV
         ggCe9IxTFgMC+ytpWgWGx1DFPoGycko/9lDQ/zubE+7klotitQGa6oMRxVlkv6h91YXQ
         qfz1HqZ5hcoZQ636d+qC0+KBLQvl8kb2J9unZ728vrbMOVytq3K2hobhPL8gQIAMurCO
         Vfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696837559; x=1697442359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=275UfiDU9qeeokdEwc1qnEsC2yeDa7UvJB7DZRh3c24=;
        b=IlGxEQZPdk/3k1tyvaxE/vBG5g1rlx5eAlOrXMX3lbNJkhUjKC70RaYoQuL0qPL7tb
         /vFNrA5rfTwU30IHFp9tPSow2zNJjry9Vu1H+8sKR6QcZPUrk94oLS5cd/UVp4Xg2isu
         W69Z95sRb8n6ZDYoaZQLaEGV8Ny8Z+N7pssoTALDefnUPeLPJviXVBaTNWJgQ5O93bXs
         hWdn00fO68fr4J/o962hUjhNvf0VdXTQFm/l2IN42jseJomB5QcudKI4d8M6u4OQt1yB
         gEJ49nXn94YwbhDxvz6kIBTnv7HkudMhe3pxRrVWuov6o/K52pk7Veg5Lgb3dqNNEovD
         YbMg==
X-Gm-Message-State: AOJu0YzWlZypyZsgLNAMGA1/8JoImkiaVu3Lt40RCeVbJWH3hM7sYnTC
        q1u6XDJxRHqmnzxF07sQYaL8sWtfQ6LB/L1NnA==
X-Google-Smtp-Source: AGHT+IHutKxSYZco/nEbOLDhTriHNFBTqIZqrhsegkNoZoy+bt9nIWOU6bQ8Qo0T6bpcod5TQAPCEBukQozqugxq4y8=
X-Received: by 2002:a25:ac5d:0:b0:d71:c79c:86c1 with SMTP id
 r29-20020a25ac5d000000b00d71c79c86c1mr6176943ybd.32.1696837559647; Mon, 09
 Oct 2023 00:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011842.1956-1-naomi.ibeh69@gmail.com> <CAP8UFD3HZOMJTxW5EkUwKu48GebSKX3-EPD8tjGEQnE2MGaZ7w@mail.gmail.com>
In-Reply-To: <CAP8UFD3HZOMJTxW5EkUwKu48GebSKX3-EPD8tjGEQnE2MGaZ7w@mail.gmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Mon, 9 Oct 2023 08:45:48 +0100
Message-ID: <CACS=G2xfUYVmvhZ_r447uArW-_6yK0r7V9BkzX7i+E7MvruA9Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] *** EDITED add.c ***
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay I understand it better now ,can I do anything about it? Or should
I leave it as is?.
It's my first time using the "git patch" and "git send-email"
commands, so it was a real struggle understanding the proper way to
get things setup.

On Mon, Oct 9, 2023 at 8:39=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 3:19=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com>=
 wrote:
> >
> > *** BLURB HERE ***
>
> A patch with number 0/X (where X is any number) is called a "cover
> letter" and is supposed to explain the purpose of the patch series it
> is part of. Usually a cover letter is not useful for a single patch
> long patch series (when X is 1), as the commit message of the patch
> should be enough.
>
> Also things like "*** BLURB HERE ***" (including the stars) are
> supposed to be replaced by a subject or some comments to explain
> things.

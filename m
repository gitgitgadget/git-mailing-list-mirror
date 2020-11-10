Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58352C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E0120679
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS6M4W5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgKJCJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgKJCJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:09:48 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9BC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 18:09:48 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so6543586wrb.9
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 18:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkdAt9gkni9NjBj5JKKtN6RVfJ6i7/sN6FmmOotCz00=;
        b=mS6M4W5AgbBAeZ92JszJjqB2toU0j+nz1qVUx5m+v1F5ycvvdD1/m8ORg/7ZJtKN2Q
         H5BQ5O7Rx1nG97Em/e0ItVVgTP1TgPFHtTJLI80YsBzFL0rcqxc92Vq7hekIkh+BSsYN
         glgKyPDETHnwmwGJDq7U3QcsgTc/lwcLXvlTTs7487eQ4ta4qCBTD4zogOwejKHBoI3w
         +rdhDJfgWhLa2ix5ky33q+kwE9R43W94MoT8Krq8uisAkvzAknDQ2k5ZuMW6OZGAQ/4q
         +F+judxOu8uLbB6cnRdMAXoeFOFlFZvJyY6NEHvsURm2cKeLr8H7v/WC/y1tr/PQu9EZ
         VL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkdAt9gkni9NjBj5JKKtN6RVfJ6i7/sN6FmmOotCz00=;
        b=GsdWi7hE+C1P2ndih0kyVH2314P+PAqbIryoDKG4tHDUlCCffZP6hYW6n2Z0HZbZ9I
         zCU/maZvb0S0nBsuaNtnm8/a2zL2B6DdGVRuB+u3+2cDxB985xDPRtTfP4mWlIxTf273
         fztVMFvdoOiprAw9VflJugmGvuI4+5DEXHWuN3c8uihCwMgkGPSQiIUI5bkSog/y3rwa
         qtAHjigGhV15hQ2yghw932fkwL24ybAMp5GrcNTJ6RC/8EZ0J1Pu2N20CtsGRxthO7ji
         iamJ6KZdoDnANsub11h+89VX7wlDrKWnEaziZFkhbc4nmmelTzFSEK9lCSewW66FqNVP
         vt4w==
X-Gm-Message-State: AOAM532ilnCWVP0IotcAyG+yE3z26Vu5rr384ATBRYDLGCwAiTtzYyy4
        pCU98s5mWXjOA2MDycCv0HnERDEmd1pt3UrZjwc=
X-Google-Smtp-Source: ABdhPJz/1+stZcjISUt1l0VpL3wP71JZaePvcIFCD2SIJjH/70bx64p/VByfkLvlWQqJ8S+0dyjhzv0JxamWfWBfAHs=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr21114870wrs.100.1604974186902;
 Mon, 09 Nov 2020 18:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20201110005331.532678-1-felipe.contreras@gmail.com> <xmqqv9ee7zkx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9ee7zkx.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 9 Nov 2020 20:09:35 -0600
Message-ID: <CAMP44s3qF2ie=+EgScyQtk_Z5qDeeWXBrJV61NTOkxOy6eBD-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] completion: bash: support for recursive/nested aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 7:47 PM Junio C Hamano <gitster@pobox.com> wrote:

> It is unclear why 3/3 needs to be separate (in other words, is there
> a reason why 1/3 and 2/3 need to be done while the function is in
> the more complex form, instead of doing what 1/3 and 2/3 wanted to
> do to the function in a way that does not require later clean-up?),
> but other than that, the end-result looks good.

It doesn't need to be separate. It's there just because the jump from
the current code to 1/3 is more natural this way (v2), but 3/3 can
certainly be merged to 1/3. We will have something a little bit odd in
the history:

  cur=$last
  if [[ "$cur" != "$1" ]]; then
    echo "$cur"
  fi

Why not just use $last instead of $cur? And in fact why clear $cur if
we are going to be setting it again?

It's just a little odd, but I sent a v3 with 1/3 and 3/3 merged, and
it's not too odd.

Cheers.

-- 
Felipe Contreras

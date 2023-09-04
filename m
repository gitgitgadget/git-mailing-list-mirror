Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E84C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 15:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351482AbjIDP3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351031AbjIDP3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 11:29:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE1CC4
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 08:29:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500cfb168c6so2645697e87.2
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693841367; x=1694446167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Pu6ibvopOu3hb6xFCMQvx3iImNE5F+c6APp+QOGLI=;
        b=Adr2/EuqL2ClVFcuF8xZEL9H3kGvE0WYJ90vQdtilb0eG9KOwt+Pbo9/ww1mB42K4u
         M37vGF79in37uLrmNxcP7T+k6x8eH3d6LjTBigvXgv4CdyMuQLARaaXt28rhiNAQAxek
         h41d4lrqPIHOlDlBFxETvvRk6DvR8jzQEmvjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841367; x=1694446167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/Pu6ibvopOu3hb6xFCMQvx3iImNE5F+c6APp+QOGLI=;
        b=b7KlFIW+mBqpM/MU0EFzcOptuIw0HAo7HaRV+0b3f74U2vx5ZABd+O4ULR1QardypQ
         CuS/kLWHNVfUmyO7u6vNaodovcagCu4YKjUM52sVY3k+Orei6IRifhTSvK0GwVU8DQeT
         Wdi8Tcj44BHRtZ4ncb9DJ3cnmyaVxtXYcez8BkelBdlvrXETMQgJ4G/OlAXXZd2PXU+v
         SPAccDjSyyhIaepFVjaFRthe3X7BwA6bMpNdEyWejT53Cp8bL+ZetGoSzlZ4GX1uvVY+
         8mFUyXS/h8Kg3gVpt7AeukSwAMWwARtvFAon+2KRbAbc26c6H/AsVGko1vigJq02HXWN
         dq/Q==
X-Gm-Message-State: AOJu0YwY25LuKoWSjWGih6tB2sb1Gv0LVmghl9C3Nd4Y9sYjN4waspxY
        DuqTH1ZgUpDqpphQlx1jALxYzUiTNrzMGbJEclcrNaDgp+0C6gqQzypJgw==
X-Google-Smtp-Source: AGHT+IGkfmV72Gj0t2AS8rxVsc80LSPrTAejgs/aJ6gN9NwDx/X4tYxIqBmLgH8f+1YnAdORBQQUuMr5jCDF1T0Z9c8=
X-Received: by 2002:a05:6512:3b2c:b0:500:d970:6541 with SMTP id
 f44-20020a0565123b2c00b00500d9706541mr9044354lfv.39.1693841366642; Mon, 04
 Sep 2023 08:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPMMpoj7s=ewXJfJyxvrcHjpmOOWEWBvZ94OOuVmYs2UQ482HA@mail.gmail.com>
In-Reply-To: <CAPMMpoj7s=ewXJfJyxvrcHjpmOOWEWBvZ94OOuVmYs2UQ482HA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 4 Sep 2023 17:29:16 +0200
Message-ID: <CAPMMpohpKJdopSpZu+ehE0MZrH8cksgtY1NEHFyZz2jj+LOKhA@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 4:59=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
>
> It seems, to me, that "my setup" makes a lot more sense than what you
> end up with when you use "--separate-git-dir", and that the behavior
> there predates the current "mutual reference" model of
> worktrees-to-their-repo. If "my" use of "core.bare" in the example
> above is sound - then should the implementation of
> "--separate-git-dir" be changed to produce a bare repo with a
> "worktrees" folder, like you get if you clone bare and add a worktree
> in two separate steps?
>

And to confuse matters further, I just stumbled across
https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir
- I don't understand when you would want to use that vs, again, a bare
repo with one or more worktrees properly attached via two-way
references, their own indexes, their own reflogs, etc.

Is it the case that this contrib script predates the current "git
worktree" support?

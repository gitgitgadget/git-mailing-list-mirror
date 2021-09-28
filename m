Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF47C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBF56108E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhI1HcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhI1HcX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:32:23 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A34C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:30:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u32so9031946ybd.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxzlmXapgG3douiPueThqGDydNWUrS/R+gIuymfgKwY=;
        b=Gpb9I+WrgmUX0QAcOhp0gwgGSTBNYItMjLLkleOHexXkdlyN53I5jSBN+GbkmY+g2S
         J3EIcElcuAMY8wKTJsLScpasq15jELfdonh+0yW5ruKHPpzcSKF1zDPCvb5EECPIMBS0
         ++Fj67aNxnqs8rw40u6zM1I68hOQ1SpNkVA5w0r4Xfk+jvIkbkIm8Swng1HU9F8MhShc
         XQJo4aRTAeV/6OuAc2fdbeDFGzZmtObq1MWXWFydaRxm85BSN/uLPE+p8CEHz3RXv2sJ
         Xt1reGMtNTp2Jm8XyF1a+2v4zeVUStxNiNBAZH+kOpkWvcPKiauRsrV2uSgqXkRDW9fu
         pMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxzlmXapgG3douiPueThqGDydNWUrS/R+gIuymfgKwY=;
        b=rPTXqK6rict+YNUADYYUgHH64cLjss0NDn++4T8XPWr/h90lH0TKDnVmPlxoLW3try
         MVYjdapZAkuVsrUOfaFZVYdFXwsVj5Vc/OHzyKW6V21yY2zZc9qyimK4d8WyDPZnZGju
         bJXFpq/DaWfqQpDzcXi436e6OGw0tkWmiVP61fZeO3REw/MSrterZNCijJ50kxQSsKgl
         mt4Ylg+2il4E+joZWjTqSaE37Uo8DExwJHwNeQXtRS0ah+6XFnsslQWMZsWuBVV2ETez
         F3Y/mbqzafldUxiiCjTKWWTtKibLNXj/Df7oW/HYwQCl3wDrBS/uMFCkGxcCQn+BN5+B
         UrPQ==
X-Gm-Message-State: AOAM533/f4YNjCXzLGEALw2YQipzt3zTDRdINYMG5hlkQ+8eqsB9DiA4
        14m2LbGUCev4kh0bjC3RSIw4DkoXoaAc/5JZ1m0=
X-Google-Smtp-Source: ABdhPJyYWKSLSwarKxRCLL83jNlJtNsxKo+4WEDEkVN447bA5WHYfVNp2G3Vae3168GjSsXV9qR4bS+GdtQ2Cv/nY0c=
X-Received: by 2002:a25:324e:: with SMTP id y75mr5071994yby.269.1632814243887;
 Tue, 28 Sep 2021 00:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com> <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Sep 2021 09:30:32 +0200
Message-ID: <CAP8UFD3da8MPgN5FfqKOX+1noGXtX1g=oU8+PaHT_Bcxa=R0RA@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: absorb git dir instead of dying on deinit
To:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 8:53 PM Mugdha Pattnaik via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: mugdha <mugdhapattnaik@gmail.com>
>
> Currently, running 'git submodule deinit' on repos where the
> submodule's '.git' is a directory, aborts with a message that is not
> exactly user friendly. Let's change this to instead warn the user
> to rerun the command with '--force'.

It seems to me that this patch fell into the cracks. Or did I miss something?

> This internally calls 'absorb_git_dir_into_superproject()', which
> moves the git dir into the superproject and replaces it with
> a '.git' file. The rest of the deinit function can operate as it
> already does with new-style submodules.
>
> We also edit a test case such that it matches the new behaviour of
> deinit.
>
> Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>

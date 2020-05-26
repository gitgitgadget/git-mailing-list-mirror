Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1917CC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8122070A
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U96dhH1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgEZSxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 14:53:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C9DC03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 11:53:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so21457851wrx.10
        for <git@vger.kernel.org>; Tue, 26 May 2020 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+pIbj5Sk1VPwodnuxRUV57XWvB6rSJX/KejxamACMnQ=;
        b=U96dhH1WmiH6RD+xOa9rB+EJerUG/Gn0zscTxavMLuvdb7xvmQc2n9LDERhtJxg7yV
         yP3ShIJ7zZNq3mm/e2Vgk63MJZE+uF5d0qC/aBdleR2wVwdFs5NdPGH8rnqQ02+9cO/9
         F33ac1MGYZ1pB8GBRjJncv7imi1uZ90lB/M/yfkEIU4wkfjlVDav4TrGxzdhalrFgyVb
         aFxYdzavwUOXqy2RLr56l4v308C77H28E94AtozSkJ+EIJo9us+khYKG5mA+6ecuuJHR
         e+fKTIcIW5dS8AtdnBhx7Zlqypg9+4mxqWblyLCYKoPr9fk7BYDJInInmSD+CrYW4ABJ
         KiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+pIbj5Sk1VPwodnuxRUV57XWvB6rSJX/KejxamACMnQ=;
        b=rXfoHtJlKL/3FrmyaMs6dkWYAlsMeAQYGBK+RODxOAcnxUsB5pMR0p5pusAYJ8+fAZ
         /Rd37GVWwwSiD0h4pn10Re+jzCWWN13X1SRtpyTufD239+DRrSwKDbBhy7A+t38mr2yj
         jzbo7I6LxbpxTGJCZHn5wKlsmqigca3c6Bh2ND81JcHWN4j+zI9j5zXM5UdwX3yLfUbh
         yS3+DEhggjh6nVMtM+P1oPWLGoZr1w9GLMNSIYuFONsrgWLHICr285o/8RjBp70Fk6FN
         avnZi39M7eM5KeofITaSDBruk2brA3VmIQctjwRqBUKK11fW+PPntzGp/o7q77k1lc93
         w8UQ==
X-Gm-Message-State: AOAM533YV3kt/bOQw63v9FUuR5mLsqoqFBlGwlwGDxhOfnF3rmFmptt7
        8jQnKOM1mt2nQolPf2Dw74/VLalmNZWYG/b8O/ZST/L/5Fc=
X-Google-Smtp-Source: ABdhPJyV42KljtLlFLKO1ygN9HMVP+9vC97fOtQd8xukNjZI7Fg5NOYKFVyas6s9bwNB7bxSpbfFKsrvR24V37ek448=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr20881900wrv.310.1590519200009;
 Tue, 26 May 2020 11:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200525210232.87550-1-carenas@gmail.com>
In-Reply-To: <20200525210232.87550-1-carenas@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 26 May 2020 20:53:08 +0200
Message-ID: <CAFQ2z_NaCGypqPD6V1k0eXWQYnCm5WE_wz+6vJURd=Cc6nHA4w@mail.gmail.com>
Subject: Re: [PATCH] reftable: technical documentation link fixes
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 11:03 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> Showing as broken links in the html version (when using asciidoc 8.6.10)
> because some of the characters in the url need encoding.
>

Thanks, looks good to me.

What do I do now? Does Junio fold this in, or do I have to send an
updated patch series?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

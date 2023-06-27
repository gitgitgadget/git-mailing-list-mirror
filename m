Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80DEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 06:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjF0G4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjF0G4I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 02:56:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB491FF0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 23:56:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98502b12fd4so100694466b.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687848966; x=1690440966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUd5ypSCPK34CF8NBm5j7kt5aqe53DW3FrIOfkWfENo=;
        b=UKG8SIIgPn+BEC7TMBs9ekLyoEl23n2INKBMi/1bzooo0Z+H0TfYwcEnECAvxFEm0o
         nSk0kIoNildSR9gEjKoTnAB5HQyZb9gm9K54igv3Bf5dzJYPJGIfTBZ0+PxMSK2SMZif
         KiRj9KaCRN9RxIk6iPnXYQ6m4k/6r9kTKvxdXl2XXwfzLpXWanmsC/3e9QR0WllhGc4o
         4I0iDK9zps8VAj5st9rD5OdS3STQ1rq2GYuMiFRirUHKA3p5dud5cLTDslcCWat20gtO
         Ef8kj+cRq4VArveSJ3Vlm9RIl0KGiM4pZGdyYJmbJcjGEWnl7J8DTJatWuAFVIMu8lkw
         abQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687848966; x=1690440966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUd5ypSCPK34CF8NBm5j7kt5aqe53DW3FrIOfkWfENo=;
        b=NkeqUXuALOPjuNriDrCRTOBNCArDvpBWO9ggI1jYn2vXsDUCuhzjBCsbEix0trWuN4
         0RpFEbA7huPl4Q0SV3onDZ2/eB/XtMxLWAVpI76m1wgbdtKYjCJ43dUfT3rInOw1JLzC
         F5fltm8YHiNdJQVaC/9ptt3Ly9/604xYjJJoHa2ky2VohYGu2+Ta5yoqVBwKUvDjrDci
         x8N6n6ZUr3bVZDMnOb1540La1O7fLtkJsic6nvXPnF2/DYNN83zVBCLv2Gs7orAIFfUv
         UZaSEhCHEohKEKSKqeoL8oh4L85mnbJGs5GtlxDmShGWAiVdP9+JsfvX6LEiE+Jxj0Hf
         Q7iw==
X-Gm-Message-State: AC+VfDx9Z50Dy5DjJLRIWnsDXW5sYfBjvqIE+JVldM6Jh3FWOn95f+9q
        iB+gyNGBDxmsMkXTqLzEaW6DihZHzgW7Higd9Jv70Bfm
X-Google-Smtp-Source: ACHHUZ5sBG69/e/YCF9uQTiibUD9JQ5Sr+NYR7uO1SEpSM80+g5YV4M5NOaKqk6djAJLniTEdOCEWZL32k8cakSw+rg=
X-Received: by 2002:a05:6402:26c6:b0:516:39bf:1223 with SMTP id
 x6-20020a05640226c600b0051639bf1223mr987415edd.2.1687848965585; Mon, 26 Jun
 2023 23:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
 <20230624011234.GA95358@coredump.intra.peff.net> <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
 <xmqqo7l25ibw.fsf@gitster.g> <CAHGBnuMjCsMetCJfhfDXb7aYttgUOc0WY+wJ_Q-tmoV4WES-pQ@mail.gmail.com>
 <20230627065103.GA1226768@coredump.intra.peff.net>
In-Reply-To: <20230627065103.GA1226768@coredump.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Tue, 27 Jun 2023 08:55:54 +0200
Message-ID: <CAHGBnuMKDE6nngaoajGfpViXy78toU4WCV_QNGvy-jqXuEaAZA@mail.gmail.com>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 8:51=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> Re-reading your email, though, I wonder if you meant something a little
> simpler, like:

Indeed, I was only having the "git mv" case in mind and to advise() at
the time of that command being run, instead of advise()'ing at "git
commit" time.

--=20
Sebastian Schuberth

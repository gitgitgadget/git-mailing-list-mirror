Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2707E92FF9
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjJFJec (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJFJea (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 05:34:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FC95
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 02:34:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f139cd94so323373166b.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696584867; x=1697189667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+s68ETb78JPiIqwA2OHHjXzsODrphGrQnAuxKh/nQo=;
        b=C16f5uqCpZ/ihvZERcnObzpiMsPMJ9OLP4lyjKcVtdmEW5H4bhkBxUP+lv7k1h9bjU
         A9MpSxz2u+zpFSUC9TMMgATmvCZwts2V5PcxExA/DKB39l8EfqJ+JyUukppkj4kkQHH+
         Y8Av7ZrW+nyCfTqLnCz/44E8oS0F7THKpP0gDNsgrCrwmZERCRhoYAzgTaD2Ikl7/Uhv
         YKVCcXmFVy5iCXhIx7Q10sjVDstrjHY1GaX0heuai6hkx+HI+FuHx5e1U5u81tcFBP/5
         Zyw64zBKaIrM4ZaVHFPd9FwvcFly/1TR2K4Z8dx0xzTXSMxflt7UqJRtzXlsKA9mKC6M
         XExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584867; x=1697189667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+s68ETb78JPiIqwA2OHHjXzsODrphGrQnAuxKh/nQo=;
        b=L4v3+JVZc1ON4bg3jFpa2VbndpDGPjb+VSRGruONcNy59fnUsB3TWggFK9eNLiCwFE
         LEs7tBfcRAHpXsjlVSLEtCD8wlO5F5VJUgeTeH5YMmx1OvvvnM8sViVjlHprMvoHhpgb
         /eVPJrS9yPgGsqx2EkyRjvVCv6L/cgI78T0Z+W7o+S+3uh1NCSJGkUv5GwpdTPOPKprM
         kDY6zzA+g/Qav5uufS8kqhVRBZohbFwkD/UPZ78wpa6Dfo96hk12QVnsrbDAThFjWEOJ
         UplPT1tBeU8SxS8ORkkra6j8MfcCcbWDQjBUjjelK9YAD+ofZ9rFCoJIqFt61TxOBsQ0
         OtAw==
X-Gm-Message-State: AOJu0Yyb7Q7h+jroOGGwdR329TcJ1gwxdmLYduEwSwe+zzlcVQBpuOHw
        R2sYNaATWBZUj6uW8AYiN/i0A18o0fXO9bxAMc4=
X-Google-Smtp-Source: AGHT+IGyjzgR9Bagd9Cz+5JqCJos2FxbxOdWyeQpfKMl/QKRV2R2i8+9wh/6oCNnoRZHCFkRW5wCsrifXGoqLCPjD6E=
X-Received: by 2002:a17:907:7631:b0:9a2:256a:65cd with SMTP id
 jy17-20020a170907763100b009a2256a65cdmr5824484ejc.4.1696584866568; Fri, 06
 Oct 2023 02:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2wzmFKih0g2S3P8UHnn+wKog4sJFD6Z66iEpptGZ4w83g@mail.gmail.com>
In-Reply-To: <CACS=G2wzmFKih0g2S3P8UHnn+wKog4sJFD6Z66iEpptGZ4w83g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2023 11:34:14 +0200
Message-ID: <CAP8UFD3kdzMKYGGGByRoBUoy8Sh01-3HDGzxBmaj2YVuB9=h_g@mail.gmail.com>
Subject: Re: [OUTREACHY] Links to Microprojects
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2023 at 10:37=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> Yes I've checked the available links on Git internship on the
> Outreachy dashboard but I could only find a link for the 2021-2022
> winter round (https://git.github.io/Outreachy-23-Microprojects/) and
> the patches on the mailing list look more advanced and not beginner
> friendly too.

It looks like you are responding to a previous email, but your email
doesn't contain any "In-Reply-To:" header to link it to other previous
emails which is confusing.

In this reply to Junio's reply to your previous email:

https://lore.kernel.org/git/CAP8UFD1cd5YZqAxYbYUMNkAYJLLGjBpNe_NK5nVq3eLxxS=
DzEQ@mail.gmail.com/

I discuss why there is no specific page for this Outreachy round and
why we might not set up specific pages for Outreachy or GSoC rounds
anymore.

Anyway I think https://git.github.io/Outreachy-23-Microprojects/ still
contains good microproject ideas like:

  - Add more builtin patterns for userdiff
  - Avoid pipes in git related commands in test scripts
  - Modernize a test script

I am not sure if the other ideas are still relevant, but they could be.

> This link (https://github.com/gitgitgadget/git/issues?q=3Dis%3Aissue+is%3=
Aopen+label%3A%22good+first+issue%22)
> has "good-first-issues" from 2019-2022, considering the time when they
> were recorded, are we allowed to pick an issue from there?

Yes, you are allowed to pick ideas from anywhere, but for old issues
or ideas it's better to make sure that they are still relevant and not
too complex. It depends on the issue how you can make sure of that.
For a bug for example you can try to reproduce it to see if it's still
relevant. Searching the mailing list can often help as you can perhaps
find if others have already worked on it or similar issues.

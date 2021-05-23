Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BAC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 02:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1682461163
	for <git@archiver.kernel.org>; Sun, 23 May 2021 02:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhEWC3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhEWC3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 22:29:44 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE823C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 19:28:17 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so5547680oot.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=oWcShDCwmJi/L2oS2GPYFQZBFruWeN2za4hLC9BzP1g=;
        b=jKUHW01g59zNWuVz82xXipLvzfdX7El71uPV00TEBDm+1LPsgVXG8awD11K/rH4p8I
         Vdro0Oa4JT4FCFWvsfsUWHqvuGPHIFP9N/HVkj5yGVUlgQDRHAn8bsP+6A2sXlzpTBYx
         dkqV+1itH/vTGsxV8KxdpYaReEPMOUeXsWmH2RwtoY0uhGf7WRhI2+ocfg4l4Dq+epfa
         NeTdWovwByWW7ftLT3HRWKrewsC3aREJ8ipUR5Jsc90s5s+rVJPFvvFOCmUsLzA8CVId
         bYshlxM3/14zm743bpS9iTe1IG1ogrOaLAMgcTl4HNDQoAEgRvCAauWuZaAKxWWSZh8x
         vnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=oWcShDCwmJi/L2oS2GPYFQZBFruWeN2za4hLC9BzP1g=;
        b=QKYjNPZX7O9UyFDXracQFmpRIFA5lqYFsCrtpOIRa3VhAXEPbdehr7iSVXrKzSzZ/r
         JPqv2uvEm555oMypjk3Q+5hfGdIQPezMRljINCyYINhZujc8zvNbJ6uBW/DrouLZ1dN3
         e2PbRt6CTQQPCNRqS88vhx6W4ZlTMxnnzjJL7GYiB9UtcXyX5y3dxrAYRZde4uFyyNJF
         LBmGnU5cEXSs/oLpIA6K6wiSQQm0sjGf2Z2hcJq6lMUqMPrhHy2jwSHeOUUK8hfHcdPh
         EBm/SDe+afoBuMce6Qr4UOuLqZo+EQLEqb4O0x8bvR7LbxmwxyEeAGe+NyXOwkr7xsu9
         pWeg==
X-Gm-Message-State: AOAM532og4NP2lL++olx+6E0JaO1XJsiP1pqwgBf8oRI4GiBeMNd5kpk
        unu1pMFvWAbvpLOHbq9ZWvOiueTnjQ1gZQ==
X-Google-Smtp-Source: ABdhPJxMXaBWcYdK1F+FwPVyn64Osey/rS9TJwbNk0iR6Y508Se4K5h5sutIWN8UvitkntORnFEomQ==
X-Received: by 2002:a4a:cb15:: with SMTP id r21mr13498300ooq.38.1621736897120;
        Sat, 22 May 2021 19:28:17 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l186sm1980639oih.55.2021.05.22.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 19:28:16 -0700 (PDT)
Date:   Sat, 22 May 2021 21:28:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Aidan <aidgal2@gmail.com>, git@vger.kernel.org
Message-ID: <60a9bdbf37fb7_87b7e208f0@natae.notmuch>
In-Reply-To: <63cf407c-95bd-fdda-88ec-5eca36d24998@gmail.com>
References: <63cf407c-95bd-fdda-88ec-5eca36d24998@gmail.com>
Subject: RE: Formatting options are ignored when tracking functions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aidan wrote:
> Does not work tracking a function
> ---------------------------
> aidan@AidanLaptop:~/Repos/git$ git log -L:vadvise:advice.c --oneline
> b3b18d1621 advice: revamp advise API
> diff --git a/advice.c b/advice.c
> --- a/advice.c
> +++ b/advice.c
> @@ -99,19 +141,23 @@
> -static void vadvise(const char *advice, va_list params)
> +static void vadvise(const char *advice, int display_instructions,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *key, va_list params)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct strbuf buf =3D STRBU=
F_INIT;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *cp, *np;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strbuf_vaddf(&buf, advice, =
params);
> =

> ---------------------------
> =

> Is this a bug or am I invoking the command incorrectly?

According to the documentation -L implies --patch, so you need to do:

  git log -L:vadvise:advice.c --oneline --no-patch

I would not expect such behavior so to me that's a bug.

-- =

Felipe Contreras=

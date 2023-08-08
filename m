Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A65C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjHHTBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjHHTAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:00:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3F20D2D
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:28:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bcf2de59cso862727166b.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691515712; x=1692120512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8n2TBtMTJ0kMA2sERbKoC/qOx3hGZ1m+//mdFkLzXc=;
        b=aJ3hg9mo3gP1LcGaaTJg69dpC51A1q5TPo4zsSjcmnWl1geQmqtNRmG19QnKsZ672O
         D8ry1FlFahwkAzygilii4T4kBOKjyZ6LIn+i+tLIeqx2wujJkCGqVf8yFNz6pdSFsysB
         3jBz1AYvFKUyAP0mcVt7umlR24QtrljC7EzE4/thpagTcqiBYU9bLsGG1JR1fBZN1TUA
         /J8OA9PIkfHTHoi0VYdshPSI0WoQq6fVfOehH1wqmlSlEeDFX9UOH9P9d13ZUE07zMYw
         QN5JLk+zbyAFWbNFzougUK4uQu8p2BG7QG0ncMC5aJYUSLHGuiSO9+L77uVGrwSO86gk
         pvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515712; x=1692120512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8n2TBtMTJ0kMA2sERbKoC/qOx3hGZ1m+//mdFkLzXc=;
        b=cUGTYYtIWApZnF2bnUZfrnzgWtU+5qzSzGFUpmjKJfRRRQ3srMxJE05kWgobINwO0y
         PTN50lip6LEpms+QqDMvG0gOcfPeRD5d++WR58Aple8uV2C5gvsWLlDmFzLTfBp+CQVp
         HvoiDcBmKFM2VVa5TxJZ+1ZcM4R5zmh6fhh0NwvtTOdIndfRvAPSySKR8YbocPnPLgkU
         ZTH/YJAXy0qgCYaAYkTyR6o3CKotvGt2+rq3WqUIDcLGgjxUbmg+vLOGSTKbsLsiVwiR
         PC1p46Hti+uNWmB4KS6jMb0Jij1Iqf6wdWJ21vElXwtJNTD8XypCFd3GpMEPTWS90Pln
         y0Ug==
X-Gm-Message-State: AOJu0YwSMUuY5eH31OB3pZX9cq+sDRaJ36YTblfTk/pozEDdpShRvrbD
        bqX92WJxcOLNKZXRztPWthlnHdTpN6HxDFGYTt/mF9hy
X-Google-Smtp-Source: AGHT+IFNX1DeQRowOekFcFH5s7QKQT0FOFi4nwxyk+4ABAy5W0tuu6K1PSDKtFvj7Df3B8qQTlN2BHyLEh2AUl68OpQ=
X-Received: by 2002:a05:6402:1111:b0:522:201f:dee8 with SMTP id
 u17-20020a056402111100b00522201fdee8mr10158435edv.0.1691483354559; Tue, 08
 Aug 2023 01:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com> <20230724085909.3831831-5-christian.couder@gmail.com>
 <ZMBQ97ucRg9gO4gW@nand.local>
In-Reply-To: <ZMBQ97ucRg9gO4gW@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 8 Aug 2023 10:29:02 +0200
Message-ID: <CAP8UFD0gojKUhZv82d-CVt9nPL+0UWCr+nV7+5_UFykCDuM9WA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] repack: refactor finding pack prefix
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 12:47=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Mon, Jul 24, 2023 at 10:59:05AM +0200, Christian Couder wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 96af2d1caf..21e3b89f27 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_obje=
cts_args *args,
> >       return finish_pack_objects_cmd(&cmd, names, local);
> >  }
> >
> > +static const char *find_pack_prefix(void)
> > +{
> > +     const char *pack_prefix;
> > +     if (!skip_prefix(packtmp, packdir, &pack_prefix))
>
> I wonder if this might be a good opportunity to pass "packtmp" and
> "packdir" as arguments to the function. I know that these are globals,
> but it at least nudges us in the right direction away from adding more
> global variables.

I have changed this in the version 4 I just sent. Now "packtmp" and
"packdir" are passed as arguments to the function as you suggest.
Thanks.

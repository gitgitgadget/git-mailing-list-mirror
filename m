Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D24CE79A8
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjITAUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITAUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 20:20:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E49D
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 17:20:34 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c0d329a8bso44294337b3.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695169233; x=1695774033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylXYo+qMAwl7U49hWhN3p3QM6ccQc8H0eMZqGafXy0Y=;
        b=iKvXEgUya6Xfb4kZI9vK5SaG3JYbdD+7vHwmmZj1TW0ADC4H/9tuLdZY3kvLkkl5Ys
         EbCMR381+udB7Rs3ywkrUyfT+y8h19FPSiNMfgInV6GvEkkm2E8i9Z7qjQO81xx4uwSD
         +fYuKnsg5VseihDntZSulskIirN66CFNE0zgAN+jlO2v/UtR7M19HXUwPyXmNkTIlzL2
         gTg5Moi37ggb6vlAxiCQ1Z7af7L1LQ7hSNim3w1v6GM8GPeWKoXilBiObW6qx65+Uan/
         WRaFM8H6QPSGq8ffyiDzUY+vnU7dfcAPbuxbh2Wtt8N5Sd729/GRJWdQ64EjFJFLdmtS
         LwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169233; x=1695774033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylXYo+qMAwl7U49hWhN3p3QM6ccQc8H0eMZqGafXy0Y=;
        b=eTzl7mCGP2mSUXnDrCYHIyHzyejcxg0Yj+H648SpZd2V3pLwzcQXnvr1AzeCN3Kn+4
         ma2Lgcj1xa06dvXqTOHm9BkDmG0eLxmlJTXe43O1/jMblvrmM3p7sRFalB32ECrb3xiq
         3qY4vXjHUzqEb5yRipQ7WA39X6yh2xkk6ouAvgeeesn8eAojpdFerJMEzvLFYxGTKCOf
         fUEWnj7Hf/wUBElOc7lI5UtUDYpF/98dsiWv2Sh5rbndtLchsSBsnejD66cMWlTsD89B
         5z5UE0ju3hM5Ag2P/dAwVnfuEoIE+0JA3NqcLlUdVRprMHBx7eCdO4Px/3Ixag0L+sd9
         ubhw==
X-Gm-Message-State: AOJu0YzycdHSUXuBmh+IvKD6Oa01IWMJ4j5uvyPK3r3RcwL7Gcv3Qwsw
        9j0iRQoJY9GY5UW4D+NqTR7OU1MIZp546EqYL1Y=
X-Google-Smtp-Source: AGHT+IH05R8OcRbYGgXMIK2vGuQILoqtIzMfqRyDvscjSKP3hDhw8SMZgEW9ntdOMpWdbVoIKvhbPlJQIHVyCbdepvo=
X-Received: by 2002:a0d:c385:0:b0:59b:cff1:a8eb with SMTP id
 f127-20020a0dc385000000b0059bcff1a8ebmr1113910ywd.34.1695169233312; Tue, 19
 Sep 2023 17:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230919064156.13892-1-worldhello.net@gmail.com> <xmqqy1h2f5dv.fsf@gitster.g>
In-Reply-To: <xmqqy1h2f5dv.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 20 Sep 2023 08:20:20 +0800
Message-ID: <CANYiYbFKaiHS5PQSjB9V6dWLCP=wiJJRNLK=v=x1_mTLXBft=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: no connection restriction in connect_helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2023 at 1:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > For protocol-v2, "stateless-connection" can be used to establish a
> > stateless connection between the client and the server, but trying to
> > establish http connection by calling "transport->vtable->connect" will
> > fail. This restriction was first introduced in commit b236752a87
> > (Support remote archive from all smart transports, 2009-12-09) by
> > adding a limitation in the "connect_helper()" function.
>
> The above description may not be technically wrong per-se, but I
> found it confusing.  The ".connect method must be defined" you are
> removing was added back when there was no "stateless" variant of the
> connection initiation.  Many codepaths added by that patch did "if
> .connect is there, call it, but otherwise die()" and I think the
> code you were removing was added as a safety valve, not a limitation
> or restriction.  Later, process_connect_service() learned to handle
> the .stateless_connect bit as a fallback for transports without
> .connect method defined, and the commit added that feature, edc9caf7
> (transport-helper: introduce stateless-connect, 2018-03-15), forgot
> that the caller did not allow this fallback.
>
>         When b236752a (Support remote archive from all smart
>         transports, 2009-12-09) added "remote archive" support for
>         "smart transports", it was for transport that supports the
>         .connect method.  connect_helper() function protected itself
>         from getting called for a transport without the method
>         before calling process_connect_service(), which did not work
>         wuth such a transport.
>
>         Later, edc9caf7 (transport-helper: introduce
>         stateless-connect, 2018-03-15) added a way for a transport
>         without the .connect method to establish a "stateless"
>         connection in protocol-v2, process_connect_service() was
>         taught to handle the "stateless" connection, making the old
>         safety valve in its caller that insisted that .connect
>         method must be defined too strict, and forgot to loosen it.
>
> or something along that line would have been easire to follow, at
> least to me.
>

These explanations are very clear and helpful, thank you.

--
Jiang Xin

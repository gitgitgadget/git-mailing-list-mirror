Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2CC433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356773AbiDSUdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 16:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiDSUdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 16:33:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5283C486
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:30:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y20so15117020eju.7
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FymqwZtDp4VgQCN5db+FzQtifUigNV++RZ9hjoeMXgA=;
        b=J+QI2xXqdtoT2id/VjtlavMlWyV+k4EbcX2Tlh9zqkCwLBUvy7DYOT9e38iMfis+mY
         VuGMxB3Fh7Kfh/aoCYdaOoaFdzemUMY9P88sOhqRRlfE0CUUKcdnuSsOGOGY5Rmy0M44
         rvFWBFhW2N/T4OwAtKsw77FwqAX2/Cbyu4na4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FymqwZtDp4VgQCN5db+FzQtifUigNV++RZ9hjoeMXgA=;
        b=n5kkDpsvIZiSHVc8oBCXXONI6B/K8znjNAnP1IwiMeI62Zgm9ECtwWg1I3cIC0FYHq
         hoauUxfvsHXZLY02A6ZynTdsWq/QtcPNlC2WOT98NPecTAVohNyYHuqjYb7J8oCaLBk4
         LowQjJfNDIM1y1X4/ZGHNAnldWlJ2stBVT7M/9FqEbtYKbHKqwEqwpSe3V+cBDEjVEB9
         pWGqB5fpWL52nsDVEMDPOKp5Hm1WVgb1ChTHV6oDmDIf/OxikEP0CqV65N0ETG4TSy1K
         tc3oIHyIvCTSNdaY2KF9ScP+DbMMVQryv+/pxtjjtWgQXl8x7KhclxF4TYGwIrbJuxmT
         a9Bg==
X-Gm-Message-State: AOAM532dc+BON/OSktcrnoTpQ1iEQ2FJQ/moQJ+apb60AXqppjmgC2/I
        FJr+41O+zd0cKrSZQ4fPDXZI4hr97LfSyXW4TSjg4g==
X-Google-Smtp-Source: ABdhPJweBmV4jZdKmK8Uuzgx3BrXU4hmds0hZlMZy7A16o0Sat+fmrKweMnCkk1+CBnqJHnHZgesiSeYdp4wx6gSUEk=
X-Received: by 2002:a17:906:4d1a:b0:6e8:8860:8a72 with SMTP id
 r26-20020a1709064d1a00b006e888608a72mr15712275eju.540.1650400221958; Tue, 19
 Apr 2022 13:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com> <20220413214109.48097ac1@ado-tr.dyn.home.arpa>
 <CAPMMpoiXNKNnARhJ2n+nzOj==-27YA68OvMmUyYnSaoLbfE4xw@mail.gmail.com> <80e83d8e-1f68-16be-6d68-fbc4aadfc78d@adoakley.name>
In-Reply-To: <80e83d8e-1f68-16be-6d68-fbc4aadfc78d@adoakley.name>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 19 Apr 2022 22:30:10 +0200
Message-ID: <CAPMMpojwo0BG45BNN6urAgd-yt1BPXKPmH6q8zza+v9BDaXKng@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2022 at 8:17 PM Andrew Oakley <andrew@adoakley.name> wrote:
>
>
> The way I look at it is that you both read and write bytes, and you may
> attempt to decode and re-encode text on the way.  Both the decoding and
> the encoding are done in metadata_stream_to_writable_bytes, so nothing
> else needs to know about the raw option being different.
>

Right - personally I just believe making the distinction explicit as
"strategies" makes for a less magical explanation than a special
encoding value that's not just a different encoding but also a
different behavior.

In other aspects, the behavior you're proposing (except for the final
fallback-decoding-failure) seems to be equivalent to what I've
implemented in the latest version.

>
> > I understand and share the data loss concern.
> >
> > As I just answered =C3=86var, I *think* I'd like to address the data lo=
ss
> > concern by escaping all x80+ bytes if something cannot be interpreted
> > even using the fallback encoding. In a commit message there could also
> > be a suffix explaining what happened, although I suspect that's
> > pointless complexity. The advantage of this approach is that it makes
> > it *possible* to reconstruct the original bytestream precisely, but
> > without creating badly-encoded git commit messages that need to be
> > skirted around.
>
> I think this gets pretty messy though.  In my opinion it's not any nicer
> than putting the raw bytes in the commit message.
>
> Git does not make any attempt enforce the commit metadata encoding, so I
> think that tools really should make an attempt to handle invalid data in
> a somewhat sensible fashion.
>
> I don't think there is really a "right" answer, anything reasonable
> would be better than what we've got now.

Alright - I went ahead with the "escape if you can't do it right"
behavior anyway, because it makes me feel better about being able to
say "no information loss" :)

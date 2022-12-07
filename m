Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGBQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGBQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:16:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9759A4C25C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:16:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so31227pjr.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXpN1EogzXrRFDEMsgjx2LayZor8lntGfmfW7odbrXI=;
        b=SwXApuu1HrXhfdxBKy1FlyA6RN7kTnguTitN7+V08qb7+YmXTExKWRH5LrQoTW31Dt
         vwD7NWtT7/D4QD54zeFDEWcPt/I9g11I6GJ/p9xx3eo7mrCClgtxT/oANNrt9Vnl0Bj8
         3YfHtDkwNstaMWd2W7+05hdi80RaLRdkK8LLkXmOLS1xsstG7FzxWLYEk2sSj+tqa05f
         s8cY+PeNu6JopqyKoMD1dQXTljST0Aio2tLDL5RGfmbZ573FSj+PZE0BsQTAUCJyK2VT
         tRR1Hu6SIkhXlQ9xx91XNqZyBkiywaqoi6+BzUcMASY4C2GADEGMUdPQdRdRuvudnWec
         fBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bXpN1EogzXrRFDEMsgjx2LayZor8lntGfmfW7odbrXI=;
        b=hTDAtR1WZVDeCimB1C/1Vd3W/C6kcemqEGI5ESphvbHzH2uJ6xf0P6+kZGKLFm0Qcx
         Tkcez8osR7w+50fE8carHFOSNyag/IC6RUsghndhshNOw/oeGF7wypoQ8QfPsQCt1//U
         iYRVbZCtQDe0ooMH9t8+T5KH1xjTdzVHFff3kIxDv4OJWhX0ILqPxvQMgsAlsKfxJz7A
         PsgsKnva1wdjOPXIIn/kOPRtY02pag8gHwlunb5QE0F+G4iYLAmxZAfXGMDjKWadhCt2
         mVECSqmuPGCPBgEM6nmzldsTOHtTMD/EV5Zrz3C6dgHj5+synCq+s9EvG0F7KKH3sdQc
         ZqMQ==
X-Gm-Message-State: ANoB5pkW1o2PDvSCACakz6bkj44NeKXt24Wn2in1sInQ1RUEJxPMUGqo
        sdtKVBC/cSG0GH+fX/Oj/P8=
X-Google-Smtp-Source: AA0mqf5jz6iyuCHStVIGbztn7RjuidvuZAZirJvZLqUhvCOMi8CY36+yLjXSxzj1ABtyVevJuyW7cA==
X-Received: by 2002:a17:90a:5991:b0:218:47f1:b47b with SMTP id l17-20020a17090a599100b0021847f1b47bmr95944240pji.201.1670375763984;
        Tue, 06 Dec 2022 17:16:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902f21100b00189393ab02csm13161410plc.99.2022.12.06.17.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:16:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670373420.git.jonathantanmy@google.com>
        <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
Date:   Wed, 07 Dec 2022 10:16:03 +0900
In-Reply-To: <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 6 Dec 2022 16:40:52 -0800")
Message-ID: <xmqqtu286mjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Instead of relying on errno being preserved across function calls, teach
> do_oid_object_info_extended() to itself report object corruption when
> it first detects it. There are 3 types of corruption being detected:
>  - when a replacement object is missing
>  - when a loose object is corrupt
>  - when a packed object is corrupt and the object cannot be read
>    in another way
>
> Note that in the RHS of this patch's diff, a check for ENOENT that was
> introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
> be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
> check is to avoid a false report of corruption if the errno contains
> something like EMFILE (or anything that is not ENOENT), in which case
> a more generic report is presented. Because, as of this patch, we no
> longer rely on such a heuristic to determine corruption, but surface
> the error message at the point when we read something that we did not
> expect, this check is no longer necessary.
>
> Besides being more resilient, this also prepares for a future patch in
> which an indirect caller of do_oid_object_info_extended() will need
> such functionality.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-file.c  | 63 ++++++++++++++++++++++++++------------------------
>  object-store.h |  3 +++
>  2 files changed, 36 insertions(+), 30 deletions(-)

The implementation looks very straight-forward.  Nicely done.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964FC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DED6613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFJLsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 07:48:06 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E0C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:46:10 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l25so1673637vsb.9
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TjTlc0LXdZmi8QRQK52GEdVWS4GPjpxC2+PTw6JKorw=;
        b=sDEh79Mvj97GxV6TufgUSdz7LLzBhCz3zOlktTz0IcubCXQsicMd7OvbYb5qBBPEpm
         mqWciQO7R1uXHqvfR1H5XGQ+NXMwcso0VGhriBU6Ds7Q/TPqoDbiQESkfAMXRrGW61ju
         woP2YeX129dOjeS5r+gvU/JPI950DfEru3aFPxIPX4z7u/rAzTmpeUp9PrBAMcrV1cSt
         uaGXCO70v2okXm96niTmLyvEearx47K2bowpRTfuRDDfNatxfUXkZJn31lb2PK3xBdpB
         uPo8KZu3P4CNLFQzx+9fgtPF119VvIv++xcRZO/HNbYpLg2IoHTo69/sNX9QGw5pT8UM
         8WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TjTlc0LXdZmi8QRQK52GEdVWS4GPjpxC2+PTw6JKorw=;
        b=mfn2q2ugYY9XhGVQ2p+fiNqAmg6hSN8AJPvgr/TJX+t9vuG9DpmUksICxo5Dx0xe/h
         BnbDEAbnOb5DBMc5c8A6ecSAfnmwhjCDWYUWBvf+uNBONdhlbBMMKpSb74BhX2Q5iGSL
         WqvxSTJdI79rfWWGtqLiYJamJPaMxY6Sthhxhc7lF8Z6l+CXtiNfNPjBkkf93Wjj+rKp
         DW1Xv0n/ceClz9uc5UUDXyAf0qZczE5Y5to5BZmlLBoiZJRm/2lK2GYq1yya6b9u4jza
         Z2tPBR7d1f7P/KeHATIPobznvePoeakaP/UibbNeIZWYfq8xxKaeqkM+OUlxhNPpew65
         hmTQ==
X-Gm-Message-State: AOAM533zuWBJsO64UQsvAaZluTFWhuhYcAZ1EYdfk555yvG7MmSZP7un
        D4DEUbb79JVkqxAXwtSeuvFCIMh1Jalsl5uzZWV3HQ==
X-Google-Smtp-Source: ABdhPJxrVTRiIz7uTrctSK9zYK2yJQCRz/CKEBDE0IwGn4+ELu55wxOoPFdKaVA/JpnqCvtWWNB8NcrAlABImdmcBDs=
X-Received: by 2002:a67:ec99:: with SMTP id h25mr4228441vsp.5.1623325569827;
 Thu, 10 Jun 2021 04:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <1bb350ea5d21eacf95426192c89173b502b7e06a.1619710329.git.gitgitgadget@gmail.com>
 <20210603025340.349224-1-jonathantanmy@google.com>
In-Reply-To: <20210603025340.349224-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Jun 2021 13:45:58 +0200
Message-ID: <CAFQ2z_PL3Envot1oAg7-vwWyx6taJfD4W_1PEByfDFT8kXgOUA@mail.gmail.com>
Subject: Re: [PATCH 6/8] refs: clear errno return in refs_resolve_ref_unsafe()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:53 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
>
> > @@ -1685,10 +1685,11 @@ int refs_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
> >  }
> >
> >  /* This function needs to return a meaningful errno on failure */
> > -const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> > -                                 const char *refname,
> > -                                 int resolve_flags,
> > -                                 struct object_id *oid, int *flags)
> > +static const char *refs_resolve_ref_unsafe_errno(struct ref_store *ref=
s,
> > +                                              const char *refname,
> > +                                              int resolve_flags,
> > +                                              struct object_id *oid,
> > +                                              int *flags)
>
> So a third function (refs_resolve_ref_unsafe_errno() - not to be
> confused with refs_resolve_ref_unsafe_with_errno(), which has an extra
> "with")? Couldn't we just swap the other 2 functions directly instead of
> going through this intermediary?

I've clarified the name. I've done it this way, because it keeps the
diff small. Swapping the functions would require code changes that I
thought would be more work to review.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

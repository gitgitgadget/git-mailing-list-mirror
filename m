Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568AC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA0560EBD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGWPbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhGWPbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:31:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC29C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:11:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a19so2339050oiw.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xt21kbhoepM/xfv4BwwQt5UXUFnyV7gKBtxLRgdTE/U=;
        b=FuPM+pQrdeKbK9KbOE2Qe7X/pvwuvbEib1azHkPMKOIhNI6eYJ8/QJ/KI6OO2T2+Jk
         ChVndXdAEDEoT0vJPWRIK8Rg3mo7UdCwL1GLaYWhJcnqGhiePCyHO17uKf3a4p0jHJCe
         gQQ+ntRTSsn8DpDZzpKo00yppr8q9xEzENyyeKryOzCy2hTJhNdofD4VJhbnOcPNuv0O
         tE+NUkGvpklE4JZwKpnxNdrcHWTvpGedqGbVFfaf/mWU+Te5qHNkUJmeK8Uu4Tth7vBD
         KzaqmSHW0CL6vubsLHR07OpSnGo4ZLyb+XwRw3XjF7z421s2J34LSUEuCaZ3MD7lGc17
         5nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xt21kbhoepM/xfv4BwwQt5UXUFnyV7gKBtxLRgdTE/U=;
        b=aVnE6yq5unQk1QvVaA88ZEoWDKn11OH8KlNRAxuSs/opeSQpqsVO2B4dfAtnvN3N04
         eKSYZXAECJktmo4BTyuXQEI350qRMOm2Mho0/MmLmG7A8Rc+VjJhLo8tA1DBm3AthbKA
         boGnD1Mw3mZbb9zJanfCgGU9c+kU3c+pskDwny7AH8UHrNAkTblmjTkFDKhforuva4lB
         jnxvsLx90KNJOIWA8Zej84y9W0+wI5pdVlnWXfdDa60diIqqUBrUc4kv/0mt2FCeN4Z8
         EhRhENF1p/r7Sf7f2VFAO7doQGMXmKELLOeY9W894YpXLmcauQEXmDASAY3m3WqnQ+e0
         ef5w==
X-Gm-Message-State: AOAM531JuGf6e877Y0WxPZon8nlncjEihQbyWl3QDtAiyooaFM6jFVuE
        ReuaZY7ZCi6ir+80mW9AqBk=
X-Google-Smtp-Source: ABdhPJwxy7vl0OZ6mCaRKkizbftDYJYLcLCBnyxUdP5FvXAhXgxWM85HLlf1kT6YqS1bZBN+Gcuwow==
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr3552024ois.7.1627056694579;
        Fri, 23 Jul 2021 09:11:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c11sm5423710oot.25.2021.07.23.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:11:33 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:11:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60faea3498189_defb208e7@natae.notmuch>
In-Reply-To: <4b20a7ad-5e1e-802f-021b-a4580e5138fe@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
 <60f330c09ee05_25f220867@natae.notmuch>
 <1329d238-e38a-7c8b-d468-500a0ae38bbb@gmail.com>
 <60f39a72c9c8e_2fb208b3@natae.notmuch>
 <4b20a7ad-5e1e-802f-021b-a4580e5138fe@gmail.com>
Subject: Re: Regression in 'git pull --rebase --autostash' since v2.32.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:
> Le 2021-07-17 =C3=A0 23:05, Felipe Contreras a =C3=A9crit=C2=A0:
> > Philippe Blain wrote:
> >> Le 2021-07-17 =C3=A0 15:34, Felipe Contreras a =C3=A9crit=C2=A0:
> > =

> >> The fix I suggested in [1] seems to fix both cases, but as I wrote t=
here
> >> it still leaves two code paths that might trigger the bug. I'm not f=
amiliar
> >> at all with the code for these two code paths, so I'm not ready to s=
end
> >> a formal patch; I thought I'd send the diff anyway if you or Denton =
(or anyone
> >> else) wants to start from there.
> > =

> > Unfortunately I'm not familiar with the `git merge` code either, I've=

> > only been modifying the `git pull` code, so I would also be starting
> > from scratch if I tried to fix that myself.
> > =

> > But I think that's where it should be fixed.
> =

> I've just sent a patch series that fixes it:
> =

> https://lore.kernel.org/git/pull.1002.git.1627042470.gitgitgadget@gmail=
.com/T/#t

Thank you. I've reviewed the series and looks fine to me.

-- =

Felipe Contreras=

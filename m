Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BEAC54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 03:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C88A20724
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 03:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imLergh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYDiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:38:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44314 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDiP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 23:38:15 -0400
Received: by mail-ot1-f49.google.com with SMTP id a49so691657otc.11
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 20:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1CTsEQL4jaQtht8G4i5Blw4fNRScUUioS84PPMbgKgg=;
        b=imLergh/MnaCYmzFp8ZteK0KNzIsAUiH3qOhIce60QFZfeL95xpgnv9Fl4WRUBic1d
         iWcq9b/ax7di3yvn1v+FwSAnAT7bO0c6F1nXBck1gexnAs6U84/v30YoMijTPFCJhSjU
         /hDuCZE5ktNQ3qMjAnbag5hyIgbmuOVCGXwp4Dpr783onFM7tYJIlNuNBLwGaZLeDWdH
         2B5nLDIzqmKPxfPZZDGtsiYJ7WONy3aKTZ0vKOvRfiuTsWbHVvAVKzmKIknTNbrMId5Q
         NxT1GRkeSoYxaFwxB7664cAarvt2aF9Swb1bIynri5NnFilm4w3S5CYdI5sALpP7AL35
         aAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1CTsEQL4jaQtht8G4i5Blw4fNRScUUioS84PPMbgKgg=;
        b=pXxuPrXbskrkrA0QaQ8Zv89LcqyqE+345P3BLuZ57vgXPbDbY4G/lLhtTarvb8/MoV
         aHR+SIx4rK7bKwT8eXQLByXWzdaQDCTz8w+Xl3DQkzyAqt0RcrZ0N5VpLBKdbaKWiHHD
         /HSxpncaQ56fKCQuUQbMX0aib/W1Us8QDZTn5mA1aSYjdQIJYCFc60p/8zMeRts1Qdaf
         8ogAfBPVLNv3W1y77nGhfOcSGP7nPMWQC/Erjq/R08z3VTKRTUDqCpsjehyXN5GUhHCm
         QR0ae8mOlulAt2m7/lGE1II+9KdmyYQzCxVIcTAH4CWatB+muwvvjMFHwCsREV+gCtGW
         yLfA==
X-Gm-Message-State: ANhLgQ0ibpmVWwUAO1eESmNHWTclQQQGgtGtFHr/4DmCzjK4B4V7rpHw
        wqpH6xSQWKWDk8kINoI2Juou+BBUQ7GKxdmpPw2zHL9S
X-Google-Smtp-Source: ADFU+vtfHXXyNUa2Kk0oNDtSwSILxJdDS6A5howK1YSS8D+Q/2SawTwyQy4pDfUiuIOLJtxzRXfAE96Nycb0LLpJJpU=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1009219otk.250.1585107494986;
 Tue, 24 Mar 2020 20:38:14 -0700 (PDT)
MIME-Version: 1.0
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Tue, 24 Mar 2020 20:38:04 -0700
Message-ID: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
Subject: "git rebase" behavior change in 2.26.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I track an upstream repo with "pull.rebase = true" where I do a `git
pull` followed by a `git log -p ORIG_HEAD..` for a branch to see
changes since the last "pull".  I normally do not commit to this
branch and thus this normally is a "fast-forward" merge.

Starting with 2.26 this no longer works because ORIG_HEAD is always
set to HEAD after my `git pull`.

I track other prances from the same repo where I do local changes and
then want the `git pull --rebase` and I thus do not want to
give up on the `pull.rebase = true` configuration.

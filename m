Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F51C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF9B2073C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/GJVGkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMOlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:41:08 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:41197 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMOlH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 09:41:07 -0500
Received: by mail-vs1-f42.google.com with SMTP id k188so3703691vsc.8
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IEztEJfotaSZd0cd0WkjedwmaipsJtresi8/ywSD3xA=;
        b=i/GJVGkA+IspRu5YUsSSKd5AY0J0SxxlfKMIbCRIWH6Uqgb1SUlrteaf+GaWAeFmNC
         gHKhCTqX9SuiM3Z0Sg56GgZ8wHF4NOBEWd4seIBxKYCiix4suvxSHw7yo3yOMyU81CLQ
         nP5kXemT7Ragqua5OdNfqu9qjFwnNJWrmZi61IUpFnYtZlGJ2F12S0KDT9xp6b7eDkQW
         9aupm0SMvFsctg4OYLJJIhgi4oLBOkz2uajhnr/MQmJAade7wsRta2GWru53GwmH/qqH
         p9neCsnPoRt50L/sP6JyqKPcxtSab2TYbVFdWb/WWp2bSfZcZ0pv9qj8Bst0PG4dWAg2
         43SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IEztEJfotaSZd0cd0WkjedwmaipsJtresi8/ywSD3xA=;
        b=WN3dOSCcThTwP09fv4EcOzakzawC/eKIiy8C8itdZdSlHB0zWlm2sFUn4eBPfl288t
         I7HxPvSmcqHZrGtPFkzSv6EXL5yhEaEL+64MaLei2p7VcjU5ANSGNfW+W3Kf17etSevA
         m+N/yWc4shwgbk/tXav14r57/V6Oif6lIOu9Ps8Epfl6rI6zsCVr5INRXPq/Ehn2F/02
         445mSw7sSe+lQZ5edX49blB/oboA4oO2kB4sR/1jdtntia7vh7AnDxrkMUNUL4YgjuHM
         pne671nLuUTPPp3P5McaKYg4n1p24hVuHdtvL+C0FV9tJYyvdVAd5iyL97fN06sSkcNr
         zegQ==
X-Gm-Message-State: APjAAAW7IFj+oxHVoTNTzDIAfFLzTAbNbMpo9sdugoomd50d+iYyUkVU
        Mh+DmPYcawtUjoxsSWYX/ZxerImichMd3l//i2GsS2Od
X-Google-Smtp-Source: APXvYqyuduwzvzjTF4iw2UGl9KWTEXFxfUVVSagTrzoNZ98679xbNmjGqAt+B6PmwelxAJK2u7F0hkpLMeIfr7bxIhQ=
X-Received: by 2002:a67:15c7:: with SMTP id 190mr2182968vsv.178.1581604866341;
 Thu, 13 Feb 2020 06:41:06 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Martin_Vejn=C3=A1r?= <vejnar.martin@gmail.com>
Date:   Thu, 13 Feb 2020 15:40:55 +0100
Message-ID: <CAJFfRmt65DV5bZa5yTvg9sDb8SS8dFFyX7Zm23T7mAHL58v1Lw@mail.gmail.com>
Subject: Calculating major.minor.patch from commit hash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like my releases to have major.minor.patch version number. While
increments of major.minor are something one has to do manually, I
don't want to do that for patch.

So I was thinking of having a VERSION file in the repo containing
major.minor and then calculate patch at the given commit C
automatically as the length of the longest path starting at C in the
subgraph containing only commits in which VERSION is the same as C's.

I can do that pretty easily right now by

* identifying commits in which VERSION changes with `git log --
VERSION` and then
* walking the graph in topo order with `git log --format=format:"%H %P"`.

The latter step can terminate early, so it doesn't have to walk the
entire repo, but the latter walks everything and can be quite slow.

Is there a more efficient way to do this?

If not, would there be an interest in a new builtin (git-depth?) that
would calculate the value?
-- 
Martin

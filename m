Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF48C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA42C20774
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/CQGU48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGILB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGILB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:01:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FBC061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:01:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o18so1802962eje.7
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Kdnr6qPGczx7JXUfuO6hAtAGBB9JF+PfJGSTefdwY1M=;
        b=Y/CQGU4850NZDCFB9bT/jeLn5tcrbVgkuRcTxDVGM5INIMcfBSf5KSwKjn6qdPlK4d
         SHYkFO6/eC56pQcYRo7I4NGhSR0mzhmRUHYPqrjSJGEIxcSdBKfWgglzb+AZElIn3WhG
         Rf5r+h+vkGpKzOPqtMQW0L91dXWj5hC5pgqJBul9O6Q/9nM8PzHoxh50ZJkKSzE7w25U
         mm1iJ7Crc/90Dux8M1cVSeXZTB30TNXIBlOKdAtIVsHuhdNhAERXesbLuqSGr3hwck0F
         FCOvlP3aNaG2V42iJujT27Y49TGCtgW3+nYfU0VuQ40i9esccJYjlBngxTOrQFik+9tn
         oQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Kdnr6qPGczx7JXUfuO6hAtAGBB9JF+PfJGSTefdwY1M=;
        b=s6BKttQauLsZiCG38ps+ufdHcFPMu50oKFQelLjeFQYuGJtOyEMW/smrXG09i29aXx
         4RQG+vhG9QXW+x+jWksD0/j+oi5+EUNfHTguFvRHchkQF/Lre7t51fD2WUGsTxaSIniI
         CdtEwlMmnnSPn2QI0CKDAZuW73QbYEb8sr5x4+EenIVSJZiSQGOIaPweqMVshFItF0in
         zdmbouvOrdNjG6UoRNYhuI/r8lDplcML5yQe5DlKm1bvRT00qkWLjtzazEmyExyew9Qw
         nuZ0FL+UdPdzPbemgKzgfE1xWcpzSHEdMln0ohMqq+JrrAj0A5o9DOjxuz5sBSUsJByB
         K7Cw==
X-Gm-Message-State: AOAM531FHBsQCEG4967lq3RTcOiO7tuWqVHuW03Va/Mf5ViQywYKig2a
        jKf6lsTwe0GwXmOAvhuo2PzKuvp/tFWDaXUGcZ77Fi+L
X-Google-Smtp-Source: ABdhPJwQDNYksTzuQ2EHgh8FyuHw0wdopCwyrTG018Dl0KqmLZwP7rZ3rMKnsw8nXuMvPJXjkb1uZ11ITbOyti8XIf8=
X-Received: by 2002:a17:906:90c1:: with SMTP id v1mr55074978ejw.481.1594292485702;
 Thu, 09 Jul 2020 04:01:25 -0700 (PDT)
MIME-Version: 1.0
From:   Antti Tanskanen <antanskan@gmail.com>
Date:   Thu, 9 Jul 2020 14:01:04 +0300
Message-ID: <CADGzKpxJ7_5htGVgHfvU-caPTm2tLxmCvuc-RoYkxaS=cPY1FA@mail.gmail.com>
Subject: Possible bug: Changing branch with file locked
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I want to inform you about the fact when I changed a branch with VS
Code open and git did not have permissions to address some files in
the other branch (or in current branch). I got an error message. That
is OK, but my current branch got also polluted with files (from the
other branch?). I needed to run =E2=80=9Cgit stash -u=E2=80=9D to get rid o=
f those.

I guess this can be reproduced if one locks a file which is in a
branch and changes the branch. Better functionality would be that git
would only show the error message, not to pollute the branch with
files.

Yours,
Antti Tanskanen

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EDEECAAD1
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiH0VsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0Vr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 17:47:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3D42AD3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 14:47:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 2so5975478edx.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3E8DomDlBx69QMvTIwJVdNBH3vlU8hQ5m8OWcZscKy8=;
        b=fFvsBwT5zrO6kjLi5xN2IIcEghJaIfvad60n8T6EWBHudtwoqlZAvFHXrSb2PQEh0d
         UHRuy6SEWDa817f9olKDdA93h5vsp00h5l9KR0wX2i7qj313lDshBRAg85SJIymexnSb
         j9PwlmD1wr4HP00QsErQt4QO/Kc2o+FvWIKfcpXdfYvmq2Od7JuMkTh9wWvyl4w3ZvEC
         I7je/a9A+BmW2O+M94BQ0lhZRHmJz1Kg9W/nSmHoeY1oOFQ7Ufq8jxOJjmO0v7qstzsF
         fT3ZzSl9MX7UvTttxDrZR5l8+mniK8a2moDF6hfje8G5QMkq1A7aKtiOjcmuD1PjRnJp
         8d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3E8DomDlBx69QMvTIwJVdNBH3vlU8hQ5m8OWcZscKy8=;
        b=M4ckc0/ZDkCxp/CYVg49snHH9LkBXJ7SpGnVaRWz+CMQp12MNjXc+h64G6A5TuD9Z6
         e9623j5t7TEu4veYJn9+S2yZZuMzJ60TzIzOGNmjatGQQTnrt1WDypqaHmhXfT5QtiiZ
         Qh7LyQqjksUWgHzTTMe3zb7Mx1gwEnDXElvA+b32F9BT/xB3iGR3NXT2zick128HLQN+
         3fzE1yYYE4jcVyZg2nq2vrp5o8z7TUjLWkzInarzpTJIE0BHoWvcVjoN818Sn+s/paO2
         25q8sTS0VYaX7Ziu0RGfC/eJr2T9p+zxlTZ0i6qn5yMyLU7VrlXglTksV9PypFNuhuXZ
         Xm7A==
X-Gm-Message-State: ACgBeo1jgH1nzbBCuFG8nKWlCUlw8ius0aqzeiKNUwDaeUsqe1qmfVUq
        QstzxLgoNoXx9bQhOJGJG37T3Rxmb1GilmIJ0pE=
X-Google-Smtp-Source: AA6agR5PAnMggJvxp8e9hAjYGQpkydEw6ZgtnYsyoqxq1Sl4uaSbzyvNcKKs6dBq00ccgMITF8IZmB4Gdn8FN7RmFPs=
X-Received: by 2002:a05:6402:35c:b0:43c:8f51:130 with SMTP id
 r28-20020a056402035c00b0043c8f510130mr11343698edw.393.1661636877159; Sat, 27
 Aug 2022 14:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net> <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>
 <YwoV9/xAcWTRbUBG@coredump.intra.peff.net>
In-Reply-To: <YwoV9/xAcWTRbUBG@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 27 Aug 2022 14:47:45 -0700
Message-ID: <CAPx1Gvddmk8cfWGg7M8gJ=rxnoTgQRgQNX95BgYcQk1N3VUi8A@mail.gmail.com>
Subject: Re: curiosities with tempfile.active
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 6:05 AM Jeff King <peff@peff.net> wrote:
> Yeah, I saw that. It's a bit vague, and if the call returns ENOSYS or
> EISDIR, that would be perfectly fine. It's the "what happens on the
> implementations that do support it..." part that I'm more worried about. :)

The history here is that pre-4.2BSD, Unix systems had no mkdir
system call. You used mknod() to make a truly empty directory and
the link() to create the "." and ".." entries within it, and all three of
these operations were restricted to the super-user.  There was no
rmdir either, so again, unlink() as the super-user was permitted to
do the job (with three calls to unlink the "." and ".." entries first and
then remove the directory).

Unlinking a directory when it still contains "." leaves the link count
at 1 and there's no GC, so it sits around occupying an inode.

If you have a mkdir() system call and don't need backwards
compatibility, you get to have these return EISDIR errors...

Chris

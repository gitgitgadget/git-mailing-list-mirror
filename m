Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7BE95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 08:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjJIIOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJIIOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 04:14:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B694
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 01:14:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d77ad095f13so4335714276.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839271; x=1697444071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw0ZkhyFYvTImUzIumgzINxRLxuWVbn7xbJbT8WIk+A=;
        b=fzQkpMa8bNXtwG61Sp8BRWig5UtuEyLf4DD/MI6W+Lz5Cq7GvQpyiwHhARXRcH/GyL
         fmsd+5b8/wLAJR49qIDUin+IXFTqBIReFbm6YQP9s6barPqH7IqlVFTeVK1/jooJ5DzS
         RNDfj7aqQ/UWg/LULPNxd2BMz5BLue4CHY6I58ew+7XnQ87DetDKMhRUbRKNvLlAh6L4
         +Tn3NX+q4m65I9DiSEMWoj4Xip+blDGz69DUnnMI9pZzCm+XNILn4LswXoeMRHZHr79A
         Mk+DD6QqbQN4twiIAPVUFV7lqH1HUzordqBl1Rc2pwL8s7Dp+fRePtnEbBVY9KXbp7f0
         x/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839271; x=1697444071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw0ZkhyFYvTImUzIumgzINxRLxuWVbn7xbJbT8WIk+A=;
        b=Qtty7C7frF6Yi8BhqqROZ1JbqEMYORaY4C/08eM3dlfkC9G6JM1wpo2OhX8iaHUxFl
         d+56NUwF7JlF5XdtnX3gALEqKKcH9EYuj9+/LrL4U8BtasrLO981tFO0xyoq7dMzlbGJ
         Yy5ciJcKnIu3TvyO5t40cnXiieSUGcRBzbJDexLEM0Hzax13x3cm88MM7U8RJcx6BpJm
         /lsRKP6fqJjeMncHR7U+zhR+8Z/T0svmTuc7c3LvmHpxtsf4zssqaMjc0oRbqZ9PcSd9
         N2siPOZ709/rwXvCiiayajo9cFHXE9jLkV7nmUQhaIYAd2wQ3UMu4UWccx04rvR7XvBg
         vTFA==
X-Gm-Message-State: AOJu0YzUL+GbxwP+jVTcQg4FnrKXUWz32ezFIfHJvy+ssA4EK9IRvihW
        gBw5zYvhJLt9Mg0838auFPud4eaXUidkLxujNA==
X-Google-Smtp-Source: AGHT+IGAkApRWAKf0vMmBWTqhCjISFRBkSh4gv9uAjmzFvGLp558RJDVEIYafjrPTi1Y1wayv98QQbW12dkMgTDDtL8=
X-Received: by 2002:a25:1688:0:b0:d11:61da:3a58 with SMTP id
 130-20020a251688000000b00d1161da3a58mr11681710ybw.54.1696839271222; Mon, 09
 Oct 2023 01:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011842.1956-1-naomi.ibeh69@gmail.com> <CAP8UFD3HZOMJTxW5EkUwKu48GebSKX3-EPD8tjGEQnE2MGaZ7w@mail.gmail.com>
 <CACS=G2xfUYVmvhZ_r447uArW-_6yK0r7V9BkzX7i+E7MvruA9Q@mail.gmail.com> <CAP8UFD3Cj7nC704Rti8jBp6VxBJDxsBpf_8vvordW8MWXc_GDA@mail.gmail.com>
In-Reply-To: <CAP8UFD3Cj7nC704Rti8jBp6VxBJDxsBpf_8vvordW8MWXc_GDA@mail.gmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Mon, 9 Oct 2023 09:14:19 +0100
Message-ID: <CACS=G2yndFLMgZj204q90py9SCGj7bu5_jH9iP2HAWU3tdBJtQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] *** EDITED add.c ***
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay then, I'd wait for additional feedback and send in a Version 2
later. Thank you

On Mon, Oct 9, 2023 at 9:03=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 9:46=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com>=
 wrote:
> >
> > Okay I understand it better now ,can I do anything about it? Or should
> > I leave it as is?.
>
> I think you should send a version 2 of the patch (so without a cover
> letter) taking into account the comments I made about it. You might
> want to wait a bit before sending version 2 though, so that others
> might have time to read your patch and give you more feedback about
> it.
>
> > It's my first time using the "git patch
>
> I guess you mean `git format-patch`.
>
> > and "git send-email"
> > commands, so it was a real struggle understanding the proper way to
> > get things setup.
>
> Yeah, it's not easy to set things up, but once that's done it should
> be much easier. To make things even easier, you could perhaps save
> somewhere the commands that you have previously used. And to improve
> or make changes to those commands, you could take a look at the
> documentation for `git format-patch` and `git send-email` which have a
> number of interesting options, and take note of those interesting
> options.

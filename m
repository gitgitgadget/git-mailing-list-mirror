Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA4C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKLLK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 06:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKLLKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 06:10:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB82677
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:10:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b11so6501597pjp.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5/0Ocbj5+Z9cJC5DtVDB+oDAJgwa1WD4A7gJOP+yc4=;
        b=hQ2Z2N0D+MBIMrAQvyFDXZea5tfjBHzgV+zQyZMv8tMgFB+67uRp5oiKEGIyJD3Fc/
         6NwGBmtRPYQkdhKOYzfX9xFBddWNHkCtfBS4yzL7CRSxPlZn67YofSAKRsJfrlMCOklm
         5SZPY6uJdNJzVaJ+YT9l3zPAnHb8/61MhZ2dPEteYUbOpe/x4KsFDAuU7/hPrPyYM7tZ
         s/KQqF624F+CwLDJ4nNHXWvnwieZu5xWXsIe6DTGY8/K1/AZ+sCnHZ+fo5Bm6Tv5pk9u
         O0Il54Y7uQgPAGypMKDG99AzL/bGCiei1bLrQAQq8BWRStbb/ZqO9Vh8TFXkzy4cGb+b
         XoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5/0Ocbj5+Z9cJC5DtVDB+oDAJgwa1WD4A7gJOP+yc4=;
        b=zUlQP9TWYTBEGGeo3S9uWbTFzeEmQ8QmRZPR61nCVBhBWRkEulG3QPlg+0FH03X+u+
         T+0xwvyTpaBeSJm/Qu/YGyj8EU1LV4wZ8G3iCvD1XCL5/PRcbfUrRI+/gZBRd98xWoqc
         ZMoIuvVtgnxdd34+YqH0+gN2cHiQpVmgIoQWIEMzODEDag3W0kQDtHZv+kDkEPo3aGGF
         30YOvysnxF5fz6Gruut18Kwp/xFaleKy6Lvmz/btHCytua0hue6XU1pvuGVHnfyGJkEz
         uKwex4faYwirIzgcjQX8rxAFqFCL/gCKyMXjNWIi8v7zN/1t16Q3RzZQAIKdUeaqRyd+
         vFhA==
X-Gm-Message-State: ANoB5plEqtbbrrfSSETEHVPqJzr6At51wzVLbSz+03BPYUjPv4AJnMHn
        bgYrdy0ehGqfiWXf4hv0Yd+/vkaf6fuyMQnlHVcbjQiNqVs=
X-Google-Smtp-Source: AA0mqf6EDPQIsr/vRi4shENG5w6wkKgQTdXuEJE1ZuH8T7AZ917K9jjbJ406R+s5QSyZpm1F3CUQJmn3rSz5J+OTTcY=
X-Received: by 2002:a17:902:e848:b0:186:f1b6:c3dd with SMTP id
 t8-20020a170902e84800b00186f1b6c3ddmr5900589plg.20.1668251454088; Sat, 12 Nov
 2022 03:10:54 -0800 (PST)
MIME-Version: 1.0
From:   "Moss, Adam David" <admoss1980@gmail.com>
Date:   Sat, 12 Nov 2022 11:10:38 +0000
Message-ID: <CAMTDv-8kxu-vwtCgz-VGBhYEbUX8edXzyaQK4szg2bmMJLjF4g@mail.gmail.com>
Subject: Annotated Tag Hooks?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is there any way to use, or are there any plans to introduce, an
equivalent of the `prepare-commit-msg`, `commit-msg`, and
`post-commit` hooks but for `git tag` events?

I would like to make use of `git interpet-trailers` to automate the
inclusion of some additional information into the tag annotation in
the same way we do with commit messages, but am struggling to come up
with a nice solution at the moment.

If there is a better approach I could use I'd welcome suggestions?
Alternatively I'd be willing to help implement such a capability if
anyone would be willing to mentor me through it?

Thanks,


Adam M.

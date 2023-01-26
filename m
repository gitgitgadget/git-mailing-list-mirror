Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15598C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 08:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjAZIJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 03:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAZIJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 03:09:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED069B0C
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 00:09:49 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cw8-20020a056a00450800b0058a3508303eso603992pfb.13
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBYtKDcv56dYs4t+BEjewHBGeLHlRscxTLekLRuw15E=;
        b=qEZiAAsP+WWs31j9ii9m4wUJPuEyIgvTTSnr9kNPB+3le5t6/Zh/jHQJZCZj1hZHtL
         7uJF81n/vlDkbRrNioV4G0wFTKsLXkGZ7+lX4iKAoqV+aZAFl42tFCNHOsXhF949AP/Q
         XuTp+2Lmh+3egAbhOi3+hZ6pas0LQ6Vvb7i47g87yZqGECdGWAjc0bE+qyC1Vg81tj0O
         eKsHL7b3D75yUm4aUh5I2T/lqvc2VxHRYN2rwaAJQAb/nuxsDROJTik4Ljd+oCwjbOFr
         xHcLNdRBao2KjymscucA1ET93QpH+DULItEdE2aI3wMRu0PcG0hxta6mwUS+vzi6gJJA
         oJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBYtKDcv56dYs4t+BEjewHBGeLHlRscxTLekLRuw15E=;
        b=WHruDCIuvsMMLLkt/W38fn86p1nGLYDbluOgDADOhFkK1wPdex77/gZW1F7U1HU32R
         W4mOgykuimVMVh8TBdW/6ASaedBOvDt/uFfXpgUH7t2Co7pXh31TdW+ZXK97ZmQ6NVJI
         X2MxXBtNHMJel8hu9PFSiX5l/OtwmzZ8LJsJiyz9QvFk9CKmAo6eMgOpjDG5548wZ8oo
         tZujNvLdC9N9lmpSXylXtg7FnKpEZZHZ0BfTzdC6VvX5l4IPoRbCH4vZXa9wKWNtHml/
         wAnUF/+/86JqoWSBVdAT3eInGjQ+NVoytPC7X/2gACjkU82zq16Akj4x0M9lftRc7V2n
         3WkQ==
X-Gm-Message-State: AFqh2koS/YQiVb9ltxLoNYcJDmwuGoZhmOftwdvy3rlRo7S0nox0DdIw
        PJ4wUUsnVFcMt36xw8no9yX7s6KnWVe8GA==
X-Google-Smtp-Source: AMrXdXuWqdfTcHsSkJlPztFK0nqlAamOe2lsA6oGMz/Ia7EnC9M339DHNHPdTyWyndVnsqiVifTvsx2k6zdpRA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:ce08:0:b0:4a9:275c:faf1 with SMTP id
 y8-20020a63ce08000000b004a9275cfaf1mr3571788pgf.71.1674720588530; Thu, 26 Jan
 2023 00:09:48 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:09:46 +0800
In-Reply-To: <20230117193041.708692-7-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com> <20230117193041.708692-7-calvinwan@google.com>
Message-ID: <kl6lv8ktvhrp.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 6/6] submodule: call parallel code from serial status
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Remove the serial implementation of status inside of
> is_submodule_modified since the parallel implementation of status with
> one job accomplishes the same task.
>
> Combine parse_status_porcelain and parse_status_porcelain_strbuf since
> the only other caller of parse_status_porcelain was in
> is_submodule_modified

I see that this is in direct response to Jonathan's earlier comment [1]
that we should have only one implementation. Thanks, this is helpful.
Definitely a step in the right direction.

That said, I don't think this patch's position in the series makes
sense. I would have expected a patch like this to come before 5/6. I.e.
this series duplicates code in 5/6 and deletes it in 6/6 so that we only
have one implementation for both serial and parallel submodule status.

Instead, I would have expected we would refactor out the serial
implementation, then use the refactored code for the parallel
implementation. Not having duplicated code in 5/6 would shrink the line
count a lot and make it easier to review.

[1] https://lore.kernel.org/git/20221128210125.2751300-1-jonathantanmy@google.com/

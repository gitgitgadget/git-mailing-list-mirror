Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058D6C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 18:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiENSnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiENSnk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 14:43:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691E3EF2C;
        Sat, 14 May 2022 11:43:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r71so10103934pgr.0;
        Sat, 14 May 2022 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lx6vOYyf/crCZ2L/bBJ5ogj6IQFuyGmUGDTzppCneM=;
        b=Diok/QJ9CYtdsD4iN25YHWFeZ5/JMFVIoRNIvm7dutWIkd6Dmi9kQ0hOnaOh7oH8RE
         dTwzlB3oKQLuT/vuaSppU6M1KHVttfZHnTkK+oTHuB6eFKhYBSdtnB9mrM/acEl11Nr6
         q3RuILhdTnL4QxZK8u77AlyAFZu8b/1R7IwRrtoHJp3KA/c57/lMXGdhmOQMZPR494Ok
         kOmh5qDePiBm8Xzbv1azv3uaCrzHqwYEBJ5CRC+2ddbcS4nl3HZZMcQ8/YZI2+MfjgFI
         83yrdg7sA6zh3pAhn0zyEy8D8U94ZwJDE/Z7XTffdBYZxkVPd2Kdw42pq1RUJGIl3ctH
         i+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lx6vOYyf/crCZ2L/bBJ5ogj6IQFuyGmUGDTzppCneM=;
        b=lFrgvCFyVR9LZFZZWxHG/Azq+i+AZybkPLt4XI55DXbgVpLNu7H8xWXsb8Eum8FNJj
         QKDGFTOTu1E5DyhuUsWZiFBWgZ7wgCqhLAJMM3ZF4N8gskTM6OYEqOfu5qYS+p1LI4XX
         UCWntyDiWjg2+4CpqOhIlaHE5GOcMZu8E1T02rXGhG9wPzWTuRXVs6VG+Ie3+u6qxVos
         xLDpfAwp8MHYIQAyA9yrzOOht/MVJTka1xrgVBhF/7gSuaY5qmTtU+TDRIhHffd+dvcS
         9lKDdBcMH4LYZ1j+4Oq7WMDE1awQyL0kmaFxNUpJbJep0wlHsxDnldrzuCR3T8coXvPV
         rpHA==
X-Gm-Message-State: AOAM531SrqKjc1OpN+dN8e9hRQ6PLOFx5yqxLGp4ssinQroWBBHPCYo7
        fP3nxFYSGyoSFaDM6UhgfzPVOYHzkLB98r9WZ8Y=
X-Google-Smtp-Source: ABdhPJwUkBSB8aML+dFZPk9K127fWzYRH0CquLnNwG5N5T76NJe7Ik0CMsh8n23XbPqIhhHMgfwIReZFRGl1pD6PB/s=
X-Received: by 2002:a63:eb16:0:b0:3c6:77a1:5be with SMTP id
 t22-20020a63eb16000000b003c677a105bemr8971232pgh.127.1652553819754; Sat, 14
 May 2022 11:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220510220821.1481801-1-tbodt@google.com> <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
In-Reply-To: <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 14 May 2022 20:43:28 +0200
Message-ID: <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
Subject: Re: [PATCH] getpriority: Only getpriority translation the priority values
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Theodore Dubois <tbodt@google.com>, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 14 May 2022 at 17:11, Alejandro Colomar <alx.manpages@gmail.com> wrote:
>
> BTW, I had to manually edit the patch.
> It's the second time I see this (I can't find the other one), your patch
> didn't apply for the following reason: the a/ and b/ prefixes in the
> file paths are missing.  Did you use git-format-patch(1) to produce the
> patch?  Can you reproduce this?
>
> I CCd the git mailing list in case they know what's going on.

Sounds like `git format-patch --no-prefix` at play. Or more likely, that
the `diff.noprefix` config is on. I don't think it can be cancelled out
by a `--no-no-prefix`, unfortunately. If a script is involved in running
`git format-patch`, maybe it's not too tedious to make it do

  git -c diff.noprefix=no format-patch ...

to cancel the config. (If that config really does want to be on, that
is.)

That said, something like

  git am -p0 ...

should help on the receiving side, by way of skipping fewer path
components when applying the patch.

Martin

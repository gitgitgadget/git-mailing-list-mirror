Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A0C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiCBIsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiCBIsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 03:48:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE77644D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 00:47:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h15so1216297edv.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 00:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nau0IQgbwe9FJewOHDU7wZ/AfhfMsHuX4DbX1bEe4Kk=;
        b=BuAzT5ftgzfJ6UwEwB7DsS8K0RzOiQ0LS39l0CuOjmo0t2x0YWx2tJWXaAABNny4TC
         EesUaPko3QPkr8Gu9uvL1RgPXeG/aoBaVLw/aIP8dy2X1oKBhTUcM8pHClhS7AD3uY1I
         TXBx34LU7ekZ1v5SDxNPNQBYORyKuoY1fYZTIy0B2IHsccw3jvUwRFWDYpCpBCm9a3jD
         o7Zn4TpnQ7ClleNd8W1ReaVMfFCSLvKgTE6BgtmiORHberPucH3twEGW44qPJ8wKyMKe
         zlDIvwaG+iLwUbY+0lM1jlyHBGA2GMKpEVg++ERi84/lR8xzuzqnCIELpP1R/MNei6qO
         Kunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nau0IQgbwe9FJewOHDU7wZ/AfhfMsHuX4DbX1bEe4Kk=;
        b=jfK5H9E0hOf4sPFzata5qDGHPWMc7GRuHnQ9jDDfbUJbPJxHHqD26JBgtHuf0F3vI0
         pZK9eJQ7/PAzzIkyVYdAllhFArIRmFu1pTQbyhx0QlKnV6ziQTyaSfj71P3chB76lZRx
         6V12BW4d0EbTOTf+KK7X5Om2lfgMLwDjuoUaOp4k9fkq6kFSlHemzIJfOkUv4gKrZF/B
         rMJCTXVubNOGYw41KH2g7shCxBtB/0w9X7tYbCWNcS4VS+TgajGwTKjrGoFCL3WuGOcO
         DRKJvz1ObUC1W51DEiWONC4kAYfaXC46hjBcgo8SB5FoPgI+SWWSWDX+bHxWDe26iy2m
         ed/w==
X-Gm-Message-State: AOAM531A7fuRrahzZYoNQUDqSNJ02uMbM5xlvv7qJ2q5aNP18twnOzHl
        aNg1zFh1zAINUT/g+rnv9rB9gANlAgEVveCIsa5eRA==
X-Google-Smtp-Source: ABdhPJxM/FLSvvifHEULhwH8jG6v5GYz1CHNoVkNWmZZnNrgzwcCHRLg/pLjtO5rGXCrh+X/sHV5l+tmmxMYRby0fzs=
X-Received: by 2002:a05:6402:d08:b0:412:a33e:24fe with SMTP id
 eb8-20020a0564020d0800b00412a33e24femr28856754edb.281.1646210853499; Wed, 02
 Mar 2022 00:47:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
 <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com> <220228.86y21v3wyj.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86y21v3wyj.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 2 Mar 2022 09:47:22 +0100
Message-ID: <CAPMMpohqPa3bqnPLKJ851JJFQhbF_ZA+hAGuE_+0z+BMF2yz0Q@mail.gmail.com>
Subject: Re: [PATCH v4] untracked-cache: support '--untracked-files=all' if configured
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 3:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> In reviewing this I found the addition of very long lines & indentation
> made this a bit harder to read. I came up with the below which should be
> squashable on top, and perhaps makes this easier to read.
>
> I.e. the one caller that needs custom flags passes them, others pass -1
> now.
>
> For throwaway "char *" variables we usually use "char *p", "char *val"
> or whatever. A "status_untracked_files_config_value" is a bit much for
> something function local whose body is <10 lines of code.
>
> And if you drop the "int config_outcome" + rename the variable the
> repo_config_get_string() fits on one line:
>

Thank you, this looks much cleaner!

One question I have about this patch itself is why you changed the arg to
new_untracked_cache_flags / configured_default_dir_flags from "repo"
back to "istate" / whether that was intentional; I had understood Junio's
recommendation that the function get the minimum it needed (the repo
in this case) as very sensible... especially now that we need to pass in
that state less often.

Another question is whether I should add a comment in
new_untracked_cache_flags explaining the new meaning of "-1" for
the flags argument, or whether this is sufficiently standard in this
project or in C generally that I should leave it implied.

A third question is whether you have an opinion on the better approach
to getting these changes merged: does it make more sense to argue
that this is an improvement overall, and that the case of configured
"all" and argument-provided "normal", which will now have worse
performance, can and should be ignored, *or* will it be easier to get
this reviewed/merged if the new behavior is made conditional upon a
new configuration key?

Last question is about protocol/workflow in this project: When I squash
your proposal in, should I add an extra
"Signed-Off-By: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>" =
line,
or just include the changes with mine?? (I've read SubmittingPatches
but don't really understand the whole signing off business; I do
understand that as your changes improve mine directly, they should
indeed be "squashed" in, rather than added as an extra commit)

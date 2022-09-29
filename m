Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A2C04A95
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 01:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiI2Bgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2Bgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 21:36:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9F11E0C1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 18:36:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so59552lff.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 18:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3pZ8dm9W7h/B8bewRUiWBURBbz6t7XhhjhklYNTvqdI=;
        b=MrYJc5tbYZ3iPDk5M+uuyJ66ddAzjm4VpglY9LihccfmauwrWAKqBr6DXeAY3XO8Km
         1s1Fd49s0ryLGi1kVhIi/waU/ChJ9HiYJ7Ch30k+xOtVEmTq41a4SZvLogOlxYLjlx01
         L7htOaz7LxXr0QDQIBOacRJeYWpYm3zHL0RPWXZ+o24z0/dB24YEC7fu/4hrkS07PbNT
         +2qw9X7DK6V6Z0SxekRqJ+bhoxYv8jOJ0X7mg9xZRf78iqGjtv0s5xdymn64Sge1Hjm6
         Kp8yvP2KbbDV6YnfJoTAWjrmhirGYQEaSWQbV7bQjxbi4Du00m5UbJTO1uF3/Bv2weFb
         7EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3pZ8dm9W7h/B8bewRUiWBURBbz6t7XhhjhklYNTvqdI=;
        b=btVlCbQisilaX0z8bldlAHnaw7bSoqQIAwHnttn/rW2Zk+1oDTjNLOtArEYmsOQAI7
         Phd0NbwhsZ9G1tZKPbIXEgw/DQODcqKWGmuGDxfEEYMWu1w/L2IyBWta6c1fNuSEts8O
         zZeiBabYtRzaoWeEp11DLsUXUxphf+7ge297118fgpOa8V8ivBHceFZ1tmW/1jed9E3d
         xS0xIXPRdwCODzxjmrzK8SsiyeIqIUm9EaTfWXc6MzuRVo1oB/lJYQcMgL8wOiv0xW+g
         r+GIVZ/VqYvgzL2cXgoPWrJxxv7RESPY8v19JwvzkIqLErLx+I+R+5zET67wQAVOkJwL
         i9iQ==
X-Gm-Message-State: ACrzQf24OO6N+bJ4F95dYxIhNWOw4Ki0NKh3vxQ5HVozGCE0lN1HGT8d
        hoK40XPtNB39jlONx3GuUSUAMplPE0GtTvON2GU=
X-Google-Smtp-Source: AMsMyM7ihYLbP7Eealt6nq8T457tMwyOMhL+tSdqBeKSzyZjrFbo9SvViLlY9OjUbUMtOE0K4kZjtfBEy0o5j2el9DY=
X-Received: by 2002:a05:6512:10c1:b0:492:a27d:ff44 with SMTP id
 k1-20020a05651210c100b00492a27dff44mr295268lfg.405.1664415405423; Wed, 28 Sep
 2022 18:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
 <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com> <bfc71a2d8adfbf9b899a47d469fe2343e4703ff7.1664350162.git.gitgitgadget@gmail.com>
 <xmqqleq3zea3.fsf@gitster.g>
In-Reply-To: <xmqqleq3zea3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Sep 2022 18:36:33 -0700
Message-ID: <CABPp-BFML-7osm-UUpXHf9exzUk0iktDWwm4tKu7ggv68SgJ_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] merge-ort: return early when failing to write a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 8:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > This is _not_ just a cosmetic change: Even though one might assume that
> > the operation would have failed anyway at the point when the new tree
> > object is written (and the corresponding tree object _will_ be new if it
> > contains a blob that is new), but that is not so: As pointed out by
> > Elijah Newren, when Git has previously been allowed to add loose objects
> > via `sudo` calls, it is very possible that the blob object cannot be
> > written (because the corresponding `.git/objects/??/` directory may be
> > owned by `root`) but the tree object can be written (because the
> > corresponding objects directory is owned by the current user). This
> > would result in a corrupt repository because it is missing the blob
> > object, and with this here patch we prevent that.
> >
> > Note: This patch adjusts two variable declarations from `unsigned` to
> > `int` because their purpose is to hold the return value of
> > `handle_content_merge()`, which is of type `int`. The existing users of
> > those variables are only interested whether that variable is zero or
> > non-zero, therefore this type change does not affect the existing code.
> >
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> Thanks.  The first paragraph in the quoted part above is new and not
> exactly "reviewed" by Elijah yet, so let's ask ;-)
>
> To me the description of the issue looks reasonable to me.  Any
> comments, Elijah?

Looks good to me!

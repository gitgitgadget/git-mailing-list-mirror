Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D94CC7619A
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 02:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjDFCQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 22:16:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD38776AD
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 19:16:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m16so24447006ybk.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 19:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680747391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy19oEnO4U/IyTdGLuJoCMn6EfbSVWsNmwzTrcRIr7o=;
        b=D51XmCgBktMECza8+d5GuoJbNUYdnS5QdiYKoyogGas4/hg4jdbhXrb9VY7QaVfdjt
         kMfmwcimQ0k26vormS0ZGKM3sVZ5Xk9zNxVqIzMSjyR/BuuhtlWFqAcx0Q9hk6QKpDAg
         zBbmY/z3dkdVqjKtWYEB0pqSJFQvAbcPoMsheAhw2LgQrHECMZAnORAqH9b06uYZNVOj
         JFYdTy4rLBiRJimqSBwMv64ZbUzSMZmf5PJk0U0C7ePFWSqOOoged9u2kwr7dhJcmZe+
         6xyjCeVFG/SDkaE9XNW+rXTgPMrITm3yFh5Ut/f+uJskcD/ccOJwgx+RgbWvNjQ1iihI
         WSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy19oEnO4U/IyTdGLuJoCMn6EfbSVWsNmwzTrcRIr7o=;
        b=kGgZ4tEr4UXG8wqrW3Kb/JJXpBcBGMwcdNhXueL+nOXCXHd0HoFt2eFWHe3xPVrPMA
         6WV+QcYIctEKUCaijYUrFi9/G1hQ7ruViY0VKLrzu/9mGDlvEecgG2s/PZ1g7oas46IT
         HVY7ODt+Sn5GweSNVUOP2QVOi9OvfhjhZNO+QD/QFzV29B38ES4LKgrVyr72ywnSiRyl
         nTGmrA2lRINIw8JELQzRtapWsCUkhPtDdi/iK99xIqUI7nD2Cta/ViQmjU9ka3Rbv2JB
         ERS4gmd/990uy/v7oZb0mWnyaT/VSljg+rRmdxTUwIlqMUD25F2uyYKchVNqe7gW/Gs0
         Jowg==
X-Gm-Message-State: AAQBX9fcK06NK/7KMVvpZWD22QnlVdaxZn3wq6C5pjExo5MoDUX2K6DO
        M1Zgv08ezjfex6E0lBpYTeMiNufQIkVY52wO27UcSEd2
X-Google-Smtp-Source: AKy350YyJWgJngB1yZIASFcVN8fvqfGIWO+mRRYewnaHVS8mOJYk5I3IJZ00Y7fhZhCV7VRNny0Q7YvOWArFaZAFaZ8=
X-Received: by 2002:a25:50d1:0:b0:b6b:d3f3:45af with SMTP id
 e200-20020a2550d1000000b00b6bd3f345afmr1068556ybb.1.1680747390993; Wed, 05
 Apr 2023 19:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <20230405213020.M231170@dcvr>
In-Reply-To: <20230405213020.M231170@dcvr>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 21:16:18 -0500
Message-ID: <CAMP44s1WDh7wbYW1+xdW5Rds7dnDtz7-aGy17pSynxVmAYo4dw@mail.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
To:     Eric Wong <e@80x24.org>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 4:50=E2=80=AFPM Eric Wong <e@80x24.org> wrote:

> (Only tested GNU/Linux and FreeBSD, though).  This (and
> `env perl') will fail if distros someday decide to start
> using `perl5' as the executable name.

When that happens you can just do `ln -s perl ~/bin/perl5`.

This is similar to what I did with the horrendous python3 transition.

--=20
Felipe Contreras

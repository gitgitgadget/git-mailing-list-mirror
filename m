Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A014C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 15:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiBQPvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:51:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiBQPv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 10:51:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D768177E7F
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:50:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z22so10437146edd.1
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSDu7eAaOa6ysZp29HO3ZTFGoo8S0vOegxgBIhkYahk=;
        b=MXQPxMwNAuTzmy7y3o/Kk2VNlhQ0BzeZQwID+s+iutKr+3QHBoeKtyQUvkLb+dWPdh
         oNObaKBiJmzwpDNlKO9TBvcQdeQKpuqrM4qhQZC2gGZN2J0zHTsSbGURtUwTcStr+WGD
         PYiqRAKGo5b3njI8mp9je0g+akpbg3uTL9VEHm/7VoPlI9ODq11+Dwr8OdPJf4p+o8+C
         jKNOg3vhuWS9/QYkRK+puRHHHMtYG+vwzecB7FpFFOWe2s58+OKYiv4kKW+t90noCavi
         Vn3n5s/2HNlfqbtqiX7zPoBF08jQz7pUZ/TJN8B95IABeOQHZHI/a6AW+cOVKOUO6DUA
         /DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSDu7eAaOa6ysZp29HO3ZTFGoo8S0vOegxgBIhkYahk=;
        b=rz+I+T2yib4ucqVM5fhxR/A4EcX23jET8QfeMk1iv6aUplLLiGczYnvYD1OnB+8RhQ
         3rgO3103mJ5yQaNbgVqmzl/JRocNGzzT5XIBMVisYAuhMqBD28jgmaG/ItvG4OQTCwAn
         s9p6RYGfGJSg2Xh+o9D72CIbPprdJy/XSG5a1493H5gu+GWX/QeS5Rqitm+rLrPq6TZP
         IoMCYdF+b1ICLOPEKQKE7mt0t4oehFZTru6olvZd5Bj41SoOqZ2FbsPdArODqnGrCmU7
         t/2EpqzeLm4SSTZVvHnI7fstgqHVQC59Lb7jbVbOa+bir/ez2/Cgt15yRNcDbHyFd6vU
         bHyg==
X-Gm-Message-State: AOAM533ufLoW8NCvOejmKAdU1MHi3Ko6NFawNrmi2mPoXk84ES9l9qXN
        vgDWbUoCiqCwYsDzWSsekteOK/Hji8+Iu7X4lWJfmDvh
X-Google-Smtp-Source: ABdhPJxI1v7VLXRhE62Ws4i4W+fFsEYBJDUIR12uJSmkUlGlADoY3J5Si7e446aNzhwNdhKpGPhEEUS++L90YpTsDc4=
X-Received: by 2002:a05:6402:50d0:b0:412:8f96:e5fa with SMTP id
 h16-20020a05640250d000b004128f96e5famr3256697edb.276.1645113055441; Thu, 17
 Feb 2022 07:50:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645102965.git.ps@pks.im>
In-Reply-To: <cover.1645102965.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 17 Feb 2022 16:50:44 +0100
Message-ID: <CAP8UFD1xiTaOvjT1UYZCUbhEF_ukgZ1cAZgbYiV+Px74RskS5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] fetch: improve atomicity of `--atomic` flag
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 2:04 PM Patrick Steinhardt <ps@pks.im> wrote:

> This is the second version of my patch series which fixes these
> problems.

I took another look and found only a very minor improvement in one of
the tests in patch 1/7.

Thanks!

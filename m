Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D15C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 03:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbhLaDMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 22:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhLaDMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 22:12:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86198C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:12:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k21so58090134lfu.0
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSnH6Fl02ElUz0gghlx7pYJCrfLdurC/A3j6WvDOysU=;
        b=YcKiolGXzWav8haxW25WL9mo54N1EAka0j3NOH6pe6v21l50/UxupG1KrGhU38uTmi
         jfRZCX1wkys7+A8PxYXoLI5UTZn6CRvT+AVJEDZP5zUaNOGEtPY05Hl58VzLrSmcxNie
         CFy8rerLeqdky0zbpoiC0M/FhrR/hrPJJHEAn6+7BC1/3KCFjpiIF4z2V5/wJr9JQ3Ii
         rRlv5Cco7mdt2mS7TLySR4IrVhBb4/TE6cIVCDWyNSrXVK+Faa+tskRx0GN0kJeju3iB
         mgn4BglA8vApMn0WDbX47Zb1/qJZT2cyNRe8cAQ8UUHW5D1elPRW5DBKi44zpnC7vbvI
         RCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSnH6Fl02ElUz0gghlx7pYJCrfLdurC/A3j6WvDOysU=;
        b=BLANZJe/uzOZGUHxBigBhJrOQzp9+C30tlFtn6aD7pWiIsfg+7hI4M3av4BMvwwubF
         BIBoTG4DgBrtwYtcpEfxahg86oWrs4l7HnJTmT8a1ZzhSOaeNZEGdTQNweBhaqXm0gZ6
         1jqnhque6KIhLcA7TfPBb47FcQN8NrJ62VcFkifA2IxmkXbXKRV7F1Zgj5e/JGLIZiOZ
         4H3/P/b67Nt+GXIXpgXMObUosPSt3v4LsP/Y8dNQlbag1YWHwvVcGrP+6+BXJfUG+8hG
         hN6sHM0i/xpGL7gIfwv+3zW3L6IYnrPavlhOxy42lC6EomRAFgNdovlWk8h6k5W7JbV2
         MTTQ==
X-Gm-Message-State: AOAM530QYxryTWf6mf+S1VH/4zKE9HmdhRjnpnGIMeqWoT5S+iRFCZOe
        uXGzLCutzGNQECX/ggA6Ov9cgjJywaulfuWYqvk=
X-Google-Smtp-Source: ABdhPJzBsMzN+jeUtICJIBmBaSjVADiPkxcX/XT40Qc8uh5j8BDX699wE4Aj7USeJt32jnvWGIXGneRRYcxAzrthpHM=
X-Received: by 2002:ac2:4651:: with SMTP id s17mr31187404lfo.66.1640920341789;
 Thu, 30 Dec 2021 19:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-3-chiyutianyi@gmail.com>
In-Reply-To: <20211221115201.12120-3-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 31 Dec 2021 11:12:10 +0800
Message-ID: <CANYiYbFbhYtrbXtu12p8z0X0id4FSbd68T-5XLBD-b0c8s=zzQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] object-file API: add a format_object_header() function
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 2:56 AM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Add a convenience function to wrap the xsnprintf() command that
> generates loose object headers. This code was copy/pasted in various
> parts of the codebase, let's define it in one place and re-use it from
> there.
>
> All except one caller of it had a valid "enum object_type" for us,
> it's only write_object_file_prepare() which might need to deal with
> "git hash-object --literally" and a potential garbage type. Let's have
> the primary API use an "enum object_type", and define an *_extended()
> function that can take an arbitrary "const char *" for the type.
>
> See [1] for the discussion that prompted this patch, i.e. new code in
> object-file.c that wanted to copy/paste the xsnprintf() invocation.
>
> 1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.co=
m/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/index-pack.c |  3 +--
>  bulk-checkin.c       |  4 ++--
>  cache.h              | 21 +++++++++++++++++++++
>  http-push.c          |  2 +-
>  object-file.c        | 14 +++++++++++---
>  5 files changed, 36 insertions(+), 8 deletions(-)

After a offline review with Han Xin, we feel it's better to move this
fixup commit to the end of this series, and this commit will also fix
an additional "xsnprintf()" we introduced in this series.

--
Jiang Xin

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF23C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332F460BD3
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhFPQaT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 16 Jun 2021 12:30:19 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37705 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhFPQaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 12:30:19 -0400
Received: by mail-ej1-f47.google.com with SMTP id ce15so4876668ejb.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 09:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UlkkcTQfrJ9HAR9BwY/79XG65NNkJC38soUFH+fMwr8=;
        b=om2EIZGZtzZ5bAm1fWwmsi9K61FAc2pkEybJWi66ZtjFZ1ZcCHsEooceuZNqHFy/qX
         Y9HU6f2d5HVs6MoY+KzeCNWXAQUBENKbWyzOpqIIq8eHr/TC8YsU50Lx4B4xvYeHvdMZ
         grcUwl3tUxP33V+7svI7cuBRWImT76bxSksEId3W94hWnk7fn3KFqGFIjxxPiAIcZLZ1
         BEIT6xRr56KIdfDAqGC/bnDYts3uX2IdrGgWTRoVRqomVbSU7r3eaMz4VQRJSgfwGKkI
         PF2+BPlc3iFow44vWI/TE52OyElIKLcHQie/B0qe0NsiX/ZvoXZoNlhYY6+1NJa4sU8i
         LyCg==
X-Gm-Message-State: AOAM530wWmjVrdg8qAtwqPWcwkMTEi5Z3HnScgjfJQiDG4vGGIRFltRK
        TAW7kdZ+c7Wq1GFGJHaODfdLagjrLmFKFNtt1pg=
X-Google-Smtp-Source: ABdhPJx+GP6StjlXaz5lxWlwqhzOINBB3/fDq2Tw9CMSIjMTwjhPBtpwK2SFGtzZzR4I6sucHcfgcuoGvxwY4ABqdlk=
X-Received: by 2002:a17:906:c311:: with SMTP id s17mr390895ejz.202.1623860891920;
 Wed, 16 Jun 2021 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <patch-1.5-4f74d7d34c4-20210616T141332Z-avarab@gmail.com>
In-Reply-To: <patch-1.5-4f74d7d34c4-20210616T141332Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Jun 2021 12:28:01 -0400
Message-ID: <CAPig+cQLRGL+jUkJi9n8_6LUpzxn-1XiCyvzCgiY38wjTi+TbQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] serve: mark has_capability() as static
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 10:16 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The has_capability() function introduced in ed10cb952d3 (serve:
> introduce git-serve, 2018-03-15) has never been used anywhere except
> serve.c, so let's mark it as static.
>
> It was later changed from "extern" in 554544276a6 (*.[ch]: remove
> extern from function declarations using spatch, 2019-04-29), but we
> could have simply marked it as "static" instead.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/serve.h b/serve.h
> @@ -2,9 +2,6 @@
>  struct strvec;
> -int has_capability(const struct strvec *keys, const char *capability,
> -                  const char **value);
> -

`strvec` isn't used anywhere in this header following removal of
has_capability(), so the forward declaration could be dropped, as
well.

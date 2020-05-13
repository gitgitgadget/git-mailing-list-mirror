Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E83C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296E0206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppl+Hz6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbgEMTag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389529AbgEMTaf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:30:35 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67361C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:30:35 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a5so507232vsm.7
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvAm/RWsLWbKrXl5wYkqUN/QzLWfdBhUymqYm03ttX4=;
        b=ppl+Hz6xL+fhqkkVJQFWJbx0QenXfFeKY1eJ8uOqNGG2nZOpAEDb9TeXcOu29d4igL
         7YojyOwmfBwz25EHRDtsqLeqBld8JPCJCEoTBdIDQO7XFlgbxDLe4o2GYkPRz8gkbGij
         IKV4+foVorv2NXvyE72bwBbq59N/BwIgfLteaewKSpb9X/dNEXwACTxY3QDBz1r9Vgcs
         uVWPdCN73NInYkvxmXG9Va8oJq14SjKuU+mR0qmodP0Hf6v9Uy34M0mZ8AhsaJTvVr12
         eli6mJJfEeWIDrq7sAeryoot1UQ1GYqKrKG5Caa3enKcn5CVv9Uk8fn1HCb5BzEarxRq
         ZWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvAm/RWsLWbKrXl5wYkqUN/QzLWfdBhUymqYm03ttX4=;
        b=KR76NwZGmxGz/2GU6Vl3ymPerwpbsHNa2JoOt1ExQxkuc8IEnjNXUtptMJIEoFf7ap
         tVFMzRLY2AS3T7dDc4HLRii3Jh2mFGehN1KZLutTlNR+lBqmmiApQ0QPHmbqF0gltRWj
         GEY0IPnxL1bS1k5eei/clg+EQBiORExjQWHDGWk9TDoUtXS6iw3Fe6XBucyciQLOzv3x
         jESBIoAfQnosmivDgACdEx4/phPmf7G5sezSrPdjq6LQVZMOvxDZ+WtllJF4CfPTg/G/
         PF0AZlZPwrLeSDfhQb8Fe88JAJQp8XUgZDBGOHLH6rZK16uiE5ONVIDGAl99Z71PSu9V
         yQiQ==
X-Gm-Message-State: AOAM532dH3FJn9scJvruEkVEKMzWHwEJrrPq7KPbkMymcdnJbYrL9TOd
        KiZFeat8FKm5RTmwyETlZf1FGza6g2Von6vPYcA=
X-Google-Smtp-Source: ABdhPJzzkYUHJKEqruQ614QuZ0kic/EauThdWglxClyDdB4iUPyICElfW45XAFK7WtSXapbQovI0HlHFQyYrdvmMh+Y=
X-Received: by 2002:a67:b91a:: with SMTP id q26mr659583vsn.118.1589398234149;
 Wed, 13 May 2020 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-4-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-4-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:30:23 +0200
Message-ID: <CAN0heSrtV15dxhKMeePbbD42FzWbnw2kRe+nKwuzzJJszvwi0A@mail.gmail.com>
Subject: Re: [PATCH 03/44] connect: have ref processing code take struct packet_reader
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In a future patch, we'll want to access multiple members from struct
> packet_reader when parsing references.  Therefore, have the ref parsing
> code take pointers to struct reader instead of having to pass multiple
> arguments to each function.

Makes sense.

> -static void process_capabilities(const char *line, int *len)
> +static void process_capabilities(struct packet_reader *reader, int *len)
>  {
> +       const char *line = reader->line;
>         int nul_location = strlen(line);
>         if (nul_location == *len)
>                 return;

"line+len" made it pretty obvious that they belonged together.
"reader+len" not so much. Your patch does minimize the change. Would
s/len/linelen/ be worth the extra churn? Possibly not. Right now, at
least we're pretty consistent about using "len" -- if this ends up as a
mixture of "linelen" and "len" I think it's worse, overall.


Martin

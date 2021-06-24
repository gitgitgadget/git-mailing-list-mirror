Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE0C49EA7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93C7613F0
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFXKi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhFXKi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 06:38:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD290C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:36:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so7758495edu.10
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=it+d9QwMAIj+fepvHsmKKI31uI5N4tobwMzvMy8WlOQ=;
        b=TnAMXoxVc0Inpgbzd/JPIcUOpPJ76wnX/NOTmzgFGmSj/XI+JGbHbmYCtc+j+DNu9/
         zV3QwlbNRLP9d1qi4tQ7pjlCItqg9JLtFxBF5mOITN/ClK3zNI/+Gc2FT6fHziNgOjYj
         IK5/soKx+M+vifKOo/1sIb7LGp/Vj2l6XunZtVNJuOr62vGVib2G7VGlra5RdS5HMF4A
         cpiVWoWT+FU4CmRe/S4zOAF6z3GcxzMlSM/bmUlxWtstP8kg610rDyRcgZxyTME40J1U
         EhB1pEOPhAGlCAzu0l25U9eAtjPuGBGXz5LkeAInz4EYVsOkcI7je3m9in6apw0Fpx55
         WwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=it+d9QwMAIj+fepvHsmKKI31uI5N4tobwMzvMy8WlOQ=;
        b=WgP9xGcDbjBJzqwmukTiYHIVi9PzY/CSGGnSbqagLnHMEMZqkImCTU6O7vy6AzV/lX
         CTy4FXsYLSC4nE4YxIG4I+jPpI5FvI++PzN7wzLwn8bHde0/rYyRKapYWJv8hRHD9zQ7
         7hmoNOZ6fxfAxFTjhYPgCUQ43K+KpT/gzyAf/qLctdR7WZ6vUHZLftpHHpOiLBLBHN6s
         OM6ll2Z4349C2fAtAqEDuy/iZcg2RhfS749szJcbtVkppmPOVDG5nVm0qieE6yY0oKec
         rAtpUjZfMDZJqYifQYn6QC4+Ni82VyMIDI5tgNfw+hJOsP9yO99ExwFjYfEb9Ru0e9Tz
         gZ+w==
X-Gm-Message-State: AOAM532TR4yrCmxhRPPgW6THoeRwHaRMMrOr4QPMJmUKfCB7ay/xdIZH
        21dx6UToIGpOl5QI0glQmDtKN88eLbM64g==
X-Google-Smtp-Source: ABdhPJwbTlpnFilLYfdmHB9DshCpHXllJ1Ydh/4LiGx+TK0UoKN2M8KVWEGhdp+fZE9j8KjnxdOtZA==
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr3171547edb.89.1624530966042;
        Thu, 24 Jun 2021 03:36:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm1722119edq.2.2021.06.24.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:36:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 22/25] progress.c: add a stop_progress_early() function
Date:   Thu, 24 Jun 2021 12:35:32 +0200
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-22.25-e7f8314867d-20210623T155626Z-avarab@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <patch-22.25-e7f8314867d-20210623T155626Z-avarab@gmail.com>
Message-ID: <87fsx71re3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +	strbuf_addf(&sb, _(", done at %"PRIuMAX" items, expected %"PRIuMAX"."),
> +		    progress->total, progress->last_update);

These two need a (uintmax_t) cast like the rest of such sprintfs in the
file, as I discovered with the OSX CI.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939FBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbiFISFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFISFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:05:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B687F21912B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:05:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so49045969eja.8
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t4PbWFNXknS3NH8uFMhd8ZLEKOfyT0jMcvuV5EoAdbA=;
        b=UL3poum2DTPne3nsIJtOvrZnEJF97/a/bN8Ymp9eKbNjiwoyuxrJ2APyo7rnd8G1a0
         d55iqaQQQtEVzTuwWaNs1r+jqBYsAaqnKsYEU5vCUMZf0vLwMuLm0bFZcpNEloTg/VSR
         8b7Byzs+AmsRuBBmFHxi1qxGYFic/WrWWA/Gwr35XHoBogsZUmQx1SbwrYB2aa3G+d8Y
         S9k4JlvNyQtkE62QAoW1zz1revAgOiijKL1oUupi2glOuyFrcc+v/BrhZdx8ztkEaIKg
         /P4pGQLe/YG3spPu1mvCbt7Fy0W2gEeR3udgt+/GA17RShPKwTC6JssIP+6SaAwtJQAK
         UtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t4PbWFNXknS3NH8uFMhd8ZLEKOfyT0jMcvuV5EoAdbA=;
        b=OO/xZ8qZVfSHlKg0JMTFL00Wwd/pRuqKZrwFRtwB6BC8TQBRltk/CsuwQy7cbV9kIU
         W9PTLP6Y/vhZhLNAPRdtCX3qJlAQDcA85ok8gUdk5JAt5VzipUUrdiddw2LO4Bm6I1a0
         HtHGWb2o/7FCd67IkyiNj//1/oVR5Qz+NaY37fFTK4VvnEQz3y5rafN5FeyKoeVTLiBN
         kUYZJmc0vtFXl1Aiez6iAlimvqx+nGvINDxZ9UMr7a0QYjGnDQcH5NkCXUbVXgifvr+w
         XHVtv+0w/AgsfjOKkSKvGyH3tDfWmPs6RM84B/DC8D/Lqv1fgDjJZQXB/7NF72Omnh2i
         rzJA==
X-Gm-Message-State: AOAM533kPpl8tl8cW4O6ABEkSWY0kwqoDvmBpv8qZEjUAIhq2b5/VPcW
        Q/CS19uYOXe/lWPvdHGEdj4CYWuhjg0=
X-Google-Smtp-Source: ABdhPJxi6cCeoZUGakmmKDUZJree35PqSHDcLSXpyvVDrIhXMhK73VXGKtwuk1iS1tJB82PHNylCCA==
X-Received: by 2002:a17:906:2885:b0:711:4611:95cc with SMTP id o5-20020a170906288500b00711461195ccmr25270175ejd.38.1654797902647;
        Thu, 09 Jun 2022 11:05:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060f8600b00711edab7622sm3473826ejj.40.2022.06.09.11.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:05:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzMWj-0031dN-GB;
        Thu, 09 Jun 2022 20:05:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] connected: distinguish local/remote bad objects
Date:   Thu, 09 Jun 2022 20:00:05 +0200
References: <20220608210537.185094-1-jonathantanmy@google.com>
 <xmqqwndpn5dz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwndpn5dz.fsf@gitster.g>
Message-ID: <220609.86zgilsofm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 09 2022, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>  builtin/fetch.c              |  2 +-
>>  connected.c                  |  1 +
>>  revision.c                   | 16 ++++++++++++--
>>  revision.h                   |  3 +++
>>  t/t5518-fetch-exit-status.sh | 43 ++++++++++++++++++++++++++++++++++++
>>  5 files changed, 62 insertions(+), 3 deletions(-)
>
> This seems to break linux-leaks CI job by making 5518, which was
> marked in some topic in flight to expect to be leak-free, fail.
>
> Because of the way linux-leaks test framework is done, it is not
> easy to tell if the code changes essential to this topic introduced
> new leaks, in which case we would want to fix that.

I think this is just an existing leak that happens to be exposed by a
new (in this file) test, i.e. transport_get() leaks via an xmalloc() for
transport_helper.

> Note that this may not the fault of the code changes in this patch.
> If the tests added by the patch started using git commands that are
> known to leak (i.e. not ready to be subjected to the "leaks" test)
> in order to prepare the scenario or to inspect the result, even if
> the code changes in this topic did not introduce any leak, we can
> see the same breakage in linux-leaks CI job.  An easy way out would
> be to disable leak-check CI for the entire 5518, but that is not
> very satisfactory, as the earlier part of that script should still
> be leak-free.

I think doing that would be fine in this case. It will get easier to fix
leaks now that "struct rev_info" is out of the way (and I've got a lot
of pending patches), but I can always loop back & re-mark this
particular test as leak-free at some future date.

> Another way out might be to add these two tests in a
> new script, which is not marked as not-leaking.  After all, what the
> new topic adds is not about exit status but how that exit status
> comes about, so it might not be a bad idea even without the CI leak
> stuff anyway.

Yeah, that sounds especially good in this case, as if we can't run httpd
we'll print a meaningful "skip" message in that case. See 0a2bfccb9c8
(t0051: use "skip_all" under !MINGW in single-test file, 2022-02-04)

> =C3=86var, does the internal state used for revision walking count as
> leaking when it is still held by the time we hit die() in
> bad_object(), or anything on stack when we die() are still reachable
> and won't be reported as a failure?

No, but in this case the variable containing the leaked data isn't in
scope by the time we exit, i.e. it was used by fetch_one() which had it
malloc'd, but the struct it lived in went away, and now we're exiting
from cmd_fetch() etc.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E35C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D0D23A9C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 13:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLRNm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLRNmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 08:42:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA6C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 05:41:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o13so5546069lfr.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uQNQLOT/7DtmvMnJHvK17MwonqFlDXDO7s11pssY9SA=;
        b=uHe/iu173FEh01X4d6ysN0mbg+pJ2P6W9qeFGyyMpSaakPawNUsVeaeTENv8zOUdZj
         PPBfxS2qKbERLjb0J3A15QCslYjel8cKqDbOhG1p6BSHQiAo9of9TIRVGnMFX++f/o5a
         U3MShGmRFBimRLxCzlfCeb2DRIwf637BrFtFZ9Eq/c3Ck+8tMD2VURjwxAFOgIzyhr5G
         BrIbkTHrxhS/gkolUZlQ6It0ToK1E4UYj3vIKIfG+ItsXhRqjL9ZvCWBQbOBJU+qcjS/
         oBDctANt6CL9sUe3Fn32ALuFOyfT4HEZdTXpO2J7JYDLa4pjnujEkz0SLi71YOTVxrCE
         PIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uQNQLOT/7DtmvMnJHvK17MwonqFlDXDO7s11pssY9SA=;
        b=CmnqMXLt1o3VmvHhv2+L9xFbiVSNJ0QsntYugGtNqpxzJw/Rcl6a2ZJU124OfSvAeG
         P5jDaldoOlIbpOt2vHsauu/EaqWBGLtj/9Zwj51k10JdshYufdUk7ORSSAm6dVHs318F
         KP/1G0QmkiF6FzqKnHW/dETjZnhuI1az2X+v9AGxQMKebyH3cecntgcZ+CIqUdcmMISg
         kSi0nm8tsvQJdTQDM+fPd5/R1iTLOdt/9QM9L8p6tl8dqYqKzp1s+WPcW5kqIWd6RVCI
         Wd5fMHISiZwEPuzJbtsHli7B05HXTiPJ5eGLdNMHz8aAZ5YDCiSQrvPZG3MluIDxbFgs
         0msg==
X-Gm-Message-State: AOAM531s7NqEVXZ9BLEpxCwvSSzwofTYl4pLlKjMpT1/DFHoYjXeyR5n
        Y+YBShrUymzaB9DdIn19dkjFx0L5JBE=
X-Google-Smtp-Source: ABdhPJwN2OhvT/mKQF0a1qv6SJ/Ze3WfVPGbEVYjaUTduusBXZXEd2OzoXxKLzpESIppLAB2zKT3hw==
X-Received: by 2002:ac2:4a62:: with SMTP id q2mr1446119lfp.188.1608298903444;
        Fri, 18 Dec 2020 05:41:43 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w24sm931531lfl.199.2020.12.18.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 05:41:42 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-24-sorganov@gmail.com>
        <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
Date:   Fri, 18 Dec 2020 16:41:41 +0300
In-Reply-To: <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 21:42:03 -0800")
Message-ID: <87blercju2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Put open curly brace on its own line
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  diff-merges.c | 36 ++++++++++++++++++++++++------------
>>  1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/diff-merges.c b/diff-merges.c
>> index cba391604ac7..0165fa22fcd1 100644
>> --- a/diff-merges.c
>> +++ b/diff-merges.c
>> @@ -2,7 +2,8 @@
>>

[...]

>>
>> -void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
>> +void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
>> +{
>>         if (!revs->combine_merges)
>>                 set_dense_combined(revs);
>>  }
>> --
>> 2.25.1
>>
>
> But...didn't you add all these functions yourself earlier in the
> series?

Yes, I did indeed and somehow picked wrong style from one of the
occurrences of this style in the existing Git codebase.

> Why didn't you split this patch up and squash it into the
> relevant previous patches?

When Junio noticed and pointed to this deficiency, I asked him if I
should fix all the series from the start, or it'd be OK to use fixup
commit. As he didn't answer and nobody else commented either, I opted
for the latter.

I can still do it if it's that essential, but I'd prefer not to, to
avoid both the hand-work and causing entire series to change. The
problem is that there were code movements in the series, so such a fix
to earlier patches would cause conflicts down the commits chain, to be
resolved by hand.

Thanks,
-- Sergey

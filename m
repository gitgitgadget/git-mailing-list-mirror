Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E49C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8293B61107
	for <git@archiver.kernel.org>; Sat, 29 May 2021 16:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE2RB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2RB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 13:01:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C3C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 09:59:48 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y76so7628260oia.6
        for <git@vger.kernel.org>; Sat, 29 May 2021 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TCJnRS4Oan4R3ifLvaAP3h0U/Itl/uPQ/cq9JqFO400=;
        b=QwNu/bVSm3KJSl9rhiD9bg0RvlGBkX3MN8LZsgP8bBwTi/uXu0cg8HnoldWcf2ku/M
         EslmiigyNhzp9Z901wOAWSAvHIE4D9ovmMfdRXCvDjGEJiznH9NiPqT2cZE37WDqZD+v
         gjd3CKCYlCpG+Ko4a4DHfAkOGWT0x9z/m+86MBo3IEDKhg2h87V35S9YJH8N4nifneKI
         NYGjH8IiJHN2lRD19N2g7Ca2bdMBo891XGsLuHVE/+FkASXlyGJcXvoVR8gY1iFsazWn
         XCpw7in/fF1xz1BElonMmqsLMRPGqyHTj5I5WJoOl7QyF+6KaXmc7/NQo0/sZpOe9v72
         558g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TCJnRS4Oan4R3ifLvaAP3h0U/Itl/uPQ/cq9JqFO400=;
        b=kt7/umkNtVQrUIfqTzmh1aXHzWz2RU9b6/AunxfSzXBpI2kENk75K6Ttb+5lRDo8R8
         6I/MVUxQ86td4R2DdOG1d3ke8Ba8b/hdRPr3e60L75dn5+VQR7DJ5l4KbUiM7LHgpbeg
         hvSoizJ3QiPL+BqGRT87XtdBq3+33pR87Re60umFYjSZKTkwIeQcGBw9aPEcby2e21P3
         cDDnxNbgI7j1Pbv4tWBVOc4W5yOzQq5tzYtPYFgdJJmrm6jt+WPIK136fHylYsjMPa0+
         VawU6qdirYoVL6pxv3Gt0ZgsrJLL8eFspVNWx+8YD5xQfDvyAZLk3W2GuN/qUoOIPHBR
         TvlA==
X-Gm-Message-State: AOAM5324QBtNJbcE+Wsu/HZ+B6FleSPQUlsJvzBroofmf8ha9Ef+FkFz
        IUBj3tIH69qQaVK14KoMcNU=
X-Google-Smtp-Source: ABdhPJy1oAHEQ4L5AYuzF2iR4UF2jA7IgqC9Ww1+nePyVxcFRQfaBtj5ZqSUf0rWgJv2B8D7d0r7Kw==
X-Received: by 2002:aca:2818:: with SMTP id 24mr9151649oix.67.1622307588191;
        Sat, 29 May 2021 09:59:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k18sm2047552otj.42.2021.05.29.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 09:59:47 -0700 (PDT)
Date:   Sat, 29 May 2021 11:59:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Message-ID: <60b272ff6bfa4_265861208d6@natae.notmuch>
In-Reply-To: <20210528214024.vw4huojcklrm6d27@pengutronix.de>
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
 <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de>
 <CABPp-BEVME5Gx=F4HWHBb_0wn6XJF==DzVLo2i1xj63BB+_jtw@mail.gmail.com>
 <20210528214024.vw4huojcklrm6d27@pengutronix.de>
Subject: Re: time needed to rebase shortend by using --onto?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-K=C3=B6nig wrote:
> I do the rebase now once before the timing for the reasons described in=

> the comment. The second identical command is quite a bit quicker. Also
> now that the commands are scripted they are done in a smaller time fram=
e
> (which matters as the machine is used heavily among my colleagues and
> me). I run the script a few times in a row, after all colleagues are in=

> their week-end:
> =

> 	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck =

> 	...
> 	rebase v5.10
> 	...
> 	real	1m13.579s
> 	user	1m2.919s
> 	sys	0m6.220s
> 	...
> 	rebase --onto v5.10 v5.4
> 	...
> 	real	1m2.852s
> 	user	0m53.780s
> 	sys	0m6.225s
> =

> 	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck =

> 	...
> 	rebase v5.10
> 	...
> 	real	1m10.816s
> 	user	1m3.344s
> 	sys	0m6.991s
> 	...
> 	rebase --onto v5.10 v5.4
> 	...
> 	real	0m59.695s
> 	user	0m53.510s
> 	sys	0m5.579s
> =

> 	ukl@dude.ptx:~/gsrc/linux$ bash rebasecheck =

> 	...
> 	rebase v5.10
> 	...
> 	real	1m9.688s
> 	user	1m3.346s
> 	sys	0m6.105s
> 	...
> 	rebase --onto v5.10 v5.4
> 	...
> 	real	0m59.981s
> 	user	0m52.931s
> 	sys	0m6.282s
> =

> So it's not a factor 2 any more, but still reproducibly quicker when
> --onto is used.

Years ago I completely rewrote `git rebase` to use `git cherry-pick`,
and the result is a very simple command:

  git checkout $onto
  git cherry-pick --no-merges --right-only --topo-order --do-walk
    @{upstream}..v5.4

The difference when you don't specify --onto is basically that both onto
and upstream are considered the same:

  git checkout $onto
  git cherry-pick --no-merges --right-only --topo-order --do-walk
    $onto..v5.4

Therefore it should be more efficient to specify --onto.

Except git tries to be smart and first tries to check if a fast-forward
is possible, even if you specify --no-ff (a mistake IMO).

To check for linear history the old code used to do:

  git rev-list --parents $onto..v5.4 | grep " .* "

Maybe that is too slow in your particular situation.

You could try --restrict-revisions=3Dv5.10 (or anything other than the
merge base), but apparently that only works with --interactive.

Another option is just hack git to disable the linear history check:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..bdbcfaa58e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1145,6 +1145,10 @@ static int can_fast_forward(struct commit *onto, s=
truct commit *upstream,
        }
 =

        oidcpy(merge_base, &merge_bases->item->object.oid);
+
+       /* Hack to avoid linear history check */
+       goto done;
+
        if (!oideq(merge_base, &onto->object.oid))
                goto done;
 =


Cheers.

-- =

Felipe Contreras=

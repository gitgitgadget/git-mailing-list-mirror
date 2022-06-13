Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D371C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 23:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiFMXB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348817AbiFMW66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:58:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D717E29
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:58:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b8so9173486edj.11
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7hkiw6xYi+WACz5jiKli4ahmU1ga+284ebQEyO9QfpI=;
        b=IoQj/0bRokr6kmz4/AUcA3h3i9VqRmjrgFVtFQX74D+e5UYIzA/gLPQ6AL+nBA15sU
         VNqg/yWJYsYd99lUX4Grc/bpwjUmQHJ0UkC5+tfU54b8+9Cu8SKEotopK5fTsYpWW+vK
         qqh7mT2dnhiWQrhTq/CUFeeohE5qh3EFa/rNJ7/KbPFgWw8spgvbtvfi7FwFeHAXpC1g
         ZRuODywRkSGpoGzdtoQCmVsvoPcUoEY+86delo6/5JLrXOYSYEMk4ckYadDoFqZiZAxI
         M3JNaZNOKv+vcPSWJUHpkT2E+0G/59cQczvOM9Ig1WUnlr5YAJAcBpGLpjtBgz2qgIDY
         wCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7hkiw6xYi+WACz5jiKli4ahmU1ga+284ebQEyO9QfpI=;
        b=D66WxHTPGCSaijw/Fa/cIBWqEsguACOJae3XlDMZfhNB8N0iyBVr3eAZ6SNNpgAZ7/
         GEoeJtRIDvQToHndhNSTAlqvodM++4zB0bwBqfexrFXc/gQuWIqwqhRhCHOnxqrpBlTD
         b9Bne2u/7aG/je0YNxCbmzormtgGBOjRsTeZfIfxNjkTjf5EWecnmRpyBLIT90Va7xtC
         vzCxc3imeslhjOVztmO1MN8UFx7EC6+e8QOhzHSyrT4mswnBBUxbSIu8Gzz7vwQhH0aE
         EWyoAHCt6blLhk+AImUGJ9kEqtOI3rcqfSFOV1kzI6eW9me0i1Xh5R/Fa+KQoDdaFUwa
         /mSA==
X-Gm-Message-State: AOAM533xzyHSfddnyb6gURizqdaVEMGMw+80g/9n5pqn5+MYH/0X+Bvj
        zUoovk4MCHCZHDDEq89SsFVRTR96xoj2NQ==
X-Google-Smtp-Source: ABdhPJy3aJaIs0O5fwm1PKRWVl9Ax8k7ETWrS4NocUOW3mKU5tp8+DXSN1dmbUHigKbHC3MEzmY1CQ==
X-Received: by 2002:a05:6402:2892:b0:42d:c871:78f4 with SMTP id eg18-20020a056402289200b0042dc87178f4mr2416222edb.192.1655161135657;
        Mon, 13 Jun 2022 15:58:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p3-20020a50c943000000b0042bcf1e0060sm5723719edh.65.2022.06.13.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:58:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0t1K-000G7f-Hn;
        Tue, 14 Jun 2022 00:58:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] ci(GitHub): mark up compile errors, too
Date:   Tue, 14 Jun 2022 00:41:28 +0200
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
 <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
Message-ID: <220614.86tu8oyxu9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 13 2022, Johannes Schindelin via GitGitGadget wrote:

> Just like we mark up test failures, it makes sense to mark up compile
> errors, too.
>
> In a sense, it makes even more sense with compile errors than with test
> failures because we can link directly to the corresponding source code in
> the former case (if said code has been touched by the Pull Request, that
> is). The only downside is that this link currently is kind of misleading =
if
> the Pull Request did not even touch the offending source code (such as was
> the case when a GCC upgrade in Git for Windows' SDK all of a sudden point=
ed
> out problems in the source code that had existed for a long time already).
> We will see how the GitHub Actions engineers will develop this feature
> further.
>
> This patch series is based on js/ci-github-workflow-markup. Which also
> serves as an example how this looks like if the offending source code was
> not touched by the Pull Request:
> https://github.com/dscho/git/actions/runs/2477526645 because it still
> triggers the above-referenced GCC build failure.
>
> Changes since v1:
>
>  * Using a comma in the workflow command now, as described in the official
>    documentation ;-) (Thank you, =C3=86var)

You're welcome!

>  * The curly bracket construct was replaced by a proper subshell, to avoid
>    jumbled output and a race where the exit.status file could be read bef=
ore
>    it was written.
>
> Johannes Schindelin (2):
>   ci(github): use grouping also in the `win-build` job
>   ci(github): also mark up compile errors

It's still genuinely unclear to me what exactly the expected
before/after result is, and I wish the 2/2 commit would discuss it.

So, in v1 we had this: https://github.com/gitgitgadget/git/actions/runs/246=
1737185

Where the *summary* for the CI said e.g. "syslog.c line=3D53#L1", so that
was the "needs a comma" bug, now it says syslog.c#L53 instead:
https://github.com/dscho/git/actions/runs/2477526645 (your link
above). So that's good.

But re my earlier comment where I asked/wondered if fixing that would
link to the source file at line 53 it still seems to just link to the
diff.

Is that a bug? The desired result? If the commit was modifying syslog.c
would the link work?

Clearly an end result where we link to the source file/lines at the rev
we're testing is much more useful.

I found this discussion:
https://github.community/t/are-github-actions-notice-warning-error-annotati=
ons-broken/225674

Which has a link to an example run at:
https://github.com/IronTooch-ColdStorage/Github-AnnotationTest/actions/runs=
/1782265048

So isn't this for creating "annotations" for just the regions that would
be involved in your diff? I.e. it shows a notice for the line(s)
involved in the diff itself, but presumably nothing else?

If that's the case I think it would be much more useful to just
e.g. wrap $(CC) in some "tee"-like command to spew its output somewhere,
and then have a "step" where we extract the warnings/errors emitted, and
emit URLs you could click on, unless there's some way to make the GitHub
UX emit the same information.

I.e. it'll be quite hit & miss whether the annotation will show up in
the diff, the compiler will often warn about a line some distance away
from the change made, e.g. if a variable is made unused.

Unless the intent is only to aggregate them on the summary page, but
then why do we need to link to the "line" at all, which will at best
work unreliably, and at worst be actively misleading.

In any case, needing to do less reading of the tea leaves would be nice,
i.e. if the commit message explain what the desired change is exactly,
and how it should be handling these cases.

Thanks.

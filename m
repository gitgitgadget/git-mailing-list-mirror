Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B77C4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLGMeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLGMeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:34:13 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A84FF95
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:33:48 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso2600208ooo.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 04:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNtmdcXkg54K/G5hXVCyezwJSHRrqB+BqIrgyhLpN68=;
        b=Xr6qqVYeOYP4MJuxKtK4JUWhwyCCcllen/rcscprCrlUFvOWoV8DfzATWbMSzw6HMN
         lczld4cUwJeJO3s/b28g2PNaGuNiez4rrDjGbdVn2u9yF6XUsLtFjng5uRNrhivx5vu8
         UrkuqsFffWf0A2GUUKCzj0nnKmpE0qN7B8U/K6oNZVuRzieISq5IRyUYScWjY8vn/DvC
         +IjFQmWKg8glQaYAHwWD1/JGcxt106ZxG5czxfVRcUSHG0qYk0hMMB0c52murmKutvCN
         m9uat/n+Z4SIKDjsTRUzDmHPuojJ4jJJwHslhd/kizP9IAHguoGQRJGKLux32vOcVQmL
         EAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNtmdcXkg54K/G5hXVCyezwJSHRrqB+BqIrgyhLpN68=;
        b=ethZAg12LU0Oal/aHR7ZxFlLWIXDXjE9asSevpgW1yfq5nH1jbsM+c03h6F1MopZcC
         0MT9caLMyaFJcol0jDKTo4cpudio/7/wwVCIXQ3KubnQXIb8zuANs5ghZx++yz0kHtHN
         qwpyTSsCs4S3e5lPZwXdLqMWpRxqWFAZihOZDpaoMX1xrPsil3hyofwMxg6ys1aFPbMw
         vRxysy9mYazrmin3HBoYqReU0UxsyBE1tFagjEmVSbeB/bxhIsBFU7kZowZ68zDddQtP
         jE9QwnOFeZyBx+5rrLKpNBrY4cE11zrmaVyGHaMIciYT2HJlNhDsMZ1IvYqR+DOZ0Rt3
         jf5A==
X-Gm-Message-State: ANoB5plbO4a2aKjrZanL3x0jNJTRn8jR6yPi2ToGkoMOl62cb3A+kiu8
        IN7qvSy4eNHGAvpzXy2Sc0m+iM+iJy+oI6CSybc=
X-Google-Smtp-Source: AA0mqf6phd4QU8IO6cYRu48Ylzr4SLhEQ725D1GVTMzdCn3ROTHClNe9nxbIa+I4fQlXnkfiRbucZsQTEDjwIIvlFHE=
X-Received: by 2002:a05:6820:1887:b0:4a0:7481:2bd2 with SMTP id
 bm7-20020a056820188700b004a074812bd2mr14335369oob.14.1670416428151; Wed, 07
 Dec 2022 04:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g> <221207.86lenja0zi.gmgdl@evledraar.gmail.com>
In-Reply-To: <221207.86lenja0zi.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 7 Dec 2022 13:33:22 +0100
Message-ID: <CAOLa=ZQua8TfApCdzoK06_2fkWb4ZCfWewXKOSaXno1fqFSq2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2022 at 12:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Dec 07 2022, Junio C Hamano wrote:
>
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> >> Add a new flag `--revision`/`-r` which will allow it work with
> >> revisions. This command will now, instead of checking the files/index,
> >> try and receive the blob for the given attribute file against the
> >> provided revision. The flag overrides checking against the index and
> >> filesystem and also works with bare repositories.
> >
> > As "check-attr" was not invented as a user-facing subcommand but was
> > a hack for debugging, I would have minded this change, but these
> > days people seem to treat it as if it is just one of the proper
> > plumbing commands, the new command line convention bothers me a
> > bit.  No other command uses --<anything> to signal that what comes
> > after it is a rev.
> >
> > But I do not think of a better alternative without making the
> > command line ambiguous, so I'll stop at raising a concern, so that
> > others who may be better at UI can come up with one.
>
> I don't really like it either, but maybe we've backed ourselves into a
> corner here.
>
> But let's look at that. So the command takes:
>
>         git check-attr <attr>... -- <path>...
>
> Or:
>
>         echo "<path>" |
>         git check-attr --stdin <attr>...
>
> So we'd want to specify a <revision>, without making the <attr> or
> <path> ambiguous.
>
> Now, when we map the attributes we go through attr_name_valid(), which
> checks that the attribute names are valid. A commentthere says:
>
>          * Attribute name cannot begin with '-' and must consist of
>          * characters from [-A-Za-z0-9_.].
>
> So can't we instead accept:
>
>         git check-attr [<rev>:]<attr>... -- <path>...
>
> I.e.:
>
>         git check-attr HEAD~:foo -- path
>
> And it wouldn't be ambiguous because attribute names can't contain ":"?
> This would be consistent with e.g. "git show" and "git cat-file", just
> with "<attr>" instead of the "<path>".
>
> This would also mean that we'd support:
>
>         git check-attr HEAD:foo HEAD~:bar HEAD~2:baz
>
> etc., i.e. the ability to support multiple revision/attribute
> pairs. Skimming the currently proposed code there seems to be no good
> reason not to support that (we just need to look up other blobs), and it
> would allow querying those without spawning N processes.

Thanks for this walkthrough, quick question, this wouldn't work with
the `-a` condition, right?
Current patch series tends to work with/without `-a`.

Also, my personal opinion is that when being consistent we need to be fully
consistent, i.e. <revision>:<path>, tweaking this slightly to be
<revision>:<attr> is
worse than breaking consistency.

--=20
- Karthik

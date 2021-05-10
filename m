Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F0C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BD2610F8
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhEJMwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbhEJMOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 08:14:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EAC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:13:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so24170585ejc.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AgXYSCIq2zVU3HCBDri/2oPwNd7VD7BqtkXjdekzu4U=;
        b=Wgbr1op/+H+K3PY16LNx1gUfVuxjiayiQYHyrwgQ3vtQTaGAJh/C0NQzyFI3jDWbVH
         1zFPkiYcak3FQWt15vDTzv3VLwuZWmWCzXMSKVTZ682SRxuPXT9znyeDCsHUcuiWHqjS
         tfjqFNGpHgFD7PTnG82bEfGv4II9KOiUP4Eq7TzfmdiNqH2+SXmNqD5MUZhkl8R0VHH8
         LNMduptPVp18CM0PGxIfqfhOATBYLgc3Xxxrc3vJw4kZRfMLvt/Om8zHJFUmLX9ZeLkc
         CDr3Ru6Qm3faHWHB6DjwXQT6xa9X1YagFOpaug1FguvYfdY034Dm17s2u/rg5183H/Wx
         Zekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AgXYSCIq2zVU3HCBDri/2oPwNd7VD7BqtkXjdekzu4U=;
        b=g7GaBjLuQSQ8JmbUZvsy4PcCIbseiMvbk9g8qkeQ2YVmJl2mreIQGOc3mLL8brx1Ln
         YfPaynYc244/72/Fa0GVQxLaIVVP+4TzKNf3et9upP15JKxR21IkdtPINTZdyE8QQ4Kx
         gXAsAtcim6/XsbHAV5a4DQLkCutaX9sVdAM9XXiSKMWJjVIPqYDEcW3AMS3TtZNRHpHM
         grutkYBUebySms+tstwyH5I+HR55qhSaeNxrP1T4G8jVA1XA3jCoxCJ+Je7GqY0GJbud
         nV3KoZYJ/3mW5D26i0URCilaGkghQyB3hc1Vr56QX7BOahs/CcH/sJ4SpKT6dfR56D2C
         dNZQ==
X-Gm-Message-State: AOAM531cSNadu5gzl+JOjXJxsYUs7vtesdFsdA0UgLTXjjEok+EW98zT
        r2YzHysEgcGqk8I5egnaqqWkcMJDomUiDw==
X-Google-Smtp-Source: ABdhPJzQMj9OhSC3iojNxxI4ccHF4IsXTckbHh3SWOPc7TpmsxQ8DNwst1tOx126VMOXYZmSrQFbPQ==
X-Received: by 2002:a17:907:7ba5:: with SMTP id ne37mr25580026ejc.113.1620648820269;
        Mon, 10 May 2021 05:13:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w2sm9267649edl.53.2021.05.10.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:13:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Date:   Mon, 10 May 2021 14:02:19 +0200
References: <20210506165102.123739-1-firminmartin24@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210506165102.123739-1-firminmartin24@gmail.com>
Message-ID: <87r1ieu6q4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Firmin Martin wrote:

> BACKGROUND
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently, git-format-patch, along with the option --cover-letter,
> unconditionally overwrites a cover letter with the same name (if
> present). Although this is a desired behaviour for patches which are
> auto-generated from Git commits log, it might not be the case for a
> cover letter whose the content is meticulously written manually.
>
> Particulary, this behaviour could be awkward in the following
> hypothetical situations:
>
> * The user can easily erase a cover letter coming from prior versions or
> another patch series by reusing an old command line (e.g. autocompleted
> from the shell history).
>
> * Assuming that the user is writing a cover letter and realizes that
> small changes should be made. They make the change, amend and
> format-patch again to regenerate patches. If it happens that they use
> the same command again (e.g. with --cover-letter), the cover letter
> being written is gone.
>
> This patch series addresses this kind of issue by asking confirmation
> from the user whenever a cover letter or a patch is subject to be
> overwritten.

I like the goal here, I'm another person with ad-hoc tooling around
format-patch to manage / avoid this particular scenario and related
issues (e.g. I have a wrapper to rm -rf the output directory & re-crete
it, in case I want to rebase but use the same -vN version).

I wonder if you've considered some ways to automatically and more gently
detect these cases, such as:

 1. When we generate the patch, set the mtime manually to the time in
    the commit object. When clobbering a file see if they correspond. If
    mtime !=3D expected =3D> *boom* and ask for confirmation.

 2. We already include a blurb like "2.31.1.838.g7ac6e98bb53" (the git
    version) if you have format.signature set. How about making that
    include a short hash of the preceding lines. If it doesn't match we
    can ask, but if it does we clobber.

    This has the added benefit that other could script their MUAs to
    highlight manually edited patches.

 3. Ditto #2 but generate the new file in a tempfile, diff them, if
    they're different complain. This also opens the door to make this
    neatly integrate with git-diff's -I option, so you could specify
    regexes to ignore. By default we could ignore lines that change
    known headers we expect to change.

 4. The format we output would need parsing, but it's not that
    hard. I.e. we expect something like:

        [...]=20=20=20=20=20=20=20=20
        Subject: [PATCH 0/1] *** SUBJECT HERE ***
        MIME-Version: 1.0
        Content-Type: text/plain; charset=3DUTF-8
        Content-Transfer-Encoding: 8bit
=20=20=20=20=20=20=20=20
        *** BLURB HERE ***
=20=20=20=20=20=20=20=20
        =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
        [...]


    And similarly for patches we could narrow things to look between the
    "---" and an expected diffstat. So we could complain just about
    changes there.

    But maybe that's a fool's errand, e.g. it would be hard to catch
    manually commented-on range-diffs without implementing a full parser
    for that format...

None of these suggestions should be read as making perfect the enemy of
the good. I *do* rely on the behavior of the setting you're introducing
and "breaking", but I think the user-base of advanced format-patch users
is small enough that we could just configure things to "never" and move
on, but accidentally losing data (as happens now) is a worse default...

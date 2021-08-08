Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C386C4320A
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53671600CD
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHHSWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHSWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 14:22:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D78C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 11:21:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a8001b029017700de3903so17241924pjn.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0KujHxmSYr13mpd5zAbpQBGvxYfbKWKkDKUV6sEYlY=;
        b=L9pFj9f9MVzE8LXaOeEIGsjgqW9vkf/z0vP9WyOJ+0Z7Au+tzlSgqTxgUoc7STF/tl
         4BgXUL3xL0u2/slKpFSciP+CASc2cnpaG+8crEvfDZBCPZDgnL8OZE411I5GIc0fGSfI
         lkCmlZICyIfWvvWZE3i0bGDkTV1K9PMa6AihpTr6z82D8j9/PuFKW4E/xWjpUFnNoVP1
         5sTMgmvddWAZsXdejauJEzEBaNF9LRXfpNm2bOpUjUMWUqto212VxiCH0d+bCMkCfeO/
         QhXxQIS+KQB4hDCdzTO14J7s21ZO8Qg3AGwV2uNgp6/ELHVl/x4eFJ0KBX0r8rFyo6Tr
         W8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0KujHxmSYr13mpd5zAbpQBGvxYfbKWKkDKUV6sEYlY=;
        b=RL7E+y3D/0vaSdsbsOrNmYtlhN8YTzpJdEiRbJXJM7V1E4zrPh1bJkBF+g8I5huDii
         /OUjmPm3q8GBKVTmy3RRxvGPXPbRiuS4ipvFHiyMQNqcE0rXwOBJUXgCHPZQgW2ecYYU
         KartSlYHkd+FDY7E5tGN+HppBPgtSJ1HkZNF2fguGznK8nOgQ0qF+nc4ZdWLItv7rrQk
         XimEtoCpp1y/yT36wYA1TtapjkTZML4R1iQrppUtfROy7UX+7iZGfSNgoOPW+i7yj7dX
         +UJW4G9XlOCb1HOcVrqbDq1owNvcomboQDKW/oQiFKr7pR4VgNfbpsYgbhC6IB/ClK2B
         Q6Lg==
X-Gm-Message-State: AOAM53218AQRDpp7rN4toi1gUEiXz2GA59Qosl/hvDeLNMG28r8YttjS
        jd1QSKWv6B60ipg8BRfQq3hSQtFKHw6tqfvi33Q=
X-Google-Smtp-Source: ABdhPJwkqrKfyn+qlAgzj4+3ARQuyAfHoQR04VP1WKydrdOHvVsymC2hT2d51qysQ++HF8NJYbptpF3SdSiyWFUmAls=
X-Received: by 2002:a17:90a:cf94:: with SMTP id i20mr30682352pju.219.1628446915400;
 Sun, 08 Aug 2021 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
 <xmqqr1f5hszw.fsf@gitster.g> <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
 <xmqqtuk0h4ph.fsf@gitster.g> <xmqqim0fhlm1.fsf@gitster.g>
In-Reply-To: <xmqqim0fhlm1.fsf@gitster.g>
From:   Noah Pendleton <noah.pendleton@gmail.com>
Date:   Sun, 8 Aug 2021 14:21:44 -0400
Message-ID: <CADm0i39LV91kochHSGVHovaTbDOd0COrQPXHD3x8rEj-1Y+eMA@mail.gmail.com>
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Very good point- I see about 21 call sites for `git_config_pathname`,
plus a few others (`git_config_get_pathname`) that bottom out in the
same function. I could see the utility of optional paths for some of
them: for example, `commit.template`, `core.excludesfile`. Some of the
others seem a little more ambiguous, eg `http.sslcert` probably wants
to always fail in case of missing file.

There seems to be a mix of fail-hard on invalid paths, printing a
warning message and skipping, and silently ignoring.

Hard for me to predict what the least confusing behavior is around
path configuration values, though, so maybe adding support for the
`:(optional)` (and maybe additionally a `:(required)`) tag across the
board to pathname configs is the right move.

That patch might be beyond what I'm capable of, though I'm happy to
put up a draft that applies it to the original `ignoreRevsFile` case
as a starting point.

On Sun, Aug 8, 2021 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I think an easier way out is to introduce a new configuration
> > variable blame.ignoreRevsFileIsOptional which takes a boolean value,
> > and when it is set to true, silently ignore when the named file does
> > not exist without any warning.  When the variable is set to false
> > (or the variable does not exist), we can keep the current behaviour
> > of noticing a misconfigured blame.ignoreRevsFile and error out.
> >
> > That way, the current users who rely on the typo detection feature
> > can keep relying on it, and those who want to make it optional can
> > do so without getting annoyed by a warning.
>
> A bit more ambitious might want to consider another more generally
> applicable avenue, which would help the userbase a lot more, before
> continuing.
>
> We start from the realization that this is not the only
> configuration variable that specifies a filename that could be
> missing.  There may be other variables that name files to be used
> ("git config --help" would hopefully be the most comprehensive, but
> "git grep -e git_config_pathname \*.c" would give us quicker
> starting point to gauge how big an impact to the system we would be
> talking about).
>
> What do the codepaths that use these variables do when they find
> that the named files are missing?  Do some of them die, some
> others just warn, and yet some others silently ignore?  Would such
> an inconsistency hurt our users?
>
> Among the ones that die, are there ones that could reasonably
> continue as if the configuration variable weren't there and no file
> was specified (i.e. similar to what you want blame.ignoreRevsFile to
> do)?  Among the ones that are silently ignored, are there ones that
> may benefit by having a typo-detection?  Do all of them benefit if
> the behaviour upon missing files can be configurable by the end-user?
>
> Depending on the answers to the above questions, it might be that it
> is not a desirable approach to add "blame.ignoreRevsFileIsOptional"
> configuration variable, as all the existing configuration variables
> that name files would want to add their own.  We might be better off
> inventing a syntax for the value of blame.ignoreRevsFile (and other
> variables that name files) to mark if the file is optional (i.e.
> silently ignore if the named file does not exist) or required (i.e.
> diagnose as a configuration error).  For example, we may borrow from
> the "magic" syntax for pathspecs that begin with ":(", with comma
> separated "magic" keywords and ends with ")" and specify optional
> pathname configuration like so:
>
>     [blame] ignoreRevsFile = :(optional).gitignorerevs
>
> and teach the config parser to pretend as if it saw nothing when it
> notices that the named file is missing.  That approach would cover
> not just this single variable, but other variables that are parsed
> using git_config_pathname() may benefit the same way (of course, the
> callsites for git_config_pathmame() must be inspected and adjusted
> for this to happen).
>
> Thanks.
>

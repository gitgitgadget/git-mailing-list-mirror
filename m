Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE1C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6EE207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVz6961f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgAMRrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:47:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37342 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMRrf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 12:47:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so9762333otn.4
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6PUY9jenulJcyt4Edylb9hwqisiDw5jtvKurRd4siI=;
        b=QVz6961fjA5MCjHAIbL8U5PiOZbSvOwIr04ZZ6XMwf69lGgy/+rCqdPSO1iGXCigt7
         qlHRpMgKpkjQ0iA+t53VYI6fDi1+20ja+lU8CiRoQibnsZRqsxr7zVzOoHZKFtLJRrGr
         RnddoO5IPaHHUYxS2w3rCHPtDHBMSkEqszBgtt81l7YxkSDu/ODtW5H5Fob8Za9ywc2P
         gsZXfs1+nDtwnT5yODvkz3VA75t8sOJc7uBCfgIB2TtsPJuVq3pHO4wMtwRmQ0pC+3pL
         e6HokV1OPwvxB6KWJXu89bDaoTpGKia9I3eflhlKII1KrcOPH45MCOGjlQckFXEm3fCA
         AQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6PUY9jenulJcyt4Edylb9hwqisiDw5jtvKurRd4siI=;
        b=kG/wPSVRnpIwP4c6mF5MnHaC6lBk9AO6OOozkcL4NV3KcwfCvHZQmhIgfhWxLLKQtK
         Vvs74HyEXlnJ1z/6vUE+h1LKn0tiWMqp/z8Q3jBqPdf9SMb/XCXt00rFwbHyNXh8ftnT
         qPOiFCV5DMxpzF5qDfcP8y47VmnqmbMJzTB8C3ED9Ghc4ax5fp2wOSjGhFBfcdNTCDQP
         1bXFGgCt2dhI0VSCxfvTr91KeS4pzxMKnI7CQSskmk0SrwoRSKx8HtxZLiyT2NUBdVZ0
         z7gWpRs3D00JomWRxsueyQggyxGEf3HJf6OVmI6PM6mjBAl1DfZCRyfApWsildxNICFl
         f2RQ==
X-Gm-Message-State: APjAAAUr5/Rrd3vS3VXssfUA/gg6ok7eiH+Zd5CUaZ35cvgxyleGsxcb
        PCF425qgWsioO+Oi8xUGCkd83DUhmbokzKyYez4s3g==
X-Google-Smtp-Source: APXvYqxkJuxoGezkn7Q+S489zXbZm2eSgwUtZX20A4OmV0OwB2TMuxzbiMGK1w2ImUsdSfHqF16knx2sDqv95/E7f1s=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr14261372otp.316.1578937654140;
 Mon, 13 Jan 2020 09:47:34 -0800 (PST)
MIME-Version: 1.0
References: <7adb48ad-299d-bbec-c467-b29376583486@p10link.net>
In-Reply-To: <7adb48ad-299d-bbec-c467-b29376583486@p10link.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Jan 2020 09:47:23 -0800
Message-ID: <CABPp-BH49aX=DX=p3bNZaTo8LKt=FH_J3h34Tbf2cYx+DJD2LQ@mail.gmail.com>
Subject: Re: under what circumstances will git replacements be pushed/pulled
To:     peter green <plugwash@p10link.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 9:31 AM peter green <plugwash@p10link.net> wrote:
>
> I need to make some local tweaks to history to make merges go more smooth=
ly, traditionally the tool for doing this is grafts, however git is yelling=
 at me that grafts are deprecated and will be removed in a future release a=
nd that I should use git-replace instead.
>
> However there is something that is concerning me, https://git.wiki.kernel=
.org/index.php/GraftPoint says
>
>  > As of Git 1.6.5, the more flexible git replace has been added, which
>  > allows you to replace any object with any other object, and tracks
>  > the associations via refs which can be pushed and pulled between repos=
.
>
> However the git-replace man page makes no mention of push or pull.
>
> under what circumstances will replacements be pushed or pulled, and what =
if any steps do I need to take to ensure that my replacements stay local.

People have to take special steps to push or pull replace refs.

Replace refs are special refnames in the refs/replace/ hierarchy.
Since clones by default only grab stuff under refs/heads/ and
refs/tags/ and set up fetches to do likewise, you don't get these by
default.  None of the push.default settings (simple, upstream,
matching, current) will push these either.  So, if the user wants to
transfer replace refs, they either need to manually call out the
refspecs, use a special fetch/push flag like --mirror, or set up a
special remote.<name>.fetch or remote.<name>.push config setting.

In other words, your replace references are local-only by default.
Anyone who wants to share them will have to be the ones to take
special steps, and likely at more than one stage (e.g. a special step
to push them to some central repo, and notify your co-worker of the
special commands they have to use to fetch them).

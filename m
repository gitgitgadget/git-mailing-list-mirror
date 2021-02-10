Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7944CC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392BF64EAA
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 17:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBJRVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhBJRVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 12:21:41 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B82C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 09:21:03 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e4so2499665ote.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 09:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3QDM0vACv5PClypP9h/JlBV9m5AhnlXjxfWjNOxKsQ=;
        b=e+IUHKyl03TxSORF6C76b79U16hk0k5HVnrkEel6oCEY3r5hzpPa8TEA+f2wJe1Hgw
         0e2bZHilyjm+hqEeDrdx87y/IYaZSygu0eGQpVONgMwjaYZC13M99QjjC9ZwxrMFA3aM
         Fd1SjGAXneXgalrg0gpsGHo7yNG4KG2k98ASz57/HDbzQzAicHbcaZj3k8A7uImVo8vF
         fN8XrAkRgMr4iF1knKz3OGwx5ojG829430grd6S6NAu529x4u4hTrtKfdbyw5tRBbz9I
         RLUTWDPRFX3BKUa+A44AKJQo+9ifTYQLqc8KB2/VcRmADJZ0NM6F4Hde4V5pZcop4bDc
         LCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3QDM0vACv5PClypP9h/JlBV9m5AhnlXjxfWjNOxKsQ=;
        b=nC8C9JTKNHxIxieU9ZHAb2TbUgz6m+2Ddf9BNfSnFwSpyGSGDJBstef1167L2ziUiI
         b9WNt262cOHPLw2+y2jiS3Vd8/hv6JcsZ1tTslU/Gio6jV0YT6tuBHosEov3z4IBfQNz
         IeN8YP5f1n1obG0wv6x5FvOhv44iFPRldg4a7As0e5IBg9CfrTszTm7AkPGcxvjqb2EO
         oa+zsgKs6rDIOw0FTwx08sM2CmFsVM1Lk8pxof3DcjuQcT0HXR+T7EVlhGTdO9ounC9N
         ICgCL05aCshPowNbCE0XVdZic0NFb8kt6eq29lAd6nyvX/uT6CwC77hSGF6qgdAIYdpJ
         MJEQ==
X-Gm-Message-State: AOAM533aq9122HH1/wfkf1vk9bO+hRdh0a0yOlyz9kDG+nc0KvmQpqC8
        vkG24s8sVBcLa2d8vQab4WvuToP1+FCXNynFx5U=
X-Google-Smtp-Source: ABdhPJz67eQGk0PuSdb+QVBpUFZ5WKKMYPHYxqQgz6JLHAswk7pQuvus8xy2dXMU5Kf6QPxpuzJ5JHPBfFsQWkowm58=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr2821615otn.162.1612977662563;
 Wed, 10 Feb 2021 09:21:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <fc72d24a3358b1c5cc2753b5f07ac60174e6452b.1612970140.git.gitgitgadget@gmail.com>
 <xmqqtuqj3mfl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuqj3mfl.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Feb 2021 09:20:50 -0800
Message-ID: <CABPp-BHuT6nvRF0QNHzXV0qNzQWAia0H7RMATNXtDSJyWJmeRA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] gitdiffcore doc: mention new preliminary step for
 rename detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 8:41 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The last few patches have introduced a new preliminary step when rename
> > detection is on but both break detection and copy detection are off.
> > Document this new step.  While we're at it, add a testcase that checks
> > the new behavior as well.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/gitdiffcore.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> > index c970d9fe438a..36ebe364d874 100644
> > --- a/Documentation/gitdiffcore.txt
> > +++ b/Documentation/gitdiffcore.txt
> > @@ -168,6 +168,23 @@ a similarity score different from the default of 50% by giving a
> >  number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
> >  8/10 = 80%).
> >
> > +Note that when rename detection is on but both copy and break
> > +detection are off, rename detection adds a preliminary step that first
> > +checks if files are moved across directories while keeping their
> > +filename the same.  If there is a file added to a directory whose
> > +contents is sufficiently similar to a file with the same name that got
> > +deleted from a different directory, it will mark them as renames and
> > +exclude them from the later quadratic step (the one that pairwise
> > +compares all unmatched files to find the "best" matches, determined by
> > +the highest content similarity).  So, for example, if
> > +docs/extensions.txt and docs/config/extensions.txt have similar
> > +content, then they will be marked as a rename even if it turns out
> > +that docs/extensions.txt was more similar to src/extension-checks.c.
>
> I'd rather use docs/extensions.md instead of src/extension-checks.c;
> it would be more realistic for .md to be similar to .txt than .c.
>
> With a raised bar for this step, the equation changes a bit, no?
>
>     So, for example, if a deleted docs/ext.txt and an added
>     docs/config/ext.txt are similar enough, they will be marked as a
>     rename and prevent an added docs/ext.md that may be even similar
>     to the deleted docs/ext.txt from being considered as the rename
>     destination in the later step.  For this reason, the preliminary
>     "match same filename" step uses a bit higher threshold to mark a
>     file pair as a rename and stop considering other candidates for
>     better matches.
>
> or something?

Good points; I've updated the docs locally to reflect your
suggestions, I'll wait a bit for any other feedback and then send out
a new round with this update.

> > +At most, one comparison is done per file in this preliminary pass; so
> > +if there are several extensions.txt files throughout the directory
> > +hierarchy that were added and deleted, this preliminary step will be
> > +skipped for those files.
>
> Other than that, the whole series looked sensible to my cursory
> read.

Thanks.

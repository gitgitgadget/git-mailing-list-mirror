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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D6C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6536721D94
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL3PLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 10:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3PLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 10:11:09 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D352C06179B
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 07:10:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d203so18946976oia.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXhknT168iMPq4j6ONkf1DH909+Zu5F0Sxuq2uO4mAo=;
        b=QO12oxWYc6cVip6Mos6ZRFNMUvnKLX72P1S7saXrKwbROc8HhrQkRPMP3JXm7oL/Cf
         +SiYBAo42vWFnVlKsQvPR+YSQyXLBSNKB5Sfr66xDHl5d7pWDDY90Eptb9H7WFAadY1D
         HONxxtQgz2Hh+80nj7jslT5TgVu0l5OSyqcuGosoeidE/7sf64g/E9RNXCytfAoBkEFx
         ZCDrerOLlE+l6vTefv0mSExW4KL9AEwf1lQcxnQuWhfFtaGwXGX/be4jaXGqr+888RB4
         wzokEQd/8KhVTcxoRpMbpJexFfKdoITiIUtB2fCqGWcPdICPhr85BxsA7N7YHDnJfpr2
         ZhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXhknT168iMPq4j6ONkf1DH909+Zu5F0Sxuq2uO4mAo=;
        b=ubyO7jtHSiK0VTR2Bh7BKEqyuazdad47RGivaXL7I9FSXt7XCe5N9CHUqVuByg0UfW
         TEOcSqQKg0Eng2CUlV1G1bzGgLtlu+iQnh7AJNh8fbbFOnNYrqHPI11JlJ0yWKRwF9+i
         D0+YSWvNjWuDkaxJXbrKpx6/wzKH37TyL1oQsFn0/80fGZBs4xWQ3oWCklE/LBkauGb0
         Dqiif1Mah07Zc54JwIUgLHLw/Czy/cxO5ZT4LHENF/iczs7IUidRCKLOKu9gT94Mj0H1
         oxPqcFyzj2ttOO0w7fIeYdr7FIaX0t7Wo4wCDAj5GIrP9lGYxPFf6+z7Xc5O2mwC0Sld
         GTPw==
X-Gm-Message-State: AOAM532YZ3d4dCgPNLOcJafSTYaB7lTZOSxsXZr8jRScqS/mka2Ejsw8
        WE1ke3RjTbhmSkiwaMQFS69hNqgiCYadBhg/jUs=
X-Google-Smtp-Source: ABdhPJx2ZoONhPRJAatbEV94qBBlVOpqKRfj9lqleAt31jdPUU46b7gEuS/Jn7MQnG4vx7dayHD6NioGI0dyYs8bby8=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr5292825oic.167.1609341028520;
 Wed, 30 Dec 2020 07:10:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <6ac555b3c0fe605fbbe6e304482c2e3aef321865.1608270687.git.gitgitgadget@gmail.com>
 <3a07f700-18fc-9f4e-3117-41e534d737b0@gmail.com>
In-Reply-To: <3a07f700-18fc-9f4e-3117-41e534d737b0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 07:10:17 -0800
Message-ID: <CABPp-BF37UeBdF4T68rvOaFRtPyZ2uoUSe48V4K8CUigy77CfA@mail.gmail.com>
Subject: Re: [PATCH 03/10] merge-ort: implement unique_path() helper
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 6:16 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Implement unique_path(), based on the one from merge-recursive.c.  It is
> > simplified, however, due to: (1) using strmaps, and (2) the fact that
> > merge-ort lets the checkout codepath handle possible collisions with the
> > working tree means that other code locations don't have to.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index d300a02810e..1adc27a11bc 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -343,11 +343,34 @@ static void path_msg(struct merge_options *opt,
> >       strbuf_addch(sb, '\n');
> >  }
> >
> > +/* add a string to a strbuf, but converting "/" to "_" */
> > +static void add_flattened_path(struct strbuf *out, const char *s)
> > +{
> > +     size_t i = out->len;
> > +     strbuf_addstr(out, s);
> > +     for (; i < out->len; i++)
> > +             if (out->buf[i] == '/')
> > +                     out->buf[i] = '_';
> > +}
> > +
>
> Thank you for pointing out that you based your code on merge-recursive.c.
> I see that this implementation is identical to the one there. I question
> whether this causes collisions in a problematic way, when "a/b/c" and
> "a_b_c" both exist in a tree.
>
> To avoid such a problem, we'd likely need to also expand "_" to "__" or
> similar. This might never actually affect any users because of the
> strange filename matches _and_ we need to be in a directory/file conflict.
>
> And maybe it's not a hole at all? If it is, we can consider patching or
> at least documenting the problem.

add_flattened_path() can certainly result in a collision, regardless
of whether the char *s parameter has any '/' characters in it.  For
example, if you are trying to get a unique path associated with
builtin/commit-graph.c due to changes from the 'next' branch side of
the merge, and builtin/commit-graph.c~next already exists, then you
have a collision.  It's actually pretty rare that the parameter would
have any '/' characters at all, since it's pretty rare for me to see
folks (other than Junio) use hierarchical branch names.  But if the
branch name were ds/line-log-on-bloom, then the provisional filename
would be builtin/commit-graph.c~ds_line-log-on-bloom.  The '/' to '_'
conversion exists just to make sure our new file remains in the same
directory as where the conflict that caused us to need a new unique
path occurred.

But unique_path() does NOT end immediately after calling
add_flattened_path() and there is no collision possible in the return
from unique_path(), because it ends with a
    while (strmap_contains(existing_paths, newpath.buf)) {
loop that modifies the resulting path until it finds one that doesn't
collide with an existing path.

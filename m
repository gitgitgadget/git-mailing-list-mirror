Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F91BC433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C27C64D9D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBHXhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBHXg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:36:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31472C061794
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 15:35:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y199so15518482oia.4
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQLUViEqIThWS9dyTtwjuBXDMX+FbA5RBW0uNga8jc0=;
        b=EohYHoi855eVF3MAufhtC2lKqm48V4tJOx75LgiigzTiWLPktWgB5GjsisRp0GN59T
         0ZgRPpMJFBXENmqsLl8Mwduad8t03jxI1uvrm31skG1X9X7EYot2elYYUyiTXYsxsUEE
         9PI0+uzmjZYtsp/FBbmtKov9UPxmdkSiFWXIpntH07wzRupHaJLPKXjgOC29f6F8y0fq
         8ENAyPXcbDRBwKZ0jd32uGQvaJsOHGBD+810d0+9Fy6LbWatC+kxKX1fGeyTVTj4icFw
         6qkzBsT4CAoEYWYf5n2oEoPwwxKHdpnW4immvwlSFK9BLi3R1ECEbcq2B0VVUUMQpo+c
         8A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQLUViEqIThWS9dyTtwjuBXDMX+FbA5RBW0uNga8jc0=;
        b=c/2HbzZ/mCtoAGaH25aXjTzDqIGSGGTIm0eTROKB9B2OlOdGkssRJiG6rtYM+5L+Zu
         gUpnlbyV9JKBV/xgz3X7GqPomYcTO4eMyi6ivhqZYAPXXTe1a6SlfGHx5fW0chdAQ/eH
         qvFqgr25HgvRp5CoVuqsyDgAW+5SKKWCS+YdhbxCyYOcKzTA9whaR6cneWy+2S275Mf2
         RfUqbvy9MT12/iMQ4SEVQ7FI0QVrZNi6lf/WoK8tovG0n+YYnqxHfrcTAY2t1nO4blIE
         girgVi/XSDegijE6ebY4Oz1Bjw2l2P7hcjZfsi/83BC+7SAnjAECPhUdRRqNB7l/F2n6
         AAdg==
X-Gm-Message-State: AOAM530EWtdOra59K4LHq2yzltxZYubytniOJ0QPbiLBYI0gK7vQ6fko
        jDukAP9KtCYtWXYtBkMyg3IdbraOOpzK8+szh6IQkab/BAlUTQ==
X-Google-Smtp-Source: ABdhPJz3yO3iZd49EAcOXPu2s6X/ww+EfBqtvcps8fk33phks8tJFndBvWowJDwDfpm6hBmDHXUMLK5JA53iofD/pwU=
X-Received: by 2002:a54:4790:: with SMTP id o16mr744680oic.39.1612827356450;
 Mon, 08 Feb 2021 15:35:56 -0800 (PST)
MIME-Version: 1.0
References: <4ceea1ec-59fe-af8e-b91d-aced4e6a1b0f@arrikto.com>
In-Reply-To: <4ceea1ec-59fe-af8e-b91d-aced4e6a1b0f@arrikto.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 15:35:45 -0800
Message-ID: <CABPp-BGydzR2NDvG_q7NJyLBTDxQZbvjgwfmeXnmhtPCf+FxRg@mail.gmail.com>
Subject: Re: Directory rename detection breaks if repo has a lot of
 similar/identical files
To:     Yannis Zarkadas <yanniszark@arrikto.com>
Cc:     Git Mailing List <git@vger.kernel.org>, vkoukis@arrikto.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Yannis, and welcome!

On Mon, Feb 8, 2021 at 9:37 AM Yannis Zarkadas <yanniszark@arrikto.com> wrote:
>
> Hi everyone! I believe I have found a use-case that breaks git's directory
> rename detection algorithm. In short, when a repo has a lot of identical
> files,
> directory rename detection breaks. I believe this happens because git feeds
> misleading renames to the directory rename detection algorithm.

The directory rename detection logic doesn't seem to have any issues
here; the problem is in the data fed to that logic, which is
essentially random.  Thus, this lies more on the side of rename
detection than directory rename detection, even if you paid more
attention to the issues once they started affecting directory rename
detection.  That's worth noting because directory rename detection
code is in merge-recursive.c, while normal rename detection code is in
diffcore-rename.c.  Just want to make sure we're looking at the right
code if you want to dive in.


In diffcore-rename.c, in the function named find_identical_files(),
ties will be broken based on whether basenames match:

    score += basename_same(source, target);
    if (score > best_score) {

If you have multiple identical files AND they have matching basenames,
then they'll all have the same score.  Since it only records a new
best if it is *better* than the previous, it will thus take whichever
one was first.  The ordering of which is first depends on the random
order that the hashmap decides to iterate over them.

Of course, this is only for identical files.  However, basename_same()
is used in one other place in the file, in association with inexact
renames, but has identical usage where the tie-breaker for files with
the same content similarity percentage are broken by whether the have
the same basename -- but any other path components are ignored.

...snip a bunch of good analysis...

> git diff --find-renames --stat $BASE $LOCAL
> git diff --find-renames --stat $BASE $REMOTE
>
> The first command is the interesting one and returns suspicious entries
> like the
> following:
>
> {z => new/a}/base/base.txt                   | 0
> {a => new/a}/overlays/develop/overlay.txt    | 0
> {a => new/a}/overlays/upstream/file_1.txt    | 0
> {z => new/a}/overlays/upstream/file_3.txt    | 0
> {z => new/a}/overlays/upstream/file_5.txt    | 0
> {a => new/a}/overlays/upstream/file_a.txt    | 0
> {z => new/a}/overlays/upstream/overlay.txt   | 0
> [...]
> {a => new/z}/base/base.txt                   | 0
> {z => new/z}/overlays/upstream/file_1.txt    | 0
> {a => new/z}/overlays/upstream/file_3.txt    | 0
> {a => new/z}/overlays/upstream/file_5.txt    | 0
> {z => new/z}/overlays/upstream/file_z.txt    | 0
> {a => new/z}/overlays/upstream/overlay.txt   | 0

And yep, that seems to be what you're seeing.  And if the renames look
like this, then trying infer directory renames based on the renames is
going to be a mess.

So it all boils down to the fact that you have identical files with
identical basenames, and renames don't currently know how to
differentiate between such files to get the "right" rename.

> Proposed Enhancement
> ====================
>
> Now that we know what is most likely going on, I can describe what I
> would like
> git to do.
>
> Intuition: If file `a/base/base.txt` in BASE is the same as
> `new/a/base/base.txt` AND `new/z/base/base.txt` in LOCAL, then prefer
> the rename
> `a/base/base.txt->new/a/base/base.txt` over the rename
> `a/base/base.txt->new/z/base/base.txt`.
>
> In other words, if multiple rename candidates are possible, prefer the
> ones that
> look more like the user move the file/folder from one path to another.

Stated differently, break ties for rename detection based on the
number of matching trailing path components.  For example, if the
basename was the only path component that was the same (e.g.
src/base.txt and source/base.txt), then we'd add one to the score.  If
the basenames were the same and two of the directories before that
matched as well (e.g. src/a/base/base.txt and source/a/base/base.txt)
then we'd add three to the score or name_score.  To implement this,
you'd only have to change the basename_same() function to: (1) rename
it (since it's no longer just about the basename), (2) make it keep
going past the first '/' component, and (3) change the 0...1 scoring
range to 0...N based on the number of '/' characters you passed while
walking backwards (except that reaching the toplevel counts the same
as hitting a '/' character, e.g. foo.txt and src/foo.txt have 1
matching path component rather than 0).

> Possible Algorithm:
>
> More generally, if files `A1`, `A2`, ..., `An` in commit A are the same
> as `B1`,
> `B2`, `Bm` in commit B, then:
> - Calculate a sorted list of scores `S(Ai, Bj), i=1,...,n and
> j=1,...,m`, where
>    `S(Ai, Bj)` is the length of the suffix match of `Ai` and `Bj`.
> - Walk the sorted list and for each element:
>      - If `Ai` and `Bj` is not used in a rename yet, apply the rename.
>      - Stop when you have found `min(n, m)` renames.
> - The remaining `max(n, m) - min(n, m)` files are either deletes (if
> they are on
>    commit A) or copies (if they are on commit B).

This would require a bigger code restructure, and I think it's no
different than my suggested changes to basename_same().

> Conclusion
> ==========
>
> I want to attempt to implement something like what I described above, when I
> have more time to get familiar with diff's internals. In the meantime, I
> would
> love to hear the opinion of more seasoned git developers on this issue.
> Do you
> agree with my findings and the direction I proposed? Is there something
> I have
> overlooked? Perhaps someone is already having these problems.

You're the first I know of to have identical files in different
directories with identical basenames, and then attempt to rename them
and do directory rename detection based on that combination.  But just
because you're the first I know of doesn't imply that you're the only
one or the last one, of course.  I think the basename_same() change
would probably fix this up nicely for you.


You'll need  to be aware, though, that I'm making lots of changes to
diffcore-rename.c right now, though, so there is a risk of conflicts.
Just since git-2.30, see these commits:

350410f6b1 (diffcore-rename: remove unnecessary duplicate entry
checks, 2020-12-29)
9db2ac5616 (diffcore-rename: accelerate rename_dst setup, 2020-12-11)
b970b4ef62 (diffcore-rename: simplify and accelerate
register_rename_src(), 2020-12-11)
81c4bf0296 (diffcore-rename: reduce jumpiness in progress counters, 2020-12-11)
ad8a1be529 (diffcore-rename: simplify limit check, 2020-12-11)
00b8cccdd8 (diffcore-rename: avoid usage of global in
too_many_rename_candidates(), 2020-12-11)
26a66a6b1c (diffcore-rename: rename num_create to num_destinations, 2020-12-11)

plus many of the commits found in each of the pull requests up at
https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch.
That shouldn't stop you, but be aware that you might need to rebase a
few times, or let me take over and keep rebasing your patches on top
of mine (retaining you as author) in order to get all the series of
patches through.


Hope that helps,
Elijah

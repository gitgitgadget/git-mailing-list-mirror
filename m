Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCB3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 06:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbiFJGlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 02:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiFJGlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 02:41:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038904C422
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 23:41:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so17284965edj.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2Ww9C2efC7ymCL6l0VfqRMyss3a4pRn4y8jSFVhfMk=;
        b=EAJxK5lqEuDcp/9V/lS3h21X8KZBgNtezMfW1RIhWdY5pQXoGjtT5fiW2LWzA1hYNt
         D3Isa3Chf6vhNNDe5TD3084IzaoH2xiVbMT0l7N1csXdUJI3VPRHtrfujszWEGRbnNVu
         boPbAik/C+PbBijoswribyAp/2h8PCMBQm3w/DiZBnmUgk3LO8ZcN3X9/ABY6fYuZP/g
         jYi2NCMeaWrSHkY9oJ3Yzly+r8CSIaDRFyclGneUIRCahoFVepozIOJGrAvHFDkWsa+k
         h+ttl7eMgF1GZLtvdLd7iqBssWYgQ98ZgpHHx3uhN83EHxgoabOvjpc1wzvljx3kv64j
         sWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2Ww9C2efC7ymCL6l0VfqRMyss3a4pRn4y8jSFVhfMk=;
        b=PIgtsX30NM6MF+yRqC8m01IogmkS6PzfRv4Zqh8dbk9lWQirexGy1Tl1CU3B3R4Pq9
         P4RTCWpMW9KIT5rWax/rAELzMYH8DAcMZBsYgoNsb/GtmSVszRJg6ggyX303JQhPunc0
         b0oI/Y9/T4hwgEsEOLej+eYk+3F5TP2BsDUjv49VBjs1rz4m9/il9w8VA5TPV4H7d5QB
         JKtwQtqhFKcvhMmkMNegukmzdViOqOS6X5XQiZTslUCuUv5uHITIF2dgje2ZwH+9q+nv
         nenl5tnpjwx9EuspccZtCdkl2H1GdV0Y4VtLi+SyC8RCHkoUR2734jX2CJnPGZZ6Vpl5
         K19w==
X-Gm-Message-State: AOAM532ms7o6Bje2bQvgcxrPec6kWOcAmOPf4DkKGIyPUpQrulrhtdTW
        d4jZGKVpv4V81KD2Ad+mWYcFCNXqzbCTCxTsbSnslzQ5J4A=
X-Google-Smtp-Source: ABdhPJx5nZuyjsWBApZPdIc3o8WKMk8FIZ+zcpn276bjmvuQUTc4KKfclYChHCBvSYCMd0FLwBuC/rQrLKJkwDlfJ60=
X-Received: by 2002:a05:6402:541b:b0:42b:deba:9667 with SMTP id
 ev27-20020a056402541b00b0042bdeba9667mr48571268edb.96.1654843277330; Thu, 09
 Jun 2022 23:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Jun 2022 23:41:06 -0700
Message-ID: <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
To:     Glen Choo <chooglen@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
>
> (I'm not 100% what the bug _is_, only that there is one.)
>
> = Report
>
> At $DAYJOB, there was a report that "git merge" was failing on certain
> branches. Fortunately, the repo is publicly accessible, so I can share
> the full reproduction recipe:
>
>   git clone https://android.googlesource.com/platform/external/tensorflow tensorflow &&
>   cd tensorflow &&
>   git merge origin/upstream-master # HEAD is at origin/master
>
> This gives:
>
>   Performing inexact rename detection: 100% (4371280/4371280), done.
>   Performing inexact rename detection: 100% (12529218/12529218), done.
>   Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410.
>
> This bug seems specific to merge-ort; "git merge -s recursive
> origin/upstream-master" seems to work as expected.
>
> In case the branches have changed since then, here are the commit ids:
>
>   $ git rev-parse origin/master
>   68e55281824e8a79fa67e1a3061f39bd4c4b2e57
>   $ git rev-parse origin/upstream-master
>   0be5bb09aeeff3a6825842326fadc8159a5553ab
>   $ git merge-base 68e55281824e8a79fa67e1a3061f39bd4c4b2e57 0be5bb09aeeff3a6825842326fadc8159a5553ab
>   8e819019081f39d83df42baba4acfced3abf3f90
>
> = Interesting info
>
> I don't understand the merge-ort code enough to understand what's going
> on, but I was able to find some (hopefully helpful) details. I added
> this log line just above the offending assert() call:
>
>         trace2_printf("0 %s, 1 %s, 2 %s, fm %d, dm %d", ci->pathnames[0],
>     ci->pathnames[1], ci->pathnames[2], ci->filemask, ci->dirmask);
>
> Here are the lines I thought were suspicious:
>
>   0 <path1>, 1 <path1>, 2 <path1>, fm 2, dm 0
>   [...]
>   0 <path2>, 1 <path1>, 2 <path2>, fm 6, dm 0 # this is the last line
>
> Notice that the last line detected a rename from <path2> to <path1>, but
> we already saw <path1> earlier.
>
> IIUC "(ci->filemask == 2 || ci->filemask == 4)" can be read as "the path
> either exists on only the left side or only the right side of the
> merge", so ci->filemask == 6 should mean "the path exists on both sides
> of the merge"?
>
> "-s recursive" seems to handle the rename just fine (it picks <path2>
> IIRC).
>
> I also dug into each commit to see which paths were present:
>
>   head="origin/master"
>   other="origin/upstream-master"
>   merge_base="$(git merge-base origin/master origin/upstream-master)"
>   path1="tensorflow/lite/g3doc/convert/metadata_writer_tutorial.ipynb"
>   path2="tensorflow/lite/g3doc/models/convert/metadata_writer_tutorial.ipynb"
>
>   git rev-parse "$head:$path1" # (exists)
>   git rev-parse "$head:$path2" # (doesn't exist)
>
>   git rev-parse "$other:$path1" # (doesn't exist)
>   git rev-parse "$other:$path2" # (exists)
>
>   git rev-parse "$merge_base:$path1" # (doesn't exist)
>   git rev-parse "$merge_base:$path2" # (doesn't exist)
>
> i.e. both files are new and are renames of each other. I haven't tried
> using this property to create a minimally-reproducing recipe though.

Thanks for the detailed report; very cool.  Interestingly, if you
reverse the direction of the merge (checkout origin/upstream-master
and merge origin/master) then you get a different error:

    error: cache entry has null sha1:
tensorflow/lite/g3doc/examples/convert/metadata_writer_tutorial.ipynb
    fatal: unable to write .git/index

This merge has a lot of stuff going on, including some big directory
renames, new files, loads of conflicts, etc.  I think the relevant
bits are the following:

merge base -> side1:
    Rename tensorflow/lite/g3doc/models/ -> tensorflow/lite/g3doc/examples
    Add tensorflow/lite/g3doc/convert/metadata_writer_tutorial.ipynb

merge base -> side2:
    Rename tensorflow/lite/g3doc/convert/ ->
tensorflow/lite/g3doc/models/convert/
    Add tensorflow/lite/g3doc/models/convert/metadata_writer_tutorial.ipynb

So the combination of the above means:
    side1:tensorflow/lite/g3doc/convert/metadata_writer_tutorial.ipynb
would be affected by the side2 directory rename to become
    tensorflow/lite/g3doc/models/convert/metadata_writer_tutorial.ipynb
which would match the name of the file on side2, BUT the side2 version of
that file, i.e.:
    side2:tensorflow/lite/g3doc/models/convert/metadata_writer_tutorial.ipynb
would be affected by the side1 directory rename to become
    tensorflow/lite/g3doc/examples/convert/metadata_writer_tutorial.ipynb
and what becomes of the side1 version of that file?  It gets messy...


I have a small reproduction recipe (using the style from t6423 to explain it):

#   Commit O: sub1/file,                 sub2/other
#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
#
#   In words:
#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2

This small reproduction recipe triggers the same assertion-failure you
reported; further, when the merge direction is reversed this testcase
shows the same alternative error I showed above for your bigger
testcase.  However, interestingly, this simple testcase also triggers
those same null-sha1 and unable-to-write-.git/index errors in
merge-recursive, regardless of the direction of the merge.  I don't
know why my testcase triggers bugs in merge-recursive and your bigger
testcase doesn't, but I wasn't too motivated to find out either; I was
mostly focused on trying to understand the merge-ort side of things.

Now, there's code in both merge-recursive and merge-ort for avoiding
doubly transitive renames (i.e. one side renames directory A/ -> B/,
and the other side renames directory B/ -> C/, and even worse if the
original side also renames C/ -> D/, because this combination would
otherwise make a mess for new files added to A/ on the first side and
wondering which directory they end up in).  However, this is a
testcase where a _leading directory_ of B/ is renamed to C/, which
sidesteps the normal doubly transitive rename check, and then the code
heads down what looks like the wrong path until it is caught by the
assertion check you reported.  In addition to the
funny-doubly-transitive-rename (involving the leading directory), your
testcase also has both sides add a file, one side to A/ and the other
side to B/ (with the same basename but different file contents), which
adds to the "fun".

Anyway, long story short...I don't have a fix yet, but just thought
I'd mention I saw the email and spent some hours digging in.

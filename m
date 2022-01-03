Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AE9C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiACQvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 11:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiACQvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 11:51:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33080C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 08:51:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w16so138210856edc.11
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VuI4Q6nga2uOnlw7PZZVl445CaUHeErVRmJcvPSTSc=;
        b=S8mgV90SogYS3b0Byqv8lUHoHBlbBgqaPuU2P9HzrsCIkjmn8wh5X6/M9ztejREbBK
         6sEjCeilXj5FYL6eGJxOloN/Ab+OS3VfHxcnqh0t5dbJj/aM953tLRdSRYiWSszy//zu
         4K41LR/tU4rlD8Pg8gl+kUqRsG6qT1Z9PyjKD3Tr0Gx2souS8Jab7rH+a5b6SncEUL06
         VNEQZdzDSuXzlYBOysqO2fmQwcFxXysiw3Vn5aKbJVXXJecRba3OtRb1UkbmazOvV+Va
         D31TaZrZROT82fqH6gOlEi3iGT0M3JC5TBc9HE/JIU9HKDVuvkYFw74THxC4cTlaZ0Qz
         v1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VuI4Q6nga2uOnlw7PZZVl445CaUHeErVRmJcvPSTSc=;
        b=cCVsB8wIBYytth4yEYoU00FewsZMQ8QPNGei29kVhe1JBF9LARmMYGrVKOHAg62nby
         nJTy6X2I1nNxUkaynXfgopLIx/S7u6J9eFD2r4g8es+pohHpap/1rU5Y4Pn/UFFT1pAf
         NtefV+otzEW64Yn882JOOMQTHPAZxk2fTnsKpaEgeVJdialyKYrIDQHxcKkEzcrzeZAE
         qSPmgqWdfvrGQI61bvujbDIUzvGxpKyNcuN3NEJqKJIux5g7HyACAxKaKxTt7/pidJJ7
         fJArAJW2Rkz94CPOoDuQCyZfZ9O4Ofjy9WEoa+hVNuGvnSr8CAArGtmf2cw7T6DFtI+i
         +gaQ==
X-Gm-Message-State: AOAM532PWLVhUNDgEf/dbwJEjGmizv7dWrZ9TF//3PJ7uU/sGqJ5s4KT
        UuMuD/VqsqYvT6ohvawWMaBSmMGEQCXwdG+Jbzs=
X-Google-Smtp-Source: ABdhPJwbMQJ8tlnH7iQdsR/s7m1/Eta7lQ4sAnNAYhVne36s8c2SOrsCbVH3ZrTZxdCHTGH0FMf9kYBTj9E0nvzF7Dg=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr37663186ejc.476.1641228689732;
 Mon, 03 Jan 2022 08:51:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
 <20220103123114.uuvpk4nley22gfkg@fs>
In-Reply-To: <20220103123114.uuvpk4nley22gfkg@fs>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jan 2022 08:51:18 -0800
Message-ID: <CABPp-BH4okfDXVC418HwfHVR2_NtbKFBOfyYGZ9mWnABMzSruw@mail.gmail.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 4:31 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
> >From: Elijah Newren <newren@gmail.com>
> >
> >When running `git merge-tree --real`, we previously would only return an
> >exit status reflecting the cleanness of a merge, and print out the
> >toplevel tree of the resulting merge.  Merges also have informational
> >messages, ("Auto-merging <PATH>", "CONFLICT (content): ...", "CONFLICT
> >(file/directory)", etc.)  In fact, when non-content conflicts occur
> >(such as file/directory, modify/delete, add/add with differing modes,
> >rename/rename (1to2), etc.), these informational messages are often the
> >only notification since these conflicts are not representable in the
> >contents of the file.
> >
> >Add a --messages option which names a file so that callers can request
> >these messages be recorded somewhere.
> >
> >Signed-off-by: Elijah Newren <newren@gmail.com>
> >---
> > Documentation/git-merge-tree.txt |  6 ++++--
> > builtin/merge-tree.c             | 18 ++++++++++++++++--
> > t/t4301-merge-tree-real.sh       | 18 ++++++++++++++++++
> > 3 files changed, 38 insertions(+), 4 deletions(-)
> >
> >diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> >index 5823938937f..4d5857b390b 100644
> >--- a/Documentation/git-merge-tree.txt
> >+++ b/Documentation/git-merge-tree.txt
> >@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
> > SYNOPSIS
> > --------
> > [verse]
> >-'git merge-tree' --real <branch1> <branch2>
> >+'git merge-tree' --real [--messages=<file>] <branch1> <branch2>
> > 'git merge-tree' <base-tree> <branch1> <branch2>
> >
> > DESCRIPTION
> >@@ -21,7 +21,9 @@ The first form will merge the two branches, doing a full recursive
> > merge with rename detection.  If the merge is clean, the exit status
> > will be `0`, and if the merge has conflicts, the exit status will be
> > `1`.  The output will consist solely of the resulting toplevel tree
> >-(which may have files including conflict markers).
> >+(which may have files including conflict markers).  With `--messages`,
> >+it will write any informational messages (such as "Auto-merging
> >+<path>" and conflict notices) to the given file.
> >
> > The second form is meant for backward compatibility and will only do a
> > trival merge.  It reads three tree-ish, and outputs trivial merge
> >diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> >index c5757bed5bb..47deef0b199 100644
> >--- a/builtin/merge-tree.c
> >+++ b/builtin/merge-tree.c
> >@@ -389,6 +389,7 @@ static int trivial_merge(const char *base,
> >
> > struct merge_tree_options {
> >       int real;
> >+      char *messages_file;
> > };
> >
> > static int real_merge(struct merge_tree_options *o,
> >@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
> >        */
> >
> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> >+
> >+      if (o->messages_file) {
> >+              FILE *fp = xfopen(o->messages_file, "w");
> >+              merge_display_update_messages(&opt, &result, fp);
> >+              fclose(fp);
>
> I don't know enough about how merge-ort works internally, but it looks to me
> like at this point the merge already happened and we just didn't clean up
> (finalize) yet. It feels wrong to die() at this point just because we can't
> open messages_file.

Yes, the merge already happened; there now exists a new toplevel tree
(that nothing references).  I'm not sure I understand what's wrong
with die'ing here, though.  I can't tell if you want to defer the
die-ing until later, or just avoid the die-ing and return some kind of
success despite failing to complete what the user requested.

>
> >+      }
> >       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> >-      merge_switch_to_result(&opt, NULL, &result, 0, 0);
> >+
> >+      merge_finalize(&opt, &result);
> >       return result.clean ? 0 : 1;
> > }
> >

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] branch: update all per-worktree HEADs when renaming a branch
Date: Mon, 21 Mar 2016 13:41:28 -0400
Message-ID: <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:41:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai3pe-0000NM-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbcCURla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:41:30 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36833 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbcCURl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:41:29 -0400
Received: by mail-vk0-f54.google.com with SMTP id q138so131451179vkb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=gXV84m5E1hTj0CW3R2lpPAagLan5HBXPB/JPqjPP7Jc=;
        b=qSzo1LB+5obYUnKxUlLwhvjL/NvhcSGnoMNvvoUcxco2W+RX2plghg5KE9tloKJLKS
         P/YpdF7shBevt++PRduRz8NKbJIjPr6DHWhLXyzZAG9cRFilHekNln8ecoclNlBEFIkA
         6RwRg73ENkP/NW9rMddPljCc668BgEg4yGfXvmbVcW2EIGxuUvRWonRsl5jDb/dxu6ns
         O4oNFTZ+/H6PlEf+3fmfXu0iRTSIhRR2D5QNG88gpJxAY45GFy9dI1eF2XhMHxtRmO/k
         UwMD7JUxCgFOpbyRgovEf3sxdBR+Dl7qB8u1SiOz1cb+i2GOUXr0zJ7Umfc3f4EogF1u
         woIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gXV84m5E1hTj0CW3R2lpPAagLan5HBXPB/JPqjPP7Jc=;
        b=CYpRZgIotnTA3S25X3WhURR7Ts7ZnLPb5ZYGtUjh4D6pHOdy/T9b/uOinkaoEMKhgN
         N3rI0qFo8wz23g5/u0mKYL/opCFRTnoTGeq01LVNhbZbsOidNTG+q8gClrvNyC9nyme6
         prubs184cDkOSYt2z2fzllmIINpbdHkwYE8imjaY08qg0XbyVp889Z84jxaUIJNjUvFD
         uB1uS0Ty5aqq/GiGozIG1aF7W6ZsE3QEw/Lxedb14zMzpeUs7xVOFOUNlSfIkTuE6cwA
         jZ0z1I4gzOWe5jFu55d85fcQJ2L+TRiO7PLWOjcDAeuBDKyrdsqrX0xp9VDDFXMKwtfw
         t9WQ==
X-Gm-Message-State: AD7BkJJlSUBUssg5Erqyy9oMT5jEtoL9cPHht18H3DPa/v6SFGkX43i0QzDB7BbM7A3VoemiLGvTp/6WcATEzQ==
X-Received: by 10.31.150.76 with SMTP id y73mr32597743vkd.84.1458582088411;
 Mon, 21 Mar 2016 10:41:28 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 10:41:28 -0700 (PDT)
In-Reply-To: <1458553816-29091-1-git-send-email-k@rhe.jp>
X-Google-Sender-Auth: GKXxMkYrT2myp_Hhu7EDwb2QxLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289426>

On Mon, Mar 21, 2016 at 5:50 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> When renaming a branch, the current code only updates the current
> working tree's HEAD, but it should update .git/HEAD of all checked out
> working trees.
>
> This is the current behavior, /path/to/wt's HEAD is not updated:
> [...]
> This patch fixes this issue by updating all relevant worktree HEADs
> when renaming a branch.

Makes sense; seems like a genuine problem. Some comment below...

> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -126,7 +126,19 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
>  test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
> +test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
> +       git checkout master &&
> +       git branch &&
> +       git worktree add -b baz bazdir &&
> +       git branch -M baz bam &&
> +       (
> +               cd bazdir &&
> +               test $(git rev-parse --abbrev-ref HEAD) = bam
> +       )
>  '

This can be done more easily without the subshell:

    test $(git -C bazdir rev-parse ...) = bam

Can you also expand the test so that it verifies that the rename works
as expected when the branch is checked out in multiple worktrees,
rather than just one. Likewise, it would be nice to check branch
rename from within a worktree in which the branch is checked out (in
addition to the test above which does the rename from outside such a
worktree).

More below...

> diff --git a/worktree.c b/worktree.c
> @@ -217,3 +217,41 @@ char *find_shared_symref(const char *symref, const char *target)
> +int update_worktrees_head_symref(const char *oldref, const char *newref)
> +{
> +       int error = 0;
> +       struct strbuf path = STRBUF_INIT;
> +       struct strbuf origref = STRBUF_INIT;
> +       int i;
> +       struct worktree **worktrees = get_worktrees();
> +
> +       for (i = 0; worktrees[i]; i++) {
> +               if (worktrees[i]->is_detached)
> +                       continue;
> +
> +               strbuf_reset(&path);
> +               strbuf_reset(&origref);
> +               strbuf_addf(&path, "%s/HEAD", worktrees[i]->git_dir);
> +
> +               if (parse_ref(path.buf, &origref, NULL))
> +                       continue;
> +
> +               if (!strcmp(origref.buf, oldref)) {
> +                       int prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
> +                       const char *symref = path.buf + prefix_len;
> +
> +                       /* no need to pass logmsg here as HEAD didn't really move */
> +                       if (create_symref(symref, newref, NULL)) {
> +                               error = -1;
> +                               break;

Is aborting upon the first error desired behavior? (Genuine question.)
Would it make more sense to continue attempting the rename for the
remaining worktrees (and remember that an error was encountered)?
Related: Since you're now dealing with multiple worktrees, you can do
a better job of letting the user know in which worktree something went
wrong rather than merely emitting the relatively generic "Branch
renamed to %s, but HEAD is not updated!".

More below...

> +                       }
> +               }
> +       }
> +
> +       strbuf_release(&path);
> +       strbuf_release(&origref);
> +       free_worktrees(worktrees);
> +
> +       return error;
> +}
> diff --git a/worktree.h b/worktree.h
> @@ -35,4 +35,11 @@ extern void free_worktrees(struct worktree **);
> +/*
> + * Update all per-worktree HEADs pointing the old ref to point the new ref.
> + * This will be used when renaming a branch. Returns 0 if successful,
> + * non-zero otherwise.
> + */
> +extern int update_worktrees_head_symref(const char *, const char *);

I guess I can understand the desire to libify this functionality,
however, it feels as if it is a feature of "branch" rather than
"worktree", hence perhaps it should reside in top-level branch.[hc]?

Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FCC3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1330F24699
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVswlhRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgB2Pv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:51:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40775 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgB2Pv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 10:51:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so719410otp.7
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNFPIPa3/bW6IvrLMoP/Y+vvimuL2pY0t73qD6PDOr8=;
        b=bVswlhRW39socWgNzlNDnwgLVCjaVxl4pA4LYoji6lZYFzfMjtI3jWLCJ+iOT2lWJd
         H3qixsfsSzuBSoaZ2dHVcGlD0uoCPBYkZrmO9L4p0uMt8OoUAdPtgNsXnE8/qh7IHZX+
         j+wtvkLonPdnSjMfFkFgPqOEdG+LLMEEgdOLZEIwGsBbqHUBMv9hBETYTbJFc5nB3kxY
         gnoBT+RbgJ+nNzsNALOz1IQr3JgAVec84lENIfb5moosByF6eh6ppmNBtUTuSJB1L+gs
         bQan18omyM7DJnUkjU8aIc+Un9Kk5hcl4bprjVLI0kgbv9AVv4TaCxO1JGYtbXwcQuKl
         KieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNFPIPa3/bW6IvrLMoP/Y+vvimuL2pY0t73qD6PDOr8=;
        b=Y/LLAx9BGUw+gHmNw9BQBfcXhgSLzd6bTMX5V+fuviG9L3+S2zcneyAOPzXRVxrrRf
         bm3uqaAfRfLOS4UxikU0EPpS4dPRYU3uXAnPC0K02zXoZlVGVvumCsA/8zHYD+4Fk5+K
         dMSfKJjJz9aeyiJpv2pWaekTFKDrrYLTORlESqctb+79O0F98RsoUzbcUqg39E19selN
         G5uNXuL9gWag2NasawtqpnZL4vPXAW+sP7HIJVGeLb1CWIIpIvFbQ13VhpTZN5yyX6mb
         XooxtEWNnokFyC5Epd+rVcsmDjZsYkLsNCxdK0tf8yyHgr6RfUtzg6teS8kdBPiSlYul
         JvVA==
X-Gm-Message-State: APjAAAUjCUyVh8vjYmbnHD/u/e+1cq7mdffNY3QoKMF+0teZ4R20ahOb
        ASt+HsZMtptcVHTAcJmL+HJpfes7bwrxUnf1F1N+HQ==
X-Google-Smtp-Source: APXvYqxDc3AWoCbrvtdJHjAJ84WCj9tjVbanBUTZB+5bMP/bgZ3vIBySEQx0snnoPq+RsBp7F3nr3Fv8Voq0XitYblo=
X-Received: by 2002:a05:6830:c9:: with SMTP id x9mr7261022oto.345.1582991486830;
 Sat, 29 Feb 2020 07:51:26 -0800 (PST)
MIME-Version: 1.0
References: <CANXsDork=bL=SUodXDzkcnjpPALm53e++UkVkJFWxaZPMBK-SQ@mail.gmail.com>
 <13cdf33b-7ca2-c391-fddd-53bdbae7f0d3@gmail.com>
In-Reply-To: <13cdf33b-7ca2-c391-fddd-53bdbae7f0d3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Feb 2020 07:51:15 -0800
Message-ID: <CABPp-BFDJL5sbfY_CK_VuO0+hR3ZNsZqQKoRWNFMjwkqt52Riw@mail.gmail.com>
Subject: Re: rebase --abort Unespected behavior
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Blaise Garant <blaise@garantcoutu.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Blaise,

On Sat, Feb 29, 2020 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Blaise
>
> On 28/02/2020 17:36, Blaise Garant wrote:
> > Hello,
> >
> > I don't know if this is a bug but it was unexpected for us. I
> > accidentally added untracked files through a `git add .` while doing
> > an interactive rebase and aborting the rebase deleted those files. Is
> > this to be expected?
>
> I agree that this is surprising and undesirable but it's not unexpected
> given the way --abort is implemented. 'rebase --abort' calls 'reset
> --hard <branch we're rebasing>' so it will discard all the uncommitted
> changes in the worktree and reset the worktree and index to the branch tip.

And it's worth noting that if they had done something similar outside
of rebase/merge/cherry-pick/etc.:

git add $UNTRACKED
git reset --hard

then the $UNTRACKED file would be deleted, so this isn't new or
unusual but matches git behavior elsewhere.

> The tricky thing with your situation is that the files are tracked at
> the point we call 'reset --hard' as they've been added to the index so
> git feels free to discard them. Perhaps rather than calling 'reset
> --hard' it would be better to use a custom callback with unpack_trees()
> that errors out if there are any paths in the index that are not in
> HEAD, the commit we just picked or the branch tip we're resetting to. If

Should such a special callback also be used for reset --hard?

Also, this special callback, as stated here, wouldn't work: paths can
exist in a merge that didn't exist in any of the three commits being
threeway merged.  All of the following situations are cases where that
can happen (and there may be more that I'm just not thinking of off
the top of my head):

1) merge in a not-fully clean state.  rebase may disallow this, at
least right now, but merge traditionally hasn't.  I'm not sure
cherry-pick --no-commit disallows this.
2) directory/file or submodule/file or submodule/subdirectory or
regular-file/symlink conflicts. the merge machinery should be free to
rename paths to something that didn't exist on either side so that the
paths from both side can coexist.
3) directory renames.  If one side renamed z/->y/, and the other side
added a new file z/new, the merge should be allowed to move that file
to y/new (depending on the setting of merge.directoryRenames...).
Note that y/new didn't exist on either side of history nor in the
merge base.

> we do that we should consider using the same thing for
> 'cherry-pick/merge/reset --abort' as well. --autostash potentially
> complicates things as the file might be in the stash but not in the
> other commits but lets not worry about that at the moment.

reset --abort?  Not sure what you're referring to here.

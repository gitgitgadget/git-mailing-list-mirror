Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 05:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbiDTFPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiDTFPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 01:15:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE233E22
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 22:12:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t11so1075057eju.13
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 22:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yhXCXw0UAhsJ3AEBNMliEmM1rDxwHvX5rn0400zccD8=;
        b=VBUzOAGVlg5rVjRHQohqLqijjrkJ0zgQ7OIu1qp40idgoXXytJPAS5t8gvB1cHPQjO
         ZL39X6pDQ8Q7EjgHhhMAfETW/u2+cAn+A0OLRGhH4Bv/qbuLL54dzBtJ4eW2d1gpIy1C
         6k1MYWMoVWbSljWz/DgVImRKssf2mBfMDpg4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yhXCXw0UAhsJ3AEBNMliEmM1rDxwHvX5rn0400zccD8=;
        b=3s/p6wqeGqqrxcbDJ2oeGOpu2BLMiu+/eTk+Q5kfVCD4nsmEXs1HvThrL/T/+M1FSp
         UcXlxdGUgNbmvChU5M+dzImnTzvKwfBIdmldQS7AQWgHvCYRbTieaQmYOVINgJmbKGLb
         RrXQh8Uz/5/htq8EWrHDtHxnnzK+xJpU4FtA/CcIohz8NaO5I9OACrQZp0dXAAMaWaf7
         Z+bL+KhK+AjGYT9PLwPOBpKJhpYiZJMiUBs1ABgE+jVbvNm7iDGYi0OTkjEIfVgplfun
         S/XEvAaDaoOacKIQBrqI/52aVDduiQ1OtkzHmfWxxENKQVa2kFjm9ujbcfQ9l1EAtm3A
         7QvQ==
X-Gm-Message-State: AOAM531S0OBjJqel1eU9fNTXNUeeULY4L/x/rgAW1wuNWyjJ7qrSne9I
        lbCmxGcugbkh81B9mlgvjy9OXm0ioa0VhP8Hf6+wyA==
X-Google-Smtp-Source: ABdhPJyVYff9lI3OL4e4nbdKieZI+cjZN88LjNKtg0FuLXUWHbLEQ7+cADoWNbn45Z331PxrAMRvPZ+oUvm0PLdbFZE=
X-Received: by 2002:a17:906:4d1a:b0:6e8:8860:8a72 with SMTP id
 r26-20020a1709064d1a00b006e888608a72mr17308053eju.540.1650431538556; Tue, 19
 Apr 2022 22:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
In-Reply-To: <Yl2qwO0SMPOhb5h9@google.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 20 Apr 2022 07:12:06 +0200
Message-ID: <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 8:15 PM Josh Steadmon <steadmon@google.com> wrote:
>
>
> I think this is a good solution for relatively inexperienced users, and
> I don't see any issues with the implementation or tests.

Yay, thanks for the feedback!

> However, I
> wonder how users for whom this may be useful are going to discover this
> option? I don't expect that such users are going to be watching Git's
> release notes looking for new features such as this, or carefully
> reading documentation changes.

Honestly, I was being a bit selfish here - I effectively control the
gitconfig of "my" users, so I was planning on enabling this by default
and letting it "settle in" in git at large, eventually proposing to
change the default.

I understand/agree that this is a little naive - if no-one has reason
to try the new behavior, very little information as to its
usefulness/appropriateness is likely to emerge, and it will never be
an obviously good idea to change the default.

>
> In the discussion on v3 of this series, you mentioned you were thinking
> about adding an advice setting to point users here; is there a reason
> why that didn't make it into v4?

The advice I mentioned I would work on wasn't actually about this new
setting/behavior, but rather about the previously existing (and
reasonably unrelated) "not tracking: ambiguous information for ref"
error, which I found to be unreasonably cryptic.

I submitted that advice change as
https://lore.kernel.org/git/pull.1183.v7.git.1648793113943.gitgitgadget@gmail.com/,
and it's gone out in a recent release.

> It seems appropriate to me to add one,
> perhaps at the point where a user with "autosetupmerge=true" would run
> into a failure when trying to push?

Having thought about this a bit, I agree. On the one hand I'm a little
nervous about adding this kind of public behavior change as I would
imagine it's more likely to encounter resistance here, on the other
hand I do think it will make the changes themselves much more useful.
Also, this patchset hasn't moved in a while, so "holding it up" with
new changes may not be a significant concern.

the current advice looks something like:
---
fatal: The upstream branch of your current branch does not match
the name of your current branch.  To push to the upstream branch
on the remote, use

    git push origin HEAD:master

To push to the branch of the same name on the remote, use

    git push origin HEAD

To choose either option permanently, see push.default in 'git help config'.
---

I would propose to add one sentence at the end along the lines of:
---
To instead avoid automatically configuring upstream branches when
their name doesn't match the local branch, see option 'simple' of
branch.autosetupmerge in 'git help config'.
---

Does that make sense to you?

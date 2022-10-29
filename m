Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB66C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 14:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJ2OyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ2OyP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 10:54:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348830F72
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 07:54:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v27so11793831eda.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d9xKGREHQPnnoXxt0lM1Z9EmhRZYjeGB7UCVrwbt2Xs=;
        b=k0sjKhrwutqQNy5DQ+J7ATPK+67OH1h0GtuEAD82aEe7JowMesbsMH6o95ORVYoSHJ
         gU1gOOb5DIa64KQvPOkd6Co/a9kVhh2d2XdOiQ1MF0SA1VLvqRC55eQD417GoL7gKt1/
         Pao2aIKx8edeaPxdj/TrRSHD1FZXGo5DLGa8q26SHbLEDPCVRZKhxCbBKHSZpQRgF6fd
         kUNxreJQWp7/tt+Hk/PVj0oYAtB0GzBRZUFRzULiW2AId3101O9k97yDGQiRtJv6zGtX
         ZZcsBdseDgy3X3J/UDdVgekidaQJnW+lLdnXedSok9R3geeJQv7jYURowhq6U2DmTbvv
         dp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9xKGREHQPnnoXxt0lM1Z9EmhRZYjeGB7UCVrwbt2Xs=;
        b=AcRjeGiO8AJNFE9wzhMOlhaILSHLPpImP/WautpUv80pbvEdf0gvhgk7p1mc4wELoK
         1C5dvdaywnUh+a0aYJZ6+VGPLvo9l+/2xMGO3J9N2VaXt+6ZlZxKFmKv1cJznVC+BcBx
         NJvcXfiOt/Sm1Mi2G0vQXnGny9P362PdBFekQSnetXFANk5m6fDueI0c3XqAktwowvPF
         StPLStFVz+qXYMc+or0QpNrMhdQfR34dLpxCbr47q3cZF62qDI0lqil+b6EoPVLVkK2x
         XHevXlaz3wofckl3nvxbRArkvzbYY7IVGBwCehvB4NrwrGWT69is4f5Q4q0tAXstKsBr
         Bung==
X-Gm-Message-State: ACrzQf3deMPwFI2wNRUk3FciqnkWv7AVYXu1fJTT3QtEM7BdaieniuLw
        he5lECnWVrVqlBY0CgT1D0gOeYJQosrm2wMGU6ETkWt2g2w=
X-Google-Smtp-Source: AMsMyM5ceLNlzT3G4qHtFg2AFxzyjMt5PqjNASIhJVUOjHqWllZj0J2UyXq67WK/XhZfCV8cHXuWQ5OKFj+SqCmIYn8=
X-Received: by 2002:a05:6402:3487:b0:45d:2674:d187 with SMTP id
 v7-20020a056402348700b0045d2674d187mr4680221edc.386.1667055251078; Sat, 29
 Oct 2022 07:54:11 -0700 (PDT)
MIME-Version: 1.0
From:   Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date:   Sat, 29 Oct 2022 16:53:59 +0200
Message-ID: <CAB1LBmsxiRHRpOibHC2c_LLAn-QSQ+qeaKF0TxQ2y8mBqTXoNQ@mail.gmail.com>
Subject: Maybe default Commits History Simplification could be more sensible
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

From here :
https://git-scm.com/docs/git-log#_history_simplification
I read :
> Default mode
> Simplifies the history to the simplest history explaining the final state of the tree.
> Simplest because it prunes some side branches if the end result is the same (i.e. merging branches with the same content)

But I am kindly questioning if the "explaining the final state of the
tree." is correct.
Because I had the following case :

If :
- commit 1 modifies some lines of file f on a branch b,
- then commit 2 modifies some of the same lines of f on master,
- and commit 3 revert commits 2,
-  and then commit 4 merges b on master,
then without --show-pulls, with git log on file f you see first 3 commits only ;
and there is no way you can apply these 3 commits in sequence,
as depicted, and obtain the master's current state.

When you use git log on a branch, you expect the default :
- to give you all that happened to your branch,
- or to give you a list of commits that applied successively explains
the current state of the branch.
I know that with trees a sequence of commits is not sufficient.
But it would be a good property of default history simplification that
your current branch state can be obtained with the first parent
subsequence of displayed commits.

Currently, default history simplification for git log on some branch b
also gives merges of branch b on branch b2, if later on branch b2 is
merged back on branch b.
To me this merge commits are less interesting than the merge commit of
branch b2 on branch b at the end.

I assume that the simplification of merge commits was intended for the
simple case :
- create branch b2 from branch b1
- n commits on branch b2
- merge branch b2 on b1
If no modification was made on b1 during that time, I agree that the
merge commit of b2 on b1 is not interesting.
In that case, it could explicitly say it displays commits on other
parents that could have been automatically rebased.
Like :
commit hxhxhxhxhxh
date
done on branch b2
merged on branch b1 at date, could have been automatically rebased
Message : It was a nice commit
...

But in the case, some common file was touched on b1 during that time,
then it should give the final merge commit. (Solution 1)
(I said touched instead of modified because of the revert.)
Or it should also simplify and remove the commit and its revert on b1.
(Solution 2)
I would prefer either Solution 1 or Solution 2 to the current default.

Many UIs above git use default history simplification.
Github for example uses default history simplification.
And you cannot customize the commands used with options in these UIs.
So I hope you will find that having better default is an important topic.

Best regards,
    Laurent Lyaudet

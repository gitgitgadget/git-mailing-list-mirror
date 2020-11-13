Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728AEC2D0E4
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFFC21D79
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX/CVokm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKMAEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 19:04:35 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207DC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 16:04:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so6755195wmm.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 16:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GzjkPtKj/trJBsU7fj+wG9Nx2xAnoaTgoeQibxlEL7Q=;
        b=QX/CVokmUVtWwQiua/l+PjnQNJXxLE/BLZ4GFD/ETNydYHaLwi6g5XwioGQ2MvHGmk
         3/t1tPIy50s1EdBEWReyfgl9l29/zjtEB1elNN0gIufvpsrrVY0VMZ3lsK34q6841vU4
         daW9DFgmuM4uCxf22FKGEl4JiB7uQ51uqI9tBOKnlXKXiHLhwx4XhFThlwRila3XrfWj
         kULxrDTM3ZIzLdMdpiXA2YJAHM228R4tTJf9odSJdlFPE8W3zDV7vfXDdsF4TW9zcYsC
         U7T6YEmch0jLn0aY8qu6QLLtZjMRP6Ry5Oxrv59/2U0I4OUtMItDbKmcbjgkSLh4smTi
         Kang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GzjkPtKj/trJBsU7fj+wG9Nx2xAnoaTgoeQibxlEL7Q=;
        b=rBx5+D5DsVK+WwmsA5EokZdsXsfT3hQ5mHduSsdG4w2bnqGcnaiNWh/zxGA9oYb0mD
         7l/rxU9fVbAwhhXGRyf5VA1lRd3CoMRb6fvYCDFsZopfXHJDeTkmxzu08uvL/TthxTDu
         BETMDi20+9xR+zvzyiF6JU4vB+ftk2M8WHH50SX/ky0CvWBCvPPbz9Y1VslzDdphEpbe
         11WdXD3C3eeioZcvLCoVqc0V+DdwTLGDXz2Jle7DnblXINbw6up63I8DID3IwI1E0q7d
         wf022/sD6Bb0cmDbD3bw0icP7AVbTxZdHSNi8PXF8uwCNyoI/LGF17lwAvcqlNZK92Jn
         g0+Q==
X-Gm-Message-State: AOAM530wvmp+REWpchbD9dlEFZsdLN5r6HRgf3Ll80WhOoGlkr47bJHZ
        TQYBCuqXxMDb5ZIQNZTE+tKxV4GR8m6xTiteob9yAl5U4GtA1Q==
X-Google-Smtp-Source: ABdhPJxXrYCuE7CtxpoG1TK3MxAh84GZ4eR6zrUmspeGh2xTappIJwZ0BQQ6nWC0mNrGJHKajRfXeUkLVAhhTOamhVI=
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr307469wmf.55.1605225873873;
 Thu, 12 Nov 2020 16:04:33 -0800 (PST)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 18:04:23 -0600
Message-ID: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
Subject: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Some of you may remember the fiasco that was the v1.6.0 release, which
obsoleted all the git-foo commands, and caused a huge revolt among
users.

What you may not remember is the suggestion I gave Linus Torvalds to
avoid such issues in the future: [1]

  What other projects do is make very visible when something is
  deprecated, like a big, annoying, unbearable warning. Next time you
  deprecated a command it might be a good idea to add the warning each
  time the command is used, and obsolete it later on.

  Also, if it's a big change like this git- stuff, then do a major
  version bump.

  If you had marked 1.6 as 2.0, and added warnings when you deprecated
  the git-foo stuff then the users would have no excuse. It would have
  been obvious and this huge thread would have been avoided.

https://lore.kernel.org/git/94a0d4530808290712s2044dd03pb93cb4a829dc56b0@mail.gmail.com/

[It's worthwhile to read (or reread) the thread to consider the
arguments back and forth.]

This is precisely what was done for Git 2.0, with the addition of
configurations such as "push.default" that enabled the new behavior,
and if unset, a huge warning was issued.

The deprecation period allowed users to become aware of the upcoming
changes, test them, complain about them, or simply disable the
warning, and continue as they were.

The Git project learned its lesson, and the transition to Git 2.0 was
much smoother than v1.6.

Now with the master branch rename we are treading on dangerous waters again.

Regardless of the reasoning behind (of which I didn't see much
discussion, and I can provide strong arguments against), the move will
affect *all* users. Such huge changes are meant for major
versions--like Git 3.0 (which we are due for).

It is not a question of changing one line of code, it's about updating
hundreds--probably thousands--of instances in various documentations
that assume the name of the branch to be "master". This is what I
argued back in 2008 when I pushed against the sudden move to "git
foo", although apparently too late to be considered. [2]

*If* we are going to rename the master branch, it should be with a
good reason, after discussing it appropriately, in a major release
(i.e. Git 3.0), after a period of deprecation, and a big warning to
invite users to provide feedback about the important upcoming change.
We can hedge these types of changes with a "core.mode=next"
configuration, as I argued back in 2013. [3]

If we don't, we are inviting what happened back in 2008 to happen again.

"Those who cannot remember the past are condemned to repeat it." --
George Santayana

Cheers.

[1] https://lore.kernel.org/git/94a0d4530808290712s2044dd03pb93cb4a829dc56b0@mail.gmail.com/
[2] https://lore.kernel.org/git/94a0d4530808271709s4e96c5a7ie6152b2937f2234b@mail.gmail.com/
[3] https://lore.kernel.org/git/1381561485-20252-1-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras

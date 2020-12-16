Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11608C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB88C2333E
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 10:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgLPKt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLPKt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 05:49:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4901C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 02:48:46 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d8so22467634otq.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 02:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sXkbJ9/dfqz7wLw7g9BFlviV7zGKZ7zqH+zXebpu8Fk=;
        b=dsfcgDZjjN+3uWbiBGKHJPDxUtKeOxjc0ERtbrfbq2wT8L9agMuyebPjNeg1obuTOh
         l7vQ19n8rrkM5FZAdtesUZR1k4jXc+7Mt4wbyMATE1K0GdSLPeyE2F9NCY66WwU0wwTy
         nQfe+aw1nmI9yw4RfxjtAhj0BZbVcjl+BYIkQ6TceQ/HrlpSyk1E9nYPw4YEdBli43PA
         no7ZNNu4jSEbiHSTKapinz3ZzEFWAY444XjucAUrSNu0rCGuV78mjhKn/kizAqYiYgZA
         uq+wKgrsZn1CDGZnR7I0z8HB0cpelvXhIR0QXMnJnD/o+jZOK0C1odgZYCizpgAj1jj1
         PGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sXkbJ9/dfqz7wLw7g9BFlviV7zGKZ7zqH+zXebpu8Fk=;
        b=btk7uBGVb76/bKZNTYb7tRFm4lVVHoPEwJlhE38OYS+qxwHip2ffG+Qlvx1lxMnq/S
         jLLV6cCz3g9DqAgD1/Hj/8SHbitr53ldRtyUZdYK6n9w5xT1if7XC+DOpmITkOEny2K/
         CzrcqsGRD4VQmvByFAoAZo6A2wXulIMvz+L8T/FIVsiC6Zhx6uqX2tsBbEK7gA8Sp3m3
         Dv/rXVbbqTr1RhXJI9rJRWYzTHjS1RCsyH+mslRRe0XyuvqQ1uPpkQ7qrbC+c3cuno9a
         DEk9FmweZFXLXrIvN6rsTRd7OEUzkBcqfxOz7m7oD3/Eecl7xzgFvHuR76RLTmbPfK0k
         L1fg==
X-Gm-Message-State: AOAM530jYvz2zw86g3scwQY1hpDW2UXvOE5LlOXQONVADYKcPYY4GIOk
        eDpKR3xfKY0gobOkUHxqexZZIwS2SboJhCyNLtFcZLTDIiQHCg==
X-Google-Smtp-Source: ABdhPJyI2BM970BAscY3LrayMSsGTtR+PPMLugqizdK/4FWAob/JwZsC7KA6suXclWv4IVXzlfbCN/4eYdxqL/FCmNA=
X-Received: by 2002:a05:6830:17c7:: with SMTP id p7mr25762883ota.21.1608115725599;
 Wed, 16 Dec 2020 02:48:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxW-LwjLWF9PPuSJmbAafw37d_18j+HmOd4+8MKbajb_8A@mail.gmail.com>
In-Reply-To: <CAHMHMxW-LwjLWF9PPuSJmbAafw37d_18j+HmOd4+8MKbajb_8A@mail.gmail.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Wed, 16 Dec 2020 12:48:04 +0200
Message-ID: <CAHMHMxW_zwq_xK3Mh5QjC4dM1muVotESZdGQkRAx8xeKYmHzbw@mail.gmail.com>
Subject: Fwd: Bug in `git add -N xyz ; git stash` command
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I think I have found a bug with the following series of commands:

$ git add -N xyz ; git stash
error: Entry 'xyz' not uptodate. Cannot merge.
Cannot save the current worktree state

It has bothered me that `git add -N xyz` "is not obvious that it is
done", unless you know that you did it - and now it seems that there
is some buggy behavior about that.
I could've sworn that there is not even a file change on the
repository (because I sync it between a VM, and after a `git pull` I
saw 3 file changes, two of them being the branch head and the log
branch head)

With regards,
Ntentos Stavros


---------- Forwarded message ---------
From: =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=
=CF=84=CE=BF=CF=82 <stdedos@gmail.com>
Date: Wed, 16 Dec 2020 at 12:32
Subject: Bug in `git add -N xyz ; git stash` command
To: git <git@vger.kernel.org>


Hello there,

I think I have found a bug with the following series of commands:

$ git add -N xyz ; git stash
error: Entry 'xyz' not uptodate. Cannot merge.
Cannot save the current worktree state

It has bothered me that `git add -N xyz` "is not obvious that it is
done", unless you know that you did it - and now it seems that there
is some buggy behavior about that.
I could've sworn that there is not even a file change on the
repository (because I sync it between a VM, and after a `git pull` I
saw 3 file changes, two of them being the branch head and the log
branch head)

With regards,
Ntentos Stavros

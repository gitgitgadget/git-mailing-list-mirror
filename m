Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0862C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B963961184
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhHWRb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHWRb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:31:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD0C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:30:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t13so15982980pfl.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oYyCaelvKz4qFj2j0B87kcyICv6LpMGL/ZVv+7PqDu8=;
        b=FuVmTt/Ua+MwS/TcRJaDxcHYBeJEySQRCwwGuv9BkSk7lJfShV+fPg7gGKVJA860xk
         +Nfmb4FQ2EH0WepqIUxjYvzgF9rWUtjOryhNiE8ym1o0vR03SPazzuR+PvidpRXTTli9
         O2SO7DFtEk3YB84bVMFeovaxDI1fsPOIo44HeiTGWp6NRgC3ezbPsBdNKVgHQGNDO6xo
         PQsHoMkDiQHIuH5Rvk28AoiG0SBVAnFWF7867jlXw+/BANIMfXuoozmCAASLDLke+8Zt
         Cx0vEBO88HihDpucXS0BQUDUDzBsjZj1m3hdGbzZ29L/BmmvJTbzOSewDBL2ywtK1LOk
         t6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oYyCaelvKz4qFj2j0B87kcyICv6LpMGL/ZVv+7PqDu8=;
        b=SXQiVGFVnVmpeq4kGZftkUoGjKWSILcb37KrOk5dkdHKlbX4oVt0+G1+Hek0cmiZ2U
         V8ZtkIhQAGSfmW5c9upZy7+vgPXE9n5CgQQNL+s5alvnUlgSjCTnGnYktbgL2SUX7G/K
         ogpN/8lNV342v4friX+xLqoWf+BxJm+TMijN1So1C9F2oSY2GMgyShmlPbtNahAGpYCQ
         5+/l/fLf73fy0Ovjxm/jKAwXJWxR1dQWghn1f7mgvMLb92mWbk8zWEBId9bYwPeRidx7
         ljvW9he0zpd9RotnSdPbptnqnVk9vzdFPCoqqJbj+YhPFoUY49+kJ93jIO4xDnUMMo9H
         IDqQ==
X-Gm-Message-State: AOAM533T0QowLt3TVFKQPGaDnnRY6fWpOfyd5h3OPPjiB46mU/mrIhb2
        zhPsA9178dCvG4uN2VNjCzlaizgbYEUBNkROiF0bf9FvmAE=
X-Google-Smtp-Source: ABdhPJwsbK4Ouys6dEi1a5IMlfs5F9GwJGkEIgp251YVdTa+EQuFBeUl3zBMS3R4axWT5Q2paFl8yoFZrD+zj7lLGdU=
X-Received: by 2002:a65:6701:: with SMTP id u1mr32855219pgf.138.1629739843600;
 Mon, 23 Aug 2021 10:30:43 -0700 (PDT)
MIME-Version: 1.0
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Mon, 23 Aug 2021 19:31:29 +0200
Message-ID: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
Subject: git read-tree doesn't accept tree-ish
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

```
git init
echo foo > foo
git add --all
git commit -m 'foo'

echo bar > foo
git add --all
git commit -m 'bar'

git read-tree HEAD~:foo
```
EXP: Read information about file `foo` into index
ACT: `fatal: failed to unpack tree object HEAD~:foo`

I expect it to work because manpage says that `git-read-tree` accepts
`<tree-ish>`

Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976FC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65802166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 08:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgCDIPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:15:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgCDIPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 03:15:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id z11so1160075wro.9
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 00:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IXYtf/8NlgsTMNQbhfjCbMWMBYORvBp33/L+EUWS6U=;
        b=eCzMWlVpZo8OdSmyZb+HgNPbERbhREpHO/dgdLGwDuTB53k6q3KlAUpsKyYOEWlHFv
         KVGyHk63Rn6BNZWtFLEl9RSQz6+slW8Q7oY59vEzy5ddHgVXN8sPRHMjOejOa3a0q1Ip
         xfvGS9Jq4ASBTlWVHqCUbnEmKjqxrleT6e9YQTuDEoeUT+um1nYgnR3KCje9rUznTKUW
         gEL4pedl1c8f98G/PnaW93UJV0DzYtdJkvsCLTghq4KpTddO/4z9dKXSjA3u8VHAXzUi
         lXyUHi/7xbGsy6qV0+oAf9I+DXElh+wkl95oJ1wl3tX+0k+QX1ffrkw9bBNg2tX5oJgS
         xeDg==
X-Gm-Message-State: ANhLgQ2VOd4nupFWAD10UqPF7tK7ODYjLIZrL5UPJbRdNXijsvd/7lIp
        WeEUurWjDv07+x2BIyI++52AO5ENwvl7k8JJRS9UM1so
X-Google-Smtp-Source: ADFU+vvJVRqv/EpxfM8OhmVykGU/dPEz0DI1Fwvg0Ly5EZGJJgJg/DDPv6rY5+Kt6ek23/5/5kGuAVlgsoBKCiaQvOE=
X-Received: by 2002:a5d:424e:: with SMTP id s14mr2955962wrr.226.1583309716202;
 Wed, 04 Mar 2020 00:15:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.570.git.1583305200143.gitgitgadget@gmail.com>
In-Reply-To: <pull.570.git.1583305200143.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Mar 2020 03:15:05 -0500
Message-ID: <CAPig+cRBNHX516_cQ_G-2azL61xOo5ndOHV_E-OmQ4XvpwBffQ@mail.gmail.com>
Subject: Re: [PATCH] t2402: test worktree path when called in .git directory
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 4, 2020 at 2:00 AM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The bug which reports an extra `/.git/.` in worktree path when called in
> '.git' directory already has been fixed. But unfortunately, the regression
> test to ensure this behavior has been forgotten.
> Here is that test.

For readers not involved in the discussion, this test was requested by
[1], but the topic graduated to "next" before it could be re-rolled.
It probably ought to be queued atop
'hv/receive-denycurrent-everywhere'.

[1]: https://lore.kernel.org/git/CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com/

> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -151,4 +151,10 @@ test_expect_success 'linked worktrees are sorted' '
> +test_expect_success 'worktree path when called in .git directory' '
> +       git worktree list> list1 &&
> +       git -C .git worktree list> list2 &&

Nit: Style is for the redirection operator to stick to the file:

    git worktree list >list1 &&
    git -C .git worktree list >list2 &&

> +       test_cmp list1 list2
> +'

The test itself makes sense.

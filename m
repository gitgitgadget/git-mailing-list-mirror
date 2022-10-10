Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B6C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 00:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJJAm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 20:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJJAmf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 20:42:35 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9E37427
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 17:24:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y4so2805740iof.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 17:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWUyaomrUhnSrtpfnP3C7VhNF+/DiRmiQbtLVRz+6sg=;
        b=Lec7/+ikTocAfeRa56U2Zxyy0bx/G9Hbu+pGQq14SxBHnWGX33wgrhw6BsREgUNi3H
         V+oq645QX0Iitsyx8R/mc/xHt4Loq5KaSwkI3YaOxvr0rd1eQq+jM/JFUJIwri8puQiE
         KN5rMl7PbqUwpZ8skkq9a+vuUvocxG+lvQFdj5akFKIDJ2lVQDD5tsxe6rQDZx1kCJaz
         01hMxpdiw2Aoo7WkDiVDPF1wg9N02mQvD8cQdP4JJd+Hry33ThHfoh650xJg2ioRou7R
         xPBPrUDepZyLkmq2wzLcdYlOKG8ERp/BhyqRbnMB2FxJePNQMSeEB2Tvpu/KKqSe5RfO
         hJpg==
X-Gm-Message-State: ACrzQf0yytfjqQG5+80/jtyn1dhhikAX/3AQPVx9t7lk2nH0O2YX0/eT
        5Z68Y7UBxp8vMzIAggdv8nWlN0tfNaZZSbzpevNGJqLSBx4=
X-Google-Smtp-Source: AMsMyM40ZuyHuim2es/DDYZAJcVKs9D5ZUP72ZqB+TM3HHZDRYTaullWXquEyOv8h751QHyCHOWvMOTgZ2vKD1cdS5M=
X-Received: by 2002:a05:6638:4092:b0:363:bea8:b0c0 with SMTP id
 m18-20020a056638409200b00363bea8b0c0mr69741jam.221.1665361172913; Sun, 09 Oct
 2022 17:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com> <xmqqsfjw63f6.fsf@gitster.g>
In-Reply-To: <xmqqsfjw63f6.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Oct 2022 20:19:21 -0400
Message-ID: <CAPig+cRqKvu-hLRpd3KZf-UmV92mpgfAuieBBzUPR2JQ0s9AdA@mail.gmail.com>
Subject: Re: [PATCH 00/12] fsmonitor: Implement fsmonitor for Linux
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2022 at 7:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> > Windows and Mac OS.
> >
> > This patch set builds upon previous work for done for Windows and Mac OS
> > (first 6 patches) ...
>
> For those who are watching from sidelines...
>
> The Windows part is already in Git 2.38; the changes needed for
> macOS are already in 'next' and the first 6 patches in this 12-patch
> series are identical to them.  The patches 7-12 are new.

Thanks for clarifying. I found it confusing that there were a number
of patches in this series which I had already seen despite the cover
letter's claim that this series builds upon "previous work". Thus, it
wasn't clear whether this series was a reroll (refining some
already-seen patches) with additional patches for Linux, or if it was
purely new work with the original patches included by accident[1].

[1]: In the few times I've used GitGitGadget, I've had to jump through
hoops to make it send just the "new" patches when I've built a series
atop some other series only in 'next' or 'seen', so I can understand
the inclusion of the first six patches being accidental. (Regarding
the hoop-jumping, it may be that I just don't understand how to "work"
GitGitGadget or GitHub pull-requests.)

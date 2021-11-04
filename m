Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B6C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC58610FD
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKDOP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhKDOP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 10:15:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89613C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 07:12:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h74so6016863pfe.0
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKwzkqUvf5KBohoQ8SGqrxZt4uDMBy1hQHwB8JR8Fho=;
        b=dI0aW6S8wQOk+jT+w1RBsXQo7d5+qUdCdoG3CDMv41Jpa0JVggfk7BK/zcie9P/xBK
         FEXLLANOvvHM2yitRWSbc0pgQSkl3NWvVVEEjQwuuw5TbY3H5Gh8a2jMuCSK+W2pNgT3
         dRvybUobf9Pf4T3mnUJMRwsnykdSiW+LUUT0Gh7Eh9KSUOjyZI4BR1wHJ5jNPdiUtTiq
         em350yviML7YSDK46KXztdDgp7gu7pis1ZHXP04VJ5CDG5jLchKsHrkHF4e0qf1Te3zY
         3bZRPGI4e2CQLQgZ8mk+Z69f8Y5sK0N9w8sgkJqPulv38K2Sq5Svr1KXGoCRkF2LQBta
         14Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKwzkqUvf5KBohoQ8SGqrxZt4uDMBy1hQHwB8JR8Fho=;
        b=LfOVHeh3MQX/aXGv6QCeQM5xNR7qVGGejTBCS6iR9QwcLQ2QVrkS5glSNbeppS/TrK
         Oxwo9K7mbWcLERWqLmZ4L+O/B+/EKfiSKbK1sNNTFpd+AzNpjZ9v4PRBPhcLEH5x6wUE
         Kf9XYAJiIESDRcnicx/GxmGceEZGBJvAtqYpL3P7qdlSd+n4zA4Ja0IQRepir81I1mD0
         kK3oVfCDIJflB3+jiXJppZG3xzUoLwkB9aXDtgvA8dbb8EKpbbgbLfbWoaSBkQqGVHDH
         KF7A3XCLx+Vi7ZafSjANJ7MPpVid3n66N/b2icrlmlv6lE+jaSMPe9oTgabSz4+Gn74g
         RMHw==
X-Gm-Message-State: AOAM53344UJLRNr/IZeJOaPUTuucPxXRorJRhQ/C0Wl+ITYcZaYPv77z
        mqATR11oN6aY8gFm3zRLnXzESD2BzXxVxE0nHhZiE+V+XrE1JI6Y
X-Google-Smtp-Source: ABdhPJy5WjtVJJd+A1DgltqyiBEpalN/E3m+V/gnFmZ3eDaKColBQxh11hF459oOUUOZbhpSTBgT6KbgMggsGqKgcOE=
X-Received: by 2002:a63:8749:: with SMTP id i70mr23387512pge.158.1636035167928;
 Thu, 04 Nov 2021 07:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net> <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
 <YYJuK70U8Sk7xSYl@coredump.intra.peff.net> <CAP8dQmsbR7V1zX=xpk+ah-5bgkOP3vJGTMBq_25m9Vhw_fADAQ@mail.gmail.com>
 <YYOrLgj3KMq6eKpp@coredump.intra.peff.net>
In-Reply-To: <YYOrLgj3KMq6eKpp@coredump.intra.peff.net>
From:   Steven Penny <srpen6@gmail.com>
Date:   Thu, 4 Nov 2021 09:12:39 -0500
Message-ID: <CAP8dQmtLt_2+ExGUB71nJz_PWHKRrzqQVtX7d8T6FpPqgatiFQ@mail.gmail.com>
Subject: Re: credential-store get: No such file or directory
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 4, 2021 at 4:43 AM Jeff King wrote:
> It's because internally, the "git credential-store get" command is
> assembled as a single string passed to the shell, whereas remote-https
> is run directly via exec/spawn.

Actually, I bet that is whats causing the problem. I am using MSYS2 Git [1],
which is not a native Windows build of Git, but one that relies on the MSYS2 DLL
for path translations and such. I have actually built a Windows native Git, but
its a pain, so its easier just to use the package. Anyway, the "non native"
Windows version, probably considers Bash the shell, so any commands being passed
to a shell probably will be looking for Bash. I dont have Bash on my system,
because for the most part I dont want or need it. If I need a shell, I just use
PowerShell.

Would it be possible for Git to just run "credential-store" directly, like other
commands? I assume stuff like "~/.git-credentials" would be a problem, but
couldnt you just do something like this instead (pseudocode):

    var cred string = os.Getenv("HOME") + "/.git-credentials"

1. https://packages.msys2.org/package/git

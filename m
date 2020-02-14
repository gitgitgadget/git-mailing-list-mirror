Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED1C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68620637
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntBcs0ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394534AbgBNRM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:12:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42797 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392106AbgBNRMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:12:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so8537316qkj.9
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8Of/a8ErL4zTP1GCVNS2kiwWaPiaRH73h/xqKoWeJo=;
        b=ntBcs0ZVAYU7sB7M1zT0gpqNxo8fmADr5PABFFsmTruKWm7OR87VYW6dOP2u6koWhk
         414jg9O+Ip7sqqXtqk+QA+XNxSh24m6+iR1SWs/q1wm5JiSptpP5+lVEQgxUEbf+up9D
         e2liEikULo954MGUJgrSs+0mpodRO01/Tv1duK5dUSULvoT+MWLxc4cJKI88OXmRYPvF
         7M//uC7PEfWjfXP6tXukXD41EzYaQPU4zvw8Rao1fsCNFCrecHPCEU/OoNvNuehvqp+o
         JUWP9/fI4S4tKxX/fRDf0XmUo+sfrDlbb6r12Cu3JbjjzbsWXcoIEOzZM1NYFkQtZPg2
         jbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8Of/a8ErL4zTP1GCVNS2kiwWaPiaRH73h/xqKoWeJo=;
        b=VvRygTJFhm25ZBP3yzHq9/OxAvGdfzDoOITcN7wFT6rJqgWnyHDXssHamipqwJ8EVB
         KJqTkPNKpll67ca4MGA3nE26wpKX69YeH7Ypz7svC0MSu/g45eCoy65Imfge3pHBarpK
         Gxvo4x7sUDJfN7mUmPktB5gc0pyrmlebFEYwxi56PkvCzQdO9AbWF+rGViGdNr1aheVv
         UMVH35OnMuYLASbCK6MSPW/d6S/06TkX8jqW2sckPemLrsFZsp80xu3CYvdPwEkiAexg
         x2O0mlKERz69/bviHSR7sQqRX+IB0t4u0mHl/4hH50/X5w9iYxFj21GbqArZsPTfeUIN
         QG2w==
X-Gm-Message-State: APjAAAW6Tl8X5o7IoRVFVjH4+d6k7Ryutht9Cd4s1Mk/6OZ9p29NLnpf
        5VPDjZ+0tn1xKCPCFfEkxF0L+YEl+wTekciRAcU=
X-Google-Smtp-Source: APXvYqxEcpXKBzlQeKyc3mPliHYJYLFj7eQkevob1301O//2JcrdGB5IIFEx5gzsUXo3fB/3m1jPvDbcbaPCbloALjE=
X-Received: by 2002:a37:a143:: with SMTP id k64mr3504768qke.397.1581700344855;
 Fri, 14 Feb 2020 09:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20190712150235.12633-1-vcnaik94@gmail.com> <20190801161558.12838-1-vcnaik94@gmail.com>
 <xmqqv9uy2qpj.fsf@gitster-ct.c.googlers.com> <CAK_rgsH0Yb=CAsCgD20xx==RaDzchtEua=q6K=7R-cfURFGHuQ@mail.gmail.com>
 <xmqqwof8x66a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwof8x66a.fsf@gitster-ct.c.googlers.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Fri, 14 Feb 2020 09:12:13 -0800
Message-ID: <CAK_rgsEV9t3okUDrG5mHX3DkyZFCX7yGoJEsSeCGTK7zBHJPgA@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib.c: handle empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 1:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I do agree that diff-lib.c::show_modified(), which is about "git
> diff-cache" (and hence "git diff <tree-ish>", i.e. comparison
> between a tree-ish and the index), is the right layer for this
> change.
>
> I am not offhand sure about the diff.c::diff_change(), though, and
> cannot say much without first thinking about it a bit more.

I'm back!

I made the changes to "struct diff_filespec" and diff_resolve_rename_copy()
that I mentioned in my previous email on this thread, and it seems to work.
But the patch seems very clunky. Even though it has been in the back of my
mind for six months, I can't think of a more elegant approach. Furthermore,
the few test cases that I could create are extremely unlikely in practice. For
all of these reasons, I would rather avoid this patch altogether.

v2 is still sitting in pu. Could we discard it? I'll send an update to the
related patch [0] in a few minutes.

[0]: https://public-inbox.org/git/20190821032100.73917-1-vcnaik94@gmail.com/

Best,
Varun

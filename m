Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F07AC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CE92146E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 16:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLSQPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:15:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34126 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSQPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 11:15:25 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so6334239iof.1
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONXZUu/RcpYXEyFhSVTocB+fWwOO+x7rdOJgo9sS9PE=;
        b=eRsATUhgICLZS0wV5rz/zvth5F6HpKJ/px+Jr00E10Oe2wURE+T4qV4Fp+3u5pXoaZ
         I1brrwEMp5EL/sjRYrS/1QSLTKa9fwDuL1jneJQ4r7MaNDXkmxC6v8DPKXDdDD7YvabG
         BPJMlXStagLeGQYK0q4lS0C4VFGSU2yVsoro9nzaDBgJzIwMMqq1FoKF1Ti8YluRhPvO
         71g7cpdkKkNZ9X5qQL+inBLn0dfMq7vVRibnet9L6L/ehpYHqzGReHUGmhoYfN8DYDXO
         L4GdIwXAhS/B7L0vwflJKvzo3U2k+NCRyWORO/lZZL4OeBhg5Io2smPsF+aw2ByVEE4F
         i9mg==
X-Gm-Message-State: APjAAAWpPxgz+w+FulnmgwLLGdiMgo7zbxJg6us0mUTXmhr4TCETk9n/
        MGi1DXna48qAaUSws/hxrU+TbopbTXJ7ia3nJrjmHpEh
X-Google-Smtp-Source: APXvYqzMvNAjffqLxH8/+ML5dayT9fEp8D0/dc2wTdzm9yGYdoTGhokdw1RE6OLOXD49itLUO+wQ/xUGiMwujyUllTo=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr8172372jad.136.1576772122894;
 Thu, 19 Dec 2019 08:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191219024518.GA3411@dcvr>
 <c4fef89a-2275-b4bc-b5c2-7bc647cd9bf6@gmail.com>
In-Reply-To: <c4fef89a-2275-b4bc-b5c2-7bc647cd9bf6@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 19 Dec 2019 11:15:10 -0500
Message-ID: <CAPyFy2AV2NG66LqBJr_Wb1_V5XhKnM+44m0H8FYa_3K4XupLow@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Dec 2019 at 08:56, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/18/2019 9:45 PM, Eric Wong wrote:
> > This goes on top of your patch:
> ...
> > +     ( cd "$1" && for i in *; do echo "$i"; done )
>
> Could we drop the "cd" and "echo" processes with this line instead?
>
>         for i in "$1"/*; do printf "$i\n"; done

That would output repo/a, but we could do something like:
for i in "$1"/*; do echo "${i#$1/}"; done

echo's a builtin on any /bin/sh I'm aware of - do you have a /bin/sh
with builtin printf but not echo?

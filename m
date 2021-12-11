Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573CDC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 06:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhLKG7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 01:59:44 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:43597 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKG7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 01:59:44 -0500
Received: by mail-pf1-f179.google.com with SMTP id k26so10351250pfp.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 22:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcrVQR9FMLmbnH6+ZGYMAN3gYIURIXiIbAiZHjGs8vE=;
        b=Z2/qYFKFnJuTz+OgLzpdcxoBHNwH9AXr/vxsz0+kCpvPMtqwE85aZJaonxB7wqV7nC
         tXgUrAd0bwaDXOu2Swb4Ry+BrhY7r6Y9CDsAwk0MFA5rnL/cIWqhgJ5iFh4cbLN4OKfu
         1aa7nNS4CZ4L/NGGWFq2jo7tB+4ztcAsJw/yyIrjpNOeJBA2xGwg2N+D4tfGERmfqH/T
         S+EKyfKaecX23dSiQtDJcE5DTLEpmcgy/EKon5tjZc0ir2toynvKKAYdKHPPE/J2Jone
         KGmQ167vFW5kYflafiZ/X/jLZ99z380gtyO+YyjuwdKnhcYQDA9vw95zAGOwKN/sdyQ2
         DxnA==
X-Gm-Message-State: AOAM533nHOEGBDz2zPXUGEOtCxGZzNnBcPjncddE4Oln/vFGmrAJcprW
        bv0/uIhsuR5tYvk9xiuuEkcAetN1eHgV+zaPqdBN0DD0C+s=
X-Google-Smtp-Source: ABdhPJzsw3kt19mxlAwXwqwQjfGe+WYsZSCE2WCFeCgE7GBIdz6QrU4cMd90MHjSiihhmNrqJjOkpGM23RxOAcqyiQs=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr22473730pfh.67.1639205983862; Fri, 10
 Dec 2021 22:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-10-sunshine@sunshineco.com> <YbMcYwj/Mvf/PoFF@coredump.intra.peff.net>
In-Reply-To: <YbMcYwj/Mvf/PoFF@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 01:59:33 -0500
Message-ID: <CAPig+cQVcv5m_9n8F1d1jo4fbLiFvDYTcBCCUcwrXdT3FJvowA@mail.gmail.com>
Subject: Re: [PATCH 09/19] tests: use test_write_lines() to generate
 line-oriented output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:22 AM Jeff King <peff@peff.net> wrote:
> On Thu, Dec 09, 2021 at 12:11:05AM -0500, Eric Sunshine wrote:
> >  test_expect_success 'color new trailing blank lines' '
> > -     { echo a; echo b; echo; echo; } >x &&
> > +     test_write_lines a b "" "" >x &&
> >       git add x &&
> > -     { echo a; echo; echo; echo; echo c; echo; echo; echo; echo; } >x &&
> > +     test_write_lines a "" "" "" c "" "" "" "" >x &&
>
> Some of these I think might be more readable as here-docs. But I think
> keeping to the minimal change here makes sense (and I admit I do not
> overly care much either way; it was just on my mind from the last
> patch).

Indeed, it's a judgment call, but I recall that it was all the
embedded and trailing blank lines in these particular cases which
pushed me toward test_write_lines() rather than here-docs since
test_write_lines() makes it way more compact, which perhaps makes it a
bit easier to get the number and placement of the blank lines correct.
The corresponding here-doc would have been:

    cat <<-\EOF >x &&
    a



    c




   EOF

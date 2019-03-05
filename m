Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F61520248
	for <e@80x24.org>; Tue,  5 Mar 2019 14:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCEO5x (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 09:57:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfCEO5x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 09:57:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id g20so2818587wmh.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 06:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFsCIpGcDAxWf3Ki6UB8jRpUNRb+bKY4hntjF4227Rc=;
        b=DqDGw4fzDuKkOKZTZh2IbcYpBRGXJyXN88hPiW2DK34d6s82DosaSvdNEuvF2/veMn
         IuCOWTUzDTn6ZAu8YDTsRx6/X1akfPoMqOtCN6NhOSDDSWygvt77PMHKBa3r75CdzQ22
         Gnv7zIIXpZOxbDzwpvZ5s5soqAQ0epAHQlPQ4+BK/kCvrRXHa/szkqi8B+NroFV/wYwK
         RoFXqG7g7Xgnh2iw4F7Od1i8Gt696G7DvUzrsjXzIGvDSzlE/2Xdh/Vg6+vIaWIGtwTR
         mOsZiCxhCshygvrQ+TTIOURt/FIGL3brZ+PRAhIaz7Rd2gg3p65ypIN99ru7csvN86JX
         pSvw==
X-Gm-Message-State: APjAAAWGFDn6gWHMFCTqlAzY5oWfo6cnxmUoFxlMVxq0RPD75RhQdSQg
        IERdtMSDFfko0t/SGdjHAPIIKEhwUFOvOZM55qrJw0JI
X-Google-Smtp-Source: APXvYqzQgfqnOggAqC399pWoTR8ZtuL0asEozbDvy3PEo2wi8xlouMCTCDZQFwwWSjktF0VKrDmlZQfAICehpyZvmxk=
X-Received: by 2002:a1c:7415:: with SMTP id p21mr3147775wmc.31.1551797871434;
 Tue, 05 Mar 2019 06:57:51 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
 <20190305142149.13671-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190305142149.13671-1-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Mar 2019 09:57:40 -0500
Message-ID: <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 9:22 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> I was asking if this patch is good enough to be added to the
> existing code? Does this patch look good?

I didn't review the patch with a critical-enough eye to be able to say
that every change maintains fidelity with the original code. As
mentioned in [1]:

    [...] an important reason for limiting the scope of this change
    [...] is to ease the burden on people who review your submission.
    Large patch series tend to tax reviewers heavily, even (and often)
    when repetitive and simple, like replacing `test -d` with
    `test_path_is_dir()`. The shorter and more concise a patch series
    is, the more likely that it will receive quality reviews.

This patch, due to its length and repetitive nature, falls under the
category of being tedious to review, which makes it all the more
likely that a reviewer will overlook a problem.

And, it's not always obvious at a glance that a change is correct. For
instance, taking a look at the final patch band:

    - ! test -d submod &&
    - ! test -d submod/subsubmod/.git &&
    + test_path_is_missing submod &&
    + test_path_is_missing submod/subsubmod/.git &&

Superficially, the transformation seems straightforward. However, that
doesn't mean it maintains fidelity with the original or even means the
same thing. To review this change properly requires understanding the
original intent of "! test -d".

The meaning of that expression can vary depending upon the context. Is
it checking that that path is not a directory (but it is okay if a
plain file exists there)? Or does it merely care about existence
(neither directory nor any other type of entry)? If the latter, then
the transformation is probably correct, however, if the former, then
it likely isn't correct. So, understanding the overall context of the
test is important for judging if a particular change is correct, and
many (volunteer) reviewers simply don't have the time to delve that
deeply to make a proper judgment.

[1]: https://public-inbox.org/git/CAPig+cSZZaCT0G3hysmjn_tNvZmYGp=5cXpZHkdphbWXnONSVQ@mail.gmail.com/

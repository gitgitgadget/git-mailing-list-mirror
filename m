Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315AC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A3160E78
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhJNSxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhJNSxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 14:53:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D6C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:51:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i20so27268677edj.10
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDLyNlJ/0LjbV8PxyT7v6TSr7X6yfDXa9DUR9XyPQfo=;
        b=eslM+PztqsziOCR5ixaGIj+ZB/kDaXv/l+bn9wFFnldBbXUJkjTPBfA0ojH9B2v5OR
         dQRWvDRp8lkGUreWMVc8XeO0UyFy++vhm4M3Wt/UoI57sKoonVLybXLZoYmYGqyeo+k9
         Fg3D8HeOfrG1BsHzm66tFCzrTMluMow0Tb4LRViYvpcijEH11k58TPTPtuWqen2GC+iu
         Cfk4pADfnFWCNUZLFP6zFxxUwHqkg7DQsWW6f0P5RRdgXM8gAnsb/g0Pv5Jettz6Tftu
         CXbw/FZYEEn1Ft2XexFMsBv/4zzn5pbCicTPj3O50797cx6xnnHkT9lhTtchPchRp1kX
         nDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDLyNlJ/0LjbV8PxyT7v6TSr7X6yfDXa9DUR9XyPQfo=;
        b=pjlEf/o5N6xOQGmUJ0O61atPW66x9qn8ZpAZf/xGVu7o5o5qmCIMQkYB6IEQhDQZxW
         PYImlKh0Oolw+GvJ2eZeSYUeUiLhyJQSY/VImt++7izMwQNFjVEXzV9KY0/NdXi9GA7K
         B1DBt+vwtXE03Jd5+LDlk0RJcfNIaNy2C+95Tm9PhQMT8jj4SZFU2Mnm/yY4i8XpBd9Q
         ZGn5+nQ0dD1prGg6FNILP/Kq6PlqO2BQfe7ONt7fBQRCLOw5kE7yxyHvZvfvuCQppIZd
         YiMtI4DkKZ92qUqBgKzAowbj4jsOy9yFeSzoggWUkylIFpnpSOEqFWizBQgRtXXGYGqm
         ph+Q==
X-Gm-Message-State: AOAM530Q1puewSWL/H/IQJ+Qm2hVn2JdlXBWLrl97GmntMG3i37oN+h9
        fiF+id8w0jJ5FepffG6chrc3fzi9vrDAZuzqdAitiu+F
X-Google-Smtp-Source: ABdhPJzwEdDicy5h73ctjOLEKn4IaHinE/3+RPLnUWwV5JOEhSf+YruIhhp/yK6T5nZUqnuZ9NcaKiPV4qfA0NngySc=
X-Received: by 2002:a17:907:7f90:: with SMTP id qk16mr940093ejc.26.1634237471067;
 Thu, 14 Oct 2021 11:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211013024539.49612-1-davvid@gmail.com> <xmqqlf2whke8.fsf@gitster.g>
In-Reply-To: <xmqqlf2whke8.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 14 Oct 2021 11:50:34 -0700
Message-ID: <CAJDDKr5w3Le_QtsCKF6+i3ThFa-FF6EVVm80ukjPSMsJZkByOQ@mail.gmail.com>
Subject: Re: [PATCH] mergetools/xxdiff: prevent segfaults from stopping difftool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 13, 2021 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > Users often use "git difftool HEAD^" to review their work, and have
> > "mergetool.prompt" set to false so that difftool does not prompt them
> > before diffing each file.
> >
> > This is very convenient because users can see all their diffs by
> > reviewing the xxdiff windows one at a time.
> >
> > A problem occurs when xxdiff encounters some binary files.
> > It can segfault and return exit code 128, which is special-cased
> > by git-difftool-helper as being an extraordinary situation that
> > aborts the process.
> >
> > Suppress the exit code from xxdiff in its diff_cmd() implementation
> > when we see exit code 128 so that the GIT_EXTERNAL_DIFF loop continues
> > on uninterrupted to the next file rather than aborting when it
> > encounters the first binary file.
>
> Sounds like a reasonable workaround, but I wonder if this should be
> limited to "when xxdiff segfaults" (in other words, if it is common
> for other difftool backends to exit with status 128, perhaps a
> better workaround might be to teach difftool-helper that 128 is not
> all that special?), and if the answer is yes (in other words, no, it
> is not common among other backends and 128 from xxdiff is very
> special), if we can easily and cheaply avoid running xxdiff on
> binaries---that way, other exists from xxdiff with status 128 can
> still be treated as an extraordinary situation.
>
> In any case, the above is a thinking-aloud by somebody who does not
> use xxdiff himself, and should not be taken as "I think this patch
> is not good enough" at all.
>
> Will queue.  Thanks.

That also matches my train of thought.

I stopped short because I figured that the xxdiff scriptlet can special-case
this shortcoming initially and if the pattern recurs in other tools then we
can consider centralizing the workarounds in the helper then.

Thanks for reviewing, much appreciated.
-- 
David

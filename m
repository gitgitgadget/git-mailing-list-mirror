Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F5C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1820637
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVRIOtRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCTVox (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:44:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32900 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:44:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id 22so2064738otf.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P1SDceLtcWDdPYxwmV6phSt7VIqrTfuNaO6YPDoMU0=;
        b=gVRIOtRN1RXian1RReOo7qO1ZsFiYrqrz8Xz/SepgSkT7eXUBtaquIUZXKneZlriBw
         tLrEWrSGDw29Dm8OMunU8VOFg+f10owZG6UgGzwUJKnVK1WYO+HLlBD1wqGK5iK0oZux
         oNVSUzHFoOnFUcLDzDftFwKPH+I4+A2UOJOteT2gZEQtZCwNvyzYKRBLdD3dXcvTVo69
         2cgeATjEXE3i7as1zGKHe7dG+XYsSwbYwrRI6Qjthy9lNx9dLoi4d1wExY5roiGZjm+v
         mX1/WL4KpDrHayrNnoSlQ9Q6/Qihum5kSFXuf/lhRuKM5AN5zrF5PoFlR9jraWqfip2R
         K/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P1SDceLtcWDdPYxwmV6phSt7VIqrTfuNaO6YPDoMU0=;
        b=eZWcwCfTrsk8K91UMG8HK+Z13aSK2XDekZcW5y+YwWyw072YjMvNzDxHD4QQetw8Jj
         7NfKZrKY7jfJi4Qos7bnkFxpGv+lWQKx4PI2JcQjTmtq9i70NrV/kRw440+lFSc1mjhD
         DubU9jxAoPTmEGBQ+P4Kx6scN8Dq0O45k7OoF0szCwoe4momqrK9yVGYTceRTm+ynPLz
         Hm9nFIxJ4JCBS656zPviqksKc6wJcNd7olpjVKTQ+UgiHtwulUJXzURezXH2doNjhG8U
         rOdpS1APSymaeR+e4O+Dgm5vu8iSXTdwXIb+xj42BrCotVrKyAMSMrNluWsirlnlGzyK
         sTeA==
X-Gm-Message-State: ANhLgQ3kw3eRsGjbThVNWkJikYijvdySIfBZDXuMoOBkf1IheBy9zoin
        ishZn8rNAMYyNgwHsLNryVeI918f6pHuFLmEVF8=
X-Google-Smtp-Source: ADFU+vvNt5lPBKV6IDa7TXA/0nWPNZCvpv3pdMPaqDTYJMTABbXupE9KeM5BeCZb7qZ11Uh6/FVNdoixabv9RXKBDPM=
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr8895257otc.316.1584740692181;
 Fri, 20 Mar 2020 14:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200320213916.604658-1-sandals@crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Mar 2020 14:44:41 -0700
Message-ID: <CABPp-BGiP7eG7Ojt8FKV5PUBFk74pkO6jnOwJEZbDzBjdJUm5w@mail.gmail.com>
Subject: Re: [PATCH] t3419: prevent failure when run with EXPENSIVE
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 2:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This test runs a function which itself runs several assertions.  The
> last of these assertions cleans up the .git/rebase-apply directory,
> since when run with EXPENSIVE set, the function is invoked a second time
> to run the same tests with a larger data set.
>
> However, as of 2ac0d6273f ("rebase: change the default backend from "am"
> to "merge"", 2020-02-15), the default backend of rebase has changed, and
> cleaning up the rebase-apply directory has no effect: it no longer
> exists, since we're using rebase-merge instead.
>
> Since we don't really care which rebase backend is in use, let's just
> clean up both, which means we'll do the right thing in every case.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I noticed this when I was working on another series and running the
> testsuite with GIT_TEST_LONG=1.  We'll probably want to add this before
> the release if possible.
>
> It may also be desirable to have at least once CI run that runs this
> way.  In my experience, it does not take substantially longer to run the
> testsuite on a modern Linux system with this option enabled.
>
>  t/t3419-rebase-patch-id.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
> index 94552669ae..824d84f9ce 100755
> --- a/t/t3419-rebase-patch-id.sh
> +++ b/t/t3419-rebase-patch-id.sh
> @@ -91,7 +91,7 @@ do_tests () {
>                 git commit -q -m squashed &&
>                 git checkout -q other^{} &&
>                 test_must_fail git rebase squashed &&
> -               rm -rf .git/rebase-apply
> +               rm -rf .git/rebase-merge .git/rebase-apply
>         '
>  }

Good catch, thanks.  Perhaps we just want to invoke 'git rebase
--quit' and let it clean up instead of manually doing so ourselves,
since it may buy us some future-proofing in case we ever want to move
the place we store rebase state?

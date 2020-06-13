Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4DC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41CC20739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZUfcqtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMJi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgFMJi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 05:38:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A7C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 02:38:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p18so8090523eds.7
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X3qoaBpHbdat+ciQbc0MbZCLGs0H0/g8EmBWWGaD8A=;
        b=cZUfcqtzbBBb4FXeJJO8QRkGJYZXnHSpkSLOBsQIU2XJsveq6Tn035QrG5lktlxPNq
         2Ymn1mFxw5fTrUfqM6Yu2Or51qeNR3p9gCcNAOaSqRLPlShhZmJKGcHh//CCn+inKTbj
         Cor7+qAxvcT7QndYQEOrxlLFU26OUpR43HLiYhCltjtsuTP2uAdzm386gAL/Z/m+VJ3F
         CdVSnw0p+wBUCR/zl/cB7Rya42OXJc4dxZ0bIGAwtpsPmeivyYm8RHBsdI/Tm6YJKPDl
         Q70MHddNpKCqLZXB9wEqPf94MEcdzEuk9/QjdJy0aIjtdAZ1afYTdQvEWTofaazlfyo2
         snjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X3qoaBpHbdat+ciQbc0MbZCLGs0H0/g8EmBWWGaD8A=;
        b=SNc+w0fizPrNc+RhVw4ib8tNQCstaYx0xE1DQcie4U4vMCymR53A+VpB30PleYkeIh
         yff55CUdyacpmyvzOjXMgmXEBUTk+U84oFTx1bEY5RxryBQTYbdIOSv9iDuir/Wbtd16
         2zJnHS2+ltB6SxnSq7GzKzF2/X1C7uHZBPJCVk0R1xkhj6Hqh4h+VbU2thWvZWo1VGmw
         37cKyfJZok1P5+CWJWB4w//AfufTo2Yv+GiukyitO+vsOyyW4pJrou91BQb5hHzI6g3F
         /jzrFiB0Lwz2y5te6xcGdRs/ii4nqsTYkzIxOImG3MBSEteA/jeCKDbEHRFbBLjW3vz4
         RLbQ==
X-Gm-Message-State: AOAM533jGu3HTqT4icalXsTP5yHCArTZlmyMVIUv/6PjpDs92fTWc6ud
        XWdknNt73TS7tLBo3Mi8nq0Ztbv8AeTLtggUcTU=
X-Google-Smtp-Source: ABdhPJzRcSl4GmdjL8BzbvG3tjvZ8J8Xhxsa+RsPVgWe2Wiututu86co2wcZGfeL2ROvCRRP/yrnydZJPaF/dvw+glU=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr15090913edw.127.1592041134764;
 Sat, 13 Jun 2020 02:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-4-alban.gruin@gmail.com>
In-Reply-To: <20200505104849.13602-4-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 11:38:43 +0200
Message-ID: <CAP8UFD26Df266Q9QnnQjM+dvKWmi8Rgj_J+BgsNrOyttxqVpQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/6] stash: remove the second index in stash_patch()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This removes the second index used in stash_patch().
>
> This function starts by resetting the index (which is set at `i_tree')
> to HEAD, which has been stored in `b_commit' by do_create_stash(), and
> the call to `read-tree' is replaced by reset_tree().  The index is
> discarded after run_add_interactive(), but not `diff-tree' as this
> command should not change it.
>
> Since the index has been changed, and subsequent code might be sensitive
> to this, it is reset to `i_tree' at the end of the function.

[...]

>         /* State of the working tree. */
> -       if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
> -                               NULL)) {
> -               ret = -1;
> -               goto done;
> -       }
> +       discard_cache();
> +       if (write_cache_as_tree(&info->w_tree, 0, NULL))
> +               return -1;

In the previous patch you use the following:

+       if (write_cache_as_tree(&info->w_tree, 0, NULL) ||
+           reset_tree(&info->i_tree, 0, 1))

Here the reset_tree(&info->i_tree, 0, 1) call is in the "done:" part
of the code. Is there a reason for that? Can't
reset_tree(&info->i_tree, 0, 1) be tried here before returning an
error? Or was the previous patch wrong? I guess the reason why the
reset_tree(&info->i_tree, 0, 1) call here is in the "done:" part of
the call is because it should be after the diff tree command is
launched. I see that the commit message tries to explain this a bit,
but it is still not very clear to me.

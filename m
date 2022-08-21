Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A6C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 04:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiHUExH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUExG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 00:53:06 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0191EAEC
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:53:05 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3246910dac3so214579687b3.12
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2SfNcVcJjROMQCHu5lTyj7W61hUB1TzZ+s4E8c3MvH8=;
        b=D2T25+CJRbredwQFxDSkkHRwHFBcVzRWXxaSAj0o7GGiT08jyZHzXQqbiNbeN7PvEf
         dXy0BhUSZMPSz+DcHjoFn77I+CIFEbAhPNSE5Wt9WTCFEJbILydRZ1/t48h9XSswudt9
         ZSzF+6gPZ+DLC84gi8xHfHbGZ7QZDxwpxms7xloyZ7IjEWFg59VBn2DhalU1QxrhEpzH
         /e5QdhSsV4kW1+aE7STciO0EQyeSc5N1zYG60Oy2XS9b/F/N3F5S3Jt+caFiJF9+HlkQ
         enXqqhRP0HXxaFvbz5HbqXqiotNHDT6afNuKuSi7Q1xvOASKPgsBqrmqsaps/hyboCB0
         NaDg==
X-Gm-Message-State: ACgBeo13IA0pfvVPkCz0mYnw0rzW+4Y/D3YHbvz3+n0wV4te/UVvxH1Z
        1l5DnwCZzBCORYaY6bWGSR2CHv4VQOjju1f96EYFHcqaiXQ=
X-Google-Smtp-Source: AA6agR5cqJl3CHbxGZemj2xE9mTHnxDVGIXO6eNMp3ppIVu8x4dnGFVuTkoKBmt9Zqv2RLQTMXM2joX7YHAqAoibgA0=
X-Received: by 2002:a25:fe07:0:b0:691:d1f4:681f with SMTP id
 k7-20020a25fe07000000b00691d1f4681fmr14449501ybe.211.1661057584718; Sat, 20
 Aug 2022 21:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com> <92840bf63782ca302e9d48a12faf7d4f5b3cc2d5.1661056709.git.gitgitgadget@gmail.com>
In-Reply-To: <92840bf63782ca302e9d48a12faf7d4f5b3cc2d5.1661056709.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Aug 2022 00:52:53 -0400
Message-ID: <CAPig+cTMxj14gYGXgE3LAPFQRdDYXiH=Fd_iCwzoJp9uS1jCzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge: only apply autostash when appropriate
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2022 at 12:41 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If a merge failed and we are leaving conflicts in the working directory
> for the user to resolve, we should not attempt to apply any autostash.
>
> Further, if we fail to apply the autostash (because either the merge
> failed, or the user requested --no-commit), then we should instruct the
> user how to apply it later.
>
> Add a testcase verifying we have corrected this behavior.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> @@ -255,6 +255,15 @@ test_expect_success 'merge --squash c3 with c7' '
> +test_expect_success 'merge --squash --autostash conflict does not attempt to play autostash' '

Did you mean s/play/apply/ ?

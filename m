Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A7C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 03:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJHDRv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Oct 2022 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJHDRs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 23:17:48 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5031278BCA
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 20:17:47 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id 8so3399815ilj.4
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 20:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzuCi8SF/vUyqx7N8FRRjxJtbit2fEtWsorq7TJqyaA=;
        b=miMsYCxCHxGRBhSMcScoCFo40NzrzXAtKzj8BNbECBdgmtsc3x/MCPGLd8U0YKfb27
         rrm9KUEifW45pUKa8KUcm+etSMjEAjfLI51ImF9w/+B9eZdzTDnmCp9VfFoMZeK8lU5B
         hr7+GgBNUmIaYLcJN3zVp3pe+U+6kzdUEk7ieWRhmTjw9+mMj3dFIauD/46HjrleCSLW
         8Kq7azTKSYmKruHvQlDPsQI/aL6i6FnRytjWeveX4kdEICAXOraOtfXQxp/i+eX5dksZ
         SUVAY3XkV2RCsJTkaNPdg/y7/qqBM9MT78UmQfOjK0eVmwo41JdeENYjNgX79BKwhe+W
         iJ+g==
X-Gm-Message-State: ACrzQf0frePv7d39dSKvJbjwi8H4pZJ/AhqwhT4q0lXRyf8JZTfxDR2B
        GW/BV7z6U0nM/VLLV/A1FH0+tDmYaYri6FybsELKXN2mvYU=
X-Google-Smtp-Source: AMsMyM6uPjGMI16cFTlb7e/qqNHun+17D4UhTNk+3X3HuYzeh9dKhigGIOAddizkkN4HvOqkSr+KzvDKmyNR0kQkxw4=
X-Received: by 2002:a05:6e02:b2f:b0:2fa:1c95:5c98 with SMTP id
 e15-20020a056e020b2f00b002fa1c955c98mr3988865ilu.249.1665199066299; Fri, 07
 Oct 2022 20:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com> <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
In-Reply-To: <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Oct 2022 23:17:34 -0400
Message-ID: <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 9:36 PM Rubén Justo <rjusto@gmail.com> wrote:
> branch command with options "edit-description", "set-upstream-to" and
> "unset-upstream" expects a branch name.  Since ae5a6c3684 (checkout:
> implement "@{-N}" shortcut name for N-th last branch, 2009-01-17) a
> branch can be specified using shortcuts like @{-1}.  Those shortcuts
> need to be resolved when considering the arguments.
> [...]
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
> @@ -133,4 +133,28 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
> +test_expect_success 'edit-description via @{-1}' '
> +       git checkout -b desc-branch &&
> +       git checkout -b non-desc-branch &&
> +       write_script editor <<-\EOF &&
> +               echo "Branch description" >"$1"
> +       EOF
> +       EDITOR=./editor git branch --edit-description @{-1} &&
> +       test_must_fail git config branch.non-desc-branch.description &&
> +       git config branch.desc-branch.description >actual &&
> +       echo "Branch description\n" >expect &&

Is the intention here with the embedded "\n" that `echo` should emit
two newlines? If so, interpreting "\n" specially is not POSIX behavior
for `echo`, thus we probably don't want to rely upon it.

> +       test_cmp expect actual

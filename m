Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B39C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C863C20722
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfK0C1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:27:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51659 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfK0C1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:27:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so5384497wme.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT1YzqCl7PNGxvyXKenGvogn1gMiNJmEi7XqE6PRsqQ=;
        b=b97JwBfijP4yXULCWOJ3xUgU7zlC4pknm4srhyZVEM7QtxCGkMcGj31zJXBDrOWOQs
         R0e7j04Qc0tzADoChB794F0XkxueJNJdh4nNza7O7N6PnwhPxBCTsJKUQ2ENQPIsEkmH
         +JB0gs7kzf/Ql1xna21HfHSQgdCwlhfQq7tvV9CWohQMv54ksayYNsYk3aDwZw0rOd6E
         xbg4yt7e9r4Aw//hP4i4bhHc0Ld9JsXWQ4IYAPdAt/5R6jBNdaaItsZwSma7/L2i63O3
         cC4YO7EQCP+NVouaP/gFQ0nsSXEaRgugLe3J6jRdl9xZRL7bA2aFd59Xt5FC7295UEq7
         IBjg==
X-Gm-Message-State: APjAAAWUE0Lugs5lSPPB8RrO19jJzdcguqQh/rlCQCzL3VQe8GUWtZao
        L+40C3OBgiJUAWjq5t0r0/qsi+xrGkKzExEBt3RXiHml
X-Google-Smtp-Source: APXvYqzInhxAqrCmU2vpl3oX5pJ5plSVj/5sXUn7qykxcecb/evOkjmBI1JQQeWChU3lrXFcag6T7qXyd4hqXmSRgpk=
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr1798800wml.95.1574821629099;
 Tue, 26 Nov 2019 18:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com> <a1741e54346a387a65e272f0210118ce81475358.1574820308.git.liu.denton@gmail.com>
In-Reply-To: <a1741e54346a387a65e272f0210118ce81475358.1574820308.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Nov 2019 21:26:58 -0500
Message-ID: <CAPig+cTqRcZ6R7bFqeNG_bvwqgAKP7NVEHBSQxgpVk+PgGVMVg@mail.gmail.com>
Subject: Re: [PATCH 1/5] t3400: demonstrate failure with format.useAutoBase
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Biesinger <cbiesinger@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 9:09 PM Denton Liu <liu.denton@gmail.com> wrote:
> Ever since bb52995f3e (format-patch: introduce format.useAutoBase
> configuration, 2016-04-26), `git rebase` has been broken when
> `format.useAutoBase = true`. Demonstrate that failure here.

What specifically does "broken" mean here?

> Reported-by: Christian Biesinger <cbiesinger@google.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> @@ -159,6 +159,12 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
> +test_expect_failure 'rebase works with format.useAutoBase' '
> +       test_config format.useAutoBase true &&
> +       git checkout topic &&
> +       git rebase master
> +'

Having read both the commit message and the test itself, I'm not wiser
about what is actually "broken" or what this is demonstrating.

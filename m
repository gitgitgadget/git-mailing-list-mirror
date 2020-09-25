Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A49C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B276A21741
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgIYS5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:57:53 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36943 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYS5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:57:53 -0400
Received: by mail-ej1-f68.google.com with SMTP id nw23so18959ejb.4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 11:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpQpH3Z+pTm4Umvy0EmMFl4iUaSbdgiVVKOP33qsPw8=;
        b=uQPATPidoHQZoC8JIuCGMwRemn5BYmSVP0hNhHQ120XTkz+Daahd5uG40C2nR8UT/o
         z9fFNqcOLPEII9bfKRJHN5fEP6sdxSIEZPDfWnh+r04+VfOzqWx6Tbdo30Pr1MjPIjUV
         V24XtjDxo9x2dDt2f4vYCRzUPFGYG1uI2aFxQvlrlp3nJBbARYfmamgcsiO29k4foFhQ
         QOYw1jd93ZNum2wS0DhFuFd+nYnZZtn2x90GxLy+rEsjTLM1UKLqEXBabaRc15LAFZAG
         EWhakuE2JEY7ase3PnxbhDPBjpX7/ZvTVhrHs/fj5pSqkxBjfYwJNJRVj+Kx0DodY1h6
         GvMA==
X-Gm-Message-State: AOAM533uuVdkoU++6vbAfMfTt0Dncn+mVmym4ouHq3Dru9uzKX0f4cJ7
        BpwJeICp5yaCLtbQihK1L8qe/RJ1jkzTjKZE7Y1ZMUGo7+c=
X-Google-Smtp-Source: ABdhPJw9F0HuKLLt0sia6f1VAxl6LpyuPwajO8RYBpX/5M8h6kxN0APXRppC4bECmd3Optz2a+tvWFVqhHANuMWrx+0=
X-Received: by 2002:a17:907:1116:: with SMTP id qu22mr3905255ejb.231.1601060271935;
 Fri, 25 Sep 2020 11:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-8-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-8-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 14:57:40 -0400
Message-ID: <CAPig+cTwQCSA1sjAWyDC5ZydT6NKzOY9ziLUJcOVMRV4cP_sAQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] t7001: use ': >' rather than 'touch'
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> t7001: use ': >' rather than 'touch'
>
> Use `>` rather than `touch` to create an empty file when the
> timestamp isn't relevant to the test.

There is an inconsistency here. In the subject you say ": >" but in
the body just ">".

A couple more comments below...

> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -47,14 +47,14 @@ test_expect_success 'checking -k on non-existing file' '
>  test_expect_success 'checking -k on untracked file' '
> -       touch untracked1 &&
> +       : > untracked1 &&

In patch [5/11] you dropped whitespace following the redirection
operator, however, this patch introduces several new cases of unwanted
whitespace.

Checking "master", I see that there are 209 instances of `: >` in
tests, but 1023 instances of `>`, which suggests that we should stick
with plain `>` rather than `: >` in this patch.

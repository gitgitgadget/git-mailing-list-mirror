Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703CDC3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD482074F
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgDTQVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:21:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36037 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDTQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 12:21:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id u13so12948117wrp.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 09:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvBDx914w7gWUv12qDCoptGu5xY0mT62yucFeQuXm7E=;
        b=SC7kE6JpuiAHG9r8EWinr8vOtpK+tPIhIsAiZLsmlA3OLQL1kjamnrLQFjo08b3xXF
         6manm1Y7oGIFiTOt3rJwj5eKmyWbKLMFztXbxY4JXu9CckcS6qz4OPcRA7wPt7k2p1Ee
         nZQWxexoGoKibvq4jMxZT82Raj6Ov1ZpqWX/XVlfywSI3/XQJ38a6909rSIwN1nAXPEz
         vaiYC913zIXY8zsqbz00AU7G5PaCK7ZoR8ECK7zw2SFkAophOENx0tTKR9+6oZogaYLd
         O3TGezhBX8B8QHa1/x+LOv1ELqEYiOu6vwxsZKMV9+ekXUiwIWhhZ8zn8sHia1vcxY9a
         miOg==
X-Gm-Message-State: AGi0PubEamquuix6fiK5cSWyATXhnRukw77S0pxBDDJzgloS8FotsaG4
        jpAgSg5GouHvV61+ceUwH1EoGwAPDW8fO6YGvVbM5g==
X-Google-Smtp-Source: APiQypJMcyyvTGX8a22gPdd3L+yEl5RFJ5U6f1asIcmaxeTWwmzkOk0apG89tGALLWH1SnbofhQuOtndTKQqhxwffK0=
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr20892212wrv.226.1587399708391;
 Mon, 20 Apr 2020 09:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587372771.git.liu.denton@gmail.com> <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
In-Reply-To: <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Apr 2020 12:21:37 -0400
Message-ID: <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 4:55 AM Denton Liu <liu.denton@gmail.com> wrote:
> The test_must_fail function should only be used for git commands since
> we assume that external commands work sanely. Since test_cmp() just
> wraps an external command, replace `test_must_fail test_cmp` with
> `! test_cmp`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
> -               test_must_fail svn_cmd commit -m "this commit should fail" &&
> +               ! svn_cmd commit -m "this commit should fail" &&

Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.

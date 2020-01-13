Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8259C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DAB21739
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMNxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:53:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMNxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 08:53:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so8613711wrj.12
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 05:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1s82AmKLq9waWJGGIfmYYp4MtEuWNrOnOpTRtchcQU=;
        b=tjBohXkFrVCciaIqfF2zIF6kgsuFlwKTXp+lQySjWY2A2XfF4KpKnR73Y41by6/JAK
         ASV/qN2x2lvOEmMOs8W5eSKGWhNaxJ7CZxlMTP6IqSFh1ynCLTPm3FLODD+W5keOrboS
         Sg47Jv5sGZdz3uSdSwj4IcCz6dYPx8wlhJNJoRRopywPndkYhjNA4uB9BhHzkRGAAmMl
         9mcp/AkF39Ch64lXaLc65OT3gWxI4TJpClyjo4/UHqOl16RR05l5xYazZvHnAYNAWGbd
         8De9WXplmC3ios7UeOdxc6Ek9li64JagNjNcwJTwkqWdI/xjCxZrGo4zMAADAq/xqv1w
         8QUg==
X-Gm-Message-State: APjAAAWOKuHLgHnWSG0rOPEeU82jMHEp+JLsTQyRmjt70JPf0tE1S9fz
        t1+3UU/tfet6oWBYG2Jn6dw2KJ0+CtN73Kx2lalVnw==
X-Google-Smtp-Source: APXvYqwxg/IN9FBrgwPc2vvdMt38IZ5eLENi6bEUO6HDZEjfmllqME5uaQKegi+BLrqvcbIb6riLCZNvHsTniTIwes8=
X-Received: by 2002:adf:db84:: with SMTP id u4mr19182761wri.317.1578923603875;
 Mon, 13 Jan 2020 05:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net> <20200113123857.3684632-21-sandals@crustytoothpaste.net>
In-Reply-To: <20200113123857.3684632-21-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Jan 2020 08:53:12 -0500
Message-ID: <CAPig+cS3w=9zqSsVOQ3NtA_ESes6H6KGwwi9R+S3h53JpWgkFg@mail.gmail.com>
Subject: Re: [PATCH 20/24] t5703: make test work with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 7:41 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> @@ -19,7 +19,7 @@ get_actual_commits () {
>         git verify-pack -v o.idx >objs &&
> -       grep commit objs | cut -c-40 | sort >actual_commits
> +       grep commit objs | cut -d" " -f1 | sort >actual_commits
>  }
> @@ -37,6 +37,7 @@ check_output () {
>  test_expect_success 'setup repository' '
> +       test_oid_init &&
>         test_commit a &&

I think this `test_oid_init` is supposed to be introduced in patch
21/24, not here in 20/24 for which it serves no purpose.

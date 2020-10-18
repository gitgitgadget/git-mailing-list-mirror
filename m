Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FCC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 03:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EBF21D47
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 03:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="P0mHcmdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJRDzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 23:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgJRDzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 23:55:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5744C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 20:55:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so7074639ilh.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 20:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HgUMuAUNeksDVZeMntHu5vvpVwfThyPoA5kNcy6rItc=;
        b=P0mHcmdntZvyKMz7QWilGeC01Y3klNyNmJqu9mcYPRQfFPZuwutcXNG6pVcCyy2685
         v9DZIFZFKzHsAMpaZ+2mWwg5YT+l5SiDki8d7NQpRZp+QqoG2ArzgH4i+iJFbMkGw2Ys
         9oAfvksmhg9gnLEBEpWyYRzCvzdCxq/OaJrUYt6I6b8n+OMdOzsvQx7Eh/kc09OfQrzX
         R4PmHPIRLXGlpGAwKdj28BnPTUZBCCS3zfw1s50bAEWzG4WYSt2DyKJy2X/53OVk3vp9
         NH+JBE7IKwqXBqvsPeq83Z6Z/wQ4Ia3z39+0RxjN+ckMIfMiJM6ZMAYnnmzr6542DIw/
         v1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgUMuAUNeksDVZeMntHu5vvpVwfThyPoA5kNcy6rItc=;
        b=YqKrG/N8b1A22efB7Mqn4gqPO40QXqDzlEgqpNs803BY71HAeAxBdrbG8yqKLGle5x
         P5Lf6X0bvj9oBVm/4iHqVvO1TrQFyC7dp8o3C8YV7bOudjxfWwsTQtVwMwkM/+KncL/P
         eLhwwPGvOVOuGvybMuJyZYEGW+5DkULDpCi5N952a2TjZQGwBjw5oSlui7JQ1iRz1hYy
         +No0Uo2KssG8Kze8nw6XtA6qeMGQR2ab1/bRH0yA6XC0Lm8jg/Oqxi2emHryNCg2Y2Ts
         ncNDURLG7I0zwFOliKT+IWe+OexR04XYeHi/1YHa/vlASCyQIpafQ8GG9Itf+5KtqHCt
         9Jog==
X-Gm-Message-State: AOAM530VmVAvDjbNJ9rx3ghssr3Lvsy5IjQ5nKIFGkqIR7IyHUzYBamz
        GgyCrTEQs2o1QoRykITFXghoAg==
X-Google-Smtp-Source: ABdhPJxzkG0EmM1ceu7yYRdagBxgim/RcQNJuep5TyR9BwjVF4AJ7TTxf+JGu7AAQpshqkv12DK7yg==
X-Received: by 2002:a92:480e:: with SMTP id v14mr722923ila.218.1602993349998;
        Sat, 17 Oct 2020 20:55:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:150e:43c9:4c9b:f1fa])
        by smtp.gmail.com with ESMTPSA id t12sm6417562ilq.76.2020.10.17.20.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 20:55:49 -0700 (PDT)
Date:   Sat, 17 Oct 2020 23:55:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Caleb Tillman <caleb.tillman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace an instant of
 test -f with test_path_is_file functions.
Message-ID: <20201018035547.GA2262492@nand.local>
References: <20201018005522.217397-1-caleb.tillman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201018005522.217397-1-caleb.tillman@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Caleb,

On Sun, Oct 18, 2020 at 12:55:22AM +0000, Caleb Tillman wrote:
> The test_path_is* functions provide debug-friendly messages upon failure.

The body looks fine to me. Your subject is getting a little long,
however. Typical guidance would be somewhere around 50 (at least in my
opinion, I thought we had something in Documentation/CodingGuidelines,
but I couldn't find anything).

Maybe something instead like:

  t0000: replace 'test -f' with helpers

or:

  t0000: modernize test style

If you're looking for inspiration, you can use `git log`'s `-S` flag to
look for anything that mentions 'test_path_is_file' to see how similar
patches have been written in the past. (When I was recommending
alternatives, I ran "git log --oneline -Stest_path_is_file -- t").

> Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
> --- Outrachy Microproject, revised submission

I think that you meant to put this "Outrachy ..." _below_ the
triple-dash line. Incidentally, Git still applies this patch just fine,
but it is easier for reviewers to pick it up if the "---" line is left
alone.

>  t/t0000-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 923281af93..eb99892a87 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
>  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
>  	rm -f .git/index &&
>  	git read-tree $tree &&
> -	test -f .git/index &&
> +	test_path_is_file .git/index &&

This looks totally correct to me.

Thanks,
Taylor

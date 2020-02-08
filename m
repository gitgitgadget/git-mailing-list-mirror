Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03947C35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679D720733
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jMG8cwFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBHXYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 18:24:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46041 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgBHXYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 18:24:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1251951pls.12
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NHB+IechgCnORT0O11rj63ypyGVRMc15X9YkdoTfLPE=;
        b=jMG8cwFbZvkiYfBVQvx01YiL3JzGlmzN8hZXRDhtNuwenkzIHQXBv+8PCsey8CSppJ
         Syz0w3SWKJ/BlFuF4I3cI8UX8xLmF5scKU7KXtbBZc+QJvzV587ZTfPh238iWY7biNt0
         5DUcWoYi1hRlBSJppFLnPlYF7VL3gYXuNemvxQT5C8X0/EAxx94MBUTM0QNeqZyJURHg
         QmnHUN8YWw30lZh1wyShWq8ucbg1u0rKzPIOBAYtDu+diJDvQvFZYPesmo+l/m4eTfad
         xZCt8Sdfy1Ll/EDq+9eoJclI0zQvKjAyNIOrirM/TtEy0dxCLoH4m9XRxph5HZxnHEmS
         x9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NHB+IechgCnORT0O11rj63ypyGVRMc15X9YkdoTfLPE=;
        b=NqoAMpquwO3YgY4crVt+EA0IQ0ZdiYvgw13gRAvKW2JLWjFn+7Ak9zsI6COutdmYLK
         IMeYJKW7HaKCGP+Q/L/Fx80cZ2OvQ3u7JcoXnF50M8f18PERFzpA2HoYfSaAz9ryG3Km
         jKCrZM2dGuvlQ0zekwtzADo4VPb3lsWKpM57qQAY9DYFu9j21FSG6EmzVz+bgtI3gsLB
         BonHdi0DFvVInfpgpk5fpQN9KtQYSAzB56MDR2chhGUNBNs4/OHdGrgggCk2ygZcttQq
         A14G5pEWDp6XyVDz+o2VrpL5qQcE1OfDVwMAoACXWlScyGLP9nohEKj0Ev5JxhdRsFcH
         ikdg==
X-Gm-Message-State: APjAAAURkEu8HOZrc+iA0rkyDtGBSGWNb66uTTvbLwSKDd4/41NZ3w8R
        9UvQhogLs+uhY4VeEpCXygHMVb6FVToupw==
X-Google-Smtp-Source: APXvYqxySaJ46Sl3QSTkUG6vpaT3sAbeUy1REcuJrfZP+FyG+ECG5n55fw1f0u6PlilK23dADdf9rA==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3mr5571290plz.73.1581204247217;
        Sat, 08 Feb 2020 15:24:07 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:dc02:8cc6:46f8:4fa])
        by smtp.gmail.com with ESMTPSA id e16sm7130445pgk.77.2020.02.08.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 15:24:06 -0800 (PST)
Date:   Sat, 8 Feb 2020 15:24:05 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] diff-options.txt: avoid "regex" overload in example
Message-ID: <20200208232405.GC33529@syl.local>
References: <20200202204739.GA24686@dinwoodie.org>
 <20200206205301.27367-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206205301.27367-1-martin.agren@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Thu, Feb 06, 2020 at 09:53:01PM +0100, Martin Ågren wrote:
> When we exemplify the difference between `-G` and `-S` (using
> `--pickaxe-regex`), we do so using an example diff and git-diff
> invocation involving "regexec", "regexp", "regmatch", ...
>
> The example is correct, but we can make it easier to untangle by
> avoiding writing "regex.*" unless it's really needed to make our point.
>
> Use some made-up, non-regexy words instead.

This is a good idea, and I think that it removes additional, unnecessary
confusion from the documentation here.

> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/diff-options.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 09faee3b44..bb31f0c42b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -567,13 +567,13 @@ To illustrate the difference between `-S<regex> --pickaxe-regex` and
>  file:
>  +
>  ----
> -+    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> ++    return frotz(nitfol, two->ptr, 1, 0);
>  ...
> --    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> +-    hit = frotz(nitfol, mf2.ptr, 1, 0);
>  ----
>  +
> -While `git log -G"regexec\(regexp"` will show this commit, `git log
> --S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> +While `git log -G"frotz\(nitfol"` will show this commit, `git log
> +-S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
>  occurrences of that string did not change).
>  +
>  Unless `--text` is supplied patches of binary files without a textconv
> --
> 2.25.0

Thanks for doing it.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

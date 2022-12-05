Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1347C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 22:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiLEW7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLEW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 17:59:33 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80183C771
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 14:59:32 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d123so3173786iof.6
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 14:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bFKiZszbrw0TBey4qVwHiFqvDQrdeyUtHMHA8uTm34=;
        b=HN0rj0K1vqX4idQMOFuPRwpHSAfiuJVAoUSp/NslGju+AdYR6to5A+qG71sVS8Onn+
         aMgB4qs/NN4+IewKY8H5wUYMnb0Tpa9YS4nBlQSLs0BcL8ROfxtNqEy9l3LDjHEQ7Fos
         IP5HNpbT1YIByfJ2BgjM+Rp9Dek97fooO13I75vahTqqbbDt1dZDuo0ZG4XKfSOot5Ll
         S2NSItdBXaZ+ja/+3dYUb4rKm1kh3j4QnY2Pb1EKmibqN0vmiafFwV8ZoUp9R09/8GFG
         IjmzgNmHoEJw6W6tTDQh6UWxtI4F8Y3xKD3OU8Kn0plTX5h4lKW9jJ+P4q/mBnU3X/Ja
         m/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bFKiZszbrw0TBey4qVwHiFqvDQrdeyUtHMHA8uTm34=;
        b=euclZDEz/nVocxyBV58ic3/P31f28aHwZzFh9LR13ptS6pu27Ewa5cGbnhUCEAkSYW
         k9+iypJKY7lDhMby4FKaCe1zQRkEUfshpjaeKcXSAFPiwUyzl9+NN5E6Prxtf+QDLzm4
         gD/CkqDRPGR82n0RPa7/Nv0zJ5G8kYGnWNMwxaBsfPwY2bTi4gPv+3z7/XleiPvjKXBZ
         HxKiWf+BEEOvHJ+z9HCDcb2TY6BTeVNgY9GLr0Id0pNA24g77ONP4von1I00ED6iLUqX
         7YKQUsdQaAlDPqBOVv0XuKglamvCMf7CXn0iJpQXDeOUu09DXlBNdZQ3cjfUS9lQgXH/
         7igg==
X-Gm-Message-State: ANoB5pml+TFaZ8Mo/e9IlQ2WeSNz7gpBJpQxYUOsTz+zsRpwjiyOrYHJ
        zkM18wHon8+ce9n6DvIItU4kBIJI2YJffUk3
X-Google-Smtp-Source: AA0mqf41Oq2fHQNLNT1HIl3uTqGkeJTbnNrXIGmdXN8H/JtIzuKCg0FNnBn1KQtkQihhpUpGZVIgZw==
X-Received: by 2002:a02:a312:0:b0:389:f80a:2cb5 with SMTP id q18-20020a02a312000000b00389f80a2cb5mr13317772jai.40.1670281171818;
        Mon, 05 Dec 2022 14:59:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w62-20020a025d41000000b003884192cc05sm6109113jaa.120.2022.12.05.14.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:59:31 -0800 (PST)
Date:   Mon, 5 Dec 2022 17:59:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
Message-ID: <Y453yiYAifv/oV5n@nand.local>
References: <20221205190019.52829-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221205190019.52829-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 08:00:19PM +0100, Christian Göttsche wrote:
> @@ -1669,7 +1669,14 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
>  /* if any standard file descriptor is missing open it to /dev/null */
>  void sanitize_stdfds(void)
>  {
> -	int fd = xopen("/dev/null", O_RDWR);

So before we would do one syscall here unconditionally. Then in the
common case, we'll do another syscall to close the descriptor we just
opened. IOW, ordinarily we expect this function to execute two syscalls.

> +	int fd;
> +
> +	if (fcntl(0, F_GETFD) != -1 &&
> +	    fcntl(1, F_GETFD) != -1 &&
> +	    fcntl(2, F_GETFD) != -1)
> +		return;

But under the same circumstances (i.e., where all three descriptors are
already valid), we now have to make three syscalls to determine the same
fact.

...So I'm not sure that I agree with brian's "this isn't making anything
worse" statement earlier in the thread.

In practice, however, it appears to be basically undetectable. Here,
'git.old' is the pre-image of this patch, and 'git.new' is the
post-image. I figure that running 'git -h' is about the fastest thing I
could do:

    $ hyperfine -N -L V old,new './git.{V} -h'
    Benchmark 1: ./git.old -h
      Time (mean ± σ):       1.6 ms ±   0.2 ms    [User: 1.1 ms, System: 0.4 ms]
      Range (min … max):     0.8 ms …   2.2 ms    1589 runs

    Benchmark 2: ./git.new -h
      Time (mean ± σ):       1.6 ms ±   0.2 ms    [User: 1.1 ms, System: 0.4 ms]
      Range (min … max):     0.9 ms …   2.2 ms    1746 runs

    Summary
      './git.old -h' ran
        1.00 ± 0.14 times faster than './git.new -h'

So it appears that the old version is ever-so-slightly faster than the
new one. But it's so noisy, and the regression is so small that it's
hard to notice it at all.

So I wouldn't strongly oppose the patch based on those numbers, but in
principle it seems flawed.

Thanks,
Taylor

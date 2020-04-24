Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB38FC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B488C2071E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9exJGaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDXRJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRJT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:09:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84472C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:09:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g6so4897047pgs.9
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EYP6L0xIqMKODxvOVzZtXadbOE4MhKVHycjk7pI8/iM=;
        b=J9exJGaNOsEzfTjkcyWW46tTGQe+iYGzGmlyPqkoy5EM5m/UMtx5idxipV+/DgTcqx
         Uank1gkjVbuuDQ9yZNIDKyY/xU0SrE7hCfC1dCCkGjG2WtFp8WSITFPDcwi3wDfMkzS3
         9D10OsnukIPjHbLIJezUztnazRyerrdyFjCGyu0PR34GbEyhx/Sg0PnksxvuJgQav+mx
         VnzgV3EyBHR6WTRT766YjuLVtLl0iZxIkhq0cuc3sMiQBLDG5BGEbGyfxyDFpcYZZkB2
         /w8qTxKFtWpIaFNoFc1rF7rwHutjfJBxN+T1Koyd6Wm3EzoTtlHStkILSylpKjnsrUbf
         OjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EYP6L0xIqMKODxvOVzZtXadbOE4MhKVHycjk7pI8/iM=;
        b=WRX7P9cohpDu+jtBjuT1WnKWybMlA70a68A0kca4M5ymjEmSuya0Ub6R2V5oW/CIWf
         yV2vAfxM83i0un9qnB/LW7Ueet7F5tu0QcBr1E5HoanRYVY6MUdh+Ekhu/9IZ6jc2zTm
         NBhJ3JgCx230yIE9RWkjKygoMfNkp7IpVoT9TRsYbxcrkh4X1GgnV+1uczkugw6vH1TX
         OenMPYA++jsfo51p2wO5q6DjXVV1RpWh/NcCqn2RltYofwhDmsMUoM8oiclj5dnFPZm2
         eUdvb640WyGNBUcpzHVWpuWFKqDybGOsroElW7n0j8cLOcIUUVqlVXfLV1Iv1oey+YHk
         H35w==
X-Gm-Message-State: AGi0PuaalipO1iPrgPARrNKwKe8bwsCsIOa+ITw4xkao31KLQlUy3RtJ
        I4Zxm+xEp+duikoj3eWd/VvzEfZj
X-Google-Smtp-Source: APiQypKxNXhczm0iwx3wgjF94SaHSDDjbgUEdpzgfn1mwlY1Fghqvt9JHfBhVXogW8qTIo4lOmUpiQ==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr11065863pfn.124.1587748159039;
        Fri, 24 Apr 2020 10:09:19 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id x66sm6207942pfb.173.2020.04.24.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:09:18 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:09:16 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200424170916.GA29153@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 17:56:46+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 24/04/2020 16:12, Đoàn Trần Công Danh wrote:
> > Somewhere later in the code, we indirectly include alloca.h
> > which will define alloca again, thus create a warning about
> > redefinition of a preprocessor.
> > 
> > Include it prior to define alloca in order to not define it again.
> 
> So, on cygwin, this patch is not required. ie. I don't see any sparse
> errors/warnings for compat/regex/regex.c.
> 
> Since cygwin uses a different c library (new-lib rather than glibc),
> I did a quick test on Linux, thus:
> 
>   $ sparse --version
>   v0.6.1-191-gc51a0382
>   $ 
>   $ git checkout master
>   Switched to branch 'master'
>   Your branch is up-to-date with 'origin/master'.
>   $ 
>   $ make clean
>   GIT_VERSION = 2.26.2.266.ge870325ee8
>   ...
>   $ 
>   $ make NO_REGEX=1 sparse >sp-out1 2>&1
>   $ 
>   $ diff sp-out sp-out1
>   0a1,2
>   > GIT_VERSION = 2.26.2.266.ge870325ee8
>   >     * new build flags
>   12a15
>   >     * new prefix flags
>   72a76
>   >     GEN command-list.h
>   226a231
>   >     SP compat/regex/regex.c
>   $ 
>   $ make V=1 NO_REGEX=1 compat/regex/regex.sp
>   cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"' -DGAWK -DNO_MBSUPPORT \
>   	  compat/regex/regex.c
>   $ 
>    
> So, again I don't see a problem. I guess it is possible that the
> version of sparse I am using (see above) has _also_ fixed this
> problem, in addition to the prototype attribute placement fix.
> 
> Another option is that the version of glibc also matters. (I am
> on Linux Mint, which is based on Ubuntu 18.04 LTS) It would not
> be the first time that I have seen errors in system header files
> change from one release to the next ...

I'm using a Linux distro with musl libc.

I guess it's the main culprit?
I have another box with glibc, but it's mostly in Windows 10,
because my sister is its main user.

I'll take a look if it make that warning when my sister agree to leave
that box to me.

-- 
Danh

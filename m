Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC65C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8022D2080C
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 17:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI8jkSIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZReW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgDZReW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 13:34:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E5C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 10:34:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so3891420pjz.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AEnc7a7tGfSlTy7gbdRm+aGEQ1jyv9kgspC891PkS3E=;
        b=FI8jkSInS3TGfUL6QbGjuVU/cueKGAiw6bPOU5x7QLMYadDhRJZCImrp9OHcnmjWRd
         Fjrlj795FPRJkdFR/1INgJFkkgLnh6nM3QTX0vDgyJIUM+zeO01uu+L13RznFRDi4Ie7
         riLillOrEFe37lM4mz/j6K5fBQVmvS7/nmGJiil/D0RhZMwO1dVDzibBtJ1IQG+PMIdH
         Ssezn/vJ3BMvu4vm98k1jsuaf68F4Tijx3kULdRv7q7ECpT1A8pfXrvW9bb0h16Dvyob
         BHvhhfej1rNhU9BnxpzwbcWSCm/ReNJkgaEQFjMUeOc6rPgjM/C1njeG2x+1OAXn1ToL
         YLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEnc7a7tGfSlTy7gbdRm+aGEQ1jyv9kgspC891PkS3E=;
        b=NXYRMrF+yHkDDkXbhohBl5xdkr8O/iU2nsaCxQqMQzJZJAmAgL8SQVNSLIDUFRdBm8
         3rli1fqNhR5Xu7NcRFE/pZFP8HIhSzxzGAipNl4stfFMAIxpvFDTovB0XkkQ//qIM7bf
         EFEr7rMmQXJIPRwUyTNWjdas52ryvJbl8pvnA8PQvELbyAjw0RBNmMo6pWFduEZXv8Qi
         OEjosiPUxxf+v5L5cv2CzzuGlWrD2dJyYYIlpmWmbwunF2ozmSaI1lw1nkUXmTaUlLvo
         IU8MaWA9pNIOs9GBXKp977KMUwP12KFpPyLkAKxjA8axd+ct5Z5tsCCFCnaRnTNNSWX+
         wsBA==
X-Gm-Message-State: AGi0PubCYigiSs8TBbbcMKMc+pjuhp06lJEnQY2+AQN9jfyqhTiyw+Cg
        /PzNsdOUaHI4IXQkxsrn8QO/DTDc
X-Google-Smtp-Source: APiQypKJN0PtKaQs/JHHIxJvJNrJtSRJSXO2q+LtKPQ/pbV75Ent7l07ymHTgFBp7BL+DZXbE1Ymow==
X-Received: by 2002:a17:90a:3266:: with SMTP id k93mr19899760pjb.118.1587922461560;
        Sun, 26 Apr 2020 10:34:21 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 20sm10247992pfx.116.2020.04.26.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 10:34:21 -0700 (PDT)
Date:   Sun, 26 Apr 2020 10:34:19 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] macos: do let the build find the gettext
 headers/libraries/msgfmt
Message-ID: <20200426173419.GA95483@Carlos-MBP>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
 <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 12:54:26PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e009383..1ea16e89288 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -133,8 +133,17 @@ ifeq ($(uname_S),Darwin)
>  	HAVE_BSD_SYSCTL = YesPlease
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
> -	BASIC_CFLAGS += -I/usr/local/include
> -	BASIC_LDFLAGS += -L/usr/local/lib

keeping these flags independenly allows people that doesn't have brew or that
have brew but hadn't installed the gettext package, to still be able to use
other libraries/packages that could be installed in those directories
either through brew (ex: libgcrypt, openssl or pcre*) or manually while
also using a compiler that doesn't use by default /usr/local/{include,lib}.

even if all this might sound like a stretch, notice that it happened before
as shown by 2a1377a2a (macOS: make sure that gettext is found, 2019-04-14)

> +	# Workaround for `gettext` being keg-only and not even being linked via
> +	# `brew link --force gettext`, should be obsolete as of
> +	# https://github.com/Homebrew/homebrew-core/pull/53489
> +	ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
> +		BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
> +		BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
> +		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
> +			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
> +		endif
> +	endif
>  endif
>  ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET = YesPlease
> 

since this doesn't depend on NO_GETTEXT and the gettext support doesn't get
automatically configured and used if found (unlike most other) then having
it here could work and is cleaner, but will still mean that MSGFMT will be
called to compile the translation files even when git is built with NO_GETTEXT

just because of that oddity I think having it with the other package related
entries in Makefile might still make sense (specially since we can't get
rid of it unless we also deprecate the other package managers), but if
cleaning it is what you had in mind  would also appreciate in that line your
review on 20200425102651.51961-1-carenas@gmail.com[1] and
20200425091549.42293-1-carenas@gmail.com[2] that do similar work and that
in the later case improve performance and correctness of git grep.

Carlo

[1] https://lore.kernel.org/git/20200425102651.51961-1-carenas@gmail.com/
[2] https://lore.kernel.org/git/20200425091549.42293-1-carenas@gmail.com/

Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05736C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9820721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5pbQ20o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgDBBmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:42:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgDBBmG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 21:42:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17so1099579pgo.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qBjt+IYSuzzE4qQh8N7zyoACRrDN/HnizYS5WpRamtE=;
        b=u5pbQ20oh+PTaEMNd1nkQU25zToZWrkBgtFgAVwWcNUdyU3TjyKSIF3CSlvWihnLd6
         NbC1fBOy5D6juMNNONCxVQKDnANSHK5b1kiaVm6WDHW5lhk2Jo9f05qh4ZgbECjx6+bO
         9fare8qmsCag1irG/vGrgAUjmAiZ7U5YL62k0tvrgBgMHn7X82atbO7Ih32o0gkEEqQa
         nozJBZYRmYJ+Sy8QYePJBxsj2GLWayP8Sr3NvdjD7MK/declUcckfE+W6rb3uwNzhFoV
         0RsIudpOG3i1v2dQS9X91ZoUcS6yG1ZXxD92FCAl9Li3CnVEbMp0LxWJ90wL6iaZh9vu
         vXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qBjt+IYSuzzE4qQh8N7zyoACRrDN/HnizYS5WpRamtE=;
        b=T+Dqh0QGXTxVQriwXQ4OReZGz0rDwqkrmIO8l3dQTWIRFrUtOTfq80vpqeSN5hKlRe
         P7E+jarYLp4iEKWmGu6a2gEEHuuJ8dzbaOCJMA2IjL8Mc9NInv9rTrdKp1u4x52QozZh
         a6FO0qlw1OXU7/fSNSfCwTXi/Vma2GnxUCEYmIMiD7zJgA+2x87TLRQJ1Lvx4wH95Hj1
         kubMpG0dAxARprlYiNs1sFLy+yNVRtuqgQQePFqkQ/YUQTN/fgvHDyPxalqnsOStm1Em
         v3gtTrR6rM7IfArppur0lG9z9StjsBZ7T7m+UFZQS8T3OfFRSwBqrDa4jJo/9DLjIfjA
         8GjA==
X-Gm-Message-State: AGi0PubNOZvkUda10y0zHWEd26wpzyzNntCm2c+g3vrZbWuco3C/0gtP
        5DEoLey1sQvVTovdP2fQsEI=
X-Google-Smtp-Source: APiQypJpLvQmYE8Mf39TWKk72Hku4OLHHasA4nsgRMn5hrjC4R0Atx+e8N1HzkmdeFymwbtw9ujeeA==
X-Received: by 2002:a63:2014:: with SMTP id g20mr606437pgg.180.1585791724689;
        Wed, 01 Apr 2020 18:42:04 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id q185sm2516231pfb.154.2020.04.01.18.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:42:04 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:42:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] travis: build and test on Linux with musl libc
 and busybox
Message-ID: <20200402014202.GC2764@danh.dev>
References: <cover.1585203294.git.congdanhqx@gmail.com>
 <cover.1585474409.git.congdanhqx@gmail.com>
 <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com>
 <20200401221835.GH2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401221835.GH2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-02 00:18:35+0200, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Sun, Mar 29, 2020 at 05:12:31PM +0700, Đoàn Trần Công Danh wrote:
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> 
> > diff --git a/ci/run-alpine-build.sh b/ci/run-alpine-build.sh
> > new file mode 100755
> > index 0000000000..c83df536e4
> > --- /dev/null
> > +++ b/ci/run-alpine-build.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/sh
> > +#
> > +# Build and test Git in Alpine Linux
> > +#
> > +# Usage:
> > +#   run-alpine-build.sh <host-user-id>
> > +#
> > +
> > +set -ex
> > +
> > +useradd () {
> > +	adduser -D "$@"
> > +}
> > +
> > +. "${0%/*}/lib-docker.sh"
> > +
> > +# Update packages to the latest available versions
> > +apk add --update autoconf build-base curl-dev openssl-dev expat-dev \
> > +	gettext pcre2-dev python3 musl-libintl >/dev/null
> 
> In 'ci/run-docker.sh' we run 'docker run' with a bunch of '--env ...'
> options to make some important environment variables available
> inside the container.  At this point in this script all those
> variables are set to the expected values, but ...
> 
> > +# Build and test
> > +su -m -l $CI_USER -c '
> 
> ... but here, for some reason, those environment variables are not set
> anymore.  This is bad, because this CI job then builds Git
> sequentially, runs the tests sequentially, runs the tests with 'make'
> instead of 'prove', and runs the tests without '-V -x'.  IOW, it's
> slow, it produces a lot of useless output, it doesn't report all the
> failures, and doesn't tell us anything about the failures.

At this point, I tempted to change this to

	su -m -l $CI_USER -c /usr/src/git/ci/run-build-and-tests.sh

instead.

But, after digging into ci/lib.sh, I found too many setup for "$CI_*",
let choose your path instead.

> > +	set -ex
> > +	cd /usr/src/git
> > +	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
> > +	autoconf
> > +	echo "PYTHON_PATH=/usr/bin/python3" >config.mak
> > +	./configure --with-libpcre
> 
> The recommended way to build Git is without autoconf and configure.
> You can set the PYTHON_PATH and USE_LIBPCRE Makefile knobs in
> MAKEFLAGS in 'ci/lib.sh', but to be able to access MAKEFLAGS in the
> container you'll need to build this patch series on top of:
> 
>   https://public-inbox.org/git/20200401212151.15164-1-szeder.dev@gmail.com/
> 
> > +	make
> > +	make test
> > +'
> > diff --git a/ci/run-docker.sh b/ci/run-docker.sh
> > index be698817cb..f203db03cf 100755
> > --- a/ci/run-docker.sh
> > +++ b/ci/run-docker.sh
> > @@ -10,6 +10,10 @@ Linux32)
> >  	CI_TARGET=linux32
> >  	CI_CONTAINER="daald/ubuntu32:xenial"
> >  	;;
> > +linux-musl)
> > +	CI_TARGET=alpine
> > +	CI_CONTAINER=alpine
> > +	;;
> >  *)
> >  	exit 1 ;;
> >  esac
> > -- 
> > 2.26.0.302.g234993491e
> > 

-- 
Danh

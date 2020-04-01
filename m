Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07A4C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 22:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F020678
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 22:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyXDDR9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgDAWSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:18:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40089 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 18:18:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so1926127wro.7
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pAQF9JI/Gio0DMlf9FzQzFyZnyw0l0Dm/qI7+RY433M=;
        b=kyXDDR9tMK6ThRbaxAJsU8BZfjtv8rozJGsUqfKhUlJsiT/wES9yRdgK9KmeuNMQo2
         YQthydIPPa23zgeQVcRT9dNHnu29qYSQhI+tBBEYwhvnbRkGBwmDIirpcOVgzJLIVR9S
         27+n9la6GXuka/C7WPf7a8VeCmL55yO4B6vLeaZhPurqNjB/XnlX78Q6NTa+lcr2DXNm
         0N4cy7gXKTq3cx8bvmNt7KJGWVB781W6eXguV+8UMLnHHo/DtZcDflF8I9ua8YL+E3ha
         haaq1yyy4RogKaQ9MlsWpnYbUz0nCKeVDQ4HAQIMm0MVSzbajmP8oYJ64jQbz4o5kz5n
         Hzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pAQF9JI/Gio0DMlf9FzQzFyZnyw0l0Dm/qI7+RY433M=;
        b=CxVjNh7m36Z7AxPNLTfceEtq5hDQEgeq+EyNlDoT9Z5SW4BTjgxE0ywZ8AHIEMXy68
         H74FjYqDuMM3OWs9MmMwcJVMOwtaQrHPUlHS2TWTtXXp/Oxy98kyjLLpaCt1FBYLX+Ya
         qWaX46DNX0hwMj2YNhsygYLCopYQ8sh9mzPDDwu9/N7T/vbKiy9qY2f8sbvUQqn5wfh8
         6EbNgpa6PgLzPQVcAovUP304yj1Fpc90f89aO2pC+cA9Ia27GwfHcVOFCz0WDrJubn+5
         FJAk9Qzf9f79MPqM9vKg7Ahx/MUBp6BvDmN85zUeZYdbxeMr3Xjr3frbq/0v7EoPH8gC
         iGig==
X-Gm-Message-State: AGi0PuZkoVh6sHGjk2abLzuir6epNCQbaQTxc4Jfw0Z62A6uYf/FFYgw
        tlS0a8bwgAsxXgAlNDZaQAw=
X-Google-Smtp-Source: APiQypJ9Lkn+KChZk1OwLyrJdcHDhpD6gPoj0SXiOSbYtvXyOomTKq9WwaWykTgJj1EPAqnoDHTcLQ==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr165727wro.32.1585779518351;
        Wed, 01 Apr 2020 15:18:38 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id j11sm4304094wmi.33.2020.04.01.15.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:18:37 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:18:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] travis: build and test on Linux with musl libc
 and busybox
Message-ID: <20200401221835.GH2224@szeder.dev>
References: <cover.1585203294.git.congdanhqx@gmail.com>
 <cover.1585474409.git.congdanhqx@gmail.com>
 <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 05:12:31PM +0700, Đoàn Trần Công Danh wrote:
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>

> diff --git a/ci/run-alpine-build.sh b/ci/run-alpine-build.sh
> new file mode 100755
> index 0000000000..c83df536e4
> --- /dev/null
> +++ b/ci/run-alpine-build.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Build and test Git in Alpine Linux
> +#
> +# Usage:
> +#   run-alpine-build.sh <host-user-id>
> +#
> +
> +set -ex
> +
> +useradd () {
> +	adduser -D "$@"
> +}
> +
> +. "${0%/*}/lib-docker.sh"
> +
> +# Update packages to the latest available versions
> +apk add --update autoconf build-base curl-dev openssl-dev expat-dev \
> +	gettext pcre2-dev python3 musl-libintl >/dev/null

In 'ci/run-docker.sh' we run 'docker run' with a bunch of '--env ...'
options to make some important environment variables available
inside the container.  At this point in this script all those
variables are set to the expected values, but ...

> +# Build and test
> +su -m -l $CI_USER -c '

... but here, for some reason, those environment variables are not set
anymore.  This is bad, because this CI job then builds Git
sequentially, runs the tests sequentially, runs the tests with 'make'
instead of 'prove', and runs the tests without '-V -x'.  IOW, it's
slow, it produces a lot of useless output, it doesn't report all the
failures, and doesn't tell us anything about the failures.

> +	set -ex
> +	cd /usr/src/git
> +	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
> +	autoconf
> +	echo "PYTHON_PATH=/usr/bin/python3" >config.mak
> +	./configure --with-libpcre

The recommended way to build Git is without autoconf and configure.
You can set the PYTHON_PATH and USE_LIBPCRE Makefile knobs in
MAKEFLAGS in 'ci/lib.sh', but to be able to access MAKEFLAGS in the
container you'll need to build this patch series on top of:

  https://public-inbox.org/git/20200401212151.15164-1-szeder.dev@gmail.com/

> +	make
> +	make test
> +'
> diff --git a/ci/run-docker.sh b/ci/run-docker.sh
> index be698817cb..f203db03cf 100755
> --- a/ci/run-docker.sh
> +++ b/ci/run-docker.sh
> @@ -10,6 +10,10 @@ Linux32)
>  	CI_TARGET=linux32
>  	CI_CONTAINER="daald/ubuntu32:xenial"
>  	;;
> +linux-musl)
> +	CI_TARGET=alpine
> +	CI_CONTAINER=alpine
> +	;;
>  *)
>  	exit 1 ;;
>  esac
> -- 
> 2.26.0.302.g234993491e
> 

Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B24C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30864206C1
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFKdBBXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJPx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:53:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42171 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJPx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:53:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id j2so2707630wrs.9
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5VyI+AHQ4pOVnYaXaVj4NWcXQrj6+GWPXFr9NK/ARvI=;
        b=QFKdBBXgLjyUwfrsiC3Buv1zH62UbHuU3RCe8eYD0RqIwFbLRjI/5b29BX1vJXZcl5
         jjO52oi3woZJLltQXg3walrTqvr23meUwSSez1vEgRiut7ykUVLpUspxUpSAO/my/C5v
         eg3WC03LsolhvHkLx+/RlZuEwNwRlqdSwzRBlYLjsLYYjzn+zjVIQvLQKlw+RjzB4sxj
         LRZT/D32oW7Q+h81fcxzWMgY4DlzNIhgUPzDDB0dCCBerJOECjG63WDADAlgftSvTelF
         fptXm5oXPvAvHtFh+Ce65CKa9fSk2ERdxMVhRNpEZlKgoaRy4DlSiAME3xoJhyp7WpRh
         K6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5VyI+AHQ4pOVnYaXaVj4NWcXQrj6+GWPXFr9NK/ARvI=;
        b=SBxe8RKsygF94JCPo32alUf6Ni3z5JN0OYWMZIxZsi+JNmP+GGp899dLUAlkfp99h6
         gcIVDzPQWqUjYWnjKKNuznH2QIX394jKna+MF/nsbj6Yb/sIlBjrzZ68ANjeSxWMW0tL
         z9Km6LNMXuJ+z3GFJOywFkb4+bOwUHK1BUaNJkM8soFc4z7XOQmd7Hsjy+dVJbuK4/Ac
         Acgmm24/V4JgPDCrW7Nsl1u2kzVAQAuSMNGRMtDh+t3WF5LCGqA1Fx48NMJV0Rmh2ZjW
         98/0EQqNMD/ZlE5LIDyRBc+7E8l440wBIeWRNa6UsaleQ7GU8b9Q9Dof2VQpTAf4A+P/
         JXfA==
X-Gm-Message-State: AGi0PubTi97rWBEGI12fuhr7EkDU6PQIL/pij0r+km4vjJYLfwhbd5ty
        vkAzFgWQKSqVJE8UTaIpWCw=
X-Google-Smtp-Source: APiQypKrbYPzKAx1T7MizPvkAHcE2hvIn0P6K9ivIq/V5Lf4usDhM2jrl9vooDDwOqz+Czlek1X1+w==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr4833028wrc.285.1586534006317;
        Fri, 10 Apr 2020 08:53:26 -0700 (PDT)
Received: from szeder.dev (78-131-17-184.pool.digikabel.hu. [78.131.17.184])
        by smtp.gmail.com with ESMTPSA id f187sm3570583wme.9.2020.04.10.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:53:25 -0700 (PDT)
Date:   Fri, 10 Apr 2020 17:53:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 05/12] ci: explicit install all required packages
Message-ID: <20200410155322.GN2224@szeder.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <4f80724641e17bf0d1937dbad77f987fbf86cd64.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f80724641e17bf0d1937dbad77f987fbf86cd64.1586309211.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 11:05:36AM +0700, Đoàn Trần Công Danh wrote:
> In a later patch, we will support GitHub Action.
> 
> Explicitly install all of our build dependencies.

... on Linux.  This patch doesn't touch the parts installing
dependencies in the osx jobs, but we do rely on some packages being
installed by default in the osx images we use.  This is worth
clarifying in the commit message, and in its subject line.

> Since GitHub Action VM hasn't install our build dependencies, yet.

s/install/installed/
I'm not sure what you mean with "yet".

> And there're no harm to reinstall them (in Travis)

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  ci/install-dependencies.sh | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 497fd32ca8..371902bb75 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -7,12 +7,17 @@
>  
>  P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
>  LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
> +UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
> + perl-modules liberror-perl tcl tk gettext zlib1g-dev apache2
> + libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl
> + libnet-smtp-ssl-perl"

I note that this list includes 'make' and 'apache2'.

>  case "$jobname" in
>  linux-clang|linux-gcc)
>  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
> +	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \

'apache2' is listed here again.

> +		$UBUNTU_COMMON_PKGS
>  	case "$jobname" in
>  	linux-gcc)
>  		sudo apt-get -q -y install gcc-8
> @@ -63,11 +68,16 @@ StaticAnalysis)
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns
> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns \
> +		libcurl4-openssl-dev

Does the Documentation job really need the 'libcurl4-openssl-dev'
package?  FWIW, I just removed this package from my system, and 'make
doc' still succeeded.

Furthermore, this doesn't install 'make', though in other jobs it is
installed explicitly.  Note that the StaticAnalysis job requires
'make' as well.

Also note that we have a 'linux-gcc-4.8' job as well...

>  
>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	gem install --version 1.5.8 asciidoctor
>  	;;
> +GETTEXT_POISON)
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS

The GETTEXT_POISON job currently doesn't install 'apache2', but with
this change it will.  If this change is intentional, then please
justify it in the commit message.  But I think that we shouldn't
include 'apache2' in $UBUNTU_COMMON_PKGS.

> +	;;
>  esac
>  
>  if type p4d >/dev/null && type p4 >/dev/null
> -- 
> 2.26.0.334.g6536db25bb
> 

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38942C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B3A60EB5
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhHKIIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbhHKIFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 04:05:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C17C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:04:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so2411356otl.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uAK9WMfgBprY4daKCyQbVXLR+22m8R8jSVNb1svZoYA=;
        b=JYHeHJMNMCdNGmGILcW77I8jhe314e8XoH/WpHV//Qp5D7oeQ7MVkeCpQ4Jyw9cGqh
         TI3UBlzvEOMMy34ucXN0RmSgismZIYZ3wU47MyFcWqSiCmXkxjHpkTqLbz50UMjn6UWR
         boTkFQf9K5AdaYH7Cyo0HyL06DZrQ1y53D/IgWVpDlba7s+YR6SHVOwedOSPTPUSQST5
         Qz+WAIV4xRv1ZZXG6E/nhhGpDHILNfBCihyaQ1SgtB98q3b55GpUL+gDKlt6gEMDp9Nb
         mQtR3XRPCDvYKzb60MAi6/MYEOAywjZ4b60DnzYbpeP3oSfjQe7BAsp/FdedOMXEff+g
         lgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uAK9WMfgBprY4daKCyQbVXLR+22m8R8jSVNb1svZoYA=;
        b=kXW7A9qC5V0rHiPcaAl5RI+hJ/2R2J0CtPJ3GAc9Vpun5PvBkwIJqtej/au768nx7Z
         5D4rk53mrh95HITk5BVutLXOHNcXuK1CIQLzkRMIaca3VBHxtJcSFeJU7U7r3lOEgvTU
         1uGsKShOoOaCZ9JF1zt7XHdBTZ5BD3jVra7OvLhSCdr4AjwKp/Wuau6bu3zGEKoVrYWh
         Ei0v+kvfcNqAG7Bwd+3cIoysS6coev15M6jlH+ITrqpf1cp+95gNGB/ZSg4a8Jy4ko20
         kEJorpqYCqROZEYx2X5/AQmB9NiwC7qn+JSVEWaAf9GrFqTBkLlUMzVj2hEk/pvpH4rA
         nyDg==
X-Gm-Message-State: AOAM5323qB+yGHcOTxhKQDYAKixZvV4v2G2zUIMdyW79JH9BBCM2cJC8
        5C3YziwqjC0mA6YyLiJQzXc=
X-Google-Smtp-Source: ABdhPJw8yKQRe2yTPnoqem4lwuatMRcL7bHEIRRRslgnF5j7U1hrXxmU7zY8b1ha2dVwfNEZaOZ4ug==
X-Received: by 2002:a9d:604d:: with SMTP id v13mr2435607otj.314.1628669080229;
        Wed, 11 Aug 2021 01:04:40 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id p124sm579760oia.8.2021.08.11.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:04:39 -0700 (PDT)
Date:   Wed, 11 Aug 2021 01:04:38 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
Message-ID: <YROElmCJQGaR8Lsx@carlos-mbp.lan>
References: <xmqqh7fwbx86.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 06:12:41PM -0700, Junio C Hamano wrote:
> 
> * cb/ci-build-pedantic (2021-08-09) 1 commit
>  - ci: run a pedantic build as part of the GitHub workflow
>  (this branch uses cb/many-alternate-optim-fixup.)
> 
>  CI update.
> 
>  Will merge to 'next'.

this version has the bug you reported[1] and provided a fix for
because the base image doesn't include git, and while the bug is
harmless it is still silly enough that should be worth fixing
before going to next IMHO..

I was preparing a version 2 reroll that included the tests, as
you suggested, which I was also planning to make a little more
useful by including other test dependencies missing from other jobs.

on that line, I also forgot to build with PCRE, which was the reason
why it was included as a dependency, and that has been corrected as
well; alternatively it could be removed and make the job slightly faster.

but if you want to have a less buggy and even faster job[2] in next
meanwhile could use instead the "1.5" reroll below which will be also
easier to base on for v2; alternatively it could wait, but was also
tempted to include UBsan in this job, and so it would need additional
fixes before it can be promoted in that case

Carlo

[1] https://lore.kernel.org/git/xmqqeeb1dumx.fsf@gitster.g/
[2] https://github.com/carenas/git/runs/3298216810
--- >8 ---
Subject: [PATCH v1.5] ci: run a pedantic build as part of the GitHub workflow

similar to the recently added sparse task, it is nice to know as early
as possible.

add a dockerized build using fedora (that usually has the latest gcc)
to be ahead of the curve and avoid older ISO C issues at the same time.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes in v1.5
* really build with PCRE
* install a smaller perl and git (used by the CI scripts)

 .github/workflows/main.yml        |  2 ++
 ci/install-docker-dependencies.sh |  6 ++++++
 ci/run-build-and-tests.sh         | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 73856bafc9..b93561978d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -324,6 +324,8 @@ jobs:
           image: alpine
         - jobname: Linux32
           image: daald/ubuntu32:xenial
+        - jobname: pedantic
+          image: fedora
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index 26a6689766..eba4b212e4 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -15,4 +15,10 @@ linux-musl)
 	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
 	;;
+pedantic)
+	dnf -yq update >/dev/null &&
+	dnf -yq install gcc make findutils diffutils perl-interpreter \
+		gettext git zlib-devel expat-devel openssl-devel \
+		curl-devel pcre2-devel >/dev/null
+	;;
 esac
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3ce81ffee9..724f9b54c8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,6 +10,12 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
+if test "$jobname" = "pedantic"
+then
+	export DEVOPTS=pedantic
+	export USE_LIBPCRE=1
+fi
+
 make
 case "$jobname" in
 linux-gcc)
@@ -35,10 +41,9 @@ linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	make test
 	;;
-linux-gcc-4.8)
+linux-gcc-4.8|pedantic)
 	# Don't run the tests; we only care about whether Git can be
-	# built with GCC 4.8, as it errors out on some undesired (C99)
-	# constructs that newer compilers seem to quietly accept.
+	# built with GCC 4.8 or with pedantic
 	;;
 *)
 	make test
-- 
2.33.0.rc1.379.g2890ef5eb6


Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A4C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7B020706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHWeWv5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgDXRXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:23:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A1C09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:23:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g2so3976299plo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8BaGIoqCDaZ6rycq0RH63AssXZImbod7+n7F6epqO4g=;
        b=SHWeWv5i1i4+5EkpzHSquw9SjYTI98agzOt7GrlUX9v3XaErCaJcUYpzXY05lLI6xQ
         G2PMPZFCChhRsUMIXXS2qTosdeBfpLG0mpW1/rhYL6Oyztdvl+Hsho7/u470Ku3iUxtM
         wukW4r7ObLF48iV20CvpbtcmCXFPdk6y0IWtj1C8eQDPH2PRT+4J+jEG0dGT9R4PGiub
         ZXwWjfVngYlvdNCmiyYlPeE+hnpDA50I80pCRz4sFTJuuRumfe3u/+iyOlFM0vgAt3Ia
         xHTJoOY17BCUtMKooca+bH4AF+zjJugmvvzIU7Qpzf/HIRYfxjprxg+94yW5JD6MhPTE
         9RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8BaGIoqCDaZ6rycq0RH63AssXZImbod7+n7F6epqO4g=;
        b=LwqO0B+vomgzsUMVC/hY9A9Xt8BcQaqFFl8vLbrlvqqVNV/PFS/q04ODBYywMYCgZT
         Ugr9GWf/ARLDDS1B+YBsXLUTwg1oR8nLxJB2llyfeFnqwmnGkg2YV/Z7MbNGul1vSRfo
         C0ASDRMo1qcE5k6CAT0Ar5Y9I5qzVue1MP39t+EPtLE7kYTqGpMh/pB7IcWE/muGhMSj
         iF7oPv1e7PAQtCLqsIjT7QAGBw+7Rq5Rr3Tgq/l9yURArNO1kx4PT/apOLL8sZZhtwD0
         C62KZvMmpllBlI2Wze+JxmmE8mWeSC5yILgOIHfFrK/Aciu9ygDoeiVc0sZIpiTEv3Nj
         4E6g==
X-Gm-Message-State: AGi0PubD4NgDIGK2NnYiHM7g/KHg8iLa9MdF2Ajhie5LsBnFH2t/LTER
        s58KYNCoO0+pDVB1y4YpP3Qulctnp1Y=
X-Google-Smtp-Source: APiQypKCV4g63+I7i+lAHnpElMtmS7kC0wtWrZNRbu/TLCd0fiZdfNOQR8fzNB8WsYXIS4TL/6aiuQ==
X-Received: by 2002:a17:90a:734b:: with SMTP id j11mr7229711pjs.108.1587748995276;
        Fri, 24 Apr 2020 10:23:15 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id k1sm5380811pgh.72.2020.04.24.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:23:14 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:23:12 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 3/8] cmake: installation support for git
Message-ID: <20200424172312.GJ1949@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <10390063a398feab86519ba4e4fd9d03f38cd0fd.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10390063a398feab86519ba4e4fd9d03f38cd0fd.1587700897.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 04:01:32+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch provides the facility to install the built binaries and
> scripts.
> 
> This is very similar to `make install`.
> By default the destination directory(DESTDIR) is /usr/local/ on Linux
> To set a custom installation path do this:
> cmake `relative-path-to-srcdir`
> 	-DCMAKE_INSTALL_PREFIX=`preferred-install-path`
> 
> Then run `make install`
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 788b53be873..25de5b5bc35 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -13,6 +13,8 @@ project(git
>  	VERSION ${git_version}
>  	LANGUAGES C)
>  
> +#TODO gitk git-gui gitweb
> +#TODO Add pcre support
>  
>  include(CheckTypeSize)
>  include(CheckCSourceRuns)
> @@ -631,3 +633,50 @@ if(MSGFMT_EXE)
>  	endforeach()
>  	add_custom_target(po-gen ALL DEPENDS ${po_gen})
>  endif()
> +
> +
> +#to help with the install
> +list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
> +list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
> +
> +#install
> +install(TARGETS git git-shell
> +	RUNTIME DESTINATION bin)
> +install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver  #${CMAKE_SOURCE_DIR}/gitk-git/gitk check

check? What does it mean?

> +	DESTINATION bin)
> +
> +list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
> +install(TARGETS ${PROGRAMS_BUILT}
> +	RUNTIME DESTINATION libexec/git-core)

Ubuntu install exec file to /usr/lib/git-core?

> +
> +set(bin_links
> +	git-receive-pack git-upload-archive git-upload-pack)
> +
> +foreach(b ${bin_links})
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
> +endforeach()
> +
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
> +
> +foreach(b ${git_links})
> +	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> +	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> +endforeach()
> +
> +foreach(b ${git_http_links})
> +	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> +	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> +endforeach()
> +
> +install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
> +	DESTINATION libexec/git-core)
> +
> +install(DIRECTORY mergetools DESTINATION libexec/git-core)
> +install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
> +	FILES_MATCHING PATTERN "*.pm")

I think distro gonna complans about this pattern!

> +install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
> +
> +if(MSGFMT_EXE)
> +	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
> +endif()

I thought we want to check for NO_GETTEXT?

-- 
Danh

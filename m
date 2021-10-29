Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1785AC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8A861075
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJ2VkK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Oct 2021 17:40:10 -0400
Received: from elephants.elehost.com ([216.66.27.132]:58559 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhJ2VkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:40:08 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TLbaWE075555
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 17:37:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        <git@vger.kernel.org>
Cc:     <avarab@gmail.com>
References: <013a01d7cd092d91cb088b5610nexbridge.com> <20211029212705.31721-1-carenas@gmail.com>
In-Reply-To: <20211029212705.31721-1-carenas@gmail.com>
Subject: RE: [PATCH] wrapper: remove xunsetenv()
Date:   Fri, 29 Oct 2021 17:37:30 -0400
Organization: Nexbridge Inc.
Message-ID: <014301d7cd0d$3019b8e0$904d2aa0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGRg/VseL3IXeLBpvX00zE9WnaeNAD1p6jrrG9kmsA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 5:27 PM, Carlo Marcelo Arenas Belón wrote:
> Platforms that are using the git compatibility layer for unsetenv use void as a
> return value for unsetenv(), so any function that checks for a return value will
> fail to build.
> 
> Remove the unused wrapper function.
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  git-compat-util.h | 1 -
>  wrapper.c         | 6 ------
>  2 files changed, 7 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h index 141bb86351..d70ce14286
> 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -879,7 +879,6 @@ char *xstrndup(const char *str, size_t len);  void
> *xrealloc(void *ptr, size_t size);  void *xcalloc(size_t nmemb, size_t size);  void
> xsetenv(const char *name, const char *value, int overwrite); -void
> xunsetenv(const char *name);  void *xmmap(void *start, size_t length, int prot,
> int flags, int fd, off_t offset);  const char *mmap_os_err(void);  void
> *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> diff --git a/wrapper.c b/wrapper.c index 1460d4e27b..36e12119d7 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -151,12 +151,6 @@ void xsetenv(const char *name, const char *value, int
> overwrite)
>  		die_errno(_("could not setenv '%s'"), name ? name : "(null)");  }
> 
> -void xunsetenv(const char *name)
> -{
> -	if (!unsetenv(name))
> -		die_errno(_("could not unsetenv '%s'"), name ? name : "(null)");
> -}
> -
>  /*
>   * Limit size of IO chunks, because huge chunks only cause pain.  OS X
>   * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
> --
> 2.33.1.1200.g715dc68e71

I will be submitting a separate patch to turn off NO_SETENV and NO_UNSETENV for the NonStop x86 platform, where the calls have been supported since October 2020. The ia64 platform will have to continue to use the compat layer.

Thank you for solving this.

Randall


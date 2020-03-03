Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC07C3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6920866
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbx4dvmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgCCLq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:46:57 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35711 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgCCLq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 06:46:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so1229299pjq.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x3oZX/51nyJwCv3+tbJhJWrAfkDdh0scJuXu1jNay/U=;
        b=Vbx4dvmO/BCpjTR48S2wkGDhPZfzbB3oXYvogSaYih1rUo5F5L4AvQklZkEXU+OFl1
         +lgEbznQ4E4WqbDRnPHPn6h0J4JAQuEh9EUTWx9s4F6+xUP8/ThXgB+CLunBKeM7v9ny
         O+vbJketmz8UkxJ1ZM0SHDO/rtKx/MzGzYVMostoT7tTCMVLUMsKP6yjwJ+VA6V27MXj
         WeJ6BN2oBB+lhsFZfxWvxVGEaiTm+SsR9ms+L8fRnWkSj3bHJVpXbkBph4AqFExbZ2xB
         oT8/ewNytScIcqAu3lmeaWpi933p7uTYQqhXjN036SjlK4tQrvV6dCBIyPKxr6FrMkBv
         OVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3oZX/51nyJwCv3+tbJhJWrAfkDdh0scJuXu1jNay/U=;
        b=eVtJCoO7eNY0dd2kRDbMGPLCY1RMVWOyZpgf20Odd1GoonfeCqH7Wz7lq/t7uVVMWC
         KPPdO1XPPu6PxKRghN2iVnDsStFVptGhkGfv9VMtgOoS7KvO9aqtdgyUqF0oUi1zWk7l
         GJaxYnol3L9sPykv8xzVrlW5aMRCZkhQctnsF6sHOiH+WegLTo3hXs6djLmcqG5zalq5
         Y0ohrta+G2f9HzNOYfbcwj+P9VufMEsi1fvmG2S3qyzLrYKotFwaEslN5ZroVTEmf91k
         LYzPq9wX+Wte+MQz81F93baeoA7LYVJ/Ac/S9C0sjlXJUquiirIm5Pv4aGqOruyKgmpX
         w2AA==
X-Gm-Message-State: ANhLgQ2iPstFC2ljtPNsPSe54wAtjX195YoO3zgQ2Zy7RUiXXLxMboAb
        xXt5iNyjldVo3U4QfcP0Cz+gorEb
X-Google-Smtp-Source: ADFU+vtunvNNKD/Gh87hzPHL0n7a1aVOLCk2ff0J4qL9BL6qMmVRO+7hc+fsP7iSkm/ggZG6TQBR1A==
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr3664051pjp.103.1583236015613;
        Tue, 03 Mar 2020 03:46:55 -0800 (PST)
Received: from localhost ([2402:800:6374:1ce3:8c96:5d8b:156f:e905])
        by smtp.gmail.com with ESMTPSA id 139sm229521pfy.70.2020.03.03.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 03:46:54 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:46:53 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] bugreport: add compiler info
Message-ID: <20200303114653.GB3610@danh.dev>
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-6-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302230400.107428-6-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-02 15:04:00-0800, Emily Shaffer <emilyshaffer@google.com> wrote:
> To help pinpoint the source of a regression, it is useful to know some
> info about the compiler which the user's Git client was built with. By
> adding a generic get_compiler_info() in 'compat/' we can choose which
> relevant information to share per compiler; to get started, let's
> demonstrate the version of glibc if the user built with 'gcc'.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     |  6 ++++++
>  compat/compiler.h               | 38 +++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 compat/compiler.h
> 
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index 17b0d14e8d..643d1b2884 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -27,6 +27,7 @@ The following information is captured automatically:
>  
>   - 'git version --build-options'
>   - uname sysname, release, version, and machine strings
> + - Compiler-specific info string
>  
>  This tool is invoked via the typical Git setup process, which means that in some
>  cases, it might not be able to launch - for example, if a relevant config file
> diff --git a/bugreport.c b/bugreport.c
> index 857b4f712c..5073c901cd 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "strbuf.h"
>  #include "time.h"
>  #include "help.h"
> +#include "compat/compiler.h"
>  
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -25,6 +26,11 @@ static void get_system_info(struct strbuf *sys_info)
>  			    uname_info.release,
>  			    uname_info.version,
>  			    uname_info.machine);
> +
> +	strbuf_addstr(sys_info, _("compiler info: "));
> +	get_compiler_info(sys_info);
> +	strbuf_addstr(sys_info, _("libc info: "));
> +	get_libc_info(sys_info);
>  }
>  
>  static const char * const bugreport_usage[] = {
> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..21f098e6a4
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,38 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +#endif
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	int len = info->len;
> +#ifdef __GNUC__
> +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> +#endif

This fixup can be used for clang on Linux, I guess it could be applied
for macOS too (since default gcc on macOS is symlinked to clang?)

--------------8<----------------------
diff --git a/compat/compiler.h b/compat/compiler.h
index 21f098e6a4..055dbb5e1b 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -11,7 +11,9 @@
 static inline void get_compiler_info(struct strbuf *info)
 {
 	int len = info->len;
-#ifdef __GNUC__
+#ifdef __clang__
+	strbuf_addf(info, "clang: %s\n", __clang_version__);
+#elif defined(__GNUC__)
 	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
 #endif
 
-------------------->8---------------------

> +
> +#ifdef _MSC_VER
> +	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
> +#endif
> +
> +	if (len == info->len)
> +		strbuf_addf(info, _("no compiler information available\n"));
> +}
> +
> +static inline void get_libc_info(struct strbuf *info)
> +{
> +	int len = info->len;
> +
> +#ifdef __GLIBC__
> +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> +#endif
> +
> +	if (len == info->len)
> +		strbuf_addf(info, _("no libc information available\n"));
> +}
> +
> +#endif /* COMPILER_H */
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
Danh

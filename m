Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D53C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AB2068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g74XXBTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIPVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:21:34 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46752 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIPVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:21:34 -0500
Received: by mail-yw1-f66.google.com with SMTP id u139so5882293ywf.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIXelue/XgIGZ3gDtlYJZ1+fcuoCMbboBtSRyBoF0ec=;
        b=g74XXBTFVrk7N0Kvzwnp3YQ5ssjQlqFECtvXDkBOOhqreL1tMYGtM+1TDAebZRmeiq
         Y0vub42a1yQrQBLibwxH+gwepRMk+UnM7bm4N32XUeQVNmYh/ImEx/Yj1rs9LlkkbrEK
         xaZmX3JWEUVZLRM9Su9wsQIU9Nk6qYvb7yNbvcWCiOfDqDQ9FF3I0na9X9viihTYbtwB
         rsG5DnwD27nhQtz/RqemGafNUMdPIqqBKlAe+7T5ZTMzi3TNk+25yXaem6zDsJRp6WnU
         WL9IhkoDdoCcJhFttTlfxyHTkb0ntedYORns6hL4tfP5xhn76hk3gREHKZG5HyO+8Yfl
         BKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIXelue/XgIGZ3gDtlYJZ1+fcuoCMbboBtSRyBoF0ec=;
        b=P9DD+rN1UUWR/Vixw7p388P8Fvu2UoMdcyBMVKl8YOKxrcydiji5oK1s1OFsnZUGot
         6lrTlPIdihd+NKYXhronkVHQkDvhTPhHzBJRnFkMoCXDmCmmaPSGi4z1NMdLMKL6GUGn
         ZPihE4HnfTmp409tAdW03hF7W5QYuFoNDmAmvnIAGKf91kDoQCQaiVazfeERf3ZizNKv
         UifKFqm786tVhyqrNTzqfDCpd2HAIBIKVScQ/TToT6IIPisbhCrsseppdoDtI3BSKRdR
         htnim8mqgbzrMVyJmc5M2S7hPOBYI7lXXItYpQM9dakEeWFYREf3YRDsOEZOfG0INPEl
         Zrtg==
X-Gm-Message-State: APjAAAU+jxM5s7o2tIpnHHxvRd8PmT6qzOJcg+eCYulnPGFGmbK8XLnR
        EPzjtynF318tpSXY6s4zOec=
X-Google-Smtp-Source: APXvYqxlH3CZAfrmzyfTYb+IbpUKGT38pP+2+JKu+yEWAwxM7M77vVYtDii1Is3MsThpcBRg/vfBuQ==
X-Received: by 2002:a81:99d2:: with SMTP id q201mr21547097ywg.158.1575904893169;
        Mon, 09 Dec 2019 07:21:33 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u136sm21033ywf.101.2019.12.09.07.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:21:32 -0800 (PST)
Subject: Re: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
To:     otalpster@gmail.com, git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, matheus.bernardino@usp.br
References: <20191208180439.19018-1-otalpster@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <06024905-b00e-0fd6-f985-64a360caac2a@gmail.com>
Date:   Mon, 9 Dec 2019 10:21:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191208180439.19018-1-otalpster@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2019 1:04 PM, otalpster@gmail.com wrote:
> From: Plato <otalpster@gmail.com>
> 
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at remove_subtree() function, by the dir-iterator API. This
> simplifies the code and avoids recursive calls to remove_subtree().
> 
> Signed-off-by: Plato <otalpster@gmail.com>
> ---
> Hello,
> 
> This is my first patch.
> I hope I cc'd the correct people and didn't mess up.

Welcome, Plato!

> The changes pass the test suite t/ and Travis CI.
> Please point out any mistakes.
> 
> Thanks for your time! :)
> 
>  entry.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 53380bb614..e7f4881d3b 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,6 +2,8 @@
>  #include "blob.h"
>  #include "object-store.h"
>  #include "dir.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>  #include "streaming.h"
>  #include "submodule.h"
>  #include "progress.h"
> @@ -50,29 +52,25 @@ static void create_directories(const char *path, int path_len,
>  
>  static void remove_subtree(struct strbuf *path)
>  {
> -	DIR *dir = opendir(path->buf);
> -	struct dirent *de;
> -	int origlen = path->len;
> +	int ok;
> +	unsigned int flags = DIR_ITERATOR_PEDANTIC;
> +	struct dir_iterator *iter = dir_iterator_begin(path->buf, flags);
>  
> -	if (!dir)
> +	if (!iter)
>  		die_errno("cannot opendir '%s'", path->buf);
> -	while ((de = readdir(dir)) != NULL) {
> -		struct stat st;
>  
> -		if (is_dot_or_dotdot(de->d_name))
> +	while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> +		if (is_dot_or_dotdot(iter->path.buf))
>  			continue;

The documentation in dir-iterator.h seems to skip . and .. for you.
This 'if' shouldn't be needed.

> -		strbuf_addch(path, '/');
> -		strbuf_addstr(path, de->d_name);
> -		if (lstat(path->buf, &st))
> -			die_errno("cannot lstat '%s'", path->buf);
> -		if (S_ISDIR(st.st_mode))
> -			remove_subtree(path);

It took me reading dir-iterator.h to realize that the iterator
is recursive, because I'm new to this API. This is a nice cleanup!

> -		else if (unlink(path->buf))
> -			die_errno("cannot unlink '%s'", path->buf);
> -		strbuf_setlen(path, origlen);
> +		if (unlink(iter->path.buf)) {
> +			die_errno("cannot unlink '%s'", iter->path.buf);
> +		}

nit: don't use braces for a single-line block.

>  	}
> -	closedir(dir);
> +
> +	if (ok != ITER_DONE)
> +		die(_("failed to iterate over '%s'"), path->buf);
> +
>  	if (rmdir(path->buf))
>  		die_errno("cannot rmdir '%s'", path->buf);
>  }

Thanks,
-Stolee


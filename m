Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83776C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 14:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiKQODS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiKQODK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 09:03:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40817616B
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:03:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x102so2738397ede.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A6i4Vbm8BjXHB/26Bid0cO0n17L41D/wfy0iYoY+Ic=;
        b=fFe/MDXQat/qPgzDBAH5/GxDrc6G6dRVnv2ohEMjMr7ZXVZvfck+x/Uic0Ov5e/dpu
         TQfY6fUX99gGxzy/jb7Y2ZavVPxELOcV9Fh37z+8BV85UgQ3AhnEF9/Od71hK1ae4nps
         maDtEO5TcPAOtRU5N+0iqUDsthfklOgiXQCZiB4IYhEIcY/EysEqcIT1GZuqVRJfhHKa
         FQXF+ykbNljVpCKW4YSLtzzy8k6Kk0JbDpnzE9lLBCx5Qg+7932ZHWIBNsi6GrGVVLI3
         gIEdYJs8t1J6tEyOLXk28uKq/+yKNeQ+8OsIzhYG5oIKrYoCg7rbIrgngEQYUT2VjYYj
         lLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A6i4Vbm8BjXHB/26Bid0cO0n17L41D/wfy0iYoY+Ic=;
        b=AAbtJC22ASEXebDNyXBVFYFu3ez3QfTyxe1aPIxXGoCreL/lx27pNkhdBexYEXyojS
         zj6DDZs1/Kko35KloCMFFR2Jkk+SBZug5F5ZEOXbmLRKwwlFvHeHpTJAa/9V27HqIL0+
         XlecWg7fAbLzePV0Tbd2Mw0zqK1XKlXcSUs+F4VMb0/8lGB3+GZ6hA75R4tDUK0nEV7K
         N1XMLF8hBLJPmg1GD8Jyj3dcs5tGKHW+Vrs4TYy0tt/9o1UrBHekK+KWiX0tMXPnFwby
         FfG7o5KhvBmOCr3+OmjMOMPs3Tmd7o4q31s7jtzzwabMR4ZnK1TVbGd/1Epx0ijRsUUK
         0hpg==
X-Gm-Message-State: ANoB5pn9eqV43+mxe1AeptPEdTtCVmzKKvXCMfiXi6bsAUXF53CI5sCk
        cf/TdYictqxpwXP7WKnSKWU=
X-Google-Smtp-Source: AA0mqf4iQ/RAqemBzZTYpN+0xR5EQxdSHjM9jgu0V7uvAspZflz7bwvfEV7POcfrGX8RGMwdzCLz0w==
X-Received: by 2002:a05:6402:524c:b0:461:c3c9:38e6 with SMTP id t12-20020a056402524c00b00461c3c938e6mr2282381edd.350.1668693787290;
        Thu, 17 Nov 2022 06:03:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q20-20020a1709066ad400b007adb86a1e1csm394515ejs.186.2022.11.17.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:03:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovfTu-004pvY-1e;
        Thu, 17 Nov 2022 15:03:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 5/6] ls-tree: introduce 'match_pattern()' function
Date:   Thu, 17 Nov 2022 15:02:34 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-6-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117113023.65865-6-tenglong.tl@alibaba-inc.com>
Message-ID: <221117.86bkp5ispx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> In preparation for actually implementing the '--pattern' option, we
> add a new method called 'match_pattern' that uses regular expressions
> to match 'ls-tree' entities.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 7661170f7ca..03dd3fbcb26 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -24,6 +24,7 @@ static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
>  static const char *format;
> +static const char *pattern;
>  struct show_tree_data {
>  	unsigned mode;
>  	enum object_type type;
> @@ -46,6 +47,32 @@ static enum ls_tree_cmdmode {
>  	MODE_OBJECT_ONLY,
>  } cmdmode;
>  
> +__attribute__((unused))

This isn't portable (we'd need a check in git-compat-util.h, and in any
case just squashing this whole commit into 6/6 where it actually gets
used would be better.

> +static int match_pattern(const char *line)
> +{
> +	int ret = 0;
> +	regex_t r;
> +	regmatch_t m[1];
> +	char errbuf[64];
> +
> +	ret = regcomp(&r, pattern, 0);
> +	if (ret) {
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regcomp() for pattern '%s' (%s)", pattern, errbuf);
> +	}
> +	ret = regexec(&r, line, 1, m, 0);
> +	if (ret) {
> +		if (ret == REG_NOMATCH)
> +			goto cleanup;
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regexec() for subject '%s' (%s)", line, errbuf);
> +	}
> +
> +cleanup:
> +	regfree(&r);
> +	return ret;
> +}
> +
>  static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
>  			      const enum object_type type, unsigned int padded)
>  {


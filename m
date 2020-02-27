Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC0C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01D524699
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ9ZOENR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgB0NIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:08:39 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55877 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgB0NIj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 08:08:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id a18so1115200pjs.5
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lbp90NLeoHCnSEvCPX2K8vrY8i8ILK9YQ8ofRPdBfXk=;
        b=nJ9ZOENRRRlN2j8ilpjGCh7nrL2UF8Pezl+AG486/jkiquV5OXPzmQWxCkr3fie0eF
         SPfvr/5mNN3UfF/nzgsMel1qZwmsR8dQ6N45ZsLMgSgsxuDHeF0boj6X/uR+nYQ1O1hO
         ZVRTwS/ujwd6dBv+mDKnkqDYRaXNLuL+wdOtDhKNRlC7kNqwBtXVvAFVWWjlRQDam3bT
         vgIZ2MDVT8TOoJOu+5XV/q15DqBvBzyoII4Nbr7swlXwFub7YxnJGoKZPtzHXd7eB/Q5
         C58VgVPUGQH3XXx+WGTSP7l9yHVm8RQJpVVzn7ezU48uKHwpNDNLqiuEd6eTvMuNYcVO
         Y/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbp90NLeoHCnSEvCPX2K8vrY8i8ILK9YQ8ofRPdBfXk=;
        b=ROtq5Cdlye6FM3qQcXez5655b10VhHLSIB8vfqFR5VKbNrRA72HJwYy1actv0+CIb7
         pWVswVcz5gl13dtEDOBTK7Fw34yHAStECQ1JPMO8WYMBwcwK/kzkmWVSVw8mZZfQZEXg
         gfOyEtejc82/MjN5xXHYjk1rzRG3kyi4xBHUS0tIzMsjVPtm1guLWwt2tne4D9fUOQJc
         MPj2/dEwHMLEx1lpWZIDl8zC3t6lDBRm2cWRXMU3tyHpPXJfkmhWJOAg1DYh6qvEVvWf
         pdGBpeQ8s17p7tDWXIczsbCYWIsTJyWg5caoXRP38XrA177/EivhauoEtkmnehQKjqr0
         89fw==
X-Gm-Message-State: APjAAAV5dJW9oLCIapxurMVE60r940PxkiBOIat46oxeFKeFeLiiGDxy
        DwjsLhrzZNcKIbz3PyuOn6whOrxe
X-Google-Smtp-Source: APXvYqyDcdn33lTL3+LUAeoJnh612+uUTKpu349C3FCPJQSB9WORmiekepLC9mTz4oZ+zGhX4jYlmQ==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr4605313ply.68.1582808918243;
        Thu, 27 Feb 2020 05:08:38 -0800 (PST)
Received: from localhost ([2402:800:6374:15b3:d2e0:eb50:f2df:f4fd])
        by smtp.gmail.com with ESMTPSA id v7sm6819777pfn.61.2020.02.27.05.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:08:37 -0800 (PST)
Date:   Thu, 27 Feb 2020 20:08:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     dev@pascalroeleven.nl
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: don't use '-h' for options
Message-ID: <20200227130833.GA10339@danh.dev>
References: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-02-27 12:42:18+0100, dev@pascalroeleven.nl wrote:
> The '-h' option for ls-remote will never be reached as the argument is
> already processed by the git wrapper before passed on to ls-remote.
> The ls-remote help text will therefore be displayed instead of the
> '--heads' option.

No, git ls-remote still see '-h'

- 'git ls-remote -h' will show short help.
- 'git ls-remote -h <remote>' and 'git ls-remote --heads <remote>'
  will show the same output

See also:
https://lore.kernel.org/git/xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com/

xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com

> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  Documentation/git-ls-remote.txt | 1 -
>  builtin/ls-remote.c             | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-ls-remote.txt
> b/Documentation/git-ls-remote.txt
> index a2ea1fd..b5b7d7a 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -21,7 +21,6 @@ commit IDs.
> 
>  OPTIONS
>  -------
> --h::
>  --heads::
>  -t::
>  --tags::
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 6ef5195..85ce336 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -63,7 +63,7 @@ int cmd_ls_remote(int argc, const char **argv, const char
> *prefix)
>  			   N_("path of git-upload-pack on the remote host"),
>  			   PARSE_OPT_HIDDEN },
>  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
> -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
> +		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
>  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>  		OPT_BOOL(0, "get-url", &get_url,
>  			 N_("take url.<base>.insteadOf into account")),
> -- 
> 2.20.1
> 

-- 
Danh

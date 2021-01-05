Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D85C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 10:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF29422525
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 10:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbhAEKaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbhAEKaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 05:30:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B18C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 02:29:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y23so2555192wmi.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 02:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oRMnMYVy0oRKOTcEbvUCw6u2ZflcM7bQjjbFK2QJDWQ=;
        b=swpSd5PgFofn/GFLH7h964kD1EtasAq2+sorzqwqzXgq4bhNZMwJWKI1fs9ulaVJHK
         mL6cibj7xFbrcugciGCnjBuFZrM2TiiQ0KgY/doF/wxuVPRlNp29yYiiuhVNV/xLhdOK
         fJsnKpXwFcisypgdN/WLrLGnMuWMlaz01EO+YXQwVNkvnSDkH8evlHUlbCFwTRCNPU4Y
         R+kqt9UrYE9y54AW0DjXElJCQ/oEbIE7zqFDhs065olG5P6BgTADPDrje0fGCjvzpLeb
         YQoDUt3UrPvMwJmJB23DPj8j7YYjLH04i46sCO/9wVSflAkZHgzdpuxfTnG0eNboDiST
         lthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oRMnMYVy0oRKOTcEbvUCw6u2ZflcM7bQjjbFK2QJDWQ=;
        b=XK470klL7CfoaSIWBdFoaBPvL1+OlBj8/2Xy7dLkryPkAXd6jpwII9WFDQOvIVUXAQ
         jdukH99yzQY0BcV4qlOAPTX7ypgMA9iXAHyeY4+/HreW1ukeJ13GAsmci6b+UlM7y/11
         roo+zG/L52X0vdhUgWbLNvBzrODf6Zx6PxX6nWoLL32Mo/UOXCNFiPLr+OG1htkmuFJF
         fjA9xhxSJSWcQa8xdPAyn8nVXlZVPIvkvBC4tX718PRm2SktZZXDQy8h1DdmJNEUTeyL
         E6cHWygBGbRRldRwYqpfmWkpRGnx5ib2B5rkwzWjEalQSgATVMhi1re3lKwgF9LH+xiW
         9wgg==
X-Gm-Message-State: AOAM531r4u8X5KAMZcHVeNoxHBa1uGiLLthx6w5GqJsRAG9/s2B9vsmL
        yPeK2VG4oO60hg5QX4slL1wowPQqSZ8=
X-Google-Smtp-Source: ABdhPJy54lLH6rWSjyfQFBWgituuzKWjN/S/KicffT9/76yX712sLIpzxr0kRWqWfiBQZRDPaLa62Q==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr2779267wmg.145.1609842559014;
        Tue, 05 Jan 2021 02:29:19 -0800 (PST)
Received: from [192.168.1.240] (183.252.189.80.dyn.plus.net. [80.189.252.183])
        by smtp.gmail.com with ESMTPSA id z3sm103597225wrn.59.2021.01.05.02.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 02:29:18 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] worktree: `list` escape lock reason in --porcelain
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
Date:   Tue, 5 Jan 2021 10:29:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rafael

Thanks for working on this

On 04/01/2021 16:21, Rafael Silva wrote:
> "git worktree list" porcelain format shows one attribute per line, each
> attribute is listed with a label and value separated by a single space.
> If any worktree is locked, a "locked" attribute is listed followed by the
> reason, if available, otherwise only "locked" is shown.
> 
> In case the lock reason contains newline characters (i.e: LF or CRLF)
> this will cause the format to break as each line should correspond to
> one attribute. This leads to unwanted behavior, specially as the
> porcelain is intended to be machine-readable. To address this shortcoming
> let's teach "git worktree list" to escape any newline character before
> outputting the locked reason for porcelain format.

As the porcelain output format cannot handle worktree paths that contain 
newlines either I think it would be better to add a `-z` flag which uses 
NUL termination as we have for many other commands (diff, ls-files etc). 
This would fix the problem forever without having to worry about quoting 
each time a new field is added.

If you really need to quote the lock reason then please use one of the 
path quoting routines (probably quote_c_style() or write_name_quoted()) 
in quote.c rather than rolling your own - the code below gives the same 
output for a string that contains the two characters `\` followed by `n` 
as it does for the single character `\n`. People are (hopefully) used to 
dequoting our path quoting and there are routines out there to do it (we 
have one git Git.pm) using a function in quote.c will allow them to use 
those routines here.

Best Wishes

Phillip

> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
>   builtin/worktree.c | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index dedd4089e5..9156ccd67e 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -567,6 +567,24 @@ static int add(int ac, const char **av, const char *prefix)
>   	return add_worktree(path, branch, &opts);
>   }
>   
> +static char *worktree_escape_reason(char *reason)
> +{
> +	struct strbuf escaped = STRBUF_INIT;
> +	char *r;
> +
> +	for (r = reason; *r; r++) {
> +		if (*r == '\r' && *(r + 1) && *(r + 1) == '\n') {
> +			strbuf_addstr(&escaped, "\\r\\n");
> +			r++;
> +		} else if (*r == '\n')
> +			strbuf_addstr(&escaped, "\\n");
> +		else
> +			strbuf_addch(&escaped, *r);
> +	}
> +
> +	return strbuf_detach(&escaped, NULL);
> +}
> +
>   static void show_worktree_porcelain(struct worktree *wt)
>   {
>   	printf("worktree %s\n", wt->path);
> @@ -580,9 +598,11 @@ static void show_worktree_porcelain(struct worktree *wt)
>   			printf("branch %s\n", wt->head_ref);
>   
>   		if (worktree_lock_reason(wt)) {
> -			if (*wt->lock_reason)
> -				printf("locked %s\n", wt->lock_reason);
> -			else
> +			if (*wt->lock_reason) {
> +				char *reason = worktree_escape_reason(wt->lock_reason);
> +				printf("locked %s\n", reason);
> +				free(reason);
> +			} else
>   				printf("locked\n");
>   		}
>   
> 

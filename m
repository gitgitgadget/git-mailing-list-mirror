Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14CC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96F320757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trH/g8np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbgDBNlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgDBNlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id s8so2108338wrt.7
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4AD27c2n6InpMrCBI9aQi3Odyxx2ieMT0Sbp3ZwYouU=;
        b=trH/g8nphMQHU6tS+xzSNuCk54VuY6mmElz4RSkToiiK9LtsoyGlnsitXpwDqhsED4
         pvCtUlUqYJn1LMuZN/qAHNWQUp92P9DY0tbyFccAXQLaafU/GIfM1gRmk5oBDG0uzCwX
         sRNt1CTlS/C8CoZP6hRI3IAid6NVeBdS1s7U0LnGgOPaPXcjsekfLMRnmWocgQL/J09J
         IANSuuKeIKLlZTENc1YKYzcagtmOvt4bv8hPqAgnF2U+G9fbkeSWM5VwoE9MZ8/RduWZ
         NR+Dvpoh/JMyc05AiXkpFiPRhdezg6hucLSxKfVZiopvjgRTzF1vr/H9o5IX+hdyaLGq
         wANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4AD27c2n6InpMrCBI9aQi3Odyxx2ieMT0Sbp3ZwYouU=;
        b=fDt3t6nueyYpS36uD74rstT94b6jCf9ir3oyXuoVGpjUzrk9FqryeWNsTKy39xeglu
         x+lBvkKIyv9uQ0LPzSR01pEMHopwt0BUjveHGL6UUsXwVtRISOW5TOroQS3ShTrViZsu
         7v/941wGlXX5s9SSgjH07m59h+/8TJRrnDqXoJe0puxcQkuxFRB/ju4Vp/cnYlgD6Xu0
         XUjgYzYs8w3IDsJlai1Ci8MbQ5FMmvJEtsVvg+za+LkmMtMIggvBzMRiBefQV7422oye
         x45iAfST5WFAkkNrG1OITdfaaUQzqvqBqhRErJdkbahNEJ6xbspOiISQNE4z79ZcMd2W
         XlOw==
X-Gm-Message-State: AGi0PuZJ1OY59N6JU2mdmIrH++jQPWHUpjBImVF0qAFMnOiT6g2VIC7N
        AfvMXOrupsQj8pK8vdJyPmpcErpD
X-Google-Smtp-Source: APiQypKy9v1uHtfRE93olcf+QcVmfVTfhLJgYk8g+lbvzyfmb4OYAsiB1w8UPtJU+g+Za80b6X+Kew==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr3808814wrv.179.1585834888928;
        Thu, 02 Apr 2020 06:41:28 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id m8sm6950013wmc.28.2020.04.02.06.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:41:28 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 07/19] rebase: use read_oneliner()
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <d07a50c5b22128263aaa8eef94546fe8bc8a9ec8.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <51bbff1e-ccca-5d13-24f1-942dcfe6174d@gmail.com>
Date:   Thu, 2 Apr 2020 14:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d07a50c5b22128263aaa8eef94546fe8bc8a9ec8.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> Since in sequencer.c, read_one() basically duplicates the functionality
> of read_oneliner(), reduce code duplication by replacing read_one() with
> read_oneliner().
> 
> This was done with the following Coccinelle script
> 
> 	@@
> 	expression a, b;
> 	@@
> 	- read_one(a, b)
> 	+ !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)
> 
> and long lines were manually broken up.

It's great to see read_one() going away

Thanks

Phillip

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/rebase.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index bff53d5d16..1146463099 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -586,15 +586,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
>   	return path.buf;
>   }
>   
> -/* Read one file, then strip line endings */
> -static int read_one(const char *path, struct strbuf *buf)
> -{
> -	if (strbuf_read_file(buf, path, 0) < 0)
> -		return error_errno(_("could not read '%s'"), path);
> -	strbuf_trim_trailing_newline(buf);
> -	return 0;
> -}
> -
>   /* Initialize the rebase options from the state directory. */
>   static int read_basic_state(struct rebase_options *opts)
>   {
> @@ -602,8 +593,10 @@ static int read_basic_state(struct rebase_options *opts)
>   	struct strbuf buf = STRBUF_INIT;
>   	struct object_id oid;
>   
> -	if (read_one(state_dir_path("head-name", opts), &head_name) ||
> -	    read_one(state_dir_path("onto", opts), &buf))
> +	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
> +			   READ_ONELINER_WARN_NON_EXISTENCE) ||
> +	    !read_oneliner(&buf, state_dir_path("onto", opts),
> +			   READ_ONELINER_WARN_NON_EXISTENCE))
>   		return -1;
>   	opts->head_name = starts_with(head_name.buf, "refs/") ?
>   		xstrdup(head_name.buf) : NULL;
> @@ -619,9 +612,11 @@ static int read_basic_state(struct rebase_options *opts)
>   	 */
>   	strbuf_reset(&buf);
>   	if (file_exists(state_dir_path("orig-head", opts))) {
> -		if (read_one(state_dir_path("orig-head", opts), &buf))
> +		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
> +				   READ_ONELINER_WARN_NON_EXISTENCE))
>   			return -1;
> -	} else if (read_one(state_dir_path("head", opts), &buf))
> +	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
> +				  READ_ONELINER_WARN_NON_EXISTENCE))
>   		return -1;
>   	if (get_oid(buf.buf, &opts->orig_head))
>   		return error(_("invalid orig-head: '%s'"), buf.buf);
> @@ -641,8 +636,8 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
>   		strbuf_reset(&buf);
> -		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
> -			    &buf))
> +		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
> +				   READ_ONELINER_WARN_NON_EXISTENCE))
>   			return -1;
>   		if (!strcmp(buf.buf, "--rerere-autoupdate"))
>   			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
> @@ -655,8 +650,8 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
>   		strbuf_reset(&buf);
> -		if (read_one(state_dir_path("gpg_sign_opt", opts),
> -			    &buf))
> +		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
> +				   READ_ONELINER_WARN_NON_EXISTENCE))
>   			return -1;
>   		free(opts->gpg_sign_opt);
>   		opts->gpg_sign_opt = xstrdup(buf.buf);
> @@ -664,7 +659,8 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	if (file_exists(state_dir_path("strategy", opts))) {
>   		strbuf_reset(&buf);
> -		if (read_one(state_dir_path("strategy", opts), &buf))
> +		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
> +				   READ_ONELINER_WARN_NON_EXISTENCE))
>   			return -1;
>   		free(opts->strategy);
>   		opts->strategy = xstrdup(buf.buf);
> @@ -672,7 +668,8 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	if (file_exists(state_dir_path("strategy_opts", opts))) {
>   		strbuf_reset(&buf);
> -		if (read_one(state_dir_path("strategy_opts", opts), &buf))
> +		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
> +				   READ_ONELINER_WARN_NON_EXISTENCE))
>   			return -1;
>   		free(opts->strategy_opts);
>   		opts->strategy_opts = xstrdup(buf.buf);
> @@ -724,7 +721,7 @@ static int apply_autostash(struct rebase_options *opts)
>   	if (!file_exists(path))
>   		return 0;
>   
> -	if (read_one(path, &autostash))
> +	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
>   		return error(_("Could not read '%s'"), path);
>   	/* Ensure that the hash is not mistaken for a number */
>   	strbuf_addstr(&autostash, "^0");
> 

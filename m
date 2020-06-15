Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF542C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69282063A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZIPzy5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgFOPEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFOPEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 11:04:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:04:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so17480439wrv.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maRJIMSJoZJf/Q2Nzj/QVTkeoccBLeGEW5NgWmUAK9g=;
        b=oZIPzy5KUqyN1DS0juZp1hrgsmkbeMtGHbIhFtyeruvVXBE6d+8pI9YGneLPbSJTdF
         t7LPp/Yi6dsXVAXSZl/zKN2NqZMdwwx6TBha09xGQFzQB6nHQxc18zdAWtsUlwfHxTcp
         AlSEwNoSKnNcUqdnE/93/BlwbT1tu3qXNrPtfZLIHGMjD1VPA4fEZkD8C5VgY1sN1yFW
         wvqimRs28WRq1njhmGAmcaSWY8p5SlMu01S2wghw8JxcMTn+h6cGGoobM+3LMlFNnclq
         MYG/eVrRGMZhIiaI2zwnk8iFGZ9k/lDWVK3OzaLR4j92Eeh9egEma0ufjCiNS8Uv1X+2
         YyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=maRJIMSJoZJf/Q2Nzj/QVTkeoccBLeGEW5NgWmUAK9g=;
        b=gbIGfuyX/7mg19F/aXaf1QeG74hgg7FNgwu70Abwr2nhALe8C8pO/5RjmV7JYGFYuG
         LJP12lbjaXTNnFNOZO11NulprfJCBVOof+4HfduSbFG4H9HQOLEIMvsJyQnfkeQU/piJ
         +p6B5nErgLd7QE8K1gqJKjD2SYRnn9aXWEPiIcCxnT83aNaG0fW1uQm3pCfRkWKrOrpg
         a01dps9ympbQhrlzO2mkVbdR6UC715uOfqIMcQhrVXhyk4z1WP8cly+EcBkCdTUcN67d
         zip+yyzUyPlWkZizF9fFpB+rdH5APMJC1U7acHlkS4iKxPcDJo4IooOV9eaQEs5KtN3s
         Ol+w==
X-Gm-Message-State: AOAM533ZCehCFyKtdljCIVdHwskQ9x+mRC4o/s3ZmhSJmuXjgg9UGGDG
        xHx+Tx3HpFSemKsHVlOyHos=
X-Google-Smtp-Source: ABdhPJxMJh/WJItPsF+NfzoNJ8iIyrGkPtt7F1cMDQEWeF3kr9YkrLDbfZX1Lewd+DNYtkj1Yksznw==
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr30928284wrq.12.1592233448562;
        Mon, 15 Jun 2020 08:04:08 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id b185sm402984wmd.3.2020.06.15.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:04:07 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/12] git_main_branch_name(): optionally report the
 full ref name
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <ca1c63c3e012edde26b4f0c67175ca53f4d29e08.1592225416.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e8ed76e8-bdd5-ae58-56ea-0513a21ac5d6@gmail.com>
Date:   Mon, 15 Jun 2020 16:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ca1c63c3e012edde26b4f0c67175ca53f4d29e08.1592225416.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

On 15/06/2020 13:50, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We are about to introduce the first caller of that function (`git
> fast-export`) that wants a full ref name instead of the short branch
> name.
> 
> To make this change easier to review, let's refactor the function
> accordingly without mixing in the actual first call using the new flag.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   fmt-merge-msg.c    |  2 +-
>   refs.c             | 12 ++++++++----
>   refs.h             |  8 ++++++--
>   send-pack.c        |  2 +-
>   transport-helper.c |  2 +-
>   5 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 43f4f829242..03dba905643 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -451,7 +451,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
>   			strbuf_addf(out, " of %s", srcs.items[i].string);
>   	}
>   
> -	main_branch = git_main_branch_name();
> +	main_branch = git_main_branch_name(0);
>   	if (!strcmp(main_branch, current_branch))
>   		strbuf_addch(out, '\n');
>   	else
> diff --git a/refs.c b/refs.c
> index f1854cffa2f..7da3ac178c4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -560,8 +560,9 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
>   		argv_array_pushf(prefixes, *p, len, prefix);
>   }
>   
> -char *repo_main_branch_name(struct repository *r)
> +char *repo_main_branch_name(struct repository *r, int flags)
>   {
> +	int full_name = flags & MAIN_BRANCH_FULL_NAME;
>   	const char *config_key = "core.mainbranch";
>   	const char *config_display_key = "core.mainBranch";
>   	const char *fall_back = "master";
> @@ -570,7 +571,10 @@ char *repo_main_branch_name(struct repository *r)
>   	if (repo_config_get_string(r, config_key, &name) < 0)
>   		die(_("could not retrieve `%s`"), config_display_key);
>   
> -	ret = name ? name : xstrdup(fall_back);
> +	if (full_name)
> +		ret = xstrfmt("refs/heads/%s", name ? name : fall_back);
> +	else
> +		ret = name ? name : xstrdup(fall_back);

This looks good, we always check the name before returning it and free 
name if we're returning refs/heads/<name>

>   	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
>   		die(_("invalid branch name: %s = %s"),
> @@ -582,9 +586,9 @@ char *repo_main_branch_name(struct repository *r)
>   	return ret;
>   }
>   
> -char *git_main_branch_name(void)
> +char *git_main_branch_name(int flags)
>   {
> -	return repo_main_branch_name(the_repository);
> +	return repo_main_branch_name(the_repository, flags);
>   }
>   
>   /*
> diff --git a/refs.h b/refs.h
> index a207ef01348..96472f9a9f5 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -157,9 +157,13 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
>   /*
>    * Retrieves the name of the main (or: primary) branch of the given
>    * repository.
> + *
> + * The result is an allocated string. Unless the flags ask for a short name, it
> + * will be prefixed with "refs/heads/".
>    */

nit pick: the flag is defined to give the fullname, to get the short 
name you just pass 0.

Best Wishes

Phillip

> -char *git_main_branch_name(void);
> -char *repo_main_branch_name(struct repository *r);
> +#define MAIN_BRANCH_FULL_NAME (1<<0)
> +char *git_main_branch_name(int flags);
> +char *repo_main_branch_name(struct repository *r, int flags);
>   
>   /*
>    * A ref_transaction represents a collection of reference updates that
> diff --git a/send-pack.c b/send-pack.c
> index 2532864c812..898720511d0 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -405,7 +405,7 @@ int send_pack(struct send_pack_args *args,
>   	}
>   
>   	if (!remote_refs) {
> -		char *branch_name = git_main_branch_name();
> +		char *branch_name = git_main_branch_name(0);
>   
>   		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
>   			"Perhaps you should specify a branch such as '%s'.\n",
> diff --git a/transport-helper.c b/transport-helper.c
> index 8c8f40e322d..7a54e5b2fb2 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1044,7 +1044,7 @@ static int push_refs(struct transport *transport,
>   	}
>   
>   	if (!remote_refs) {
> -		char *branch_name = git_main_branch_name();
> +		char *branch_name = git_main_branch_name(0);
>   
>   		fprintf(stderr,
>   			_("No refs in common and none specified; doing nothing.\n"
> 

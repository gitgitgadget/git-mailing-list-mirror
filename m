Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A2AC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA5424889
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI2m7U4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgDFPPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:15:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53645 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgDFPPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 11:15:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id d77so15067782wmd.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5j1thckj9Yd6Yyzy4buZ9OISBP7ZE9DgkFxgCGtt1qA=;
        b=jI2m7U4G85bJ72b+xtMJORjgBRe9vq0VWoQeRYkdm1Dc0UvWMdTMsaAxmhuKsJ14c8
         RsjSRtsXX6XdbQ+pDKBaNOE8T/xunssqNiVY+PcS45CTC60GLtddDKaHPiHufLCEiCIL
         gDbEtqyNPfrzb7FMr+6j0YMdUicD0hvM9pa4nPk1xoZIzrFR3vXc9/lpR+4rIA+OOjbI
         z580nhmtsjXIfedUy3FCICncNj5Zfduc+vVxj35zVOf2MQLsEpCGeaywjFP7CrLKD7mN
         f4UAqE0rQmD7wgLpIJx/LMSu3PyzjJxY9mqXfXaYf9OLZ8gNnBoOsbN1WMUfVss6QXYI
         bOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5j1thckj9Yd6Yyzy4buZ9OISBP7ZE9DgkFxgCGtt1qA=;
        b=lhZoecfblMBP90Q7/BWFSNUdf8JzMCRlIQkozFYu0lNXzk3erlVIZ7St5735g25K/A
         n03YUbhKJad59FxIf+EsMHzrUiHtUKfUVZMsWxjGiOqK25vd6yIQsZZOfcwBjbO5n/4M
         herArUoXzcPHwKV7OPuvAgK15YaKGyF5vyMP4Y7pa83tfYUelVGfR1aCgsYvIiYxfK8r
         LZ71rFU8NaOWIWuwYoWDTNuh94tkKRVMxQynrKO0IOlL+gZSiufYgRXCAL1LF7/QhPqQ
         +SLRsimNE60xds03A7F/yP/yHCHooEgoxv8B/w8CUlppnovnw2pAEJFB3gsfYSRs9hz8
         ujDA==
X-Gm-Message-State: AGi0PuYvadtztLvtSI8H9M3GH040DNrhU/dKFeqWKQR5zaEZg1UwgI9y
        zaMtdKJfj9dfBHeMyvXUmis=
X-Google-Smtp-Source: APiQypKMIlcMxFrZyALiGbnTIR1YesgNE9WUMmp8Bq+ldbDrEcCxm7no3f/OF5wqC/1FKRtkxEzGAw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr165804wmi.31.1586186148315;
        Mon, 06 Apr 2020 08:15:48 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id p5sm28292895wrg.49.2020.04.06.08.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:15:47 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 19/23] sequencer: implement save_autostash()
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <75dc3f10a1aac24007b660a02ce829c8702ffd0e.1585962673.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f178c14b-3cf9-ca2f-258a-3475f2fb9678@gmail.com>
Date:   Mon, 6 Apr 2020 16:15:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <75dc3f10a1aac24007b660a02ce829c8702ffd0e.1585962673.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 04/04/2020 02:11, Denton Liu wrote:
> Extract common functionality of apply_autostash() into
> apply_save_autostash() and use it to implement save_autostash(). This
> function will be used in a future commit.
> 
> The difference between save_autostash() and apply_autostash() is that
> the latter does not try to apply the stash. 

the latter is apply_autostash() - surely that tries to apply the stash?

> It skips that step and
> just stores the created entry in the stash reflog.

I think we want save_autostash() so we can call it to save the stash 
when running a reset - perhaps we should mention that in the commit message.

Best Wishes

Phillip

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 37 +++++++++++++++++++++++++++----------
>   sequencer.h |  1 +
>   2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5dd1c2438e..fb52583bc2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3699,7 +3699,7 @@ void create_autostash(struct repository *r, const char *path,
>   	strbuf_release(&buf);
>   }
>   
> -int apply_autostash(const char *path)
> +static int apply_save_autostash(const char *path, int attempt_apply)
>   {
>   	struct strbuf stash_oid = STRBUF_INIT;
>   	struct child_process child = CHILD_PROCESS_INIT;
> @@ -3712,13 +3712,17 @@ int apply_autostash(const char *path)
>   	}
>   	strbuf_trim(&stash_oid);
>   
> -	child.git_cmd = 1;
> -	child.no_stdout = 1;
> -	child.no_stderr = 1;
> -	argv_array_push(&child.args, "stash");
> -	argv_array_push(&child.args, "apply");
> -	argv_array_push(&child.args, stash_oid.buf);
> -	if (!run_command(&child))
> +	if (attempt_apply) {
> +		child.git_cmd = 1;
> +		child.no_stdout = 1;
> +		child.no_stderr = 1;
> +		argv_array_push(&child.args, "stash");
> +		argv_array_push(&child.args, "apply");
> +		argv_array_push(&child.args, stash_oid.buf);
> +		ret = run_command(&child);
> +	}
> +
> +	if (attempt_apply && !ret)
>   		fprintf(stderr, _("Applied autostash.\n"));
>   	else {
>   		struct child_process store = CHILD_PROCESS_INIT;
> @@ -3734,10 +3738,13 @@ int apply_autostash(const char *path)
>   			ret = error(_("cannot store %s"), stash_oid.buf);
>   		else
>   			fprintf(stderr,
> -				_("Applying autostash resulted in conflicts.\n"
> +				_("%s\n"
>   				  "Your changes are safe in the stash.\n"
>   				  "You can run \"git stash pop\" or"
> -				  " \"git stash drop\" at any time.\n"));
> +				  " \"git stash drop\" at any time.\n"),
> +				attempt_apply ?
> +				_("Applying autostash resulted in conflicts.") :
> +				_("Autostash exists; creating a new stash entry."));
>   	}
>   
>   	unlink(path);
> @@ -3745,6 +3752,16 @@ int apply_autostash(const char *path)
>   	return ret;
>   }
>   
> +int save_autostash(const char *path)
> +{
> +	return apply_save_autostash(path, 0);
> +}
> +
> +int apply_autostash(const char *path)
> +{
> +	return apply_save_autostash(path, 1);
> +}
> +
>   static const char *reflog_message(struct replay_opts *opts,
>   	const char *sub_action, const char *fmt, ...)
>   {
> diff --git a/sequencer.h b/sequencer.h
> index cf1284f9ed..2d09c1ac0b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -193,6 +193,7 @@ void commit_post_rewrite(struct repository *r,
>   
>   void create_autostash(struct repository *r, const char *path,
>   		      const char *default_reflog_action);
> +int save_autostash(const char *path);
>   int apply_autostash(const char *path);
>   
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
> 

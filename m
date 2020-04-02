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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA22C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41642063A
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDbXa96l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbgDBPLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:11:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50450 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbgDBPLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 11:11:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id t128so3793437wma.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Zu4RohFAFELTSPH1E6AS67dJa0MOvJai98/GQcTR0E=;
        b=QDbXa96lh4GFOBwxUxAlebB97E9FEjB3fohvXsBahIZIoHbG4g+Kb3R8VXr62e5fAo
         M6hhQy42/fIdcOf7zyL3duW4OQKg9ytG8TNaRRQ9mBThVhBibLWPgpbhvBqXXb+s7Rp/
         MeqWijQ+jkxBXacSn/Fr2gez2/woeEGkqs1k6P0hIcF+XNFLQtcsBehKK9yrIqXwdxaU
         WUdJv6gSuXUsytEfkbRdx/JBjYPZuzImvoIum8Damq8RgLlhMYuCcmTTNhphyep/VS04
         hA/+iyPf3MlkhibGU/U8jtqRUege0gU8rEERf7VutFz6iRw7+ppXT5vRM8A2ziLD0SNt
         JHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7Zu4RohFAFELTSPH1E6AS67dJa0MOvJai98/GQcTR0E=;
        b=LOyrvujaqTEYoGtl3mECfAQ/cSLotE30fDG/9UKt6zBCGzjBL5aem3Vz3S/pKO9cpT
         btM26/rFVlYkDSKo4ekZ9CVlebgswZ/ezgGN62y2HJ4D+bR+ttAQZSVDLVWSRDWPjPZ+
         OAhc2EuiCgRtwDHzabKn1XHnjo7XBmgSlIYbxbrNqlSdRZiWvpEf/UrC3wrFDd9XLtst
         EQvRWbCX4rV1aVDNVyF/XJgEiMZK2e3rYNftSsgRriyz2XGYX8vu2ygArDYJqTwPROJz
         HDPH34CO8Kmy3WBycUh5TUNgDu2H/wKM4qTz4O/9AOhEe80ROguAxQDuMnj8xDxze5h8
         2pXg==
X-Gm-Message-State: AGi0PubSROXZFQeSMFRdu0gZE5izzkDoN0h3gx7NICgq7WdLJE3QwD+8
        GZKt165kle0M/YF9hki2tCI=
X-Google-Smtp-Source: APiQypJK7nvbARRMqDwQnt0aj0/I/6MWP3e0DTAoOn4xt0z5Yn2nEEahaOX8+P2hHgJZRyUrjJxtZQ==
X-Received: by 2002:a1c:1bc2:: with SMTP id b185mr3715447wmb.167.1585840259479;
        Thu, 02 Apr 2020 08:10:59 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id s66sm7812419wme.40.2020.04.02.08.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:10:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 16/19] sequencer: implement save_autostash()
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <e21e2c6416766234114ba94cbaf5b47f0595ee69.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <eb4ea9a5-a076-fb63-e587-1851f14218db@gmail.com>
Date:   Thu, 2 Apr 2020 16:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e21e2c6416766234114ba94cbaf5b47f0595ee69.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> Extract common functionality of apply_autostash() into
> apply_save_autostash() and use it to implement save_autostash(). This
> function will be used in a future commit.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 37 +++++++++++++++++++++++++++----------
>   sequencer.h |  1 +
>   2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 81b6c700d1..d67d47b332 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3705,7 +3705,7 @@ void create_autostash(struct repository *r, const char *path,
>   	strbuf_release(&buf);
>   }
>   
> -int apply_autostash(const char *path)
> +static int apply_save_autostash(const char *path, int attempt_apply)
>   {
>   	struct strbuf stash_sha1 = STRBUF_INIT;
>   	struct child_process child = CHILD_PROCESS_INIT;
> @@ -3718,13 +3718,17 @@ int apply_autostash(const char *path)
>   	}
>   	strbuf_trim(&stash_sha1);
>   
> -	child.git_cmd = 1;
> -	child.no_stdout = 1;
> -	child.no_stderr = 1;
> -	argv_array_push(&child.args, "stash");
> -	argv_array_push(&child.args, "apply");
> -	argv_array_push(&child.args, stash_sha1.buf);
> -	if (!run_command(&child))
> +	if (attempt_apply) {
> +		child.git_cmd = 1;
> +		child.no_stdout = 1;
> +		child.no_stderr = 1;
> +		argv_array_push(&child.args, "stash");
> +		argv_array_push(&child.args, "apply");
> +		argv_array_push(&child.args, stash_sha1.buf);
> +		ret = run_command(&child);
> +	}
> +
> +	if (attempt_apply && !ret)

If attempt_only is not set then we wont get any message - is this 
intended? Previously we always showed the message when applying was 
successful

>   		fprintf(stderr, _("Applied autostash.\n"));
>   	else {
>   		struct child_process store = CHILD_PROCESS_INIT;
> @@ -3740,10 +3744,13 @@ int apply_autostash(const char *path)
>   			ret = error(_("cannot store %s"), stash_sha1.buf);
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

I'm a bit confused by the new message, perhaps the commit message could 
explain what attempt_only is used for and then I suspect the reason for 
this change will become clear

Best Wishes

Phillip

>   	}
>   
>   	unlink(path);
> @@ -3751,6 +3758,16 @@ int apply_autostash(const char *path)
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
> index 44ecfee7f3..1cb0e4e4b7 100644
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

Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92333C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E72080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBHgXdGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBIP7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:59:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgBIP7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:59:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7816425wma.1
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CvP76tqHd5Y/IkFX6oXnWBrwjyADMQJ1UuXv9Pj3qJ4=;
        b=IBHgXdGUNW4fh7QzPdefXSjmuB7pJcezc6AJf2BPjSHADe5ehrKt132rVjE0XsoXaX
         sAxsP9PbyUD5a80aXENMUc9q2ej+IluHioLXGm5F+fWNRZHGhqwUdqTyO7oAAD4bIFHB
         nLQ1GzMMsjXnM2XVbclhM0ZP2/dp5c4qWvLPwOh8AYJZZmmMMxgHWCCSl9dDRIlfO6BA
         znkfD49ljGPeDiZH+7cSnl5S7+tKTfcIfLpgFqX/pIVBZxTLn4B9JAn6p3cHfadl6FjI
         +3oDv24eYxBTMAum5+ajyQaVlkqO9bdDmEenHZGsLE39rxpakRKpdZrANbqKp0+Zrw19
         LJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CvP76tqHd5Y/IkFX6oXnWBrwjyADMQJ1UuXv9Pj3qJ4=;
        b=kd4sbFfL9YJOaquN6wDYNimKmR+u3kjfujjILBUVrqqh6rVHda725Aq7kISbAeHQMC
         RBFjERWOUzMveEO1Cl//xw943Lv3x0/rjVVMXtR0LcoG8hmke7XxndLNakPYOwsgstyT
         YDcdxcTvUJ9H03nhuecwMFjXcgIeFkDSp3NPyDKsVthX1nejeqdBqBepdPy2pTB9yXLE
         mZBF85bDPV3Jzb5u7r6ZoxVxfbvCnXBkPhd13cbrDvCoIms6g/U/+cTbDCZFrrHLUbdL
         BxDm8jQywK5QZfvKc06dumm6EUbhv2Ynr+eKua1CsQMYVc0lGSGDIp2hF+FvycJh3sqp
         cZdQ==
X-Gm-Message-State: APjAAAWwukq5c5W4jEW9gSCP5GNAJSGf2XJWQs647RDX57Dhve+629vT
        9WMMRt+5CoZUQ7WL9LMaqeA=
X-Google-Smtp-Source: APXvYqy+dQsjqAh/ygnd516Wmx3K0UD68HOXZJavMhUfHJ5BXmrHd2VEyQZiK8jJOOsFfi73sLyzaQ==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr10036407wmi.70.1581263948625;
        Sun, 09 Feb 2020 07:59:08 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id p15sm11537773wma.40.2020.02.09.07.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 07:59:08 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 01/19] git-rebase.txt: update description of
 --allow-empty-message
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <3ea48d53940cb7e1a82a8a6eb819497c0448af6a.1579155273.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <09f2a9bd-1fd2-b44b-a279-baf37ae23391@gmail.com>
Date:   Sun, 9 Feb 2020 15:59:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3ea48d53940cb7e1a82a8a6eb819497c0448af6a.1579155273.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 16/01/2020 06:14, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit b00bf1c9a8dd ("git-rebase: make --allow-empty-message the
> default", 2018-06-27) made --allow-empty-message the default and thus
> turned --allow-empty-message into a no-op but did not update the
> documentation to reflect this.  Update the documentation now, and hide
> the option from the normal -h output since it is not useful.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt |  7 ++++---
>   builtin/rebase.c             | 12 +++++++-----
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0c4f038dd6..c83be7ffc2 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -265,9 +265,10 @@ See also INCOMPATIBLE OPTIONS below.
>   See also INCOMPATIBLE OPTIONS below.
>   
>   --allow-empty-message::
> -	By default, rebasing commits with an empty message will fail.
> -	This option overrides that behavior, allowing commits with empty
> -	messages to be rebased.
> +	No-op.  Rebasing commits with an empty message used to fail
> +	and this option would override that behavior, allowing commits
> +	with empty messages to be rebased.  Now commits with an empty
> +	message do not cause rebasing to halt.

Do we want to mention that the user can pass --no-allow-empty-message to 
override this?

Best Wishes

Phillip

>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8081741f8a..faa4e0d406 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -453,8 +453,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
>   			   REBASE_FORCE),
>   		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
> -		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
> -			 N_("allow commits with empty messages")),
> +		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
> +			   N_("allow commits with empty messages"),
> +			   PARSE_OPT_HIDDEN),
>   		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
>   		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
>   			 N_("keep original branch points of cousins")),
> @@ -1495,9 +1496,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
>   				N_("add exec lines after each commit of the "
>   				   "editable list")),
> -		OPT_BOOL(0, "allow-empty-message",
> -			 &options.allow_empty_message,
> -			 N_("allow rebasing commits with empty messages")),
> +		OPT_BOOL_F(0, "allow-empty-message",
> +			   &options.allow_empty_message,
> +			   N_("allow rebasing commits with empty messages"),
> +			   PARSE_OPT_HIDDEN),
>   		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
>   			N_("mode"),
>   			N_("try to rebase merges instead of skipping them"),
> 

Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8863A20786
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plnneIfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKDNYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgKDNYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:24:38 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4CC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 05:24:38 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 9so22123511oir.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mXurjlC882bOaRbmwfU4VlXHFKoOgMZ3rH2UJQud+tE=;
        b=plnneIfRpqYOUoeryzo4u/Zx5alX0h05aWbt5nc/9rGGZVYwIfvUSWAoaRl+INPLXA
         RIxNN+lYLYPZTvhNJgkRMLYn2qksZZKMfaX2giuBkg/47KTuecW4djBrjx8dlo5ol1wF
         7z8FN8zRJVxNd7Q3MtoWBGBzpEk9cmjxh5h+tZYvupyNfUvNw2R8gpz5C5Rcc9V8TxNK
         +/D3I/TcLr7LmlIJRvxNdLzxY+mjQZdXz3hvkeVEFdWLCebSzgUNO9CHNwDRnSW1YC7D
         8Rt1PMHpEDosfTE7UM9O5crbUalI20q2Q1wCU56Z32/9eok4gnlWfTXOiVgZoB00GOau
         D5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXurjlC882bOaRbmwfU4VlXHFKoOgMZ3rH2UJQud+tE=;
        b=Bp7AafcVpWv/d0RK7h3fCM6i9Ox30Q7kewJUjzps/TDgPKxJ3oCidVEQqKFoXG13gN
         b9YvDQ4SNSMFip6IGuB/Yen8AGeqTEVklyfPmwYJWZBqB5T/C8jvoCjoFmGj68XNi6Au
         PtxbD7E2PqnR8564DKJRhILR8YPtfmzMfuT7BW6MrNP2m75XOG1le16mwP2XPn/XM2zN
         Yi7uvxHudZFDvvT0RmazU1wipX9kO9+5M5il29lI6h56BUgsvRBkVMkNj/BD+26eKQ7Z
         ykdzkOEClZNxjsdl8l1BO3YgTkOBj0eAtwP7eOn9wxb6DtPw1KeysVrdqlFCKZ1KhcR7
         ua6w==
X-Gm-Message-State: AOAM531nzeqek6Lwr18hERLwafLUamJRXXasAB27bgTz3jmWcrfvJU1y
        FkvvMlo9Ye5ubUnOvHvU2K8/rUj3IckV3w==
X-Google-Smtp-Source: ABdhPJydt8MNnp5iHscPbCE5RE0NsDmIcrhD7p1l9KlBzJzNkTkvMBV799Cr257aBHkXNosl8gK5Ug==
X-Received: by 2002:aca:b683:: with SMTP id g125mr2409068oif.146.1604496277299;
        Wed, 04 Nov 2020 05:24:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 85sm439504oie.30.2020.11.04.05.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 05:24:36 -0800 (PST)
Subject: Re: [PATCH] doc: clarify that most --abbrev[=<n>] are about minimum
 length
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
 <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
 <xmqqblgdq4k0.fsf_-_@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7d6ea51-6aaa-bf74-2e19-1d1283001489@gmail.com>
Date:   Wed, 4 Nov 2020 08:24:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqblgdq4k0.fsf_-_@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 8:44 PM, Junio C Hamano wrote:
> Early text written in 2006 explains the "--abbrev=<n>" option to
> "show only a partial prefix", without saying that the length of the
> partial prefix is not necessarily the number given to the option to
> ensure that the output names the object uniquely.
> 
> Luckily, the text written for "git describe" in 2011 explains that
> the output is made to name the object uniquely using at least <n>
> hexdigits much clearly.
> 
> Model the explanation and update documentation for the diff family
> of commands, "blame", "branch --verbose", "ls-files" and "ls-tree".

Thanks for being thorough here! Your patch is already an
improvement on what we have. I hope that my suggestions
below help to improve it further.

> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -446,7 +446,8 @@ endif::git-format-patch[]
>  --abbrev[=<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
>  	name in diff-raw format output and diff-tree header
> -	lines, show only a partial prefix.
> +	lines, show <n> hexadecimal digits, or as many digits
> +	as needed to form a unique object name.

A reoccurring theme in this patch is that the --abbrev option
provides a lower bound, even if fewer digits are needed for a
unique object name. Using these two phrases with an "or" has
some ambiguity about which is chosen.

Perhaps we should try to describe it as "<n> is the default,
but can grow as needed". Here is an attempt:

-	lines, show only a partial prefix.
+	lines, show at least <n> hexadecimal digits, increasing the
+	prefix length as needed to uniquely identify an object.

If you prefer wording like this, then there are a few very
similar snippets later in git-branch.txt and git-ls-files.txt.

> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -87,7 +87,9 @@ include::blame-options.txt[]
>  
>  --abbrev=<n>::
>  	Instead of using the default 7+1 hexadecimal digits as the
> -	abbreviated object name, use <n>+1 digits. Note that 1 column
> +	abbreviated object name, use <m>+1 digits, where <m> is at
> +	least <n> but ensures the commit object names are unique.
> +	Note that 1 column
>  	is used for a caret to mark the boundary commit.

This captures the "at least <n>" pretty well, especially considering
the complications around "+1".

> ---abbrev=<length>::
> -	Alter the sha1's minimum display length in the output listing.
> +--abbrev=<n>::
> +	In the verbose listing that show the commit object name,
> +	use <n>, or as many hexdigits as needed to form a unique
> +	object name.

Adapting from your wording here made me think that this might
be a simpler way to phrase it:

+--abbrev=<n>::
+	In the verbose listing that show the commit object name,
+	use at least <n> hexdigits to form a unique object name.

> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 17c5aac4b7..da6ab0de0c 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -16,7 +16,8 @@ configuration (see linkgit:git-config[1]).
>  
>  --abbrev-commit::
>  	Instead of showing the full 40-byte hexadecimal commit object
> -	name, show only a partial prefix.  Non default number of
> +	name, show only a partial prefix that names the object uniquely.

Perhaps "show a prefix that uniquely identifies the object" ?

> +	Non default number of
>  	digits can be specified with "--abbrev=<n>" (which also modifies
>  	diff output, if it is displayed).

I know this is in the existing docs, but this last sentence should
probably start with "A non-default number of digits..." Alternatively,
we could rephrase the entire thing to use more active voice:

+ The `--abbrev=<n>` option modifies the minimum number of digits
+ for these prefixes, including objects reported in displayed diff
+ output.

Thanks,
-Stolee

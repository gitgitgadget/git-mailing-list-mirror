Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB3C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF9B2072E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 13:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBrwddCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAFNi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:38:27 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45073 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFNi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 08:38:27 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so19005453qvu.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CKRbw38bfVf0uouHxU8tKRqXgvc0YdyRf5SybqAUlM8=;
        b=qBrwddCsVOq5u8kiXa86L6e5AlTD4IBCQ36yEBG59y4UD4zhpf0MbyENZg/Ttj+2tF
         A9fP/D2chRcbTTN9AdWD2LCDDQzMPLCctGxuIl5c61cDmbgPYeU/xy6fblu5KUh+eiXT
         VqBBiavAtW1O3rC4iIp52MzUiy0gb6Q9etPq3SfxVr5yGsJee7AquCxkzOw030biKuPh
         U8fRSH8RFazg5hpad5Fdl42ijSEZdURh9TPe5qn8E9zHVeXoKFF1Zd7Nnqb9OOHEMLIA
         GrFlYgrT3hAFDe+UfvcQjk36QRHc4uquLP8UEr/CC8YFJmbLvJLqDZL0kXXhIjELmBLn
         BFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKRbw38bfVf0uouHxU8tKRqXgvc0YdyRf5SybqAUlM8=;
        b=ZFll4g8N6QzzGDfAPVjJPr59f8jGCj4Ij7bMULBwT100j6hiQZTDiVEpXJD4uW5Vwh
         UtupKxVH7L6m19qVDJQEnJ8nftL7vSAx6ysCdcF9skyfOYG2rsDOCrBsEyPNrHOLQzSj
         Qv6/r5Cszko7YvQi9yDRI+IJKX5VTkSJ9X1wQ4NU755vwev918Q1xWxX+KRUM2kA2zyG
         293RhLUZXugD2dps4l5KRiMEoLohsygwThQ2Pd7vQg9jY+MBHEETt/PAaIaiUuQhvasI
         p88exQ/CppPb6KouGOsv9tw0XKrJae6o7eCxGcZCqW9GV7Kvd0JimCVWWpAZRIFi226k
         voKw==
X-Gm-Message-State: APjAAAWmKzu4Uc/eK2B++UI7dRysfDj3a3Hl8eBN0BGSI4Zmsr2evbr8
        XSgNAajrqxfRyKSteFIWE9j2n6uc
X-Google-Smtp-Source: APXvYqzMFAmx5O3pgAU87QqptIMTxJURJIsXXOlgGljnAjNzY2mZEqLTvp/hL+bnbdUeDBr/h1pjiw==
X-Received: by 2002:a05:6214:1189:: with SMTP id t9mr77701558qvv.153.1578317905165;
        Mon, 06 Jan 2020 05:38:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:edba:a09c:727e:8e59? ([2001:4898:a800:1010:9ef0:a09c:727e:8e59])
        by smtp.gmail.com with ESMTPSA id r205sm20694934qke.34.2020.01.06.05.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 05:38:24 -0800 (PST)
Subject: Re: [PATCH 1/1] commit: make the sign-off trailer configurable
To:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
References: <20200105174127.9278-1-hji@dyntopia.com>
 <20200105174127.9278-2-hji@dyntopia.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com>
Date:   Mon, 6 Jan 2020 08:38:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200105174127.9278-2-hji@dyntopia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2020 12:41 PM, Hans Jerry Illikainen wrote:
> The commit builtin did not previously have a configuration option to
> enable the 'Signed-off-by' trailer by default.
> 
> For some use-cases (namely, when the user doesn't always have the right
> to contribute patches to a project) it makes sense to make it a
> conscientious decision to add the signoff trailer.  However, others'
> might always have the right to ship patches -- in which case it makes
> sense to have an option to add the trailer by default for projects that
> require it.

My initial thought was that the sign-off was supposed to be a purposeful
decision, but then I also realized that I never do anything in the Git
codebase that I _can't_ put online under the GPL. (It may not make it
upstream, but it will always be put online somewhere.)

> This patch introduces a commit.signOff configuration option that
> determine whether the trailer should be added for commits.  It can be
> overridden with the --(no-)signoff command-line option.

With that in mind, I think this is a valuable feature.
 
> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>

Did you generate this with your config option? ;)

> +commit.signOff::
> +	A boolean to specify whether commits should enable the
> +	`-s/--signoff` option by default.  *Note:* Adding the
> +	Signed-off-by: line to a commit message should be a conscious
> +	act and means that you certify you have the rights to submit the
> +	work under the same open source license.  Please see the
> +	'SubmittingPatches' document for further discussion.
> +

I wonder about the language of "should be a conscious act" here. It's
as if you are trying to convince someone to not use this feature. Perhaps
switch it to "is a deliberate act" and add something such as "Enable this
value only in repos where you are the only user and always have these
rights."

The multi-user scenario may be worth clarifying explicitly here. If there
is any chance that another user will join the machine and use that same
repo, then they would have a different user.name and user.email in their
global config (probably) but this as a local setting would provide their
sign-off.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index c70ad01cc9..497e29c58c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1474,6 +1474,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		sign_commit = git_config_bool(k, v) ? "" : NULL;
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.signoff")) {
> +		signoff = git_config_bool(k, v);
> +		return 0;
> +	}

Since we are directly modifying the same global used by the --[no-]signoff
option, I verified that the config options are checked before the arguments
are parsed. Thus, --no-signoff will override commit.signOff=true...

> +test_expect_success 'commit.signOff=true' '
> +	test_config commit.signOff true &&
> +	echo 1 >>positive &&
> +	git add positive &&
> +	git commit -m "thank you" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
> +	git var GIT_COMMITTER_IDENT >ident &&
> +	sed -e "s/>.*/>/" ident >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'commit.signOff=true and --no-signoff' '
> +	test_config commit.signOff true &&
> +	echo 2 >>positive &&
> +	git add positive &&
> +	git commit --no-signoff -m "thank you" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
> +	git var GIT_COMMITTER_IDENT >ident &&
> +	sed -e "s/>.*/>/" ident >expected &&
> +	! test_cmp expected actual
> +'

...which you test here, too. Excellent.

> +test_expect_success 'commit.signOff=false and --signoff' '
> +	test_config commit.signOff false &&
> +	echo 1 >>positive &&
> +	git add positive &&
> +	git commit --signoff -m "thank you" &&

Perhaps it is worth adding an explicit "-c commit.signOff=false" here?

> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
> +	git var GIT_COMMITTER_IDENT >ident &&
> +	sed -e "s/>.*/>/" ident >expected &&
> +	test_cmp expected actual
> +'
> +

I wonder if the boilerplate for these tests could be simplified or
shared across the tests?

For example: could we not just use test_i18ngrep to see if commit.msg
contains (or does not contain) the string "Signed-off-by"?

I believe this patch delivers the stated feature well. Hopefully others
can add commentary on its usefulness or possible issues in using it.

Thanks,
-Stolee

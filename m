Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CADC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350701AbiD1SGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiD1SGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:06:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879BB7172
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:02:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so7829590wrb.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=nZ8n51DFdeMp+Dpk0efeD1/vqLK3fzU1rryK5obvZpc=;
        b=CarG/AvrKDRuk4hIVmb3cBGGz7SZV4szpWWzU3sS1rSwErsLHWE82ASh1e+LHbbddH
         lnr8/3/X4EeaH8uyavGRSsQKQVhEr7BDATkUI7RtBYgLbXe+kEvvlILIae9c4KmoXgeW
         Sx6y2QuVyTavFJpoENDkLnOJADUz0ZZvJvbPZdX1izgXa0+fAN8kNHHMEVIIEbJ7yW5Y
         gB6bT5Bv3q87/D1KGFP2qSFt7vGTTbxqGA69D4hLw4PG48o2LvjV8HxFomz9b8ZGQ8Fe
         J726jnNzUPKcDaVV3hOLiycYpjnF8Mfh+OFttESnlgPrh4S2InjRK1qcUfFMerEKojdH
         r9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=nZ8n51DFdeMp+Dpk0efeD1/vqLK3fzU1rryK5obvZpc=;
        b=m0eXzoikA09G9WH2j5Z2OCzC/PMtHkzyt/UofeZfbwfrjeevnFgR1xdGwxDIE8ySKZ
         oKIELtNXa37m40q4encCoQGU9P67f4aYZCjpxlTGBVq2SEcwKRvK95sQnlacl5kAdS/m
         mb6lOsTs8Ac7npGc5DGmGUOEghBq5T900BgWxJeljCqlF6HKGu0uJToUNGgLMWX4sdpS
         w/VkhN9g+y+5UxVyWwT3J7bX2Lol86YOqS+juvDzbz5pog0lhpdTR9nWcxUZ/Q6zvklr
         oTDwidZv1QyvTP4yc4cDMoxiTdHU8R2LfRGdG7MfFFstWsjR1qHeB4jz0OYyM9MpozL4
         bhHQ==
X-Gm-Message-State: AOAM533MXtxCJZUHI0WNREYrYE5Zdkhze9xP40aRj+v+n+wjri/cPvv3
        EnwQCfwrfyvnSO1RYsyHVd4=
X-Google-Smtp-Source: ABdhPJyY4qtz28NyFVuMOZpo7+Ji9ocX48dKl7Z9Br5eP4/6LpE578xhDlJFbTcNwWelSGptWFQcEQ==
X-Received: by 2002:a5d:6391:0:b0:20a:e4c5:c247 with SMTP id p17-20020a5d6391000000b0020ae4c5c247mr12510906wru.516.1651168966269;
        Thu, 28 Apr 2022 11:02:46 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm504143wri.111.2022.04.28.11.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:02:46 -0700 (PDT)
Message-ID: <225d0f01-89d5-f2b4-36f2-097b915d66c5@gmail.com>
Date:   Thu, 28 Apr 2022 19:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
Reply-To: phillip.wood@dunelm.org.uk
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-2-carenas@gmail.com>
Content-Language: en-US
In-Reply-To: <20220428105852.94449-2-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 28/04/2022 11:58, Carlo Marcelo Arenas Belón wrote:
> bdc77d1d685 (Add a function to determine whether a path is owned by the
> current user, 2022-03-02) checks for the effective uid of the running
> process using geteuid() but didn't account for cases where that user was
> root (because git was invoked through sudo or a compatible tool) and the
> original uid that repository trusted for its config was no longer known,
> therefore failing the following otherwise safe call:
> 
>    guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>    [sudo] password for guy:
>    fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)
> 
> Attempt to detect those cases by using the environment variables that
> those tools create to keep track of the original user id, and do the
> ownership check using that instead.
> 
> This assumes the environment the user is running with after going
> privileged can't be tampered with, and also does the check only for
> root to keep the most common case less complicated, but as a side effect
> will miss cases where sudo (or an equivalent) was used to change to
> another unprivileged user or where the equivalent tool used to raise
> privileges didn't track the original id in a sudo compatible way.
> 
> Reported-by: Guy Maurel <guy.j@maurel.de>
> Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Randall Becker <rsbecker@nexbridge.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   git-compat-util.h | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 63ba89dd31d..dfdd3e4f81a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -393,12 +393,50 @@ static inline int git_offset_1st_component(const char *path)
>   #endif
>   
>   #ifndef is_path_owned_by_current_user
> +
> +#ifdef __TANDEM
> +#define ROOT_UID 65535
> +#else
> +#define ROOT_UID 0
> +#endif
> +
> +/*
> + * this helper function overrides a ROOT_UID with the one provided by
> + * an environment variable, do not use unless the original user is
> + * root
> + */
> +static inline void extract_id_from_env(const char *env, uid_t *id)
> +{
> +	const char *real_uid = getenv(env);
> +
> +	/* discard any empty values */
> +	if (real_uid && *real_uid) {
> +		char *endptr;
> +		unsigned long env_id;
> +		int saved_errno = errno;

I still don't understand why you're worried about preserving errno - am 
I missing something? It's not wrong to save it but I'm not sure why we 
need to. is_path_owned_by_current_uid() does not save it around the stat 
call so why do we need to do this here?

> +
> +		errno = 0;
> +		env_id = strtoul(real_uid, &endptr, 10);
> +		if (!errno && !*endptr && env_id <= (uid_t)-1)

Thinking out loud:
"!errno && !*endptr" ensures we have read a valid integer from SUDO_UID. 
If uid_t is unsigned then "env_id <= (uid_t)-1" ensures the value we 
read fits into a uid_t. If uid_t is signed then this test is always true 
and we could truncate the value we read. However if we don't trust 
SUDO_UID then we shouldn't be doing any of this so we are trusting that 
the truncation never happens which means we probably don't need this 
test in the first place.

Best Wishes

Phillip

> +			*id = env_id;
> +
> +		errno = saved_errno;
> +	}
> +}
> +
>   static inline int is_path_owned_by_current_uid(const char *path)
>   {
>   	struct stat st;
> +	uid_t euid;
> +
>   	if (lstat(path, &st))
>   		return 0;
> -	return st.st_uid == geteuid();
> +
> +	euid = geteuid();
> +	if (euid == ROOT_UID)
> +		extract_id_from_env("SUDO_UID", &euid);
> +
> +	return st.st_uid == euid;
>   }
>   
>   #define is_path_owned_by_current_user is_path_owned_by_current_uid

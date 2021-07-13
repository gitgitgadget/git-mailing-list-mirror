Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F239C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B86135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhGMXhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMXhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:37:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349BC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:34:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k20so6195pgg.7
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7nd2lf95kJfMXAQCHp1zFomryYtU9byLHnrXbXTFy8=;
        b=dvtCiS8iIYJAJ2vrsxIqidGckuU8UgRjC20Qdb0apYVTHL1Gzl7Fvk5ee45Da/yP0k
         5xgvXdfWLhZcEGXeCtGvAudLL0+NTOoy9d8yFs6OykCamIdOwgRlBbT+31kaBlY+pYDX
         FHkRQvxuAscrMshyO4PthlBUl5HMH14M9TwHoVvsIYq9y449hcaKXDQ/GI00U2N345TG
         fCT27NjbBDuL6bhPR7Rj3jFXFD9Aa+IX+DKOjvrJpF34PgbUdF+J5bBrGYG1hJsnzZLX
         7Tn9z9okPcN1CKPFDmxeB/4P0H5TtIa945Ua6t2JYwO/WQVGa551ZSwS5JjiqDYC04kG
         Tcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7nd2lf95kJfMXAQCHp1zFomryYtU9byLHnrXbXTFy8=;
        b=YEJ56hq2t03dicB9KvwNu8byzLfIv2H4smbQaY37rcehpY0C+UL8Q5KvLNERI9nQ79
         fus46MdlDSlQXVmmg0Yhvo5Cx1zf434BaY4ZDsjS+hou/XkgRGtCw1vQt/NjHrbkagag
         mzvJaGyTGRlrjV6oEaXoEs+dI1+K6Bft9l0ZqSEhWsHonaLejqRWtHEEUDK2xwPsKA7U
         EoXPmBHyKQYmHwDjomcAQU722qQUctRgEpq0KONb0USy3rtcvVRHufxeYX8SM7Q9jHYS
         ZqwSHGwgUAVZo96KC5IuB1CivG4fjoaU3+P8UN7rGiP8HB7Q7kKapPE10kTmQ8Qt8IYT
         07Kw==
X-Gm-Message-State: AOAM531yiokpI1i/ugqlpC94c8IHAFqtbEVBNG8U59Y4ZxUUjj93dKUp
        PSmoeDDsJTC5VCxbbWYJ304=
X-Google-Smtp-Source: ABdhPJwNxAlDtEqj52cPQ9jwxJuGWlNnXzOjRNiAKn+KeRYZskRn4x/E+NFyQaELNKgzBN8zdQQH5Q==
X-Received: by 2002:a62:5b04:0:b029:308:6fc4:da91 with SMTP id p4-20020a625b040000b02903086fc4da91mr6904387pfb.26.1626219262779;
        Tue, 13 Jul 2021 16:34:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id f6sm216148pgl.2.2021.07.13.16.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 16:34:22 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] merge-ort: add some more explanations in
 collect_merge_info_callback()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <8aea3713902b7d006f527ccd76faf6f944529bdb.1626204784.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7f4fc9f6-9b46-6e39-1a66-b72e0c583f21@gmail.com>
Date:   Wed, 14 Jul 2021 06:34:19 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8aea3713902b7d006f527ccd76faf6f944529bdb.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/07/21 02.32, Elijah Newren via GitGitGadget wrote:
> @@ -1018,8 +1018,8 @@ static int collect_merge_info_callback(int n,
>   	if (side1_matches_mbase && side2_matches_mbase) {
>   		/* mbase, side1, & side2 all match; use mbase as resolution */
>   		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
> -				names, names+0, mbase_null, 0,
> -				filemask, dirmask, 1);
> +				names, names+0, mbase_null, 0 /* df_conflict */,
> +				filemask, dirmask, 1 /* resolved */);
>   		return mask;
>   	}
>


Is df_conflict stands for directory-file conflict?

>   	/*
> -	 * Record information about the path so we can resolve later in
> -	 * process_entries.
> +	 * None of the special cases above matched, so we have a
> +	 * provisional conflict.  (Rename detection might allow us to
> +	 * unconflict some more cases, but that comes later so all we can
> +	 * do now is record the different non-null file hashes.)
>   	 */
>   	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
>   			names, NULL, 0, df_conflict, filemask, dirmask, 0);
> 

So when none of special cases matched, we assumed there's conflict 
(although provisional), right?

-- 
An old man doll... just what I always wanted! - Clara

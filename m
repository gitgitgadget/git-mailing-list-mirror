Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCCC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D81660FEB
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhEJFht (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEJFht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:37:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F75C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 22:36:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a0242b0290155433387beso7641710pje.1
        for <git@vger.kernel.org>; Sun, 09 May 2021 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Xph/xqV+3JYsW1K70zlKVjQy3s/X4bmYy7DVVWXEqaI=;
        b=ld0cOfmgdHjrkdFOCIEyHcfySlGivNyYWTp8wjE8dIqkX+KP7rNRiUlQj1dn1GoExC
         jCj7UQYubqo0fJRmOrTgelNJ93sxTyN0+XhumDobm4po8/jeRozKYi8lcO3jaO8BYQI4
         vaTG9owqtD+s12SyNo1J3nUkQCYocoRcTNJPWTnwGT4HHDmi1640XV6tJjwddndbodCy
         vE06BwS24U0RywkwyF9IyqwMj20f6fkDkeEwucgUicikSz9VLkurZK5znZTX6HkmKKW6
         2xLwhCr/EiH6iHxKaGwac4Ddbq21TaqJtDfe4/CAyW5lrlq2iCT+6Bo8QY/Es32LoBWn
         tBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xph/xqV+3JYsW1K70zlKVjQy3s/X4bmYy7DVVWXEqaI=;
        b=XFaz1aOu5h5sijrLOwYPQ+ZNd4MuofqPTs64mpfoFnoDk81aGJnz0EIIziqebz+mQf
         j9cbsIW2LCu/L6OBE9kk78i7teMFdBYBxVS/Dh4bck3f33jRkEBUGtmUIqepqw5Jm01R
         G2XXkLbXGkP8FcwDv4kedjkH6rgfUCRGD++2sKH+X16O3lvCFpgqZHmIAuipTv4dXwyi
         MjjXWSW3jkBaXuT7vwQR/+q2I0Wdq82pFK66bzy5u4znJ6n/n0tfGrfMGaSCbgdoINPT
         do4tziLYVwPrUb27UfzRjiXtOiBi2QjeCIxMnhqDlavFRGy5OAHVvMO4eo3COA8W7mbM
         405A==
X-Gm-Message-State: AOAM531x5sb8Y2hiXL4jN4RooqNWJk8mQimAIqjBqfd2WEuHgqdp/F8S
        cShuK3+eJMGskmO2w3TBZAg=
X-Google-Smtp-Source: ABdhPJydEhIMkr70iAaB1+d3ftLgmUHtHkioHurjezFGM0xkbnENgCeq/RmsuYTkHmy54O3Vf/S3Mg==
X-Received: by 2002:a17:90a:f87:: with SMTP id 7mr6697235pjz.38.1620625003685;
        Sun, 09 May 2021 22:36:43 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-59.three.co.id. [116.206.28.59])
        by smtp.gmail.com with ESMTPSA id u17sm9948674pfm.113.2021.05.09.22.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 22:36:43 -0700 (PDT)
Subject: Re: [PATCH] merge-ort: split "distinct types" message into two
 translatable messages
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, gitster@pobox.com
References: <20210509215250.33215-1-alexhenrie24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <bb3a3968-f78e-7534-1274-2e6c916b9a8a@gmail.com>
Date:   Mon, 10 May 2021 12:36:39 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210509215250.33215-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/21 04.52, Alex Henrie wrote:
> The word "renamed" has two possible translations in many European
> languages depending on whether one thing was renamed or two things were
> renamed. Give translators freedom to alter any part of the message to
> make it sound right in their language.

What are the examples? In French, Spanish, German, Portuguese (pt-PT),
or even Slavic (like Russian) or even Hungarian, and etc?

> -			path_msg(opt, path, 0,
> -				 _("CONFLICT (distinct types): %s had different "
> -				   "types on each side; renamed %s of them so "
> -				   "each can be recorded somewhere."),
> -				 path,
> -				 (rename_a && rename_b) ? _("both") : _("one"));
> +			if (rename_a && rename_b) {
> +				path_msg(opt, path, 0,
> +					 _("CONFLICT (distinct types): %s had "
> +					   "different types on each side; "
> +					   "renamed both of them so each can "
> +					   "be recorded somewhere."),
> +					 path);
> +			} else {
> +				path_msg(opt, path, 0,
> +					 _("CONFLICT (distinct types): %s had "
> +					   "different types on each side; "
> +					   "renamed one of them so each can be "
> +					   "recorded somewhere."),
> +					 path);
> +			}

Seems OK.

For example, in Indonesian, the first case (both sides are renamed) would be
something like:
```
%s punya tipe yang berbeda pada setiap sisi, kedua-duanya dinamai ulang...
```
The second case (only one side) would be something like:
```
%s punya tipe yang berbeda pada setiap sisi, salah satunya dinamai ulang...
```
But the status quo (before this patch) would be translated as:
```
%s punya tipe yang berbeda pada setiap sisi, (kedua-duanya | satu) dari mereka
dinamai ulang...
```
On the both sides case of status quo, the personal pronoun `mereka` (they)
refers to the conflicted sides, where as on this patch, such conflicted sides
are instead be referred as `-nya` suffix on the translation.

I personally avoid using `mereka` atau `ia` as personal pronoun that refer
to things, and instead using `itu`.

-- 
An old man doll... just what I always wanted! - Clara

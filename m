Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE9C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiHCWmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiHCWmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:42:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A217A82
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:42:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw1so17710819plb.6
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=hqxeSUZUP3bA40gaDlsIsulTMFoXrswHArzZ5YZdNLk=;
        b=Mgt9Xxv4XUNPzCvP9hKs1o9SodSSWIsPQIfUmEPjeFHRCl3HZyYD8Ixwhk5qY5moqM
         kttgK3Fyo25ofQlQUSIvYR7bIucuXHcuf33MEUEb6fNJEtixP8vMJSPWbGxpu2sWb6V7
         drYoAAsVv7/Jy5euSjNrrM7RGilrG5sGXgIxvFhUUqyvTrg6VeEhBqkOAYA3fFW/J/cs
         E7INjq6nJev5L4qX49r5z9fVnByuBLn1CNChvBzTARuzH2iXfUvY4GQaDeg2rYYEZBM4
         JSNfzDUb0/oiTPH2TfF+hm2T7SiJymxOkhtcyHiFOJgXLb45LRazGDEMog3xxPtUYCar
         zm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=hqxeSUZUP3bA40gaDlsIsulTMFoXrswHArzZ5YZdNLk=;
        b=phMte2SF0DOfAaDF+isWtJnYdQlOQ7YpCcQncegnJ9DpsAfTRvbCjBAhH2W6aVCarY
         0cQMFRqhsNOd76PgHf337I3Jdy9B3L8opTjwz4Uiwfm6kwpp9xC6DOsbIrwOuMTajNxu
         vM5SJpcx4SRUCxSwdWWf9rBZR7+/Kw9zgm5dOA8aokxkrNBg4muY9Gna/3xu+xS3YlE/
         y1/P1PrEBKPBZIhO0VgkeYZ+m0CDPB1SNpafBSjLaFzEppNEYeu4gqhJi6pcGqPWe9sF
         1J5iDAB7OyNDrNp+aNc+K5yRPb6kClJjVMEinVZHkM+1La+H03WfW8Ld8EgTeWezhqZf
         MC6A==
X-Gm-Message-State: ACgBeo3VUGYDb+J7j8ZZom+GBXSLIAI4r3EOMX4DBxwObKupDPXmz26+
        USDSEIwc8sZA0Fty64zSSkZwqw==
X-Google-Smtp-Source: AA6agR5O2HRwcnHjsixlig+khtmaqmVyTYJcuKc3EsQx8Q/hkFbXo1NUfIF9qhWTmOiisba2tgfnCw==
X-Received: by 2002:a17:902:b191:b0:16c:c0d3:cc32 with SMTP id s17-20020a170902b19100b0016cc0d3cc32mr27375053plr.41.1659566537434;
        Wed, 03 Aug 2022 15:42:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8993:c42:1e1d:1a70])
        by smtp.gmail.com with ESMTPSA id x16-20020aa78f10000000b0052d200c8040sm7217091pfr.211.2022.08.03.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 15:42:16 -0700 (PDT)
Date:   Wed, 3 Aug 2022 15:42:09 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 08/10] log: create log.decorateFilter=all
Message-ID: <Yur5wXXiBtKRO/Y5@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <8142b32f023685c78936a618d7b93aaf86ba77fb.1659122979.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8142b32f023685c78936a618d7b93aaf86ba77fb.1659122979.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change introduced the --decorate-all option for users who
> do not want their decorations limited to a narrow set of ref namespaces.
> 
> Add a config option that is equivalent to specifying --decorate-all by
> default.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/config/log.txt |  5 +++++
>  Documentation/git-log.txt    |  4 +++-
>  builtin/log.c                | 12 ++++++++++++
>  t/t4202-log.sh               |  3 +++
>  t/t9902-completion.sh        |  3 +++
>  5 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 456eb07800c..615cb26e5c9 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -18,6 +18,11 @@ log.decorate::
>  	names are shown. This is the same as the `--decorate` option
>  	of the `git log`.
>  
> +log.decorateFilter::
> +	By default, `git log` only shows decorations for certain known ref
> +	namespaces. If 'all' is specified, then show all possible ref
> +	decorations. Default value is 'default'.
> +

Could we make it more clear here that "all" is the only supported value?
IIUC any other value will just get the default behavior. Just reading
the doc as-is, I worry that users might expect that they can add
specific refs / ref-patterns that would be added to the filter.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562BFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiDAPz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357976AbiDAPjY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:39:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7336100E36
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:15:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h16so1919786wmd.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SvgItSf6kUD3SykNqF5E9XJooBRD/kFf1d2Hqh5sYOs=;
        b=oqKoFWRMf7AP4to5xZQFovtS6A/YF00rUvUO47aMCgAPIjsOV3RLm+RMBv9yEGZAzs
         RNZ6rjlCa3KSMIznb3kklyjYKoFHYV8G9dzKCiAH9O96sexdrVPLIBlDxqQKvAmHCPKd
         nxTyWJjbtoayp+6d30V8kzcqx8Y7+qHeFj02AAUDltPKW4ujSC+CUqaehUSwpzEVOBb0
         yeuge6FizoT4NgYw+/KVy+lXPBexv8Wtnqz2RJqq9EmacE2D6IK0O5gbWYrnn+5ABq6J
         tG2DLduVMptA7aRZK2USfT2UwySl1iM20kDHdbOot/ol7Tj1RqAdfNrU4m9Uk9/WW1Dv
         fNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SvgItSf6kUD3SykNqF5E9XJooBRD/kFf1d2Hqh5sYOs=;
        b=3O2RyhtIkna/9sMY/oYqHG//38RwT11dD5CpdDafhSf1cAgJu+mrWvTaIvaPN7odBe
         chr11cu41bYS7oaHnGnU1KFfZ7FYV7yOnHaTirKKNpTBj9yz0q5Mw4i1A37PUJERj4qV
         pTZvImGH/4aOejF8ruxNdvNDnwzFaS0XalEKwwjg3bRHvwcI8T79K60GXfM9rJPEQslC
         08sCNStxZ61uPuRK/S80gdidY16qQ1joXrHQ+egqjlQWgePcpQw6HZr6hKjZI1oL4Zmf
         P3SjvWQwLbLBCKApdS50QBCmsS8ZOax0t2ZdSzWis2VJ5Q6HkayrKRqmJcOpt9+VZALw
         v/iw==
X-Gm-Message-State: AOAM533vFidyUfoXtTLsmjax4xzJIx1EaZ9suyS5Ve61OUTtTBC51z8G
        Rv1ibl0DqgOBTJlU3kzK+Yk=
X-Google-Smtp-Source: ABdhPJzUFFFjIxUt0rz22M5xQAabhbyTASjrlO3DXWGm9ZhO+orFctd+MYYjSgKETL8GNTLfMvka6Q==
X-Received: by 2002:a05:600c:3789:b0:38c:bd93:77d6 with SMTP id o9-20020a05600c378900b0038cbd9377d6mr9295541wmr.12.1648826110447;
        Fri, 01 Apr 2022 08:15:10 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b00205d3d37dcdsm2290926wrq.103.2022.04.01.08.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:15:10 -0700 (PDT)
Message-ID: <e1bdb860-070b-8596-2a32-e9bc3ad354b0@gmail.com>
Date:   Fri, 1 Apr 2022 16:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 05/27] revision.[ch]: split freeing of revs->commit
 into a function
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-05.27-2d0ed57ec2e-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-05.27-2d0ed57ec2e-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> Move the existing code for invoking free_commit_list() and setting
> revs->commits to NULL into a new release_revisions_commit_list()
> function. This will be used as part of a general free()-ing mechanism
> for "struct rev_info".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   revision.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 7d435f80480..29f102cb83d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2923,6 +2923,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>   	return left;
>   }
>   
> +static void release_revisions_commit_list(struct rev_info *revs)
> +{
> +	if (revs->commits) {

This guard copied for the original is not needed, free_commit_list() 
will handle NULL just fine.

Best Wishes

Phillip
> +		free_commit_list(revs->commits);
> +		revs->commits = NULL;
> +	}
> +}
> +
>   static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
>   {
>   	struct commit_list *l = xcalloc(1, sizeof(*l));
> @@ -4080,10 +4088,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
>   	 * boundary commits anyway.  (This is what the code has always
>   	 * done.)
>   	 */
> -	if (revs->commits) {
> -		free_commit_list(revs->commits);
> -		revs->commits = NULL;
> -	}
> +	release_revisions_commit_list(revs);
>   
>   	/*
>   	 * Put all of the actual boundary commits from revs->boundary_commits

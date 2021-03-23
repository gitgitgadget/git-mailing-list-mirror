Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0148C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B68619C2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhCWUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCWUxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:53:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1FC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:53:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so80103wmj.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYeT/OnP59/QQZjlKv5Nv6PHFNnnObi3H6FbcXAkN9I=;
        b=qnrPrK2729auSWZNidauyFG5BKSnrqsCZRrzSVXarV90JwdOadeyjqeugvEfJhL3bD
         gwWoQLhMmg5QtI76aaw+xC9u39jkqhXEduNka7LhwSyFT9tCsRnOrW1lnYCDiIexQxP4
         qUsA8zzNigoZO69O35zTINbp0trCvnBWZ2QSbykXWiHZJjCX7WHFvhwXdeLNZNyHWniz
         JTiv8kQgkxVBv3KP+8R8Ea6wF1RSiaTWFXR3Y0PGxOtHh76qYOLvC9h54hW2esXGCHgH
         WNt/5WH1379EpwxV/YzZGEw69FI9OvinG/3fumFMApfWHAu0eJqkQ7BJS5KmXc+Hf208
         rznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYeT/OnP59/QQZjlKv5Nv6PHFNnnObi3H6FbcXAkN9I=;
        b=EwBUCb+aDcyaeCKNLZHvwd4pC1uGJm2NIxIEv00/brkN0DoaBm0TUALHjF9M+anc+z
         oAeoPMjhzHfWFirwrqbq1YdIIdgkEZK9YKtcqnVLeFG/VaOt0OQGTDlZ5GicZlHsTi0Y
         yO2pipWNSguI6DDsOzh25AN0bFqbLS25J2xwYqJT0flioed9WvwZx+u01yZwd3yt+lcl
         OyXnB0Y6pJ53ZN9JlJbiKN4U51B4nikuzshkqSHLgAaJ1zgNc7xDzEN+9y/i6EVpxDb4
         hcgVo+Tv9xG5jg8h9lNDT6Pu0nT0E0RS7Tbq9P0e+BKgmf80kuN6brVJ4/697zDuc4He
         tvLg==
X-Gm-Message-State: AOAM533IWxUoN/jXRhYc51oGKHzxeR/XEWgX60yjchptQJR8Pc5y+w0Y
        ANIDgCZilhKmsfC0Lgy8AzQ=
X-Google-Smtp-Source: ABdhPJwjBZaohVyJoJAOL3+X9hyf9H7+xiVVJhXhlgzk0VQdydKkzdhmZFACi7Frfbb+sG+bghLjIw==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr5132356wmc.65.1616532823982;
        Tue, 23 Mar 2021 13:53:43 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-370-45.w86-199.abo.wanadoo.fr. [86.199.105.45])
        by smtp.gmail.com with ESMTPSA id t20sm58171wmi.15.2021.03.23.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:53:43 -0700 (PDT)
Subject: Re: [PATCH v7 08/15] merge-one-file: rewrite in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
 <20210317204939.17890-9-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2103222303210.50@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <c968a6b8-bc0e-04f0-b72d-9fef05b60bd8@gmail.com>
Date:   Tue, 23 Mar 2021 21:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103222303210.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 22/03/2021 à 23:20, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Wed, 17 Mar 2021, Alban Gruin wrote:
> 

>> @@ -69,10 +69,13 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>>
>>  	if (skip_prefix(pgm, "--use=", &use_internal)) {
>>  		if (!strcmp(use_internal, "merge-one-file"))
>> -			pgm = "git-merge-one-file";
>> +			merge_action = merge_one_file_func;
>>  		else
>>  			die(_("git merge-index: unknown internal program %s"), use_internal);
>> -	}
>> +
>> +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
>> +	} else
>> +		merge_action = merge_one_file_spawn;
> 
> I would have a slight preference to keep the default initializer, because
> that makes it easer to reason about. But if you _want_ to keep this patch
> as-is, I won't object.
> 

Yeah, not sure why I did this.  I'll change this.

> It is a bit sad that the conversion cannot be done more incrementally, as
> there is a lot to unpack in the many different cases that are handled. It
> looks correct, though.
> 
> Just one thing:
> 
>>
>>  	for (; i < argc; i++) {
>>  		const char *arg = argv[i];
>> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
>> new file mode 100644
>> index 0000000000..ad99c6dbd4
>> --- /dev/null
>> +++ b/builtin/merge-one-file.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * Builtin "git merge-one-file"
>> + *
>> + * Copyright (c) 2020 Alban Gruin
>> + *
>> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
>> + *
>> + * This is the git per-file merge utility, called with
>> + *
>> + *   argv[1] - original file object name (or empty)
>> + *   argv[2] - file in branch1 object name (or empty)
>> + *   argv[3] - file in branch2 object name (or empty)
>> + *   argv[4] - pathname in repository
>> + *   argv[5] - original file mode (or empty)
>> + *   argv[6] - file in branch1 mode (or empty)
>> + *   argv[7] - file in branch2 mode (or empty)
>> + *
>> + * Handle some trivial cases. The _really_ trivial cases have been
>> + * handled already by git read-tree, but that one doesn't do any merges
>> + * that might change the tree layout.
>> + */
>> +
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "lockfile.h"
>> +#include "merge-strategies.h"
>> +
>> +static const char builtin_merge_one_file_usage[] =
>> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
>> +	"<orig mode> <our mode> <their mode>\n\n"
>> +	"Blob ids and modes should be empty for missing files.";
>> +
>> +static int read_mode(const char *name, const char *arg, unsigned int *mode)
>> +{
>> +	char *last;
>> +	int ret = 0;
>> +
>> +	*mode = strtol(arg, &last, 8);
>> +
>> +	if (*last)
>> +		ret = error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
>> +	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
>> +		ret = error(_("invalid '%s' mode: %o"), name, *mode);
>> +
>> +	return ret;
>> +}
>> +
>> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct object_id orig_blob, our_blob, their_blob,
>> +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
>> +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
>> +	struct lock_file lock = LOCK_INIT;
>> +	struct repository *r = the_repository;
>> +
>> +	if (argc != 8)
>> +		usage(builtin_merge_one_file_usage);
>> +
>> +	if (repo_read_index(r) < 0)
>> +		die("invalid index");
>> +
>> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
>> +
>> +	if (!get_oid_hex(argv[1], &orig_blob)) {
>> +		p_orig_blob = &orig_blob;
>> +		ret = read_mode("orig", argv[5], &orig_mode);
>> +	} else if (!*argv[1] && *argv[5])
>> +		ret = error(_("no 'orig' object id given, but a mode was still given."));
> 
> Here, it looks as if the case of an empty `argv[1]` is not handled
> _explicitly_, but we rely on `get_oid_hex()` to return non-zero, and then
> we rely on the second arm _also_ not re-assigning `orig_blob`.
> 
> I wonder whether this could be checked, and whether it would make sense to
> fold this, along with most of these 5 lines, into the `read_mode()` helper
> function (DRYing up the code even further).
> 

Do you mean rewriting the first condition to read like this:

    if (*argv[1] && !get_oid_hex(argv[1], &orig_blob)) {

?

In which case yes, I can do that.

BTW the two lasts calls to read_mode() should be like

    err |= read_mode(…);

Cheers,
Alban

> As for the rest of the patch, it is totally possible that I missed a bug,
> but it looks correct to me, and the added regression tests give me a good
> feeling about the patch, too.
> 
> Thanks,
> Dscho
> 

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B4C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 09:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiBAJpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiBAJpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 04:45:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A5C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 01:45:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m4so52385240ejb.9
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KpHwjpBK3XGK1q6KR6bKlZjeEESuPli246X5MOVN0k8=;
        b=ORdwDHRHOyBer3RzJh7JJQHz9NymBY046Mn5GRVlheaOfIN3+etFCW4gtmpUSkeCSo
         EPNn38qeE+BcERsognA19zrYDsuf06SVqhVkh5QYkEW8vTlxFygJINXX4scZwzx+9aVr
         C2ul7t9oWA8HpXnRAIN8dldoMPRmuPHy3ddJZV11upxoqpf4dMRkCZWpyh66CjoLo6Zl
         TMIbGwPQ0sOlsVZGgBv75MywthPkM7gbn2rg0Oe7Nw2xQ2G6uxxMnBKy0Wv9qZSt9mKa
         6S1r27J3k099mzGGukTPPqG5QjdXh3ftalXJaEH83VwbiEBhDngvX8P2NZwQncMeqxU6
         fKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KpHwjpBK3XGK1q6KR6bKlZjeEESuPli246X5MOVN0k8=;
        b=BVkCYzY40HJvJi9GG9IaO4p8D+WM4QapbhBBhQnjG/HF/KOtQIfZuLVhIeyh8FfCOf
         lFhIi0qSOVgBGv7LOt6e5GNAh5Y5X+huepj8mX35rLuvTFrKF2rFSEj4W7HPq3cPwLBM
         eDPHhMgsLwEZfpL2pBkibYN1LYSCAb9J9bc7uIT8GICQ4PiKhhWv7S2EeOyeSvzkMeVO
         qHSVsO1Nrk+6rqIDHvTfYiY42e23iSez8SEK5eQXYxo1YAhmMMfjxL4QZdFArAJUV4I6
         qf3+SwEFFPHIbD7Z5l2TwD65odFsP9SywwxWQ+Mx0OEZxU2LY++J8d0+wGdDh8BEOykS
         J/lQ==
X-Gm-Message-State: AOAM5339F9MFInYJY5C00YPh05f9aysoIa0VBDJYkC8z83lh1ULW4VKF
        tXclUxScjXldeZz2yi3zyqIBJyi5LkM=
X-Google-Smtp-Source: ABdhPJwvggwxNVvcuRfyYFy5tbKFzN1BIV075z6NJ/nIBAgwz4fKV+J/tDR+hXpOm8AghfhmMtZhCQ==
X-Received: by 2002:a17:907:3fa5:: with SMTP id hr37mr20876729ejc.690.1643708732512;
        Tue, 01 Feb 2022 01:45:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l3sm14211617ejg.44.2022.02.01.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 01:45:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEpj8-003yTK-Ui;
        Tue, 01 Feb 2022 10:45:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 02/10] log: clean unneeded objects during `log
 --remerge-diff`
Date:   Tue, 01 Feb 2022 10:35:41 +0100
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
 <f06de6c1b2fbd5c5a23b6755197a3683c7d18d2f.1642792341.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <f06de6c1b2fbd5c5a23b6755197a3683c7d18d2f.1642792341.git.gitgitgadget@gmail.com>
Message-ID: <220201.86v8xyapj9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> @@ -944,7 +945,12 @@ static int do_remerge_diff(struct rev_info *opt,
>  	strbuf_release(&parent1_desc);
>  	strbuf_release(&parent2_desc);
>  	merge_finalize(&o, &res);
> -	/* TODO: clean up the temporary object directory */
> +
> +	/* Clean up the contents of the temporary object directory */
> +	if (opt->remerge_objdir)
> +		tmp_objdir_discard_objects(opt->remerge_objdir);
> +	else
> +		BUG("unable to remove temporary object directory");

Re the die in 1/10 I don't think this will ever trigger the way this bug
suggests.

If we didn't manage to remove the directory that'll be signalled with
the return code of tmp_objdir_discard_objects() which you're adding
here, but which doesn't have a meaningful return value.

So shouldn't it first of all be returning the "int" like the
remove_dir_recursively() user in tmp_objdir_destroy_1() makes use of?

What this bug is really about is:

    BUG("our juggling of opt->remerge_objdir between here and builtin/log.c is screwy")

Or something, because if we failed to remove the director(ies) we'll
just ignore that here.

> +void tmp_objdir_discard_objects(struct tmp_objdir *t)
> +{
> +	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
> +}

I skimmed remove_dir_recurse() a bit, but didn't test this, does this
remove just the "de/eadbeef..." in "de/eadbeef..." or also "de/",
i.e. do we (and do we want) to keep the fanned-out 256 loose top-level
directories throughout the operation?

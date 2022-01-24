Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B712C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 10:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiAXKCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiAXKCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 05:02:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B76C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:02:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r10so24553518edt.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GsrE6fpgwAaT4NqpRUPwZbcXmAcc/xXGmQwzkMd7MTY=;
        b=ZPsWviINRsqh8IBdcjxTn2xbKN7eMKcJ3zidYm7BbntXyC/D8ilvhQNOEFKWYueLml
         lzs4hnwFUTHb/e5wtoIfLL03IPhRpwiuYmf1shbD1afBG+AP8bXfF5FZsguwxqukN2G6
         YJEQ/BtYFL8QO4a5W4MGpoQ5NqColUG70SDkWM1QF4r0zNlYLbmcnNudFd+kCrAhL6Km
         +owR6xsOfFberGvZtOKF9f44lJ0ph0qGgHJkClnw9VVdB/CnqgAHlVrnr3cYqlUjz5sq
         poTtdgbrT3G40CUPxEm/hIjFHfJaWJ/Yspen5DLl/mXKJq7xjneFsSmxNr+F5kAOjWuu
         Hz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GsrE6fpgwAaT4NqpRUPwZbcXmAcc/xXGmQwzkMd7MTY=;
        b=Svup8Qb5OxL8wQSpGty+TTyW8DDiy6QZj2F3U3QKPTK052JlnH4o8HCMo8+GeO1t+2
         WtATAHRitG6hZDwwmoKgbKm+TdRH6/LjLCKssFOzv2Y7xLgQZn8vzZZkY1NTN8T202OV
         oKST3VUDHart+nm3cf18nDIE+Lshf7cwpSRpttqYdUTpWW+n466r2/i+jG5WatYhCjg2
         CVJBhU4TJo73HmWclPtUJmyAslKZK8/iTP6fgeeAsYBT7TWDWhqQYQEbQPs2h/BfukNM
         kaAyBiVE4GHT+3Kyi2Gmjq+cY16KiG9fu4+20KjRrod7u5jWhGgELuubfCt6f1Vys8js
         Y0Ow==
X-Gm-Message-State: AOAM5305A/hAKUC+LVbEUGmYc3UrI0Ymq5LJ7Dov0ybbsGIiu/6ELIH4
        ztPcZ1h5+POsTKT/yHlwGsu49aZzchM=
X-Google-Smtp-Source: ABdhPJwV/zNFC/PIiDE8oDHCuQILMjPgfgMLP2VLNpogcMNoP0yr8/LXnoxj6C8l9tKL4JxiqKKCLQ==
X-Received: by 2002:a50:8d05:: with SMTP id s5mr15447866eds.251.1643018539349;
        Mon, 24 Jan 2022 02:02:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f19sm1629334edu.22.2022.01.24.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:02:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBwAy-002QP1-RE;
        Mon, 24 Jan 2022 11:02:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have
 conflicts
Date:   Mon, 24 Jan 2022 11:01:28 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <220124.868rv5ih93.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Callers of `git merge-tree --write-tree` will often want to know which
> files had conflicts.  While they could potentially attempt to parse the
> CONFLICT notices printed, those messages are not meant to be machine
> readable.  Provide a simpler mechanism of just printing the files (in
> the same format as `git ls-files` with quoting, but restricted to
> [...]
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 560640ad911..d8eeeb3f306 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -11,6 +11,9 @@
>  #include "blob.h"
>  #include "exec-cmd.h"
>  #include "merge-blobs.h"
> +#include "quote.h"
> +
> +static int line_termination = '\n';

But unlike ls-files we don't do anything with line_termination as a !=
'\n', maybe in a later commit?

>  struct merge_list {
>  	struct merge_list *next;
> @@ -395,7 +398,8 @@ struct merge_tree_options {
>  };
>  
>  static int real_merge(struct merge_tree_options *o,
> -		      const char *branch1, const char *branch2)
> +		      const char *branch1, const char *branch2,
> +		      const char *prefix)
>  {
>  	struct commit *parent1, *parent2;
>  	struct commit_list *common;
> @@ -449,6 +453,22 @@ static int real_merge(struct merge_tree_options *o,
>  		o->show_messages = !result.clean;
>  
>  	printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +	if (!result.clean) {
> +		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
> +		const char *last = NULL;
> +		int i;
> +
> +		merge_get_conflicted_files(&result, &conflicted_files);
> +		for (i = 0; i < conflicted_files.nr; i++) {
> +			const char *name = conflicted_files.items[i].string;
> +			if (last && !strcmp(last, name))
> +				continue;
> +			write_name_quoted_relative(
> +				name, prefix, stdout, line_termination);

But here it's never \0 or whatever.

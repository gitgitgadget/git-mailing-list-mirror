Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83349200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEFXlt (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:41:49 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44078 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEFXls (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 19:41:48 -0400
Received: by mail-wr0-f173.google.com with SMTP id y15-v6so14789810wrg.11
        for <git@vger.kernel.org>; Sun, 06 May 2018 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kz1g0a1YX8UHRGGsT5HzStCgOMtxXooJ4/YCySB+OzA=;
        b=nu4DOcgSiNYZDnDGeweKcKErKLyHruWctcpiOn1CaztpUxWaeg03XCEZHCx2/0evD0
         6R5gXNrYAGTnBtfYoKDN9urdJRS7JajhbR0J/77viip3e9lC9Lq6WPazcRM20NW5oXbK
         6u9p1hUdkO8sKyJ9knCF4qZSu6YXrmzGqit+sX23YDmc3DeVknwt8miFDIEMZrddukSn
         gGe2ToJXeJc2bFLbVGMTLQqxxPRAmzQCAgcMxArLlGrNVSxJq/+DQJzz1YUSC1+hHeBQ
         ghUNewLRwjuzdv1mi19xVJWosqYXSLPAnLNmG8/LLnRO21taVM5bjw5IIDrYiAkePE+5
         gCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kz1g0a1YX8UHRGGsT5HzStCgOMtxXooJ4/YCySB+OzA=;
        b=K5Md7vb0QJWFlNSAsOhMiQUgIgeOxForH0Lf4obqiL8EQ6dvA9tbCHW3j3Q3MeCU9e
         yQS7Y0/H/1XUYddOiGE0Oi7MfLZymlCA1dTdzY/L9xkfNjmF5uuUpI+U4/Z76o0GvwPi
         WFwsA5TNP5JOigs/cUxotVSuopuQxTYrwI4WSFyMFilD6mhWZ0WdirNYRbKeSYc961Bm
         XJ/YL3AaNzsXZCYErTtir/lWy77KS9pMK2vg/GXj5/STbpIEV0Hme15Zur9FSFW0pn38
         d3epCPeEoEqlw9k/djl8QBVrbnK5J/ZL7RAWAyrh8pqJAdldRFa3+vz3Fj00p7N6eHdb
         yiOw==
X-Gm-Message-State: ALQs6tA48bHjpz5xpRseVqI81wNCRSC/fyWAYjO/819pDqCVwr2tBc0B
        ho8yecgHc3N7ZQctO4YnnIg=
X-Google-Smtp-Source: AB8JxZpAyxxIo/j9A+uNPgKv9z9aaEfX06kPbZBRCp/TAoCBmFNBGbgDJxTW/GB8vLXx3RSM5ae35A==
X-Received: by 2002:adf:b685:: with SMTP id j5-v6mr29029726wre.10.1525650107160;
        Sun, 06 May 2018 16:41:47 -0700 (PDT)
Received: from localhost.localdomain (x4db290cc.dyn.telefonica.de. [77.178.144.204])
        by smtp.gmail.com with ESMTPSA id m134-v6sm9357985wmg.13.2018.05.06.16.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 16:41:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v10 18/36] merge-recursive: add get_directory_renames()
Date:   Mon,  7 May 2018 01:41:37 +0200
Message-Id: <20180506234137.3414-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.563.g5f538d38fa
In-Reply-To: <20180419175823.7946-19-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-19-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 30894c1cc7..22c5e8e5c9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c

> +static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
> +					     struct tree *tree)
> +{
> +	struct hashmap *dir_renames;
> +	struct hashmap_iter iter;
> +	struct dir_rename_entry *entry;
> +	int i;
> +
> +	/*
> +	 * Typically, we think of a directory rename as all files from a
> +	 * certain directory being moved to a target directory.  However,
> +	 * what if someone first moved two files from the original
> +	 * directory in one commit, and then renamed the directory
> +	 * somewhere else in a later commit?  At merge time, we just know
> +	 * that files from the original directory went to two different
> +	 * places, and that the bulk of them ended up in the same place.
> +	 * We want each directory rename to represent where the bulk of the
> +	 * files from that directory end up; this function exists to find
> +	 * where the bulk of the files went.
> +	 *
> +	 * The first loop below simply iterates through the list of file
> +	 * renames, finding out how often each directory rename pair
> +	 * possibility occurs.
> +	 */
> +	dir_renames = xmalloc(sizeof(struct hashmap));

Please use xmalloc(sizeof(*dir_renames)) instead, to avoid repeating the
data type.

> +	dir_rename_init(dir_renames);
> +	for (i = 0; i < pairs->nr; ++i) {
> +		struct string_list_item *item;
> +		int *count;
> +		struct diff_filepair *pair = pairs->queue[i];
> +		char *old_dir, *new_dir;
> +
> +		/* File not part of directory rename if it wasn't renamed */
> +		if (pair->status != 'R')
> +			continue;
> +
> +		get_renamed_dir_portion(pair->one->path, pair->two->path,
> +					&old_dir,        &new_dir);
> +		if (!old_dir)
> +			/* Directory didn't change at all; ignore this one. */
> +			continue;
> +
> +		entry = dir_rename_find_entry(dir_renames, old_dir);
> +		if (!entry) {
> +			entry = xmalloc(sizeof(struct dir_rename_entry));

Similarly: xmalloc(sizeof(*entry))


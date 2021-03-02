Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3206C433E9
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C6564F20
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575639AbhCBPXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhCBEHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 23:07:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D4EC0617A7
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 20:06:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z12so11065838pga.11
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 20:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LZeUHYb525h+NH0lsX8H8uJaBMTxC+OJeWrZmehul1A=;
        b=pwwgku4EjamWw/jmp0Ew2y+Ijvw5ovdqWvekGsttgiOopA69A2WY9EwFUfwmemOOoj
         6PXVANttUJmmXtgwYrnjOUu+tlTHa+M3VGyBBCrhRyGIBQ5bcBW/Uq1rxal0rG/qUuGu
         +O8QlddJxIDUzJMLeZGzi7pfXAfYSCNtbQDB4jL/V7pFJFRlJNqa465q6eXcehn0FP1C
         WamPYJxfU44zec2Xq0nQJ5hM3VjOyOjEfv3GD2ZZXg+QDlD9kIcjhqpcApXa5df+WK33
         XQkRVR4N3BOF+I4n6YV93qEqETEN3RSsNvIx5bknGP22fUphTVKR1uYQlsEO0HfbajjF
         woqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LZeUHYb525h+NH0lsX8H8uJaBMTxC+OJeWrZmehul1A=;
        b=eJFWDOQlheCw3o9n9lGcEmDqA1FJurKRlDMzkpBnJWDW61d88nX2qO8EtTvKawBcGd
         AmX/Z8CyBbJHlpm5rO8nzlRBRk1LXthZydCxXu/F/9Fxm3p1UbwezsE5g6goT/l/OIJm
         0za+kfM9jD9OysajRPuuLqGCAGV8GfRqfX4GJczjIofemwhb0B/0mqyyb/UuBgbsDJJj
         boNaYn//y0VG1HjzmJrkeIB/hwK3Qv6dCkv7k9sTTeNLDhMvffVwoPaasrMPUMWzoWbn
         nRq4ml+xYd7jNEom4eiHEjFrLHk8Kok+PDsWG/J2sfcBkefFsv+0jhd8/8gRVQLEewzv
         3pHw==
X-Gm-Message-State: AOAM530w1IVj2hSECQin0fLJetKSgYijZBXJs1n2deGOeQ6XgZyachkn
        fNvyP8IUZ8pdb+fGb5SxGjNzQXf9nVmWPScoI+YD
X-Google-Smtp-Source: ABdhPJy/gosvUuuyxxJoEuAgy9ievf9lRYTX1yHoXVlBhEINDaYdGh6CDFa7IGQCXz6j9KaG8unqM7isBuv1OgBuCCod
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:9905:: with SMTP id
 b5mr2194356pjp.195.1614657987451; Mon, 01 Mar 2021 20:06:27 -0800 (PST)
Date:   Mon,  1 Mar 2021 20:06:25 -0800
In-Reply-To: <bc42b56ea2c3ac7ead1cad2a95ac01a7adfbb28f.1614193703.git.me@ttaylorr.com>
Message-Id: <20210302040625.4035284-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <bc42b56ea2c3ac7ead1cad2a95ac01a7adfbb28f.1614193703.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 04/15] builtin/multi-pack-index.c: split sub-commands
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index eea498e026..caf0248a98 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -5,17 +5,33 @@
>  #include "midx.h"
>  #include "trace2.h"
>  
> +static char const * const builtin_multi_pack_index_write_usage[] = {
>  #define BUILTIN_MIDX_WRITE_USAGE \
>  	N_("git multi-pack-index [<options>] write")
> +	BUILTIN_MIDX_WRITE_USAGE,
> +	NULL
> +};

I think this way of writing is vulnerable to confusing errors if a
missing or extra backslash happens, so I would prefer the #define to be
outside the variable declaration.

> +static int cmd_multi_pack_index_repack(int argc, const char **argv)
> +{
> +	struct option *options;
> +	static struct option builtin_multi_pack_index_repack_options[] = {
>  		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
>  		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
>  		OPT_END(),
>  	};
>  
> +	options = parse_options_dup(builtin_multi_pack_index_repack_options);
> +	options = add_common_options(options);

I looked for where this was freed, but I guess freeing this struct is
not really something we're worried about (which makes sense).

The other patches up to this one look good.

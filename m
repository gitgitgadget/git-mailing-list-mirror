Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB97FC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 09:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiL2JDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2JDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 04:03:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064210FE5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 01:03:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v23so18605683pju.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqBAPt6jG8+yzqEAWhOut7/xg7ELJQMKzOuWvkzmrl0=;
        b=qrsEhuzDTf7LDtm5H4PT272PKDR0JVWqwF3ZFGIS0fqK8/9TWcqLQz1MDQZvizAOmf
         JkoVXtnF4Dmvru7hz84lv3jhFIg+LRQf3uY0+ePw3DLpwABp9ObiNR8iDrRkHeQ9AOzB
         oXVOFR9YrAxOPTgPfoJBXK23oc9STKwsGVhYvJ0w3n26awgqWx5OVzqeiwErUbQJix/D
         5hb7VnglAi16x49dO0xlBvd6Ddb57a9BKj98ZAlyXeM9BDHWjSYw56lR6rJ3w1qdWkiy
         82V39YQs/KR85R2C7MalxcAwLKddpTIhzi0SsQv6gX06a6Bo+AJ6sxbJWOSndGYSWiFa
         QaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqBAPt6jG8+yzqEAWhOut7/xg7ELJQMKzOuWvkzmrl0=;
        b=t3GTjOCRgBGFR/XiwxZkZ0xVSDmsvfgq4IWEOfspOlIOUVV9enTBZwfRsovFj9bff6
         cB9JYFVY9u91GJ8/lB8XFCmzGrAP3Yh8HL7/pc0HQA5Qb/xOpcOwTmIMAkakaJFWGMcM
         eK5lk5jTRqyHXO1ypRO838rn6r97ve4YKpoLYgrAH97jEtV15oYQ5iMMIIQ5FhK6L2BG
         L3XnKhYEeJQq0CrPgUKJFmoms0HrsSbBjQr0eZM01OtIXIEYPWiLLmFqnPlMLVCQD3Me
         eHlJbPd/2TqF5JZm5qlKeynzmNFpNJGmSs4OBxBjrRUd+jQCfPdFBBPlCzFSP0c5mWuN
         9CQA==
X-Gm-Message-State: AFqh2kqOVbvARBI/Xpcmx36R8McwzkLGbltbdkKH5xX3r680xNE6e8H8
        gvTOgHCtZ8KjNPl+Y0lua5LQshM6yHAyEg==
X-Google-Smtp-Source: AMrXdXsuq1G9XhGXa0r/EKJ08tYLed+L0cfCUaRnjP9rojxsdbAh+rRn8FsaCz4JNv3pcQtZB0J3yg==
X-Received: by 2002:a17:902:b613:b0:18f:98bb:c08e with SMTP id b19-20020a170902b61300b0018f98bbc08emr28011609pls.36.1672304579705;
        Thu, 29 Dec 2022 01:02:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b00186b3c3e2dasm12412975plh.155.2022.12.29.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:02:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/20] clone: use free() instead of UNLEAK()
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
        <patch-05.20-49e6714939d-20221228T175512Z-avarab@gmail.com>
Date:   Thu, 29 Dec 2022 18:02:59 +0900
Message-ID: <xmqqk02amvjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
> pointers when finished, 2021-03-14) to use a "to_free" pattern
> instead. In this case the "repo" can be either this absolute_pathdup()
> value, or in the "else if" branch seen in the context the the
> "argv[0]" argument to "main()".
>
> We can only free() the value in the former case, hence the "to_free"
> pattern.

Many other patches in the series, especially the ones that touch the
library-ish parts that can be called unbounded number of times, do
make sense, but this patch helps nobody.  Not even the leak checker,
who should already be happy with the existing UNLEAK() marking.  The
only thing it does is to free() a piece of memory obtained from a
one-time allocation that will be discarded upon program exit anyway.

If this were a freestanding patch done outside any series, I would
probably have not bothered to queue it.  I'll be queuing as part of
the larger whole, but I am not all that impressed by this step and
the thinking that led to its inclusion in the series.

Thanks.




>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f518bb2dc1f..48156a4f2c2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -892,6 +892,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int is_bundle = 0, is_local;
>  	int reject_shallow = 0;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
> +	char *repo_to_free = NULL;
>  	char *path = NULL, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
>  	const struct ref *refs, *remote_head;
> @@ -949,7 +950,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	path = get_repo_path(repo_name, &is_bundle);
>  	if (path) {
>  		FREE_AND_NULL(path);
> -		repo = absolute_pathdup(repo_name);
> +		repo = repo_to_free = absolute_pathdup(repo_name);
>  	} else if (strchr(repo_name, ':')) {
>  		repo = repo_name;
>  		display_repo = transport_anonymize_url(repo);
> @@ -1392,7 +1393,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	free(unborn_head);
>  	free(dir);
>  	free(path);
> -	UNLEAK(repo);
> +	free(repo_to_free);
>  	junk_mode = JUNK_LEAVE_ALL;
>  
>  	transport_ls_refs_options_release(&transport_ls_refs_options);

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA9ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 17:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiIARRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIARRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 13:17:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D00F52DE7
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 10:17:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b196so7289279pga.7
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=FLV4D1gK4d2NrvdrwliOXNy3DgvlAif2rLVi5PMETVQ=;
        b=TE/hhQVqUkwInZbydrHIrJxG1vsp1m+3yP7cVhIkH+D3HHT8zBbHPq6OXKGxshtI4V
         TL8pq91A3dIzKI7d1Xv+IB9TiTBnafCd5NECuycxA1kd0WTLeljBmk7s0cSyKWdAbiLH
         cCv5IS8q1T1Hj/kRh0MrriG9HbstZ5GCrztiqaS/89wT8IaMgJa1zIkiZU8zC7oGRnMc
         aUHL1ow7x0Kd67Z6ddA/5VXzZIGmn/RAHyoZWzMMUhNOl4ZCcsyYaY/ICHFLkNHq3J7b
         OUP5WtfG76DyClcDOAzqvMIev1NH9Pz6I/8emvUZyBnhBQGKZA6aqmwoVExlFpejASl6
         3pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=FLV4D1gK4d2NrvdrwliOXNy3DgvlAif2rLVi5PMETVQ=;
        b=lndGJuR0WKe9RHOqCw2G2KCHoxlsvUYNwfcFLoZEPmJORaHVDOQXIM4UsluLA0iO5U
         E0nfv5Jy4LBNi02kUcvMZM+GV4/KzuQShcclCjSZL2wgxd8YCO8ltv8A61rppsFidDKJ
         UU+yuJVYU+CjWMI9CN7CFgvXP3XhdZ7h77HSqLfL38y0ORmSpBN6uP2Zd2DxgMVbWz2f
         5m3wyneCWJr+ksLvYW1drdQkCUOCtr/A25OFLOCYSFa+SotXYjfb07TCmeDdJT6cZjyf
         VWLUr0hRTtxFq9I+vFCplntPMpat2EsSGd0pWWITX9MnfWXGmbO8MSx5kul0T5DnJHpY
         jYmg==
X-Gm-Message-State: ACgBeo36U/91m8ofZOMNJMxNffTT6VOR/lSrGP1jpvxvOZUN4YDe6xMJ
        Z+lhkAogLOhnmEK9vyn+1K8=
X-Google-Smtp-Source: AA6agR73cMm6lcsNiyDw6c/gidJjymdkjZ2wmzG9refMqFhBMy9sZQ3wo6taJwkGVPspo74AvvPPCw==
X-Received: by 2002:a63:84c2:0:b0:42b:f6bc:69f5 with SMTP id k185-20020a6384c2000000b0042bf6bc69f5mr18554340pgd.10.1662052657705;
        Thu, 01 Sep 2022 10:17:37 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b00172951ddb12sm14354513plg.42.2022.09.01.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:17:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
        <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
Date:   Thu, 01 Sep 2022 10:17:36 -0700
In-Reply-To: <20220901045736.523371-4-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Wed, 31 Aug 2022 21:57:36 -0700")
Message-ID: <xmqqpmgf9fpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Before this patch, whenever --sparse is used, `git-grep` utilizes the
> ensure_full_index() method to expand the index and search all the
> entries. Because this method requires walking all the trees and
> constructing the index, it is the slow part within the whole command.
>
> To achieve better performance, this patch uses grep_tree() to search the
> sparse directory entries and get rid of the ensure_full_index() method.

When you encounter a "sparsedir" (i.e. a tree recorded in index),
you should know the path leading to that directory. Even though I no
longer remember the details of the implementations of grep_$where()
which I did long time ago, I think grep_tree() should know how to
pass the leading path down, as that is the most natural way to
implement the recursive behaviour.  This patch should be able to
piggyback on that.

> @@ -537,8 +534,26 @@ static int grep_cache(struct grep_opt *opt,
>  
>  		strbuf_setlen(&name, name_base_len);
>  		strbuf_addstr(&name, ce->name);
> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
> +			enum object_type type;
> +			struct tree_desc tree;
> +			void *data;
> +			unsigned long size;
> +			struct strbuf base = STRBUF_INIT;
> +
> +			strbuf_addstr(&base, ce->name);
> +
> +			data = read_object_file(&ce->oid, &type, &size);
> +			init_tree_desc(&tree, data, size);
>  
> +			/*
> +			 * sneak in the ce_mode using check_attr parameter
> +			 */
> +			hit |= grep_tree(opt, pathspec, &tree, &base,
> +					 base.len, ce->ce_mode);

OK.  Instead of inventing a new "base" strbuf, we could reuse
existing name while running the grep_tree() and restore it after it
returns, and I suspect that the end result would be more in line
with how grep_cache() uses that "name" buffer for all the cache
entries.  But that is not a correctness issue (it is move about
preventing from making the code worse).

> @@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  		int te_len = tree_entry_len(&entry);
>  
>  		if (match != all_entries_interesting) {
> -			strbuf_addstr(&name, base->buf + tn_len);
> +			if (S_ISSPARSEDIR(check_attr)) {
> +				// object is a sparse directory entry

No // comments, please.

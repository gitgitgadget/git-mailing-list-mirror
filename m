Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05AC4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiDEJx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349159AbiDEJtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177D5FB2
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:41:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g22so14220291edz.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mBPFmh2pZMOO6Bp1u/neLH+9HSKC91UK2ApUGK1SqaY=;
        b=H9vpBXUrfTMtUJtwwm8BuDUFtBkpAyWnNm1omVLp7nelug7/Z08Vr8G4rX0IVLL040
         te24q2fm202nuuKOyo+hhAWe5P92fR2YOIOiE4e60vR85/qBLt6/ZPQv6yLpVxq88ypb
         nZ43RpfYSyin58zWcJNp+r+sYdau8mDoVeKI0vf8BOfMg8U8ln1cwDh6zviKSxZW0XhO
         2uqZqL7WbSuN215khvLPtpEi7RBxgCTzKflYPqP5ZHvsz1dhio9oDEdDo3dSibn6WX55
         B6WHu6AqXSjo5LOYwGGbbVcYYYB93CQMCSU76JOcf1K87nFS85r/5WW6lPVuPZQkkKmp
         e71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mBPFmh2pZMOO6Bp1u/neLH+9HSKC91UK2ApUGK1SqaY=;
        b=HbyZBIQImeMftbA/lr8T7UlM1BS+/fvAQLpYG4e4f8g0ZIO2byTZKG7pCikXLsQ6c3
         rDNJY/3qsCAvxS7dLm32XwHtNx4OS7Ac/m7A8X3s58ATiYFKIM0QIHce20rX+95N6cWL
         eiyACgcwUo/7yWWRxDzwjl34bZkB1qcuVvJgGTH27HIprB8/KyBuurkSTdXsUQpd1MM0
         bO66at50jVzrYpg4IdZo/3z23XhUI8vguv4xOpp9C9O06kIbpFxCzibuFgVYqClrAlsT
         ozrVeW7t2pld1kjcmXnXOnfBKi8e6PUbujogK7+mDCiYzlSybD1yFSFhIBHpGyE4jpbg
         LGJg==
X-Gm-Message-State: AOAM530yhK7rNgw4NhkU0stGDL/dEuJ4qgBH31fZmhq3hvaHA/cyLqV5
        68fvYd2lKiCx4j+zwUGj+VlG9NDznnqGYg==
X-Google-Smtp-Source: ABdhPJxtSkJm4Gsku/X7gyy161GWIxJ0Cjs5IrDYA+HphthgQmwd11t7p/qeCrRcNzvWQlrknFon9A==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr2643113edz.114.1649151704071;
        Tue, 05 Apr 2022 02:41:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm6182489edb.39.2022.04.05.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:41:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbfh0-002sFs-Ug;
        Tue, 05 Apr 2022 11:41:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] blame: report correct number of lines in progress
 when using ranges
Date:   Tue, 05 Apr 2022 11:36:05 +0200
References: <20220404182129.33992-1-eantoranz@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220404182129.33992-1-eantoranz@gmail.com>
Message-ID: <220405.86o81flve1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Edmundo Carmona Antoranz wrote:

> When using ranges, use their sizes as the limit for progress
> instead of the size of the full file.
>
> Before:
> $ git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines:  10% (122/1210), done.
> $
>
> After:
> $ ./git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines: 100% (122/122), done.
> $
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/blame.c  |  6 +++++-
>  t/t8002-blame.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8d15b68afc..e33372c56b 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	unsigned int range_i;
>  	long anchor;
>  	const int hexsz = the_hash_algo->hexsz;
> +	long num_lines = 0;
>  
>  	setup_default_color_by_age();
>  	git_config(git_blame_config, &output_option);
> @@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	for (range_i = ranges.nr; range_i > 0; --range_i) {
>  		const struct range *r = &ranges.ranges[range_i - 1];
>  		ent = blame_entry_prepend(ent, r->start, r->end, o);
> +		num_lines += (r->end - r->start);
>  	}
> +	if (!num_lines)
> +		num_lines = sb.num_lines;
>  
>  	o->suspects = ent;
>  	prio_queue_put(&sb.commits, o->commit);
> @@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	sb.found_guilty_entry = &found_guilty_entry;
>  	sb.found_guilty_entry_data = &pi;
>  	if (show_progress)
> -		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
> +		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
>  
>  	assign_blame(&sb, opt);

Looking good.

> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index ee4fdd8f18..151a6fddfd 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -129,6 +129,34 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
>  	test_must_fail git blame --exclude-promisor-objects one
>  '
>  
> +test_expect_success 'blame progress on a full file' '
> +	cat >progress.txt <<-\EOF &&
> +	a simple test file
> +
> +	no relevant content is expected here
> +
> +	If the file is too short, we cannot test ranges
> +
> +	EOF
> +	git add progress.txt &&
> +	git commit -m "add a file for testing progress" &&

Let's just skip this then and use existing test setup. A quick glance at
the state after this test shows that e.g. the "hello.c" we already
created would be a good candidate.

> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress progress.txt > /dev/null 2> full_progress.txt &&
> +	grep "Blaming lines: 100% (6/6), done." full_progress.txt

Let's use test_cmp here instead, as we expect nothing else on stderr,
and with grep one wonders why it's not ^$ anchored, but just:

    echo "Blaming lines: 100% (6/6), done." >expect &&
    git blame ... 2>actual &&
    test_cmp expect actual

is better, both because it's more exhaustive as a test, and because
it'll give better debug (diff) output on failure than grep will (just no
output at all).

> +test_expect_success 'blame progress on a single range' '
> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress -L 2,5 progress.txt > /dev/null 2> range_progress.txt &&
> +	grep "Blaming lines: 100% (4/4), done." range_progress.txt
> +'
> +
> +test_expect_success 'blame progress on multiple ranges' '
> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress -L 1,2 -L 4,6 progress.txt > /dev/null 2> range_progress.txt &&
> +	grep "Blaming lines: 100% (5/5), done." range_progress.txt
> +'

Style nit, no space after ">", so e.g. 2>err.

Also shorter names are easier to read, so just:

    [...] 2>err

Or "actual" per the suggestion above.

And no need to redirect stdout to /dev/null, it's helpful to see it by
default in the verbose test output, we let that take care of suppressing
all of it ornot.


>  test_expect_success 'blame with uncommitted edits in partial clone does not crash' '
>  	git init server &&
>  	echo foo >server/file.txt &&


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD5C4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 20:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiK1Upp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 15:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiK1Upo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 15:45:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DA10FD4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 12:45:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so104744577b3.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QA13FO+m7H6Hmc/cN508VLCr6CUiqHPr0BKJUMqzijQ=;
        b=TdddZCjnDHV9wKHmGqQot3OGWyhAASIx1jRGrttE0zQY7pkghQZKDG5MrfwNbfp9vY
         rxBht8IgV0HmbTl0ssh/z+yO8RdvKIeha4FHCAo/OhFAggrTHGdxNBz6Pgozz6FechQi
         2x0gCoyCi30WqcqQBFJbsmU2afmFCUuD3HUGmRKi6LfGd8pr4K14vBG4zWB3Z+dKND1E
         Y4PBWtO2mbClCFMttJA2ndOxxJNWeGwzlIMRelyGo5V0avIfiqH5++yW+1jtC9KZZ+zP
         8rD5OKbtIkGWIsfnnGg30lFSv2CHATdxp9M/FjC4/4kWNmu6kPF8I11PkYpcx1RuaVjf
         VDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA13FO+m7H6Hmc/cN508VLCr6CUiqHPr0BKJUMqzijQ=;
        b=eX72Zh8C2xkNdq/odJDr8yLxa2JiQTFltTImkzBQFjh/MCMSvQTMt0eQJ2jcNSbVF9
         31s+55dtbB/wL997Qb2eINN7hTRlB1iDPN1F9HzGvwkfRmw7MKR8cxNdfnOmecwGUuW3
         tRhdEeWKQLhsT33UqPq7bg1EPtNKeDLh03XJCQ7TYrAs4qZg1d0ho5dwLRbmQR0gpZk2
         XEe4KMkOqvZcm5NghdA2cTVNsZvh6ElawSuVdmf7gn79Msavs8o+S4+wqH2sg9RXggD8
         /O8chSECpCp71rVdrMWK5eVbIMc3HbiqoVCDrxmU5SAtFywJdk9vcreJ2D5GH/uzFMc2
         I1Jw==
X-Gm-Message-State: ANoB5pmLTjPpLhGhlb0erDSwUlIXUXwt933kQ6PxTENOCEI9HPKmaNSS
        pj5tat8hKAVhLOou9+OnWY3zGV4FBo0deW2G5Ym0
X-Google-Smtp-Source: AA0mqf4KnWWuUviFOg3oA8YopfEJ6+nAEVmT9WPSMGOWCQYwKMrU1dKcme45jQ46bP/i86w3sIj2bRHTCjRmpf5n8fl7
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:ec47:0:b0:390:c13a:a92a with
 SMTP id r7-20020a0dec47000000b00390c13aa92amr4ywn.282.1669668341945; Mon, 28
 Nov 2022 12:45:41 -0800 (PST)
Date:   Mon, 28 Nov 2022 12:45:38 -0800
In-Reply-To: <20221108184200.2813458-2-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128204538.2748977-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> +	if (opts->duplicate_output && opts->ungroup)
> +		BUG("duplicate_output and ungroup are incompatible with each other");

Thanks for spotting "ungroup" - that helps me to focus my review.

> @@ -1680,8 +1683,14 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  	for (size_t i = 0; i < opts->processes; i++) {
>  		if (pp->children[i].state == GIT_CP_WORKING &&
>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> -			int n = strbuf_read_once(&pp->children[i].err,
> -						 pp->children[i].process.err, 0);
> +			struct strbuf buf = STRBUF_INIT;
> +			int n = strbuf_read_once(&buf, pp->children[i].process.err, 0);
> +			strbuf_addbuf(&pp->children[i].err, &buf);
> +			if (opts->duplicate_output)
> +				opts->duplicate_output(&buf, &pp->children[i].err,
> +					  opts->data,
> +					  pp->children[i].data);
> +			strbuf_release(&buf);

[snip]

> Add duplicate_output_fn as an optionally set function in
> run_process_parallel_opts. If set, output from each child process is
> copied and passed to the callback function whenever output from the
> child process is buffered to allow for separate parsing.

Looking at this patch, since this new option is incompatible with "ungroup",
I would have expected that the new functionality be in a place that already
contains an "if (ungroup)", and thus would go into the "else" block. Looking at
the code, it seems like a reasonable place would be in pp_collect_finished().

Is the reason this is not there because we only want the output of the child
process, not anything that the callback functions might write to the out
strbuf? If yes, is there a reason for that? If not, I think the code would
be simpler if we did what I suggested. (Maybe this has already been discussed
previously - if that is the case, the reason for doing it this way should be in
the commit message.)

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3ecb830f4a..40dd329e02 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
>  	return 0;
>  }
>  
> +static void duplicate_output(struct strbuf *process_out,
> +			struct strbuf *out,
> +			void *pp_cb,
> +			void *pp_task_cb)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	string_list_split(&list, process_out->buf, '\n', -1);
> +	for (size_t i = 0; i < list.nr; i++) {
> +		if (strlen(list.items[i].string) > 0)
> +			fprintf(stderr, "duplicate_output: %s\n", list.items[i].string);
> +	}
> +	string_list_clear(&list, 0);
> +}
> +
>  static int task_finished(int result,
>  			 struct strbuf *err,
>  			 void *pp_cb,
> @@ -439,6 +454,12 @@ int cmd__run_command(int argc, const char **argv)
>  		opts.ungroup = 1;
>  	}
>  
> +	if (!strcmp(argv[1], "--duplicate-output")) {
> +		argv += 1;
> +		argc -= 1;
> +		opts.duplicate_output = duplicate_output;
> +	}

In the tests, can we also write things from the callback functions? Whether we think that callback output should be
duplicated or not, we should test what happens to them.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F28C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 06:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBMGfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 01:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBMGfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 01:35:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DE9010
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 22:34:59 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id ds10-20020a056a004aca00b0059c8629c220so5853113pfb.23
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 22:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ2YU96GAEnnLHdexHmLQ63MXFWOHK3Uc+z08r4nBU=;
        b=mTcJiCjP8eog/F9tNLIkESC7iPjCmajJ8BbW4m8Px71wMljqe5csNr+vkxUigee6gc
         VB+M5eH715c1v89H1pKbScD7ZqSfKeLUshsHssduYVhycI/eiWqQOBaCV2WzpsHytGIt
         qizdUwWO8/y6YXKXVY/9tBwzcRU7V0SQqtb7w/lxXUtyxua4RmBeeS79CWA/yWBDU/OK
         TDu17JcSoab6g1N1h/xAOpgLKN78WxPnCv4tz8pKEoeMRBtHcsc8u6Qc2XYg0OsYR3WV
         X5QDoapx//ji+KGdkqfk6fwLlJJkZ61RoyA6G5rvuSHNBLYHi87AXclwMYf0THR9feBo
         JnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlQ2YU96GAEnnLHdexHmLQ63MXFWOHK3Uc+z08r4nBU=;
        b=jsRz7lEvnEZFIvq/i/6X/c4lbGGv+RDU67866pOqNYtFVY200JiTbhH7kUwfoyG5Pz
         XweiYCis6YnwzAxTkvyX3BCaYc9Ade34EIgcSmjG+oL1hXWygkYN5oXa8//FrUpNiA/v
         MN1nrSozlTn51sFJ87jfnvkTqbIN6WQtnAiDK5ieXDHKcytfntmJGKNRepTZE3JrKhXa
         D4+s9/l1EC5Nzr+AjmCq/x5TRUvlGirGNHX3g6FPlccX5bUOFRbbBB/anjmAuMaoCIi6
         Eq4zPMKV7PU86fbWqZaywZxwTeBrNHwXKWO4AsROc+DvPSCkQUmb0Pd5F6YHg2Xx1Vux
         bJ4A==
X-Gm-Message-State: AO0yUKWES2x2jDum3yw2g9hMuRgiRPgIN+WhS1AkFH2Cby7jYfv8xa3X
        ScXaSNd6501spT4vqwnTsfAtoo9N2p4CRg==
X-Google-Smtp-Source: AK7set+lrt/pY56B5KCiorMMplQpxIMUIlCgTtxNiMtpOQAc8acHVZxdW+QchS5rFqH6wzl/OJ4wDq1IQGWmLw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:c950:b0:19a:9b8c:279f with SMTP
 id i16-20020a170902c95000b0019a9b8c279fmr621078pla.26.1676270098802; Sun, 12
 Feb 2023 22:34:58 -0800 (PST)
Date:   Mon, 13 Feb 2023 14:34:57 +0800
In-Reply-To: <20230209000212.1892457-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-2-calvinwan@google.com>
Message-ID: <kl6lo7pyax9q.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 1/6] run-command: add duplicate_output_fn to run_processes_parallel_opts
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -1645,14 +1650,19 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  	for (size_t i = 0; i < opts->processes; i++) {
>  		if (pp->children[i].state == GIT_CP_WORKING &&
>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> -			int n = strbuf_read_once(&pp->children[i].err,
> -						 pp->children[i].process.err, 0);
> +			ssize_t n = strbuf_read_once(&pp->children[i].err,
> +						     pp->children[i].process.err, 0);
>  			if (n == 0) {
>  				close(pp->children[i].process.err);
>  				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> -			} else if (n < 0)
> +			} else if (n < 0) {
>  				if (errno != EAGAIN)
>  					die_errno("read");
> +			} else if (opts->duplicate_output) {
> +				opts->duplicate_output(&pp->children[i].err,
> +					pp->children[i].err.len - n,
> +					opts->data, pp->children[i].data);
> +			}
>  		}
>  	}
>  }

What do we think of the name "duplicate_output"? IMO it made sense in
earlier versions when we were copying the output to a separate buffer (I
believe it was renamed in response to [1]), but now that we're just
calling a callback on the main buffer, it seems misleading. Maybe
"output_buffered" would be better?

Sidenote: One convention from JS that I like is to name such event
listeners as "on_<event_name>", e.g. "on_output_buffered". This makes
naming a lot easier sometimes because you don't have to worry about
having your event listener being mistaken for something else. It
wouldn't be idiomatic for Git today, but I wonder what others think
about adopting this.

[1] https://lore.kernel.org/git/xmqq4jvxpw46.fsf@gitster.g/

> +/**
> + * This callback is called whenever output from a child process is buffered
> + * 
> + * See run_processes_parallel() below for a discussion of the "struct
> + * strbuf *out" parameter.
> + * 
> + * The offset refers to the number of bytes originally in "out" before
> + * the output from the child process was buffered. Therefore, the buffer
> + * range, "out + buf" to the end of "out", would contain the buffer of
> + * the child process output.

Looks like there's extra whitespace on the 'blank' lines.


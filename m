Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95FC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBGWq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGWq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:46:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9537D9B
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:46:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa10so16316244ejc.9
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pqg1LH9FvYKNXU2luHahefeHtgwwN0hC9TqETawHzo=;
        b=kfB52DkymSU6ElIHMtcrWmkVgq30fJtAj7lIj/jAAbSHejrn+vnUY7Qd2Ls57sBrkp
         sfLrioVtV5SuTnvFIm9xsaIDy87rvHax7hieMdByxhAQowDbqxJs29wppNOI5hmQo6Dc
         Sfybmrs+D7jGmwjY64llNUaQ8QTU8j36XRN1mAJyHUit2JYcgwK/693BqLpdhc9MrkW+
         2S2VZzvljDMjU3YHa33SVCpd97cz6xQ5G68vcSImyk2GywB1N7p+7sDpVGBV2M79RO/3
         HGGmd+IBEWNTUXoMSUjT4N+ew+tnxAbHOTrXEEGkMVxR0rZbuxllc4YqbmH4EMgpHFvA
         vCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pqg1LH9FvYKNXU2luHahefeHtgwwN0hC9TqETawHzo=;
        b=hf/G9lBzBMh7vLa19cRf8MjMpn8O3g40OfvW7KmkLLXxSM/CPh43S34SuLBxsY4lvA
         Ih+mb3uEORmDta1R/4FjMyMRRYYCXKTpn9R5TkXkBMLLG+csmppVnYGc+6NNY5zuh7dI
         X+UknOuxrgLvG+Rv+quUzB2zdALMXYkyossJCAFPt0A351v3iGRBk8EAZZEgQPa8S0rb
         iNRMfCTzZ835eCaxIJcNap9D9djR0tU8dWXfcPKBRbcybHRKRQwKsUokqYnhCZC0zQJO
         J/nxSpQXth2Vxvj2hE4LXAwzhzfDyTTUSGK+1EK7EJdykfsIRR88Alkkl5jYZvsQS6cU
         Qycw==
X-Gm-Message-State: AO0yUKVblr63mG8qKmOJrOs64d8HuDho0HqyPrfydnntmLQiVFDTSy/Q
        1GFP5McBjIrw2bRDuRg8VYCbedL26yyvP0F6
X-Google-Smtp-Source: AK7set8BD1/K0LDwaKan6pvUU8cNCP12ddSmYr7kUB1CIIOCRbkLAW9KB/yE1Pk+X7AIVnZs2Ntz1Q==
X-Received: by 2002:a17:906:1249:b0:88b:4962:b72f with SMTP id u9-20020a170906124900b0088b4962b72fmr5110203eja.20.1675809982343;
        Tue, 07 Feb 2023 14:46:22 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906149000b00889c115cf6asm7461395ejc.145.2023.02.07.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:46:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPWjF-0013oz-0X;
        Tue, 07 Feb 2023 23:46:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 1/7] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Date:   Tue, 07 Feb 2023 23:16:20 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-2-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-2-calvinwan@google.com>
Message-ID: <230207.86y1p914ci.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> diff --git a/run-command.c b/run-command.c
> index 756f1839aa..cad88befe0 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1526,6 +1526,9 @@ static void pp_init(struct parallel_processes *pp,
>  	if (!opts->get_next_task)
>  		BUG("you need to specify a get_next_task function");
>  
> +	if (opts->duplicate_output && opts->ungroup)
> +		BUG("duplicate_output and ungroup are incompatible with each other");
> +
>  	CALLOC_ARRAY(pp->children, n);
>  	if (!opts->ungroup)
>  		CALLOC_ARRAY(pp->pfd, n);

A trivial request, not worth a re-roll in itself: The "prep" topic[1] I
have for Emily's eventual config-based hooks doesn't need to add new
run-command.c modes that are incompatible with ungroup, but that happens
in the next stage of that saga.

When I merge your topic here with that, the end result here is:

	if (opts->ungroup) {
		if (opts->feed_pipe)
			BUG(".ungroup=1 is incompatible with .feed_pipe != NULL");
		if (opts->consume_sideband)
			BUG(".ungroup=1 is incompatible with .consume_sideband != NULL");
	}

	if (!opts->get_next_task)
		BUG("you need to specify a get_next_task function");

	if (opts->duplicate_output && opts->ungroup)
		BUG("duplicate_output and ungroup are incompatible with each other");

So, whether do the incompatibility check before or after
"get_next_task" is arbitrary. If I had to pick, I think doing it after as you're
doing here probably makes more sense.

But would ou mind if this addition of yours were instead:

	if (opts->ungroup) {
		if (opts->duplicate_output)
			BUG("duplicate_output and ungroup are incompatible with each other")
	}

Like I said, a trivial request.

But it will save us the eventual refactoring of that into nested checks
as we add more of these options.

To the extent that we need to mention the seemingly odd looking pattern
we could just say that we're future-proofing this for future
incompatible modes.

1. https://lore.kernel.org/git/cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com/#t

> @@ -1645,14 +1648,21 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  	for (size_t i = 0; i < opts->processes; i++) {
>  		if (pp->children[i].state == GIT_CP_WORKING &&
>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> -			int n = strbuf_read_once(&pp->children[i].err,
> -						 pp->children[i].process.err, 0);
> +			ssize_t n = strbuf_read_once(&pp->children[i].err,
> +						     pp->children[i].process.err, 0);

This s/int/ssize_t/ change is a good on, but not mentioned in the commit
message. Maybe worth splitting out?

If I revert that back to "int" on top of this entire topic our tests
still pass, so while it's a good change it seems entirely unrelated to
the "duplicate_output" subject of this patch.

>  			if (n == 0) {
>  				close(pp->children[i].process.err);
>  				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
> -			} else if (n < 0)
> +			} else if (n < 0) {

Here you're adding braces, which is an otherwise good change (but maybe
worth splitting up, I haven't read the rest of this topic to see if
there's even more style changes).

In this case we should/could have done this change with the pre-image,
before "duplicate_output".

>  				if (errno != EAGAIN)
>  					die_errno("read");
> +			} else {
> +				if (opts->duplicate_output)

I've read ahead and this topic adds nothing new to this "else" block, so
why the extra indentation instead of:

	} else if (opts->duplicate_output) {
		[...];

> +					opts->duplicate_output(&pp->children[i].err,
> +					       strlen(pp->children[i].err.buf) - n,

Uh, why are we getting the length of strbuf with strlen()? Am I missing
something obvious here, or should this be:

	pp->children[i].err.len - n

?

> +					       opts->data,
> +					       pp->children[i].data);

Especially with how otherwise painful the wrapping is here (well, not
very, but we can easily save a \t-indent here).

> +			}
>  		}
>  	}
>  }
> diff --git a/run-command.h b/run-command.h
> index 072db56a4d..6dcf999f6c 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -408,6 +408,27 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
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
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel,
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + *
> + * This function is incompatible with "ungroup"
> + */
> +typedef void (*duplicate_output_fn)(struct strbuf *out,
> +				    size_t offset,
> +				    void *pp_cb,
> +				    void *pp_task_cb);

There's some over-wrapping here, I see some existing code does it, but
for new code we could follow our usual style, which would put this on
two lines.

> +
>  /**
>   * This callback is called on every child process that finished processing.
>   *
> @@ -461,6 +482,12 @@ struct run_process_parallel_opts
>  	 */
>  	start_failure_fn start_failure;
>  
> +	/**
> +	 * duplicate_output: See duplicate_output_fn() above. This should be
> +	 * NULL unless process specific output is needed
> +	 */

Here we mostly refer to the previous docs, but the "unless process
specific output is neeed" is very confusing. Without seeing the name or
having read the above I'd think this were some "do_not_pipe_to_dev_null"
feature.

Shouldn't we say "Unless you need to capture the output... leave this at
NULL" or something?

> +static void duplicate_output(struct strbuf *out,
> +			size_t offset,
> +			void *pp_cb UNUSED,
> +			void *pp_task_cb UNUSED)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	string_list_split(&list, out->buf + offset, '\n', -1);
> +	for (size_t i = 0; i < list.nr; i++) {
> +		if (strlen(list.items[i].string) > 0)

First, you can use for_each_string_list_item() here to make this look
much nicer/simpler.

Second, don't use strlen(s) > 0, just use strlen(s).

Third, you can git rid of the {} braces for the "for" here.

But just getting rid of that strlen() check and printing makes all your
tests pass.

And why is this thing that wants to prove to us that we're capturing the
output wanting to strip successive newlines?

Using a struct string_list for this is also pretty wasteful, we could
just make this a while-loop that printed this string when it sees "\n".

But it's just test code, so we don't care, I think it's fine for it to
be wastful, I just don't see why it's doing what it's doing, and what
it's going out of its way to do isn't tested for here.

> +test_expect_success 'run_command runs in parallel with more jobs available than tasks --duplicate-output' '
> +	test-tool run-command --duplicate-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_must_be_empty out &&
> +	test 4 = $(grep -c "duplicate_output: Hello" err) &&
> +	test 4 = $(grep -c "duplicate_output: World" err) &&
> +	sed "/duplicate_output/d" err > err1 &&

Style: ">f" not "> f".

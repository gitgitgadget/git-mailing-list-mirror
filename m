Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CB5207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 04:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164650AbdDXEb2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 00:31:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164638AbdDXEb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 00:31:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 287D781BF2;
        Mon, 24 Apr 2017 00:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CI8uNqjQaCrFera57gV0CPj0W/o=; b=OZSuW1
        k7Qh1bYXPU/nBGAFPpVvJ1yS87baxwyQEuUWENKGybjVlcPA4viBGh8e0yvnkkQf
        ooYSK90YNFtdil8L5rNX9CqFLs/Vh0bUFSdiR9zCMSIiEagOtBATtaaKfc1sGCcW
        gAUD4tLUT/GqI7TTa53qszNW58l110OITxiJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nNwMxealI4kBGQq52Vo5RDC7jDwKMeg0
        IYztQT2x4uQ7jLdcD3m0tm/2gDe6tOpUa++YG+fF96yjJ38Qp1X1OUgvDEUY/73d
        qWaNVMG0FKsZYrowSBIGWu41aCv5j1AQFkY0rTa3L9yc2TMovLvnUApvM8u32zLv
        VMbkE881oMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EA4B81BF1;
        Mon, 24 Apr 2017 00:31:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77CE681BF0;
        Mon, 24 Apr 2017 00:31:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v6 3/8] convert: Split start_multi_file_filter into two separate functions
References: <20170421172611.12152-1-benpeart@microsoft.com>
        <20170421172611.12152-4-benpeart@microsoft.com>
Date:   Sun, 23 Apr 2017 21:31:23 -0700
In-Reply-To: <20170421172611.12152-4-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 21 Apr 2017 13:26:06 -0400")
Message-ID: <xmqqshkyzask.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFFD327E-28A6-11E7-BFC5-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Subject: [PATCH v6 3/8] convert: Split start_multi_file_filter into two separate functions

Two minor nits, because the capital after "<area>:" looks ugly in shortlog
output, and having () there makes it easier to notice that a
function name is being discussed.  I.e.

    convert: split start_multi_file_filter() into two separate functions

> To enable future reuse of the filter.<driver>.process infrastructure,
> split start_multi_file_filter into two separate parts.
>
> start_multi_file_filter will now only contain the generic logic to
> manage the creation and tracking of the child process in a hashmap.
>
> start_multi_file_filter_fn is a protocol specific initialization
> function that will negotiate the multi-file-filter interface version
> and capabilities.

The above fails to describe a lot more important/significant change
this patch makes.  Two mistaken check "errno == EPIPE" have been
removed as a preliminary bugfix.  I think the bugfix deserves to be
split into a separate patch by itself and hoisted much earlier in
the series.  It alone is a very good change, with or without the
remainder of the changes in this patch.

Thanks.

> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  convert.c | 62 ++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 793c29ebfd..36401fe087 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -565,35 +565,14 @@ static void stop_multi_file_filter(struct child_process *process)
>  	finish_command(process);
>  }
>  
> -static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
> +static int start_multi_file_filter_fn(struct cmd2process *entry)
>  {
>  	int err;
> -	struct cmd2process *entry;
> -	struct child_process *process;
> -	const char *argv[] = { cmd, NULL };
>  	struct string_list cap_list = STRING_LIST_INIT_NODUP;
>  	char *cap_buf;
>  	const char *cap_name;
> -
> -	entry = xmalloc(sizeof(*entry));
> -	entry->cmd = cmd;
> -	entry->supported_capabilities = 0;
> -	process = &entry->process;
> -
> -	child_process_init(process);
> -	process->argv = argv;
> -	process->use_shell = 1;
> -	process->in = -1;
> -	process->out = -1;
> -	process->clean_on_exit = 1;
> -	process->clean_on_exit_handler = stop_multi_file_filter;
> -
> -	if (start_command(process)) {
> -		error("cannot fork to run external filter '%s'", cmd);
> -		return NULL;
> -	}
> -
> -	hashmap_entry_init(entry, strhash(cmd));
> +	struct child_process *process = &entry->process;
> +	const char *cmd = entry->cmd;
>  
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> @@ -642,7 +621,38 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
>  done:
>  	sigchain_pop(SIGPIPE);
>  
> -	if (err || errno == EPIPE) {
> +	return err;
> +}
> +
> +static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] = { cmd, NULL };
> +
> +	entry = xmalloc(sizeof(*entry));
> +	entry->cmd = cmd;
> +	entry->supported_capabilities = 0;
> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +	process->clean_on_exit = 1;
> +	process->clean_on_exit_handler = stop_multi_file_filter;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external filter '%s'", cmd);
> +		return NULL;
> +	}
> +
> +	hashmap_entry_init(entry, strhash(cmd));
> +
> +	err = start_multi_file_filter_fn(entry);
> +	if (err) {
>  		error("initialization for external filter '%s' failed", cmd);
>  		kill_multi_file_filter(hashmap, entry);
>  		return NULL;
> @@ -733,7 +743,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  done:
>  	sigchain_pop(SIGPIPE);
>  
> -	if (err || errno == EPIPE) {
> +	if (err) {
>  		if (!strcmp(filter_status.buf, "error")) {
>  			/* The filter signaled a problem with the file. */
>  		} else if (!strcmp(filter_status.buf, "abort")) {

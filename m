Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE16207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbcILVdF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:33:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61388 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752078AbcILVdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:33:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41A733E155;
        Mon, 12 Sep 2016 17:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sR28Zp4WF51Mm28i3ionC2dB6dA=; b=mWguoL
        QNHxpX+1VEUp51tpnv1dzBUxrudevLxwbHDLQx7O+tAgP/5rRhXelLrxw/edTmFk
        KfpMLaMKJ+lz/9p6vIthrGcZf7d7fx08C5U8NtNZJjg4uZEVkxUm0KcfijbMHqM7
        UWdevCY8/uB7Xgo30SrwmkhsxukOgJOorIo8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WOFluxRBFTv7fncsolrOacyFrtob4U91
        aPXj63WQblMKArzsL2id/u7QNBE9eEzpCzia2SUgylBY2joMe2ZY98nHSmnvegHM
        pB3WnFk09PkiNXxABWKjxsI4igvtQONlIo0RJv/5m0prxonNPKS273/XMJY/jyxd
        M+4enk6E4kc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39E843E154;
        Mon, 12 Sep 2016 17:33:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACD8E3E153;
        Mon, 12 Sep 2016 17:33:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 18/25] sequencer: support cleaning up commit messages
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <773ba280e64c2dfabff0d6e6a0a0808482461677.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 14:33:00 -0700
In-Reply-To: <773ba280e64c2dfabff0d6e6a0a0808482461677.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:33 +0200
        (CEST)")
Message-ID: <xmqqd1k8ztv7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C0139DA-7930-11E6-8764-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -788,7 +792,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> -			opts, allow, opts->edit, 0);
> +			opts, allow, opts->edit, 0, 0);
>  
>  leave:
>  	free_message(commit, &msg);

So the existing caller did not ask to cleanup


>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit, int amend)
> +			  int allow_empty, int edit, int amend,
> +			  int cleanup_commit_message)
>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -522,9 +523,12 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  		argv_array_push(&array, "-s");
>  	if (defmsg)
>  		argv_array_pushl(&array, "-F", defmsg, NULL);
> +	if (cleanup_commit_message)
> +		argv_array_push(&array, "--cleanup=strip");
>  	if (edit)
>  		argv_array_push(&array, "-e");
> -	else if (!opts->signoff && !opts->record_origin &&
> +	else if (!cleanup_commit_message &&
> +		 !opts->signoff && !opts->record_origin &&
>  		 git_config_get_value("commit.cleanup", &value))
>  		argv_array_push(&array, "--cleanup=verbatim");

Which is consistent with this change.  This is a no-op enhancement
for existing callers and makes new callers to ask for cleaning up.

We will see if a hardcoded "--cleanup=strip" is sufficient when we
see new callers (we _know_ it would be sufficient for the first new
caller by definition ;-).

Makes sense.  Thanks.

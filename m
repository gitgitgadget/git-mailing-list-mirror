Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA134C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A96C217BA
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p8SaE0cY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBDSoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:44:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55682 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDSoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 13:44:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67BF7AD4A8;
        Tue,  4 Feb 2020 13:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ty5MPu1G6yuGKtU6dk15xXIYvXM=; b=p8SaE0
        cY2RsfpgK219R4NaILTfPV2ZDseweKG0WT372hPog9frgVMZKnf2hGJIGQVkpFqO
        YhyY0Ku1xKPWBtosuX9dRH4474zzjmOQlnvsqHTXHIJvVTfJcEqVdh0o8XZ9t4ZQ
        Gr/BBpSqnacNHeL+s+PMXfI8/5CHOCoic7eWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BtJXMQmIWu7HfW/0WJpASC+ykZjapu4t
        pv9p24/42jNk1tSs4+e/jwfNWbBtScrnRShNGLX60Jj0EdAn5zo7f7FGFHauAZiL
        7fUThqVqRUCURTe1vHJbZvWzICPNQnpurBiXPz3OwaGYlIblaQK1AyrKmT5QaJn9
        1G8dXINDjwA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FE36AD4A7;
        Tue,  4 Feb 2020 13:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E9B0AD4A4;
        Tue,  4 Feb 2020 13:44:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 11/15] bugreport: collect list of populated hooks
References: <20200124033436.81097-1-emilyshaffer@google.com>
        <20200124033436.81097-12-emilyshaffer@google.com>
Date:   Tue, 04 Feb 2020 10:44:39 -0800
In-Reply-To: <20200124033436.81097-12-emilyshaffer@google.com>
        (emilyshaffer@google.com's message of "Thu, 23 Jan 2020 19:34:32
        -0800")
Message-ID: <xmqqh8068a5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 677E149A-477E-11EA-862F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> +	/*
> +	 * Doesn't look like there is a list of all possible hooks; so below is
> +	 * a transcription of `git help hook`.

That's "git help hooks", if I tried my reproduction correctly.  A
straight-forward (in the sense of "what we want in the outcome is
quite clear" and not in the sense of "anybody can design and
implement it with a single 30-line patch") follow-up we can make
after this series lands is to rethink how Documentation/githooks.txt
is maintained and the list we have here is synchronized with it.

The design could me just the matter of running "grep" of some sort,
with appropriate markups that are no-op to AsciiDoctor/AsciiDoc
added to the documentation source, to produce this list.

> +	 */
> +	const char *hooks = "applypatch-msg,"
> +			    "pre-applypatch,"
> +			    "post-applypatch,"
> +			    "pre-commit,"
> +			    "pre-merge-commit,"
> +			    "prepare-commit-msg,"
> +			    "commit-msg,"
> +			    "post-commit,"
> +			    "pre-rebase,"
> +			    "post-checkout,"
> +			    "post-merge,"
> +			    "pre-push,"
> +			    "pre-receive,"
> +			    "update,"
> +			    "post-receive,"
> +			    "post-update,"
> +			    "push-to-checkout,"
> +			    "pre-auto-gc,"
> +			    "post-rewrite,"
> +			    "sendemail-validate,"
> +			    "fsmonitor-watchman,"
> +			    "p4-pre-submit,"
> +			    "post-index-changex";
> +	struct string_list hooks_list = STRING_LIST_INIT_DUP;
> +	struct string_list_item *iter = NULL;
> +
> +
> +	if (nongit) {
> +		strbuf_addstr(hook_info,
> +			"not run from a git repository - no hooks to show\n");
> +		return;
> +	}
> +
> +	string_list_split(&hooks_list, hooks, ',', -1);
> +
> +	for_each_string_list_item(iter, &hooks_list) {
> +		if (find_hook(iter->string)) {
> +			strbuf_addstr(hook_info, iter->string);
> +			strbuf_complete_line(hook_info);
> +		}
> +	}
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output <file>]"),
>  	NULL
> @@ -193,6 +243,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Safelisted Config Info");
>  	get_safelisted_config(&buffer);
>  
> +	get_header(&buffer, "Configured Hooks");

Phrase nit.  There may be many people who just enabled hooks without
configuring, so "Enabled Hooks" may be more appropriate.  We do not
have to inspect what is in the hook to determine if it is enabled,
but we do need to if we want to tell if a hook is "configured".

> +	get_populated_hooks(&buffer, nongit_ok);
> +
>  	report = fopen_for_writing(report_path.buf);
>  	strbuf_write(&buffer, report);
>  	fclose(report);

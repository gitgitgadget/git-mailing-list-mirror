Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A8C11D25
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE6020679
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGRty5tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgBTU6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:58:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgBTU6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:58:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7A51AE50E;
        Thu, 20 Feb 2020 15:58:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6WJXkzkVJRikGa+FkYM6e4DUM94=; b=oGRty5
        tnRccZq459i9csOqMk0tCRhrPie/wLxvFFyAUAtO6F60/2C22q9gDJ24Ec6Tw+mG
        S0V0g1GQecOBwcsVReIwDDIqP3Qu2KgGWHTZyOBpPGt2fbxY3LYtEL1/EZ5p5JRH
        UaDO/2T+tOGDge+3K9UF1Og4CKUgTrtpGsNcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fz1hPKMAe8bdJ1PtxOm3KRSGBCfqi1v6
        9LNfHffQgNhflA1BpzMoN52xEQPE2L7U/6TqZwvpscURQJaoQT5S+3dCa70e4gZi
        inOt9M7wWq1L8NQRAy1B5ZmP68tlCXdJrTLcJwYcV9ix2+2vR3ZrBF13E4KW86tJ
        at9rGrktaRI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEBFFAE50B;
        Thu, 20 Feb 2020 15:58:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27457AE50A;
        Thu, 20 Feb 2020 15:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 11/15] bugreport: collect list of populated hooks
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-12-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:58:32 -0800
In-Reply-To: <20200220015858.181086-12-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:54 -0800")
Message-ID: <xmqqeeup9ds7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C27CB340-5423-11EA-9AA6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> +{
> +	/*
> +	 * Doesn't look like there is a list of all possible hooks; so below is
> +	 * a transcription of `git help hooks`.
> +	 */

It may want to become a NEEDSWORK comment.

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

Typo here?

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

I do not get why you want to use string_list for this, especially if
you need to use string_list_split.

To me,

	int i;
	const char *hook[] = {
		"applypatch-msg",
	        "pre-applypatch",
		...
		"post-index-change",
	};

	for (i = 0; i < ARRAY_SIZE(hook); i++) {
		if (hook[i] is enabled)
			strbuf_addf(hook_info, "%s\n", hook[i]);
	}

would be far easier to understand.  Do you have an external source
that can feed you a single long string of comma separated hook names
in mind, so that the initialization of *hooks will become simpler
that way, or something?

> +		if (find_hook(iter->string)) {
> +			strbuf_addstr(hook_info, iter->string);
> +			strbuf_complete_line(hook_info);
> +		}
> +	}
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
>  	NULL
> @@ -166,6 +216,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Safelisted Config Info");
>  	get_safelisted_config(&buffer);
>  
> +	get_header(&buffer, "Enabled Hooks");
> +	get_populated_hooks(&buffer, nongit_ok);
> +
>  	report = fopen_for_writing(report_path.buf);
>  
>  	if (report == NULL) {

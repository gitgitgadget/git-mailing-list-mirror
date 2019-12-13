Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9EC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654EF20706
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pucZNAF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMVrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:47:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57663 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:47:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D54719F94;
        Fri, 13 Dec 2019 16:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2SHfbprZ7o+1tbbHCaPHYTdxMKE=; b=pucZNA
        F+s7mXXaE/sN++IiRzZh4ZBuusyI9K1zcsnKAyAzSEE4iwqqm0NmWWjt68BeBcPG
        QHzFXUoadzTunVfQdcOQA+kQSI2OIGxNynEl9MPlcCvC+p6xzRp63Ml7dy/G9v2P
        EonYg/+nS27SRrsrqnvequMteRTnMy0ZDeY30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=arpowRUOChIgTVlbCwtj5yFtuIrsn1S1
        nPw6g38/7/I1ZAJXCTAWjUfiHvJIANcyAstbxO6SrsdtnsnVyih378JdfnUWcJYK
        Fws1aOSYnQbIci+87k/Gt0qzJBvRcD0NF6RwUS50jNrmHWzh2kMmezpLql18OntF
        UZLvTn/qJsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 362E319F8F;
        Fri, 13 Dec 2019 16:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9008A19F81;
        Fri, 13 Dec 2019 16:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 11/15] bugreport: collect list of populated hooks
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-12-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:47:27 -0800
In-Reply-To: <20191213004312.169753-12-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:08 -0800")
Message-ID: <xmqqzhfvhp8w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28717982-1DF2-11EA-971A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	/*
> +	 * Doesn't look like there is a list of all possible hooks; so below is
> +	 * a transcription of `git help hook`.
> +	 */

We probably would want to employ technique similar to what you used
for the list of safe configuration we saw in an earlier patch in the
series.  What's not even documented is not worth reporting ;-)

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
> +	int nongit_ok;
> +
> +	setup_git_directory_gently(&nongit_ok);
> +
> +	if (nongit_ok) {
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
> @@ -188,6 +240,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Safelisted Config Info");
>  	get_safelisted_config(&buffer);
>  
> +	get_header(&buffer, "Configured Hooks");
> +	get_populated_hooks(&buffer);
> +
>  	report = fopen_for_writing(report_path.buf);
>  	strbuf_write(&buffer, report);
>  	fclose(report);

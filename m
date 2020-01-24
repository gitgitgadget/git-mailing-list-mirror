Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7DEC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1202075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lfagrZux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbgAXTST (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:18:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56603 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgAXTST (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:18:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 181DF414D1;
        Fri, 24 Jan 2020 14:18:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DFuNue25wB99B8EZQtuXgwU4Ok4=; b=lfagrZ
        uxhWw+HoW7MrZ4ifd+bjOvpXrli5ghS3Uo3NpAnSCgnKRFPfef4Rie9JnGPZZ3zd
        47XmsTldqXsu8iEo4E1OFB87UbQ0GoRVzGWuktP50TKpV3cdGRONdkkWDZkEx4xj
        iCQ70qTh498Z5aI8EYsq58gRXKpTbUSDtwzP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pM6ps3pzg1Hrn7qsNYCxGKrNK1XC0Whi
        0KJRvpUft0GAxCuxNs9yq/XXsIYf18oVUUpIPEeji62CFzZX2evDLG6l4DRPJ11B
        nmI2G7r0r1a4rh2fHZheiLO0ln30OQ3YIbFb6ixTsa19YBC3TvgBq1i2Y8V/Eosc
        pAu+ki9pv38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EBD6414D0;
        Fri, 24 Jan 2020 14:18:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 678F0414CF;
        Fri, 24 Jan 2020 14:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 6/6] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 11:18:15 -0800
In-Reply-To: <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 24 Jan 2020
        00:21:06 +0000")
Message-ID: <xmqqsgk4zmrs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45E38CB4-3EDE-11EA-A303-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +const char *scope_to_string(enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_SYSTEM:
> +		return "system";
> +	case CONFIG_SCOPE_GLOBAL:
> +		return "global";
> +	case CONFIG_SCOPE_LOCAL:
> +		return "local";

Despite the screw-up at an earlier step, this one is correct ;-)

> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
> +	case CONFIG_SCOPE_SUBMODULE:
> +		return "submodule";
> +	default:
> +		return "unknown";
> +	}
> +}
> +

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e5fb9114f6..79dbea9bd1 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1771,6 +1771,65 @@ test_expect_success '--show-origin blob ref' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success '--show-scope with --list' '
> +	cat >expect <<-EOF &&
> +		global	user.global=true
> +		global	user.override=global
> +		global	include.path=$INCLUDE_DIR/absolute.include
> +		global	user.absolute=include
> +		local	user.local=true
> +		local	user.override=local
> +		local	include.path=../include/relative.include
> +		local	user.relative=include
> +		command	user.cmdline=true
> +	EOF

We cleaned up the existing ones that are overly indented from this
script in an earlier step.  Let's not re-introduce them.


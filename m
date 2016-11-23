Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BFC1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934292AbcKWWZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:25:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934274AbcKWWZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:25:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B5A352516;
        Wed, 23 Nov 2016 17:25:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HN793eBSiQGsz6NTJtvnT+/Iaew=; b=WRllaO
        iD7P3QEn7T2Cj1MQMCBpij8bqtZG7NKoVgq6bJuXXda2T+i6bStfXRW28KWEKhU9
        kC1DgPy8swA+QFwSaqTrB0x75EDAk8qHQC1ELYXWb5PMdQ9ZVwYZDtPnyGu+rxWP
        k8aReD4E4nv51pFeG7iFMVtSky9S1OhajA980=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i+8QB9aI5eQQ62j2Da5ruxPfiEF/s+jx
        P6OUkR0LvaG7MZOEMdx9l1d2sNO7Jp8X/Jsh5OXNUdfdZggsNtJASSj55TZLA3O1
        uYlOh19yoNmgSrV9trwJtM+qifufqFwmYgwhaqY5rKuzLaHad4whozxj0Z8rzPLf
        PmU6PURZbTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CC1D52515;
        Wed, 23 Nov 2016 17:25:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1B3952514;
        Wed, 23 Nov 2016 17:25:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 1/1] difftool: add the builtin
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
        <cover.1479938494.git.johannes.schindelin@gmx.de>
        <3e9a2f31c779476c7524849a2e5307f2d3396fe8.1479938494.git.johannes.schindelin@gmx.de>
Date:   Wed, 23 Nov 2016 14:25:02 -0800
In-Reply-To: <3e9a2f31c779476c7524849a2e5307f2d3396fe8.1479938494.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 23 Nov 2016 23:03:15 +0100
        (CET)")
Message-ID: <xmqqwpftltq9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEBC2B2C-B1CB-11E6-B435-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	if (!strcmp(var, "core.usebuiltindifftool")) {
> +		use_builtin_difftool = git_config_bool(var, value);
> +		return 0;
> +	}

This no way belongs to the core set; difftool.usebuiltin would be
more appropriate.

> +	if (!use_builtin_difftool) {
> +		const char *path = mkpath("%s/git-legacy-difftool", git_exec_path());
> +
> +		if (sane_execvp(path, (char **)argv) < 0)
> +			die_errno("could not exec %s", path);
> +
> +		return 0;
> +	}
> + ...
> diff --git a/git-difftool.perl b/git-legacy-difftool.perl
> similarity index 100%
> rename from git-difftool.perl
> rename to git-legacy-difftool.perl
> diff --git a/git.c b/git.c
> index efa1059..0e6bbee 100644
> --- a/git.c
> +++ b/git.c
> @@ -424,6 +424,7 @@ static struct cmd_struct commands[] = {
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
>  	{ "diff-index", cmd_diff_index, RUN_SETUP },
>  	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
> +	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },

Running set-up would mean that the spawning of legacy-difftool would
be done after you chdir(2) up to the root level of the working tree,
no?  I do not think you can safely add these two bits here until the
migration completes.

I doubt that setting core.usebuiltindifftool to false and running
the tool from a subdirectory and a pathspec work correctly with this
patch.  If running difftool from a subdirectory with a pathspec is
not tested in t7800, perhaps we should.

It is nice that we can now lose PERL prerequisite from t7800 ;-)

Thanks.

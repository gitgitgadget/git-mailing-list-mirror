Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BDEC35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A712082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/G5Gj3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJSLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:11:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56954 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:11:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 476F443F12;
        Mon, 10 Feb 2020 13:11:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VTNiFGH7Cpnm4lxY1nYvzHXnz2o=; b=F/G5Gj
        3FdUxNsK8erPnteGW96Ms1XzIkueRh03hXcV4JaHq5Zgk4p+9o3iWPhqtwkLBU18
        itZjk5VXux7jhpjczcECfESULY9P65MUB2sv+xFKkl+4iagH/wM31tHwaC8qdfLj
        G4u5EDj4WjfOuzDk2q1w0HVcfOXt9CNjVdyxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VtrwC6JGwiWEW7b4yIIy1yeXvpURBiMC
        Q035FCyLQK5vw+qGgzwwc3V8YI9BSYWyLwAiOEJw3D6B8jlaVETXwH9tk83F1pL2
        8OLYoH9WZ/ZuZhEgVhCN+sblLbkp59OXh5pYr6mVY6TNHqEVWx3lT/8ce7yanz2n
        uvphOBGSNcM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4070F43F10;
        Mon, 10 Feb 2020 13:11:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DF8F43F0F;
        Mon, 10 Feb 2020 13:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 07/10] config: preserve scope in do_git_config_sequence
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <f61985375c5096b863dc99ef613d864bfd010d96.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:11:08 -0800
In-Reply-To: <f61985375c5096b863dc99ef613d864bfd010d96.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:56 +0000")
Message-ID: <xmqqzhdqz51f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6C3793A-4C30-11EA-A7B0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> do_git_config_sequence operated under the assumption that it was correct
> to set current_parsing_scope to CONFIG_SCOPE_UNKNOWN as part of the
> cleanup it does after it finishes execution.  This is incorrect, as it
> blows away the current_parsing_scope if do_git_config_sequence is called
> recursively.  As such situations are rare (git config running with the
> '--blob' option is one example) this has yet to cause a problem, but the
> upcoming '--show-scope' option will experience issues in that case, lets
> teach do_git_config_sequence to preserve the current_parsing_scope from
> before it started execution.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This step is new and it does make sense.

Thanks.



> diff --git a/config.c b/config.c
> index fe1e44a43a..0e2c693e78 100644
> --- a/config.c
> +++ b/config.c
> @@ -1702,6 +1702,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	char *xdg_config = xdg_config_home("config");
>  	char *user_config = expand_user_path("~/.gitconfig", 0);
>  	char *repo_config;
> +	enum config_scope prev_parsing_scope = current_parsing_scope;
>  
>  	if (opts->commondir)
>  		repo_config = mkpathdup("%s/config", opts->commondir);
> @@ -1741,7 +1742,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
>  		die(_("unable to parse command-line config"));
>  
> -	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
> +	current_parsing_scope = prev_parsing_scope;
>  	free(xdg_config);
>  	free(user_config);
>  	free(repo_config);

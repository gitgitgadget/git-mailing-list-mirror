Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE30C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0C2082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SzLRRIcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgBJSKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:10:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59792 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:10:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E586BBF83F;
        Mon, 10 Feb 2020 13:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I5GXqkhqtcjtaz1wajDFgrtFfqc=; b=SzLRRI
        cbCSkC01Abs3UjsPQ+pBaO/pxjwgf6tPAKAyXhjsq3nRVBiRyoTNuEFEj+BrPHJW
        lrEJ0t5gsCxKVQtlCaAZbaPgtTa2d7NN9vomzBimSrrJ0E+exf8z0rWWlIboh0je
        r26S6z5dTilUAoddpvnJIYKt/QpMyFa/bFBHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eAFa3CdylFhqfANplm3Gaxu48sHglEx8
        tcuchdxd1JTPXAx0hYirCEFIAJU++iS2BezM80KbcduN1TyXIUgYAM2l+FCnhX2t
        bhg31Nnc1dyK3NlWdcs/BjBpmMeJDMKAjehFe0H0E0qowj9XJChUVWT5aDl1L68Q
        /13Ay1EnlrU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDA63BF83E;
        Mon, 10 Feb 2020 13:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AE5DBF83D;
        Mon, 10 Feb 2020 13:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 06/10] config: clarify meaning of command line scoping
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <64c20d0556e9e72663940da7f58a8e55a75fa9d0.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:10:04 -0800
In-Reply-To: <64c20d0556e9e72663940da7f58a8e55a75fa9d0.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:55 +0000")
Message-ID: <xmqq4kvy1fgj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91733882-4C30-11EA-B802-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
> values passed in via the -c option.  Options passed in using this
> mechanism share similar scoping characteristics with the --file and
> --blob options of the 'config' command, namely that they are only in use
> for that single invocation of git, and that they supersede the normal
> system/global/local hierarchy.  This patch introduces
> CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
> CONFIG_SCOPE_CMDLINE redundant.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.c              | 6 +++---
>  config.h              | 2 +-
>  t/t1308-config-set.sh | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

This makes sense, even though it is halfway undoing what 04/10
unnecessarily did ;-)

I think I can just wiggle minor fixes in to 04/10 and then adjust
this one to get the series into a better shape myself before queuing
them to expedite the process.  Let me finish reading the remainder
of the topic.

Thanks.

> diff --git a/config.c b/config.c
> index 7422bdebb1..fe1e44a43a 100644
> --- a/config.c
> +++ b/config.c
> @@ -1737,7 +1737,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		free(path);
>  	}
>  
> -	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
> +	current_parsing_scope = CONFIG_SCOPE_COMMAND;
>  	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
>  		die(_("unable to parse command-line config"));
>  
> @@ -3305,8 +3305,8 @@ const char *config_scope_name(enum config_scope scope)
>  		return "local";
>  	case CONFIG_SCOPE_WORKTREE:
>  		return "worktree";
> -	case CONFIG_SCOPE_CMDLINE:
> -		return "command line";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
>  	default:
>  		return "unknown";
>  	}
> diff --git a/config.h b/config.h
> index d3ed41ef8e..b570f4ce43 100644
> --- a/config.h
> +++ b/config.h
> @@ -301,7 +301,7 @@ enum config_scope {
>  	CONFIG_SCOPE_GLOBAL,
>  	CONFIG_SCOPE_LOCAL,
>  	CONFIG_SCOPE_WORKTREE,
> -	CONFIG_SCOPE_CMDLINE,
> +	CONFIG_SCOPE_COMMAND,
>  };
>  const char *config_scope_name(enum config_scope scope);
>  
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 728a2b87ce..fba0abe429 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-cmdline
>  	origin=command line
>  	name=
> -	scope=command line
> +	scope=command
>  	EOF
>  	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
>  	test_cmp expect actual

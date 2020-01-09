Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3925C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ED62067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SQ3C0OAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgAITTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:19:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58921 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgAITTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 14:19:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91B4141024;
        Thu,  9 Jan 2020 14:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WXJfeyzfNGNr1F94652F14cbQ8=; b=SQ3C0O
        Am4+7yIQvu6bGsB6vjsHf45tVSmwG/Bn3s7LCcZYIkyKNOTMRiqo5F63K2gCKw6+
        kJGU6m9VrlKiJr1qBX4noeKrpRUooYtScvKtO1I3NSu5qoIWr5/Q3STMgX/6YeKH
        I7Ebru95FQMcgYo39dO48JvRc07RnEOOhfsuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uNUG45zMh94RnPx5y2LqQ6eHucT9zWco
        WVQYgKuTgBEaRnYrU4xytbngilWFe31LItFWo0GCbD90wiTpVh8SX3+6uawgen78
        tNwJOJG9znKi0fW+JQgwWprLVs63QLUQ7vszXGhG0i2tbaCI1ez1s+br/L2S79wp
        r8EZqYQflBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E44141023;
        Thu,  9 Jan 2020 14:14:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8399B41021;
        Thu,  9 Jan 2020 14:14:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 3/4] config: clarify meaning of command line scoping
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <82252735467d876b4726f512a02cc44d271696ca.1578565001.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 11:13:59 -0800
In-Reply-To: <82252735467d876b4726f512a02cc44d271696ca.1578565001.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Thu, 09 Jan 2020
        10:16:40 +0000")
Message-ID: <xmqqh814zbm0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31325172-3314-11EA-8D3E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
> values passed in via the -c option.  This is a little bit too specific
> as there are other methods to pass config values so that the last for a
> single command (namely --file and --blob).

Sorry, but I cannot parse this, especially around "so that the last
for ..." part.

> As the "visibility" of config
> values passed by these situations is common, we unify them as having a
> scope of "command" rather than "command line".

Is the "unification" something done by this patch?  It does not
appear to be so.  The existing code already was using CMDLINE to
call "git -c VAR=VAL" and also something else (which is not clear to
me, unfortunately, probably because I failed to parse the above
X-<), and this step renames CMDLINE to COMMAND perhaps because
CMDLINE has too strong connotation with the "-c" thing and much less
with the other thing (which is not clear to me, unfortunately) and
you found that renaming it to COMMAND would cover both cases better?

I also do not get what you meant by "visibility", but it probably is
primarily because it is not clear what "the other thing" is.



> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c               | 2 +-
>  config.h               | 2 +-
>  t/helper/test-config.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index 447a013a15..f319a3d6a0 100644
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
> diff --git a/config.h b/config.h
> index 284d92fb0e..f383a71404 100644
> --- a/config.h
> +++ b/config.h
> @@ -300,7 +300,7 @@ enum config_scope {
>  	CONFIG_SCOPE_GLOBAL,
>  	CONFIG_SCOPE_LOCAL,
>  	CONFIG_SCOPE_WORKTREE,
> -	CONFIG_SCOPE_CMDLINE,
> +	CONFIG_SCOPE_COMMAND,
>  };
>  
>  enum config_scope current_config_scope(void);
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 6695e463eb..78bbb9eb98 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
>  		return "repo";
>  	case CONFIG_SCOPE_WORKTREE:
>  		return "worktree";
> -	case CONFIG_SCOPE_CMDLINE:
> -		return "cmdline";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
>  	default:
>  		return "unknown";
>  	}

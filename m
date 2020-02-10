Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B92C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC92820842
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G27+pxRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJSPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:15:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57143 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJSPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:15:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB3D043F4B;
        Mon, 10 Feb 2020 13:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7gE0qPi/78wmWpky3QZ0dVbZh5Y=; b=G27+px
        RksU5k7BztjSCDkT3qP8Rk6Tv5mk5IX/DeyzrbgdzIY+FqO+quqETSVqC4rXhJj5
        BiZW9Z+/bG76c3dMGW/720U9l8mwnBc+qPv8tuUPs4Qz09g4eNiOZWS9w+RuNoEZ
        U4T+dgcHuWgKdOnZ74ndGxOoa60cRAKwuWGDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OhCmdns4japgWhEJFbHGC3iU8PvCIl4n
        UFB8PZzgXCfC4/OJuUaC/s+BLNtAGMHDzj7k1Gjm1maJPACoz/bnT0p0xA5fETrc
        2xYtjVVtiI5BHmIjSnFYi4fEbkaiUOyPb7AamcKb8uWKnm4BYMXS7IDDbP35zp3e
        rGOncobL+Mk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B333E43F4A;
        Mon, 10 Feb 2020 13:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BFFF43F49;
        Mon, 10 Feb 2020 13:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v7 09/10] submodule-config: add subomdule config scope
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <dd376246ec75e50b2e07f10ae7ec1e59c1e0572f.1581294660.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 10:15:17 -0800
In-Reply-To: <dd376246ec75e50b2e07f10ae7ec1e59c1e0572f.1581294660.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Mon, 10 Feb 2020
        00:30:58 +0000")
Message-ID: <xmqqr1z2z4ui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ADCA240-4C31-11EA-9392-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Before the changes to teach git_config_source to remember scope
> information submodule-config.c never needed to consider the question of
> config scope.  Even though zeroing out git_config_source is still
> correct and preserved the previous behavior of setting the scope to
> CONFIG_SCOPE_UNKNOWN, it's better to be explicit about such situations
> by explicitly setting the scope.  As none of the current config_scope
> enumerations make sense we create CONFIG_SCOPE_SUBMODULE to describe the
> situation.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---

Other than a typo on the title, I think this one is perfect ;-)

Will queue.

>  config.c           | 2 ++
>  config.h           | 1 +
>  submodule-config.c | 4 +++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index 9b6afca210..18a6bdd9ff 100644
> --- a/config.c
> +++ b/config.c
> @@ -3311,6 +3311,8 @@ const char *config_scope_name(enum config_scope scope)
>  		return "worktree";
>  	case CONFIG_SCOPE_COMMAND:
>  		return "command";
> +	case CONFIG_SCOPE_SUBMODULE:
> +		return "submodule";
>  	default:
>  		return "unknown";
>  	}
> diff --git a/config.h b/config.h
> index 165cacb7da..fe0addb0dc 100644
> --- a/config.h
> +++ b/config.h
> @@ -42,6 +42,7 @@ enum config_scope {
>  	CONFIG_SCOPE_LOCAL,
>  	CONFIG_SCOPE_WORKTREE,
>  	CONFIG_SCOPE_COMMAND,
> +	CONFIG_SCOPE_SUBMODULE,
>  };
>  const char *config_scope_name(enum config_scope scope);
>  
> diff --git a/submodule-config.c b/submodule-config.c
> index 85064810b2..b8e97d8ae8 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -635,7 +635,9 @@ static void submodule_cache_check_init(struct repository *repo)
>  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
>  	if (repo->worktree) {
> -		struct git_config_source config_source = { 0 };
> +		struct git_config_source config_source = {
> +			0, .scope = CONFIG_SCOPE_SUBMODULE
> +		};
>  		const struct config_options opts = { 0 };
>  		struct object_id oid;
>  		char *file;

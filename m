Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B8C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2C92072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GETuPcpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgAQUoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:44:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57767 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUoh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C16EA813D;
        Fri, 17 Jan 2020 15:44:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xRIOBURvjF3iEVlOaYw7pv7Rztg=; b=GETuPc
        pvcVdyytWMUd8Ct44aHyUvV51w4oXpLvw3fu3P375iVQFjlg1jFiR47dfgDrcUyA
        y5K2IWjLApXGgyBh1GOpUJ9Ah+ndad0Wv9HnzkL4cDcLMEyKoL2eERzLMy8dG+s4
        Rc9S7sAm1fRWyDzpFtzbemBQTvA/o6cAeJKFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NXYYAl0PIIenKiPwIDV9YWk00EI5WfuP
        yq/rsLUhPfpO/LDb/aN1oNiwrp3aL4BHy6TzUuK1epBDeyuizEeI1Yz4p83EOVuY
        bZrlZFSP57udlzDooa+1bsLepaxtlW8jZCHThWTWx5SDKInbChk8fUqL+1dG/Xsq
        wyl8nrPJwuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65F36A813C;
        Fri, 17 Jan 2020 15:44:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9252AA813A;
        Fri, 17 Jan 2020 15:44:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v3 2/4] config: refine config scope enum
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <f06f9291b7c357422abad9f9cdd7425ef9e22509.1579275102.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 12:44:30 -0800
In-Reply-To: <f06f9291b7c357422abad9f9cdd7425ef9e22509.1579275102.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 17 Jan 2020
        15:31:40 +0000")
Message-ID: <xmqq1rrxertd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A3C4FCE-396A-11EA-B31B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/config.h b/config.h
> index 91fd4c5e96..284d92fb0e 100644
> --- a/config.h
> +++ b/config.h
> @@ -298,7 +298,8 @@ enum config_scope {
>  	CONFIG_SCOPE_UNKNOWN = 0,
>  	CONFIG_SCOPE_SYSTEM,
>  	CONFIG_SCOPE_GLOBAL,
> -	CONFIG_SCOPE_REPO,
> +	CONFIG_SCOPE_LOCAL,
> +	CONFIG_SCOPE_WORKTREE,
>  	CONFIG_SCOPE_CMDLINE,
>  };

So the gist of the change is to split REPO into two, LOCAL and
WORKTREE.

If we can find a way to state that concisely, perhaps we can improve
"refine enum" and make it more informative.

> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..6695e463eb 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
>  		return "system";
>  	case CONFIG_SCOPE_GLOBAL:
>  		return "global";
> -	case CONFIG_SCOPE_REPO:
> +	case CONFIG_SCOPE_LOCAL:
>  		return "repo";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
>  	case CONFIG_SCOPE_CMDLINE:
>  		return "cmdline";
>  	default:
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 7b4e1a63eb..535b2a73f7 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-cmdline
>  	origin=command line
>  	name=
> -	scope=cmdline
> +	scope=command

Why???

>  	EOF
>  	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
>  	test_cmp expect actual
> diff --git a/upload-pack.c b/upload-pack.c
> index a00d7ece6b..c53249cac1 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1073,7 +1073,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  		precomposed_unicode = git_config_bool(var, value);
>  	}
>  
> -	if (current_config_scope() != CONFIG_SCOPE_REPO) {
> +	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> +	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
>  		if (!strcmp("uploadpack.packobjectshook", var))
>  			return git_config_string(&pack_objects_hook, var, value);
>  	}

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B25C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 19:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCATez (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCATey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 14:34:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F5392A9
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 11:34:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l1so14446134pjt.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 11:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bvA8+a7yHJKxu4qR1OFXGAdde5cIDehj8QOyF+QJp1I=;
        b=AZmK/4H0F6fFZIQns8UOOhzJZ9qc+GAYgYx7Z7sTXa9TM7khHSKej67/e+Ay04UjJU
         t4j+3sAmz4UXRM0EYdFfRrMHgJnAqrZpk5Gky1Kabg2tL4BzdGX3X1chGjk/s9Km0ZJv
         RBsi8nkBwZ/HNTdWiYnxVf9+9JOO9dsSr4yvUMsBUcltlZ22aPJauHcJD2qbxJH3/nZI
         EqeY4u7NcH1Flly9EvNPeQTVRwLNfAEldYRiLmOIKEtq/7q4bXDmP/sDb7bSOfIndnqT
         pqp+VX3wO50aheIJvD1+A5sDmjfT+F8pDYH8eoXpPUcoVtYU+htdHAR67mpUdmirQeQK
         916Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvA8+a7yHJKxu4qR1OFXGAdde5cIDehj8QOyF+QJp1I=;
        b=wOl/QfHWZIF2i4/wyERu1Ln6gBTee8QeoCNy60FxqXcno2bYMsmwOgU307in9IuWrK
         ICyD6Ukc+W7j81c4gOseNqnoWXWcgmp3fkfFJsPrJfNDhokSW0RjAfJxQl8TbwYizMDF
         /eC4MFA7Ef33MKsJaoGKQM7UZ5918Ymwi4sYU6NhocXos/11LLYk/06Kp8JFaIvsaMJu
         IBMYnmkMd51FBHGg3F6O9DCTHMoYe8L4BCaei2DBP5lBP3JYCQqP6dVHp6LP9n3USg+D
         70WBVzatNmWvH/fDv+IBVMqJTHXYphY1fUt/KIJYV82I6/h+4e3mIvCgEpZ7Rp3LymHy
         xLyw==
X-Gm-Message-State: AO0yUKWwp65bnuyWAOheEimS2ZhzEK3ztRs6x2n2E0dbK+364oGSeKXb
        b93Usv4aEhHUCaEpbI6UtsKNAA6f5+A=
X-Google-Smtp-Source: AK7set9Vzd4IxAY/Ytv8ufJMg8icwlPCSxL+jrRZPEPOC1GOhVJkOAE6nqUdARrpFvWCt/W+ICXbZQ==
X-Received: by 2002:a17:903:284d:b0:19c:d420:9bc9 with SMTP id kq13-20020a170903284d00b0019cd4209bc9mr6865586plb.8.1677699286174;
        Wed, 01 Mar 2023 11:34:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001994a0f3380sm8695939plc.265.2023.03.01.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:34:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        Joakim Petersen <joak-pet@online.no>
Subject: Re: [PATCH try2] completion: prompt: use generic colors
References: <20230228145934.4182166-1-felipe.contreras@gmail.com>
Date:   Wed, 01 Mar 2023 11:34:45 -0800
Message-ID: <xmqq4jr4nu3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When the prompt command mode was introduced in 1bfc51ac81 (Allow
> __git_ps1 to be used in PROMPT_COMMAND, 2012-10-10) the assumption was
> that it was necessary in order to properly add colors to PS1 in bash,
> but this wasn't true.
>
> It's true that the \[ \] markers add the information needed to properly
> calculate the width of the prompt, and they have to be added directly to
> PS1, a function returning them doesn't work.
>
> But that is because bash coverts the \[ \] markers in PS1 to \001 \002,
> which is what readline ultimately needs in order to calculate the width.
>
> We don't need bash to do this conversion, we can use \001 \002
> ourselves, and then the prompt command mode is not necessary to display
> colors.
>
> This is what functions returning colors are supposed to do [1].
>
> [1] http://mywiki.wooledge.org/BashFAQ/053
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 19 +++++++------------
>  t/t9903-bash-prompt.sh           |  8 ++++----
>  2 files changed, 11 insertions(+), 16 deletions(-)

Comments from those who use colored prompt and who are familiar with
the mechansim used to implement this?  As I do not use the feature
at all and haven't been following it, seeing independent support
would help the topic.

Thanks.

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 57972c2845..76ee4ab1e5 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -100,9 +100,7 @@
>  #
>  # If you would like a colored hint about the current dirty state, set
>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
> -# the colored output of "git status -sb" and are available only when
> -# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
> -# but always available in Zsh.
> +# the colored output of "git status -sb".
>  #
>  # If you would like __git_ps1 to do nothing in the case when the current
>  # directory is set up to be ignored by git, then set
> @@ -259,12 +257,12 @@ __git_ps1_colorize_gitstring ()
>  		local c_lblue='%F{blue}'
>  		local c_clear='%f'
>  	else
> -		# Using \[ and \] around colors is necessary to prevent
> +		# Using \001 and \002 around colors is necessary to prevent
>  		# issues with command line editing/browsing/completion!
> -		local c_red='\[\e[31m\]'
> -		local c_green='\[\e[32m\]'
> -		local c_lblue='\[\e[1;34m\]'
> -		local c_clear='\[\e[0m\]'
> +		local c_red=$'\001\e[31m\002'
> +		local c_green=$'\001\e[32m\002'
> +		local c_lblue=$'\001\e[1;34m\002'
> +		local c_clear=$'\001\e[0m\002'
>  	fi
>  	local bad_color=$c_red
>  	local ok_color=$c_green
> @@ -574,11 +572,8 @@ __git_ps1 ()
>  		b="\${__git_ps1_branch_name}"
>  	fi
>  
> -	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
>  	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
> -		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
> -			__git_ps1_colorize_gitstring
> -		fi
> +		__git_ps1_colorize_gitstring
>  	fi
>  
>  	local f="$h$w$i$s$u$p"
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index d459fae655..d667dda654 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
>  
>  actual="$TRASH_DIRECTORY/actual"
> -c_red='\\[\\e[31m\\]'
> -c_green='\\[\\e[32m\\]'
> -c_lblue='\\[\\e[1;34m\\]'
> -c_clear='\\[\\e[0m\\]'
> +c_red='\001\e[31m\002'
> +c_green='\001\e[32m\002'
> +c_lblue='\001\e[1;34m\002'
> +c_clear='\001\e[0m\002'
>  
>  test_expect_success 'setup for prompt tests' '
>  	git init otherrepo &&

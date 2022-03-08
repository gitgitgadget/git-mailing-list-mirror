Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C7FC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350567AbiCHWOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350628AbiCHWOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:14:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED705546B6
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:13:44 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g31-20020a63521f000000b003783582a261so186865pgb.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=njtcRgehVbGouq7wLAiQ3QWF+cEzIuw97X9CVgdPcy0=;
        b=iroXYUcvyZjddKMJjmk26KXA56uYvG2EKMuuEi/6wiF46MCMDP2ggJKVXuuYK6OZiS
         bT1XvK481FcmdsIxt39OpMpJvNAjuamsOHumMwgS/4/o00MZDG8QiVUsoQ9GN87RRDsj
         by46vDjPfTRGXifqUEMEoAxfRS7n0VuNxMZgs+UxOwrZt7t22BlEK65zmF6E9vGJ93oS
         Xn54NJDVlEuMO6MxIhj2YzVfe68GIGOkKuqhZDQpHwN/twsuaMfq8KLiry9FI+Mlayh9
         5wcGcXL4g/To8RhL1yBB1cc0ZM00kgLtjJxDaoHk8V+8ke1U5MLzEXSjQPINVOudCvzo
         5lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=njtcRgehVbGouq7wLAiQ3QWF+cEzIuw97X9CVgdPcy0=;
        b=HeQ29QA30bZYlaeWO+rBLQLOCdPbvQ69L+POpaqe7J+8uLZ87RMOy/LQX7/UKnF0cq
         iE0ysJrVqfCfYaoBNJnzg6F/AVF1w7jNOePGsx+zKCGtlI6Jd6yS4SUP9/nZQQj1kMnu
         Z44RV8rHz0VBbShpce8v9A9zDYcpT81ZPN+5IPTfy8nMTidR32QhQFcAg3LaUUgMJu9I
         ow7iWmF24VEVV3EPkprsC+0RhMCBJL8Lni79Of3Erck90EvX9dUHo3TgmV07fsUWhGyI
         n7N5a3kcvkiocn3SstvMYyEjPKDCwnC6JXvH0i2EbZT8/+qATvoUkW+FhzwR0dJDGrym
         JlKw==
X-Gm-Message-State: AOAM533g6jL5Vhc+dpn+exajP9vUOpoaw5HsfeQnB7zH7W5rysbEA0Zt
        oDrluv7PkP5yPqNtz7w25c+18CTTrHQnIg==
X-Google-Smtp-Source: ABdhPJzWOUK6cLk61PhgTlUqcV4HqAoWWfQMPG8mpydy7WLHoW/XVjquQnoKqqd6WeNuVXL4KRokvWaVzTHKZA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:aa08:0:b0:373:cc0b:5b71 with SMTP id
 e8-20020a63aa08000000b00373cc0b5b71mr15743414pgf.599.1646777624359; Tue, 08
 Mar 2022 14:13:44 -0800 (PST)
Date:   Tue, 08 Mar 2022 14:13:34 -0800
In-Reply-To: <20220301002613.1459916-3-emilyshaffer@google.com>
Message-Id: <kl6lee3c5bzl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
 <20220301002613.1459916-1-emilyshaffer@google.com> <20220301002613.1459916-3-emilyshaffer@google.com>
Subject: Re: [PATCH v8 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Reviewing this series lightly because I will need to base
'ar/submodule-update reroll pt 2' on this (pt.1 is at
https://lore.kernel.org/git/20220305001401.20888-1-chooglen@google.com).

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 652861aa66..59dffda775 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -449,6 +449,9 @@ cmd_update()
>  			;;
>  		esac
>  
> +		# Note that the submodule is a submodule.
> +		git -C "$sm_path" config submodule.hasSuperproject "true"
> +
>  		if test -n "$recursive"
>  		then
>  			(

This hunk has a textual conflict with 'ar/submodule-update reroll pt
2', but the fix is easy - just teach "git submodule--helper update" to
set the config in C.

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 11cccbb333..422c3cc343 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	)
>  '
>  
> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 git -C submodule config --unset submodule.hasSuperproject &&
> +	 git submodule update &&
> +	 git -C submodule config submodule.hasSuperproject
> +	)
> +'
> +
>  test_done


I think there is a gap in the test coverage. I notice that this doesn't
test that we set submodule.hasSuperproject when the submodule is cloned
for the first time with 'git submodule update'. I thought that maybe the
test for this was here...

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 40cf8d89aa..833fa01961 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -115,6 +115,10 @@ inspect() {
>  	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
>  	git -C "$sub_dir" update-index --refresh &&
>  	git -C "$sub_dir" diff-files --exit-code &&
> +
> +	# Ensure that submodule.hasSuperproject is set.
> +	git -C "$sub_dir" config "submodule.hasSuperproject"
> +
>  	git -C "$sub_dir" clean -n -d -x >untracked
>  }
>  

But when I removed the "set submodule.hasSuperproject in submodule"
line, i.e. 

 		git -C "$sm_path" config submodule.hasSuperproject "true"

t7400 still passes.

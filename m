Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24AC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIGU0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGU0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:26:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC5CBC13A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:26:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so2698837pfe.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=NvkGPdNH6vmcYi4teLqI1SiT1T1qsw3A2enyY5hnjeQ=;
        b=oeb6PTcfE1DFc2BtBwPaDOaABRvM6SzlZ3deIBcLeUQH+CvUJNoJOd8tLtswya1wN0
         YhWyHaUm5q5qC+btZ+i/5GO8aJo5gsK5z7/SPejLISGf+B6bkK9B5vTevW15xDKC0fZM
         tfAh6uKpdfwdn69t6RqYp3SzgV/lNJzKin+iTU9/dRATbAPq9o6mSSu47firUra/KN0Q
         fKjIeP1X13t8GiwvXc4V1595mp58Uw7SXm+Mxh3I3GjPgxYO1uw8PaiKWoyiHANCffJk
         JAuNuo+VqdFnlMoECMPTQaOjYIN+L4fG+ZkpW1mH6H9CgxtXd3eBldL3b5SSu92FAY5p
         1x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NvkGPdNH6vmcYi4teLqI1SiT1T1qsw3A2enyY5hnjeQ=;
        b=PL9Atw1Fa5G5e9RuWbm0oq3AL/vzeA8iYTUhMRNHsPwllgkKP/ABEi3XAqJlGWHGT+
         ZAQFrUOGWiH+XFFOMDAe6SRAg3nzF2/ztn1WwOOorFbN6dmIF6gKQ61nZUbvCAj8Hvvc
         fG8k2HHUaL3n868YYAT/7SmwOCQmUoa1J4D2IVh2KQayuGxTYJ9p98E8nJA0tb11Dsiv
         4RIgXy8IBiknEXFEWp8uRLstuC3eS+FbLsSxOnrRgURleBbmCY1EzXl985t6VFTvMqOJ
         DYyAU2WP/Czdbn5MyhXxs/hE44+WbtgaWxmb5vXRBxlQrTK/xfLSPCyXp5nJ0YRMmiD2
         hxWQ==
X-Gm-Message-State: ACgBeo2PB+rwRYOTDIXDoM5U2sHdCwjbBcFok3icUI2v+JB6EGqU7B0a
        skwcUEgbKd7RSG9qBdN3+FUC/J78cFg=
X-Google-Smtp-Source: AA6agR6qiUrrjqQEISX6jIaG/DKVkRta//qMb6IJE6xPoqZQHLaHsg3Qbe6HfjCQr995gUzOJ0vLPA==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr4861643pge.228.1662582359898;
        Wed, 07 Sep 2022 13:25:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 198-20020a6218cf000000b0053e6de11a38sm2321448pfy.81.2022.09.07.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:25:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] branch: refactor "edit_description" code path
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <d2624238-048c-ac5b-1d45-e08051202c79@gmail.com>
Date:   Wed, 07 Sep 2022 13:25:59 -0700
In-Reply-To: <d2624238-048c-ac5b-1d45-e08051202c79@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 7 Sep 2022 11:52:26 +0200")
Message-ID: <xmqq7d2fszhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Minor refactoring to reduce the number of returns in the switch case
> handling the "edit_description" option, so the calls to strbuf_release
> can also be reduced.  New resources to be added also do not need to be
> released in multiple places.
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  builtin/branch.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 55cd9a6e99..5229cb796f 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -614,7 +614,7 @@ static int edit_branch_description(const char *branch_name)
>  	strbuf_reset(&buf);
>  	if (launch_editor(edit_description(), &buf, NULL)) {
>  		strbuf_release(&buf);
> -		return -1;
> +		return 1;
>  	}
>  	strbuf_stripspace(&buf, 1);


Our API convention is to signal a failure with negative return
value.  Granted that this is not a general API but is merely a
helper function in the implementation of a single command, it would
be less confusing if you sticked to the convention.

Unless there is a compelling reason not to, that is.

> @@ -791,6 +791,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	} else if (edit_description) {
>  		const char *branch_name;
>  		struct strbuf branch_ref = STRBUF_INIT;
> +		int ret = 0;
>  
>  		if (!argc) {
>  			if (filter.detached)
> @@ -803,19 +804,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf)) {
> -			strbuf_release(&branch_ref);
> -
>  			if (!argc)
> -				return error(_("No commit on branch '%s' yet."),
> +				ret = error(_("No commit on branch '%s' yet."),
>  					     branch_name);
>  			else
> -				return error(_("No branch named '%s'."),
> +				ret = error(_("No branch named '%s'."),
>  					     branch_name);

OK.  These are good uses of a new variable 'ret'.  Note that error()
returns negative one.

> -		}
> -		strbuf_release(&branch_ref);
> +		} else
> +			ret = edit_branch_description(branch_name);
>  
> -		if (edit_branch_description(branch_name))
> -			return 1;
> +		strbuf_release(&branch_ref);
> +		return ret;

When editor failed, we leaked branch_ref strbuf, but we no longer
do.

Which is good.

This makes cmd_branch() return -1 (when we see error() call) or 1
(when edit_branch_description() fails and returns 1).  I would
suggest to

 * Fix the return value of edit_branch_description() so that it
   signals a failure by returning -1

 * cmd_branch() to return (or call exit() with) -ret, as ret has 0
   when everything is peachy, and negative in any error code paths.


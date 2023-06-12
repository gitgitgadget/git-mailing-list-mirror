Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F9C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbjFLV7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFLV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:59:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD7E41
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:59:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3b56dcf1bso20586145ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607158; x=1689199158;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNkQwRnctNVe5gluH/Z+kM0GEySdeD1m1EQsCwQdjQ0=;
        b=nXCcZFGqviwLZvSS7wgnWPYKizYtsdRyhxZfYHlctaPsI8vp1AudPm7vJhSOzS0+mB
         TUvHVTmFcZImMPhGutami3jY1SkXhX+VNWjqQpr+pxtJcoleOR4zsNlAjICDWM9INPMa
         wAn99RbCybuSXYLB0X2+t/ZyT+lAPOAhMQL8Cv8SiYEqe0Xha+slyVf5K1QhdVlkkqxv
         L5FBqrrpL7Cn04czAsuy5EP8TWnAhcZV+/RmdxDO+U1ilXwQ7c4hvX6hhK6ESirrguLu
         JiXdlwxklqhGYCciAQ0x6l5EXQ6i95RQAjvsEh0fPzl7HXZs0Dd1yXobMHo2eWLq6wiv
         BtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607158; x=1689199158;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vNkQwRnctNVe5gluH/Z+kM0GEySdeD1m1EQsCwQdjQ0=;
        b=DJ6sLFctNwWrQRQZMfkJ1y6lk8PefQTUhtBRFYz9NdsmKXSPMBSqN8wQ7gaJsvkFAU
         q2Gs0EoIE/nnLZjcgmIaU1X9MQB5WeoOanLdEGMHImoO1pcO0FdSRw7NzN6a+xA3q8rK
         vFEabqUdeWC5m9GKoLRMpQzgybNmtnEQKV+QLzhQwgLs5ANNjnpwMEL5KpGJWilND/Xx
         Sc6RxYYKHfKaQ5e7m6nAWNoPLGf40wvFueDRR+FhT1Y0ko8iVDSBUgZ9mbD6DvEJeS3N
         geRybAtoLPt7oTj9vQpyKAFNTVvLR/ffF/JZzNOIEMefTaaoSM2kQ3whKkaqAl0k4jt7
         52ug==
X-Gm-Message-State: AC+VfDySkSG2/S4crsSw71HJjERtXZZwJOFhtdvbXTRD3lRx6j4B/k5t
        t8WBYuTYv7kSWlB2UikR09UbsyUJG2Q=
X-Google-Smtp-Source: ACHHUZ6sxUfdQpc9tnWbH5LSW2ljpANM9vo9TCzPhNpqupT/iQWg0eKoVLtngkQzZiTtfOs1dPExtA==
X-Received: by 2002:a17:903:230f:b0:1a6:82ac:f277 with SMTP id d15-20020a170903230f00b001a682acf277mr8063086plh.14.1686607158073;
        Mon, 12 Jun 2023 14:59:18 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id io6-20020a17090312c600b001ab28f620d0sm8730631plb.290.2023.06.12.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:59:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] [RFC] http: reauthenticate on 401 Unauthorized
References: <pull.1521.git.git.1686474351611.gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 14:59:17 -0700
In-Reply-To: <pull.1521.git.git.1686474351611.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Sun, 11 Jun 2023 09:05:51
        +0000")
Message-ID: <xmqqmt147362.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> A credential helper may return a bad credential if the user's password
> has changed or a personal access token has expired. The user gets
> an HTTP 401 Unauthorized error. The user invariably retries the command.

... and no matter how many times the user retries, the command will
never succeed?  Is that the problem the patch tries to solve?

> To spare the user from retrying the command, in case of HTTP 401
> Unauthorized, call `credential fill` again and reauthenticate. This will
> succeed if a helper generates a fresh credential or the user enters a
> valid password.
>
> Keep current behaviour of asking user for username and password at
> most once. Sanity check that second credential differs from first before
> trying it.

Soon after changing the password is probably the time it is more
likely that you would mistype your password, than after you got used
to typing it over and over again.  I can understand the wish to
avoid asking for correct password forever, but giving just one
attempt feels a bit cruel for that reason.

> diff --git a/credential.h b/credential.h
> index b8e2936d1dc..c176b05981a 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -134,7 +134,9 @@ struct credential {
>  		 configured:1,
>  		 quit:1,
>  		 use_http_path:1,
> -		 username_from_proto:1;
> +		 username_from_proto:1,
> +		 /* Whether the user has been prompted for username or password. */
> +		 getpass:1;

Mental note: the comment here says "prompted".

>  	char *username;
>  	char *password;
> diff --git a/http.c b/http.c
> index bb58bb3e6a3..d2897c4d9d1 100644
> --- a/http.c
> +++ b/http.c
> @@ -1732,7 +1732,11 @@ static int handle_curl_result(struct slot_results *results)
>  	else if (results->http_code == 401) {
>  		if (http_auth.username && http_auth.password) {
>  			credential_reject(&http_auth);
> -			return HTTP_NOAUTH;
> +			if (http_auth.getpass) {
> +				/* Previously prompted user, don't prompt again. */
> +				return HTTP_NOAUTH;
> +			}
> +			return HTTP_REAUTH;

And here we also see "prompted" again.  Perhaps it will help make
the result easier to read if we renamed the new member from
"getpass" to another phrase that contains "prompt"?

>  		} else {
>  			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
>  			if (results->auth_avail) {
> @@ -2125,6 +2129,9 @@ static int http_request_reauth(const char *url,
>  			       struct http_get_options *options)
>  {
>  	int ret = http_request(url, result, target, options);
> +	int reauth = 0;
> +	char* first_username;
> +	char* first_password;

In our codebase, asterisk sticks to the variable, not type.

Thanks.

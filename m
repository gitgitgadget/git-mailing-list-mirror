Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26720C77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEDRmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRmo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 13:42:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F8E1
        for <git@vger.kernel.org>; Thu,  4 May 2023 10:42:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115eef620so14149426b3a.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683222162; x=1685814162;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeWIJjTPeuEjzHAhSigabVJyPHNuPSTccqBjrWlMjXg=;
        b=kYnFVJbx/xCk18ghwMWixSIFQ2HMkWG9cud1hdJmvFvDF+jxiqP7PP8R71qNlsa7sv
         gCPIrDiFN4IMkz4tFQ7WygZtGo+hkE2Jb0ZEwAJy0uQihPPXGmrFio7diTt5h0F1ahgc
         C6+W08GAYIHFrsYLWfBjmpG5zpNYAYGRZm4pmcxabT/UUyJd6AnGaE37AhC+xDX/goHz
         NtirDbK0WvCJOUQSsFEnpWhFww19lFuBaKi1es0Vns0QbNl+6WX4ov8f1rV042fQ1s8C
         7TNapxUVAu3Wr+pRlcVuudFMndEHRtOM8j+1z68MCZbhga5liOeELpYqZCwjAyLqWWDk
         WMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222162; x=1685814162;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jeWIJjTPeuEjzHAhSigabVJyPHNuPSTccqBjrWlMjXg=;
        b=LGYbd/x038KPo94ns5lxfr/jdg7Xie0EuXCaAM1pN7by+62U3iif462tUlnOM27Ezj
         W1OJqyOsKs9xMevHcg6NHYsqpBTL0tkUz7wr1Mfy9HytT3HhhTggaRtC6cj5wtvlqC4R
         MXaKOnYJF6/V8tDKDHsDoB0ZhL86IvfiCYvOlHGI1vlUUhEuerDCqlLyW9BY3ZXWfzCO
         I3Ea2mY7HEenESS5v9Qj8OeNH5YypJtB1GUNvRTy1wAGvWVRHxz7sAfdKX8q6Y/mw7Jb
         QhukUWwq4WewC0FW41YgzzNeylxLHQxj/++IoRR4wxOpYPsC6z7dtd8JaHCUvQikaijm
         L+gw==
X-Gm-Message-State: AC+VfDw6ExU16vtxltua0q9xmG5mj3cXtuQV/jM6A6GpdnPg8q0Fup3k
        PZmgTg+L8OTqlGaoaJJyjco=
X-Google-Smtp-Source: ACHHUZ6kCoHOISpyqWUhYQyXyHL6EXy6ct2SUxEMrGiRmLrWgbX3XuVac5hgbN8QqlkTGMMTdvbWKg==
X-Received: by 2002:a17:902:c943:b0:1a9:2a9e:30a8 with SMTP id i3-20020a170902c94300b001a92a9e30a8mr5358641pla.9.1683222162533;
        Thu, 04 May 2023 10:42:42 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm8532234plb.289.2023.05.04.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:42:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential/libsecret: support password_expiry_utc
References: <pull.1469.git.git.1678829531648.gitgitgadget@gmail.com>
        <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
Date:   Thu, 04 May 2023 10:42:41 -0700
In-Reply-To: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Sat, 25 Mar 2023 07:36:04
        +0000")
Message-ID: <xmqqjzxoj8mm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
> index 2c5d76d789f..3f2b530db79 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -39,6 +39,7 @@ struct credential {
>  	char *path;
>  	char *username;
>  	char *password;
> +	char *password_expiry_utc;
>  };
>  
>  #define CREDENTIAL_INIT { 0 }
> @@ -54,6 +55,20 @@ struct credential_operation {
>  
>  /* ----------------- Secret Service functions ----------------- */
>  
> +static const SecretSchema schema = {
> +	"org.git.Password",
> +	SECRET_SCHEMA_NONE,
> +	{
> +		{  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +		{  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +		{  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +		{  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
> +		{  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +		{  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
> +		{  NULL, 0 },
> +	}
> +};

We used to use the bog-standard "COMPAT_NETWORK" but now we are
adding an extra element, and that makes it necessary to define our
own?  OK.

>  static char *make_label(struct credential *c)
>  {
>  	if (c->port)
> @@ -78,6 +93,9 @@ static GHashTable *make_attr_list(struct credential *c)
>  		g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
>  	if (c->path)
>  		g_hash_table_insert(al, "object", g_strdup(c->path));
> +	if (c->password_expiry_utc)
> +		g_hash_table_insert(al, "password_expiry_utc",
> +			g_strdup(c->password_expiry_utc));
>  
>  	return al;
>  }
> @@ -101,9 +119,11 @@ static int keyring_get(struct credential *c)
>  
>  	attributes = make_attr_list(c);
>  	items = secret_service_search_sync(service,
> -					   SECRET_SCHEMA_COMPAT_NETWORK,
> +					   &schema,
>  					   attributes,
> -					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
> +					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK |
> +					   // for backwards compatibility

No // comments please.

> +					   SECRET_SCHEMA_DONT_MATCH_NAME,

SECRET_SCHEMA_DONT_MATCH_NAME does not seem to be listed as one of
the flags to be used with secret_service_search_sync(),

    https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/SecretService.php#secret-service-search-sync

and the only reference to it I found was as a flag to be placed in
the schema.

    https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/migrating-schemas.php
    https://www.manpagez.com/html/libsecret-1/libsecret-1-0.18.6/libsecret-SecretSchema.php

But I'll take your word for it.

I found nothing unexpected or surprising in the rest of the patch to
this file.  They all looked just a fallout of having to store and
retrieve one extra item from the database together with many other
things we already store and retrieve.  Cleanly written.

> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 5ea8bc9f1dc..9ebf7eeae48 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -43,6 +43,7 @@ helper_test_clean() {
>  	reject $1 https example.com store-user
>  	reject $1 https example.com user1
>  	reject $1 https example.com user2
> +	reject $1 https example.com user3
>  	reject $1 http path.tld user
>  	reject $1 https timeout.tld user
>  	reject $1 https sso.tld
> @@ -298,6 +299,35 @@ helper_test_timeout() {
>  	'
>  }
>  
> +helper_test_password_expiry_utc() {
> +	HELPER=$1
> +
> +	test_expect_success "helper ($HELPER) stores password_expiry_utc" '
> +		check approve $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user3
> +		password=pass
> +		password_expiry_utc=9999999999
> +		EOF
> +	'
>
> +	test_expect_success "helper ($HELPER) gets password_expiry_utc" '
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user3
> +		--
> +		protocol=https
> +		host=example.com
> +		username=user3
> +		password=pass
> +		password_expiry_utc=9999999999
> +		--
> +		EOF
> +	'
> +}
> +

Is any random number usable for this test, or is there some
constraints (like, "it cannot be too small to be a timestamp in the
past, because the entry will be expired immediately")?  If there is
some constraint like that, is it a good idea to also test that
(like, "make sure an entry with expiry already happened is
rejected")?

Thanks.


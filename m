Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8758FC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBFUg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBFUgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 15:36:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BF2A994
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 12:36:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so37756918ejb.8
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4gRAjESW0PPPtoRtImGStuvtUEP9GLEDb/7GvcDXS4=;
        b=pWSn8QVeKjeiWbfKnSklMWN45GatGwdhaHPFvX7/AFejpuVeBxsLuiRAeU2ZqCuyqu
         054X4BmuTlsuledXVT577SH/SffepDNn6tTvr6PaHruAFlraxt13k5YMGJtACz1oXoMA
         1KjdDijVOAD8GvWXWxwKkDLigYReGC6LkGcjQBtyeGW5JuFqt1yCxPu0wh53vx/Ii8Sg
         FqvSK2QKFmRuY8mgzzNWnWV7mg4iQ80rgJgzlOK5jlzGTNmVlmbiftoiPted/3gvmcAM
         xi1EWp56IEemkooTOX3pIDOi+g01QWdPYE+QVB6yoYbK5RsHu9f90MoC0yo8RWEbhMZp
         75OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4gRAjESW0PPPtoRtImGStuvtUEP9GLEDb/7GvcDXS4=;
        b=c70Wj/ODeIzFdBok+fKBunMFoWDiN6ugM0IM9NMVSCdlcmIDhn9n4QcNTRPKKdrTqj
         m/S6JtPJgxNYmTUC9EyzKZqDQGeiRNZtUZyUir597a3Qt1cMQ8JkIiZnt5QUAJu9ZGtL
         pTr2nVDRN9FRsm1ga8aO2rCdllj1lFcWVnknSyTqvBEfyVE7Owwa6maedZN9+HhVgIPy
         m3Gtx0TXF4fSNUz124QqpRdYpZ1yHhFEMe8xFr4SJUQkFj9f4mLf8mrklNP0csGzH5Md
         o+tSOwKKKO/LcPvJGvb4z99vAj9Cl95jup2NEhvV8JciWIG5QVliS5SKnQO4VMawoZ4S
         pIrA==
X-Gm-Message-State: AO0yUKXMl9BU5LuTxs8aZRXxhBZJ60mh5bsFIaHvuslaLDyjTIER4Viy
        +nmWtIVexedycXeptx9CvPJHUvVUhX14DBcU
X-Google-Smtp-Source: AK7set/y4xMuUOcWUHG2DUWL3QAD3x7bmcwNO1XVZlh2oi52h7YKFa79rC+2Q33tlxlsOo448XGqYQ==
X-Received: by 2002:a17:906:3e56:b0:877:7789:765a with SMTP id t22-20020a1709063e5600b008777789765amr697320eji.16.1675715781962;
        Mon, 06 Feb 2023 12:36:21 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id me17-20020a170906aed100b0083f91a32131sm5890237ejb.0.2023.02.06.12.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:36:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP8Ds-000VWR-1m;
        Mon, 06 Feb 2023 21:36:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v8 1/3] t5563: add tests for basic and anoymous HTTP access
Date:   Mon, 06 Feb 2023 21:32:53 +0100
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
Message-ID: <230206.86fsbi5y63.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Add a test showing simple anoymous HTTP access to an unprotected
> repository, that results in no credential helper invocations.
> Also add a test demonstrating simple basic authentication with
> simple credential helper support.
>
> Leverage a no-parsed headers (NPH) CGI script so that we can directly
> control the HTTP responses to simulate a multitude of good, bad and ugly
> remote server implementations around auth.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  t/lib-httpd.sh                 |  1 +
>  t/lib-httpd/apache.conf        |  6 +++
>  t/lib-httpd/nph-custom-auth.sh | 42 +++++++++++++++++
>  t/t5563-simple-http-auth.sh    | 86 ++++++++++++++++++++++++++++++++++
>  4 files changed, 135 insertions(+)
>  create mode 100755 t/lib-httpd/nph-custom-auth.sh
>  create mode 100755 t/t5563-simple-http-auth.sh
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 608949ea80b..2c49569f675 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -137,6 +137,7 @@ prepare_httpd() {
>  	install_script error-smart-http.sh
>  	install_script error.sh
>  	install_script apply-one-time-perl.sh
> +	install_script nph-custom-auth.sh
>  
>  	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
>  
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 0294739a77a..76335cdb24d 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -135,6 +135,11 @@ Alias /auth/dumb/ www/auth/dumb/
>  	SetEnv GIT_HTTP_EXPORT_ALL
>  	SetEnv GIT_PROTOCOL
>  </LocationMatch>
> +<LocationMatch /custom_auth/>
> +	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> +	SetEnv GIT_HTTP_EXPORT_ALL
> +	CGIPassAuth on
> +</LocationMatch>
>  ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
>  ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
>  ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
> @@ -144,6 +149,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
>  ScriptAlias /error_smart/ error-smart-http.sh/
>  ScriptAlias /error/ error.sh/
>  ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
> +ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
>  <Directory ${GIT_EXEC_PATH}>
>  	Options FollowSymlinks
>  </Directory>
> diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
> new file mode 100755
> index 00000000000..8f851aebac4
> --- /dev/null
> +++ b/t/lib-httpd/nph-custom-auth.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +VALID_CREDS_FILE=custom-auth.valid
> +CHALLENGE_FILE=custom-auth.challenge
> +ANONYMOUS_FILE=custom-auth.anonymous
> +
> +#
> +# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
> +#
> +# If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as a valid
> +# credential for the current request. Each line in the file is considered a
> +# valid HTTP Authorization header value. For example:
> +#
> +# Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
> +#
> +# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as headers
> +# in a 401 response if no valid authentication credentials were included in the
> +# request. For example:
> +#
> +# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> +# WWW-Authenticate: Basic realm="example.com"
> +#
> +
> +if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
> +	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")

Rather than "test -f "$f" & grep ... "$f" I think you can just use only
"grep", if the file doesn't exist it'll give you an error.

If you don't want to see that error just pipe it to /dev/null, in case
that's what you were trying to avoid with the "check if it exists
first".

> +echo 'HTTP/1.1 401 Authorization Required'
> +if test -f "$CHALLENGE_FILE"
> +then
> +	cat "$CHALLENGE_FILE"

Maybe the same here, i.e. just:

	cat "$f" 2>/dev/null

> +test_expect_success 'setup_credential_helper' '
> +	mkdir -p "$TRASH_DIRECTORY/bin" &&

The "$TRASH_DIRECTORY" is already created for you, so don't use "-p",
unless something went wrong here..

> +	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
> +	export PATH &&
> +
> +	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
> +	write_script "$CREDENTIAL_HELPER" <<-\EOF
> +	cmd=$1
> +	teefile=$cmd-query.cred
> +	catfile=$cmd-reply.cred
> +	sed -n -e "/^$/q" -e "p" >> $teefile

Style: ">>$f", not ">> $f"

> +	if test "$cmd" = "get"; then

Style: We usually use "\nthen", not "; then".

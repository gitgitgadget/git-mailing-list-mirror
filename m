Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13485C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 22:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiG0WLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiG0WKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 18:10:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2545FACA
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:09:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3592462pjq.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Es2Olm3GXXV+QJBs8VSeQERm7payhcnBIToqBCJmEQc=;
        b=Q+i3rntdYOXIhTZR0rZ7BAavW1MdzzUqS6+lqgc8jbMRGp9iUV57bnuPNX69dTaHig
         MPAOGiF0QoYqrss+N5ngV7fPeIt0vdRWI0gs79By86rKRMUgzxctO/tr7/ehl0vdQzTi
         L7qpJjkY/h8nLelm1GXmfBwKi3oS9k8e5uB+/BuXLWxn2+/xdHDym/Vewa3SqXc43Y5+
         G+8tfkdefvkadFsTmsMaeRIGQyWkEjPjhl065I/xUrbOBus1q1KWNEsocT9Fg6SP7gTv
         ob/KidVsirqSxiwMEN/cteyAwJJt7FFKPn0nPoFiLQ3ZJ1zgd/VV7FUrdaVBf7UZXXCB
         XGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Es2Olm3GXXV+QJBs8VSeQERm7payhcnBIToqBCJmEQc=;
        b=467K9PhwUPWTJMw8Cq1XUbx3JI1f3j/CBwcLDKntHyw0fYKfhTkMMMF1DuwGo4iS9l
         3y9Dr1t0I8XhEbn8bhqZiCB7dRwLQGr49qgKGSFsqL3W6oXGIQPm2WI9q6M7q5XrchfL
         Fv5MQpuezF1eXut+E8GCtnorNmU5HunEkNmeTlqV3BJDR6I+jEjjQ5kkb2mJG4YRUI3O
         Lxp8AtXE87qVOYaomL5+0wtos/nvwZRFGUnLAUIeK7FvqWUEzBYYlrdZL+3KRNR76my3
         HcVCkEq4ODc+GvPJ1IDPp6FgY5YBbsMo6lTtPxTolY4f+Xl9T5uQ/gnnsXQfIjp1u70l
         jFIw==
X-Gm-Message-State: AJIora+G9FVqY3kuSfXGXf4mJojmIS0MOS0vL7teR1Yq6MSCapYm6qhB
        KB4R57vQdZTHIoiTenThs2CeHA==
X-Google-Smtp-Source: AGRyM1t0y+5BmcFawbN6ZPrTjgGy/vB151gl6uWPvCsx5VNps51h5OxtZSki2xCa7pBqv6m1G+aX+A==
X-Received: by 2002:a17:903:32c3:b0:16d:328f:8988 with SMTP id i3-20020a17090332c300b0016d328f8988mr23037164plr.108.1658959777923;
        Wed, 27 Jul 2022 15:09:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6dea:f5ba:2fa:f9c3])
        by smtp.gmail.com with ESMTPSA id t125-20020a625f83000000b00517c84fd24asm14815821pfb.172.2022.07.27.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 15:09:37 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:09:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/5] bundle-uri: add support for http(s):// and file://
Message-ID: <YuG3miyCKtnv3Na/@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <f6bc3177332e8608d0ba300669853bbad01c3266.1658781277.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bc3177332e8608d0ba300669853bbad01c3266.1658781277.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change created the 'git clone --bundle-uri=<uri>' option.
> Currently, <uri> must be a filename.
> 
> Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
> and use git-remote-https as the way to download the data at that URI.
> Otherwise, check to see if file:// is present and modify the prefix
> accordingly.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c                | 70 +++++++++++++++++++++++++++++++++++--
>  t/t5558-clone-bundle-uri.sh | 45 ++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 3 deletions(-)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index b35babc36aa..7086382b186 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -23,10 +23,74 @@ static int find_temp_filename(struct strbuf *name)
>  	return 0;
>  }
>  
> -static int copy_uri_to_file(const char *file, const char *uri)
> +static int download_https_uri_to_file(const char *file, const char *uri)
>  {
> -	/* File-based URIs only for now. */
> -	return copy_file(file, uri, 0);
> +	int result = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	FILE *child_in = NULL, *child_out = NULL;
> +	struct strbuf line = STRBUF_INIT;
> +	int found_get = 0;
> +
> +	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
> +	cp.in = -1;
> +	cp.out = -1;
> +
> +	if (start_command(&cp))
> +		return 1;
> +
> +	child_in = fdopen(cp.in, "w");
> +	if (!child_in) {
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	child_out = fdopen(cp.out, "r");
> +	if (!child_out) {
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	fprintf(child_in, "capabilities\n");
> +	fflush(child_in);
> +
> +	while (!strbuf_getline(&line, child_out)) {
> +		if (!line.len)
> +			break;
> +		if (!strcmp(line.buf, "get"))
> +			found_get = 1;
> +	}
> +	strbuf_release(&line);
> +
> +	if (!found_get) {
> +		result = error(_("insufficient capabilities"));
> +		goto cleanup;
> +	}
> +
> +	fprintf(child_in, "get %s %s\n\n", uri, file);
> +
> +cleanup:
> +	if (child_in)
> +		fclose(child_in);
> +	if (finish_command(&cp))
> +		return 1;
> +	if (child_out)
> +		fclose(child_out);
> +	return result;
> +}
> +
> +static int copy_uri_to_file(const char *filename, const char *uri)
> +{
> +	const char *out;
> +
> +	if (skip_prefix(uri, "https:", &out) ||
> +	    skip_prefix(uri, "http:", &out))
> +		return download_https_uri_to_file(filename, uri);

Since we're not using "out" here, should we replace the skip_prefix()s
with starts_with(), or perhaps even istarts_with()?


> +	if (!skip_prefix(uri, "file://", &out))
> +		out = uri;
> +
> +	/* Copy as a file */
> +	return copy_file(filename, out, 0);
>  }
>  
>  static int unbundle_from_file(struct repository *r, const char *file)
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index f709bcb729c..ad666a2d28a 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -33,4 +33,49 @@ test_expect_success 'clone with path bundle' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone with file:// bundle' '
> +	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
> +		clone-from clone-file &&
> +	git -C clone-file rev-parse refs/bundles/topic >actual &&
> +	git -C clone-from rev-parse topic >expect &&
> +	test_cmp expect actual
> +'
> +
> +#########################################################################
> +# HTTP tests begin here
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'fail to fetch from non-existent HTTP URL' '
> +	test_when_finished rm -rf test &&
> +	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
> +	grep "failed to download bundle from URI" err
> +'
> +
> +test_expect_success 'fail to fetch from non-bundle HTTP URL' '
> +	test_when_finished rm -rf test &&
> +	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
> +	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
> +	grep "is not a bundle" err
> +'
> +
> +test_expect_success 'clone HTTP bundle' '
> +	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
> +
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&
> +
> +	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
> +		"$HTTPD_URL/smart/fetch.git" clone-http &&
> +	git -C clone-http rev-parse refs/bundles/topic >actual &&
> +	git -C clone-from rev-parse topic >expect &&
> +	test_cmp expect actual &&
> +
> +	test_config -C clone-http log.excludedecoration refs/bundle/
> +'
> +
> +# Do not add tests here unless they use the HTTP server, as they will
> +# not run unless the HTTP dependencies exist.
> +
>  test_done
> -- 
> gitgitgadget
> 

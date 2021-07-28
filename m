Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE1CC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B076101B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 22:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhG1WcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhG1WcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 18:32:13 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF89C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:32:10 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so2824349qvb.14
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aUe40Je4QzcN+OGBJV83lFSYTYT9rx0rWe7p6TvAMZ8=;
        b=FlhYlmzMvPYMst9V8WKy256sYRUr69E7+R7/v8kZs5AsrULsW+/7tglS4l4yL5/zeG
         SasLQNDzy8H6ID3RxMenp33v7S7GxrNlcs6eJBCVomZsYFa7n4g3YgTn6AibErUCjxp5
         fEtB9mA+MMWZKJ39Vg0tl6diyd/b1bq8oFNprY77c/eUuQfa+LL71RtJ/F1oamB6ICTl
         Lys9EmVC709iBp029QTM1xKBK2nfU8QBOa87uXQDsrbmeElsNLIUr6f8H1MxkkiQIxZw
         cyx2+EW+vYVgH3xYp4J88oDd02XpyEx4ccLvRR1+W/21SrFe3baiYLDxBPh3wwfUYQU1
         vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aUe40Je4QzcN+OGBJV83lFSYTYT9rx0rWe7p6TvAMZ8=;
        b=NTQWqtOlXk16LplpkNquAhqFNRxXw+bv4O+FI1BOgTi1KfUrwZhOH0yOEc02opOEEG
         G4iqfHXOWydyE+bpA1ti76VreGJHlBcAYFSLhv1gtvjinpX96zPgzjU3yiGpQ4Ld/CZ1
         WijC3Z6cm0youUzTPJncXmFlMuUBwBnWvUd5VUH5KWqbiR3p+d8Xpq2eVI63RwUiWvoX
         g8NtD0Hc3vjwunyL0LEhwjWgnhys6vofVQLoeqFYRr9gsljhcC8D/KMPL9O6/WI369XN
         xbuez9OogPqKsijQRj8hf6xLUPtgdZCcV3Cn0YRDlU22/D/giJVi69c5p9y436ChHoSU
         kaAA==
X-Gm-Message-State: AOAM530zC9CYxwwFnNZ1G3PJNM7MtEMcshFtd0yzHpBLcvd+mNomISr+
        bh5smvUaA71Z97MlaRUcDQ/TuF7hPHyhzFbJO3pd
X-Google-Smtp-Source: ABdhPJyFFkPdggrVNT4DtC9z+KymY2pqG28v0aUi/6PlMA/sZvOllSE6mVOYh1prHTkzoKSas1FlOVE7h9UORC9Q5itH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1303:: with SMTP id
 a3mr2369776qvv.49.1627511529882; Wed, 28 Jul 2021 15:32:09 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:32:06 -0700
In-Reply-To: <7c8502c65b833e7e563a833b592f6932421b1056.1627501009.git.gitgitgadget@gmail.com>
Message-Id: <20210728223206.2715554-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <7c8502c65b833e7e563a833b592f6932421b1056.1627501009.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v6 1/9] ssh signing: preliminary refactoring and clean-up
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, fs@gigacodes.de,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this patch set is beyond the "is this a good idea in general"
phase (in particular, I think that being able to sign Git commits by
using SSH infrastructure is very useful), so I'll proceed to critiquing
the commits in more detail.

Firstly, in commit messages, the left side of the colon is usually the
name of the subsystem - in this case, "gpg-interface".

> To be able to implement new signing formats this commit:
>  - makes the sigc structure more generic by renaming "gpg_output" to
>    "output"
>  - introduces function pointers in the gpg_format structure to call
>    format specific signing and verification functions
>  - moves format detection from verify_signed_buffer into the check_signature
>    api function and calls the format specific verify
>  - renames and wraps sign_buffer to handle format specific signing logic
>    as well

I think that this commit should be further split up - in particular, it
is hard for reviewers to verify that there is no difference in
functionality before and after this commit. I already spotted one
difference - perhaps there are more. For me, splitting the above 4
points into 4 commits would be an acceptable split.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 127aecfc2b0..31cf4ba3938 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -15,6 +15,12 @@ struct gpg_format {
>  	const char *program;
>  	const char **verify_args;
>  	const char **sigs;
> +	int (*verify_signed_buffer)(struct signature_check *sigc,
> +				    struct gpg_format *fmt, const char *payload,
> +				    size_t payload_size, const char *signature,
> +				    size_t signature_size);
> +	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
> +			   const char *signing_key);
>  };

[snip]

>  static struct gpg_format gpg_format[] = {
> -	{ .name = "openpgp", .program = "gpg",
> -	  .verify_args = openpgp_verify_args,
> -	  .sigs = openpgp_sigs
> +	{
> +		.name = "openpgp",
> +		.program = "gpg",
> +		.verify_args = openpgp_verify_args,
> +		.sigs = openpgp_sigs,
> +		.verify_signed_buffer = verify_gpg_signed_buffer,
> +		.sign_buffer = sign_buffer_gpg,
>  	},
> -	{ .name = "x509", .program = "gpgsm",
> -	  .verify_args = x509_verify_args,
> -	  .sigs = x509_sigs
> +	{
> +		.name = "x509",
> +		.program = "gpgsm",
> +		.verify_args = x509_verify_args,
> +		.sigs = x509_sigs,
> +		.verify_signed_buffer = verify_gpg_signed_buffer,
> +		.sign_buffer = sign_buffer_gpg,
>  	},
>  };

I think that verify_signed_buffer and sign_buffer should replace
verify_args and sigs, not be alongside them. In particular, I see from
later patches that a new entry will be introduced for SSH, and the
corresponding new "verify" function does not use verify_args or sigs.

> @@ -279,10 +300,6 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>  		return -1;
>  	}
>  
> -	fmt = get_format_by_sig(signature);
> -	if (!fmt)
> -		BUG("bad signature '%s'", signature);

Here is the difference in functionality that I spotted. Here, lack of
fmt is fatal...

> @@ -309,35 +330,32 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>  int check_signature(const char *payload, size_t plen, const char *signature,
>  	size_t slen, struct signature_check *sigc)
>  {
> -	struct strbuf gpg_output = STRBUF_INIT;
> -	struct strbuf gpg_status = STRBUF_INIT;
> +	struct gpg_format *fmt;
>  	int status;
>  
>  	sigc->result = 'N';
>  	sigc->trust_level = -1;
>  
> -	status = verify_signed_buffer(payload, plen, signature, slen,
> -				      &gpg_output, &gpg_status);
> -	if (status && !gpg_output.len)
> -		goto out;
> -	sigc->payload = xmemdupz(payload, plen);
> -	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
> -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
> -	parse_gpg_output(sigc);
> +	fmt = get_format_by_sig(signature);
> +	if (!fmt)
> +		return error(_("bad/incompatible signature '%s'"), signature);

...but here it is not.

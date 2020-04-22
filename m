Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E0C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D898220704
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7OZQB8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVX5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDVX5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:57:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F4C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:57:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so1590628plp.9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O5haFmf9YrjLL6E74d2vP99C+LpHWGhZCBGI6r/XhAY=;
        b=W7OZQB8B0x97vlzgKqV+qy+iaJ5oUXuoZWweHml4P518/TyVA6KrPGkLg4UVMe7mH/
         xjCK6Bjgy0RCTQkdmphgSHjrT7fvY+a/VFTKoJTu7kf91HJzqZFk3ifdrLL14M0N4yZy
         eL20n2oQagrZG3urUcmNl9Kt5N4gsuJMncdIflkbbOqCht/iRm3IIZbibQd/PM9HxUPp
         c4p9bT0o8KkcQwUp4xPSqpOUFWSA+1lj1i+Zrrnd5G3ztSzQNjHhvkfuFcxL6KzrWile
         s2yKzyYtLllGpFku/uZmyO9M34PjJb5cnXA5Z9pk5V/8BqRMSmR484UlO3o5WRTo1Yy6
         STAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O5haFmf9YrjLL6E74d2vP99C+LpHWGhZCBGI6r/XhAY=;
        b=jjYmyemN98wB/ePJ0uWNjGnUO6l1n9Zw/W85BoKjYcYV72zm5YslvdypYG3KBqBJbD
         DZ0RbelT+jv55s09CeygrqU3IV6rXX/uBnHhL/1gwhbHrA/fVHZyb2vqe5zVUXawZtzY
         9vZRYHxn94Smxz8FRkx+ooLCt2JfRSiutWxLGEm/56LAmzKU8OSTIN2escIhFIpwROzs
         24b+NkkLImz2QoKpMCKN/euFx0YQUb/OQk3dSBnePqk6EPF7bRINFhUxJsTBK2db/0dz
         D5emcKZpg8V/x4ZOmTPFUuUY50AH4Ku66YhwaGrAiTGbungsCwexbHbJIPUorVRrjEXW
         Dmcg==
X-Gm-Message-State: AGi0PuYSI8IY4O0LKesVTDnDvYdn8N397ftbprpjcAM1la2XMrSUvH7E
        /7T0htitFSBHW1oVN0vcbYc=
X-Google-Smtp-Source: APiQypJ1sNei7oe3LxVJufkfqwUniaIM1pW6/XA7VVAshK0soaf1VDUeCWo2R0Dy1kbyTPYfBkEaHg==
X-Received: by 2002:a17:902:7795:: with SMTP id o21mr1157083pll.202.1587599830499;
        Wed, 22 Apr 2020 16:57:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id d8sm641452pfd.159.2020.04.22.16.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:57:09 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:57:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
Message-ID: <20200422235708.GF140314@google.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <66823c735b1d5ea2047a29656e82fa6fe895f6f1.1587588665.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66823c735b1d5ea2047a29656e82fa6fe895f6f1.1587588665.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> In the patches for CVE-2020-11008, the ability to specify credential
> settings in the config for partial URLs got lost. For example, it used
> to be possible to specify a credential helper for a specific protocol:
>
> 	[credential "https://"]
> 		helper = my-https-helper
>
> Likewise, it used to be possible to configure settings for a specific
> host, e.g.:
>
> 	[credential "dev.azure.com"]
> 		useHTTPPath = true

Ah, I see.

[...]
> --- a/credential.c
> +++ b/credential.c
> @@ -53,7 +53,12 @@ static int credential_config_callback(const char *var, const char *value,
>  		char *url = xmemdupz(key, dot - key);
>  		int matched;
>  
> -		credential_from_url(&want, url);
> +		if (credential_from_url_gently(&want, url, 0, 0) < 0) {
> +			warning(_("skipping credential lookup for url: %s"), url);
> +			credential_clear(c);

Hm, the error message doesn't seem right here, since `url` is a config
key instead of URL whose credential's are being looked up.

Should the error message include the entirety of `var` to make
debugging easier?

[...]
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -448,4 +448,17 @@ test_expect_success 'credential system refuses to work with missing protocol' '
>  	test_i18ncmp expect stderr
>  '
>  
> +test_expect_success 'credential config accepts partial URLs' '
> +	echo url=https://example.com |
> +	git -c credential.example.com.username=boo \
> +		credential fill >actual &&

Can the tests also check the behavior with bad URLs (that we are
appropriately tolerating and warning about them?

Stepping back: one thing I like about the code in "master" that uses
urlmatch_config_entry is that it is not treating these config keys
in the same way as URLs that Git would fetch from.  For example, if
one of the config keys contains %0a, then that's perfectly fine ---
we are not going to write them to a credential helper or to libcurl.

The only problem is that the pattern matching syntax doesn't match
the behavior that users historically expected.  (Keeping in mind
that we never actually provided the behavior that users expected.
`credential.example.com.helper` settings applied to all hosts.)

Would it make sense for parsing these config url patterns to share
*less* code with credential_from_url?  Ramifications:

- unless we add specific support for it, we'd lose support for
  patterns that are specific to a user (e.g.
  "credential.https://user@example.com.helper").

- likewise, we'd lose support for
  "credential.https://user:pass@example.com.helper".

- we could control what "credential.https:///repo.git.helper"
  means, for example by rejecting it.  When we reject it, the
  error message could be specific to this use case instead of
  shared with other URL handling.

- we wouldn't suport "credential.example.com/repo.git.helper"
  by mistake.

- to sum up, we could specifically define exactly what cases we want
  to support:

	[credential "example.com"]
		# settings for the host
		...

	[credential "user@example.com"] # maybe
		# settings for the host/user combination
		...

	[credential "https://"]
		# settings for the scheme
		...

	[credential "https://example.com"]
		# settings for the host/scheme combination
		...

	[credential "https://example.com/"]
		# likewise
		...

	[credential "https://user@example.com"] # maybe
		# settings for the host/scheme/user combination
		...

	[credential "https://user@example.com/"] # maybe
		# likewise
		...

	[credential "https://example.com/repo.git"]
		# settings for the host/scheme/path combination
		...

	[credential "https://user@example.com/repo.git"] # maybe
		# settings for the host/scheme/user/path combination
		...

  without accidentally promising support for anything else

What do you think?

Thanks,
Jonathan

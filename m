Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E295C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiCGPnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbiCGPnr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:43:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1531218
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:42:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id yy13so24011541ejb.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DGpb6p3U3pWorQ2uCjJaiF+9TdxybNV/H9Lz96uKpng=;
        b=C0O0NTni2wMnFMw4ljRyiKuCY19aqg99y9MCQYGLtkAojfgqHSaCfWRaW1flqGNxCW
         HhvUB9TOkiTOvuIMWcbIsHM2iqnFjU7iODcQNNk0f2OBKdVgt/slCQ2V9xGxazgC9IH0
         Y6Ra7oPAA02Yz7BPtigeJyqF6kCp9MoyBFWtG6o8c83HSJZdOND4h1PRm8gM/PZK38Py
         Amsxgi9vS8XzhsYJ2FYg+Ht5R8cVVZUL23Ke07M5apKjDueBRskPQJe1T1vR+tKxSGMG
         d5RPHUsFaQm/YSrqaswW4yTxpqH3RSIxMczxq3So3FzkaYzYcpiem+q7/pPiPfm5OswW
         +UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DGpb6p3U3pWorQ2uCjJaiF+9TdxybNV/H9Lz96uKpng=;
        b=cMOYI1gjZuGk0Yj5uW0Tkq7hJ5xcaYD/3DYFKXcaYiJb9T1MaQcjHBx2pZ/2/NXJ6l
         gj+bcnPUldhSZQ5hKbbTI0361L5TZ/awwn93ph27wtCLe8JVq5BuGuDK6xEUnr7O1XmM
         5sL82vEZKg1O/wUZWKfibySUpALqIzWPbEQ6g48r1RSHkPsVX+bBzsCCXMBD2ndD7VKv
         XCzVgRcmvn+85WKlCh1MZEjX84tM8aND3py0zXv3Qpa+6/kjiDOETawH/tdYtqGRGZqD
         nUyJ+lyXq8UpIHNNGv2C5+r0Nyw9OGqj06B3zTWcoTV3V/xhHi90YSSiCHSjVGGZFYCU
         wW9w==
X-Gm-Message-State: AOAM532Tlce6DULUp8o29FLjD0kl4Vipvn61rVjhHNZAfbv+KaVKJwdR
        vY2ix0jR1Qk/OQf5Bt7PE2zWSsRXAOQC9w==
X-Google-Smtp-Source: ABdhPJxP726Is60ZIO+5pXBuedvqLJIc6AdV1VS2sCcJQ7u7oPbGu7dMRKGFf9XYXl5QPZCPx2Nthw==
X-Received: by 2002:a17:907:608b:b0:6da:8fa8:27e8 with SMTP id ht11-20020a170907608b00b006da8fa827e8mr9564024ejc.168.1646667770078;
        Mon, 07 Mar 2022 07:42:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w22-20020a05640234d600b004165de83109sm807268edc.48.2022.03.07.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:42:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFVY-001Ztm-SD;
        Mon, 07 Mar 2022 16:42:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 08/11] bundle: parse filter capability
Date:   Mon, 07 Mar 2022 16:38:30 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
Message-ID: <220307.86bkyhzs3r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The v3 bundle format has capabilities, allowing newer versions of Git to
> create bundles with newer features. Older versions that do not
> understand these new capabilities will fail with a helpful warning.
>
> Create a new capability allowing Git to understand that the contained
> pack-file is filtered according to some object filter. Typically, this
> filter will be "blob:none" for a blobless partial clone.
>
> This change teaches Git to parse this capability, place its value in the
> bundle header, and demonstrate this understanding by adding a message to
> 'git bundle verify'.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle.c                      | 17 ++++++++++++++++-
>  bundle.h                      |  3 +++
>  list-objects-filter-options.c |  2 +-
>  list-objects-filter-options.h |  5 +++++
>  4 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index dc56db9a50a..2afced4d991 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -11,7 +11,7 @@
>  #include "run-command.h"
>  #include "refs.h"
>  #include "strvec.h"
> -
> +#include "list-objects-filter-options.h"
>  
>  static const char v2_bundle_signature[] = "# v2 git bundle\n";
>  static const char v3_bundle_signature[] = "# v3 git bundle\n";
> @@ -33,6 +33,8 @@ void bundle_header_release(struct bundle_header *header)
>  {
>  	string_list_clear(&header->prerequisites, 1);
>  	string_list_clear(&header->references, 1);
> +	list_objects_filter_release(header->filter);
> +	free(header->filter);
>  }
>  
>  static int parse_capability(struct bundle_header *header, const char *capability)
> @@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
>  		header->hash_algo = &hash_algos[algo];
>  		return 0;
>  	}
> +	if (skip_prefix(capability, "filter=", &arg)) {
> +		CALLOC_ARRAY(header->filter, 1);
> +		parse_list_objects_filter(header->filter, arg);
> +		return 0;
> +	}
>  	return error(_("unknown capability '%s'"), capability);
>  }
>  
> @@ -220,6 +227,8 @@ int verify_bundle(struct repository *r,
>  	req_nr = revs.pending.nr;
>  	setup_revisions(2, argv, &revs, NULL);
>  
> +	revs.filter = header->filter;
> +
>  	if (prepare_revision_walk(&revs))
>  		die(_("revision walk setup failed"));
>  
> @@ -259,6 +268,12 @@ int verify_bundle(struct repository *r,
>  			     r->nr),
>  			  r->nr);
>  		list_refs(r, 0, NULL);
> +
> +		if (header->filter) {
> +			printf_ln("The bundle uses this filter: %s",
> +				  list_objects_filter_spec(header->filter));
> +		}
> +
>  		r = &header->prerequisites;
>  		if (!r->nr) {
>  			printf_ln(_("The bundle records a complete history."));
> diff --git a/bundle.h b/bundle.h
> index 06009fe6b1f..eb026153d56 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -5,11 +5,14 @@
>  #include "cache.h"
>  #include "string-list.h"
>  
> +struct list_objects_filter_options;
> +

For the other ones we include the relevant header, do the same here (or
if there's a need to not do it, do we need it for the rest too?)

>  struct bundle_header {
>  	unsigned version;
>  	struct string_list prerequisites;
>  	struct string_list references;
>  	const struct git_hash_algo *hash_algo;
> +	struct list_objects_filter_options *filter;
>  };

I haven't tried, but any reason this needs to be a *filter
v.s. embedding it in the struct?

Then we'd just need list_objects_filter_release() and not the free() as
well.

Is it because you're piggy-backing on "if (header->filter)" as "do we
have it" state, better to check .nr?

> @@ -55,7 +55,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
>   * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
>   * convenience of the current command.
>   */

These API docs....

> -static int gently_parse_list_objects_filter(
> +int gently_parse_list_objects_filter(
>  	struct list_objects_filter_options *filter_options,
>  	const char *arg,
>  	struct strbuf *errbuf)
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index da5b6737e27..347a99c28cf 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -72,6 +72,11 @@ struct list_objects_filter_options {
>  /* Normalized command line arguments */
>  #define CL_ARG__FILTER "filter"

...should be moved here, presumably.

> +int gently_parse_list_objects_filter(
> +	struct list_objects_filter_options *filter_options,
> +	const char *arg,
> +	struct strbuf *errbuf);
> +

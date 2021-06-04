Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DFC4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7732613DE
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFDV1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:27:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABCDC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 14:25:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k11so9142421qkk.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YUSEG7L9BLi83+rI9qkeRkMdAWE8XASTCrWHEDJ4Dxs=;
        b=hWl37o14Xtcz6Uz68vTtmGLiLEGTU90sCUDl5F3MLmjpSV1w5EOqF+8/edw4ed3aNc
         NhJScDV5xRppX8l6ihKKxqUSURwlGuwELPWwy9E1eKMwhaxlluK8EoxiriTe5Id0g/DF
         7KJSosfXeAsu6UrP4S8WAnU6bHmD0haMJdxfVHqnJ3lqeuA6VTy5KiVRubEsFoPhBslO
         O+AQt3cUiYLV/vfHiux/CkgK2zKAIFC54dC/EP/LdB0kUfnuXtCI8DE1Azbuzzsd5QDO
         u5wtq1c6GBMpt+hmFrAbwJdq9N6RGf88TNoS6OUd85ZCZ7WPXHxgI9EqUzzftkRsf59E
         HY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUSEG7L9BLi83+rI9qkeRkMdAWE8XASTCrWHEDJ4Dxs=;
        b=bPjWqFabXxlDT0N71Ra1Nk9czX0sKrmVMv4CidZG9i9opo3iaM9gLeop8A4sVlc2Xa
         ltCUy0GwEVVrV9C9x6AEy2jMxrdAQmVPnQ2THBkzhAEcRACklWRuXHWLxx+82tSk0YG6
         6woEgnqDYPNnE8+oGlWI+DQQLubR6Iz5CGF89t5uqar9wBzFN5Qo+RcgMmDU8o0CUiwm
         up+0J6N1ErbZfmGD5GgkZ97juplBlhWMduUb7TgwjDWgmfnWNFLxaytqawn9IY78VpIO
         X7bXJ+WE+2P7QgVkb760PIjW742HEoKok6foh4QOjeCfYlunpi/enQAdDI8aQyNpiWnn
         At2A==
X-Gm-Message-State: AOAM533TzRGMoSRMu17AsG3dMadyFYLE4Z3PayH+uF14Mp+knIIzZyCI
        LQ/XXiuHD2V4yvSgqB763S1tCCaG3R5F6Obl
X-Google-Smtp-Source: ABdhPJzKwt6T5/wHxRuIQDywjxNC8I5xjD/5llLx9DYPwYp2AIL7AOclpokf9OJoQs8wWrZjp7RYjQ==
X-Received: by 2002:a05:620a:13a8:: with SMTP id m8mr6016123qki.213.1622841948329;
        Fri, 04 Jun 2021 14:25:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e28c:b821:dd88:1fd1])
        by smtp.gmail.com with ESMTPSA id m14sm4249174qti.12.2021.06.04.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:25:47 -0700 (PDT)
Date:   Fri, 4 Jun 2021 17:25:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
Message-ID: <YLqaWm9NOmtENT2J@nand.local>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:19PM -0700, Jonathan Tan wrote:
> This is one step towards supporting partial clone submodules.
>
> Even after this patch, we will still lack partial clone submodules
> support, primarily because a lot of Git code that accesses submodule
> objects does so by adding their object stores as alternates, meaning
> that any lazy fetches that would occur in the submodule would be done
> based on the config of the superproject, not of the submodule. This also
> prevents testing of the functionality in this patch by user-facing
> commands. So for now, test this mechanism using a test helper.

OK. Everything you wrote seemed reasonable to me, but I did have a
couple of questions on the test you added:

> diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> new file mode 100644
> index 0000000000..e7bc7eb21f
> --- /dev/null
> +++ b/t/helper/test-partial-clone.c
> @@ -0,0 +1,34 @@
> +#include "cache.h"
> +#include "test-tool.h"
> +#include "repository.h"
> +#include "object-store.h"
> +
> +static void object_info(const char *gitdir, const char *oid_hex)
> +{
> +	struct repository r;
> +	struct object_id oid;
> +	unsigned long size;
> +	struct object_info oi = {.sizep = &size};
> +	const char *p;
> +
> +	if (repo_init(&r, gitdir, NULL))
> +		die("could not init repo");
> +	if (parse_oid_hex(oid_hex, &oid, &p))
> +		die("could not parse oid");
> +	if (oid_object_info_extended(&r, &oid, &oi, 0))
> +		die("could not obtain object info");
> +	printf("%d\n", (int) size);
> +}

Hmm. Is there a reason that the same couldn't be implemented by calling "git
cat-file -s" from the partial clone?

> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 584a039b85..e804d267e6 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -604,6 +604,30 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
>  	git -C repo cherry-pick side1
>  '
>
> +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> +	rm -rf full partial.git &&
> +	test_create_repo full &&
> +	printf 12345 >full/file.txt &&
> +	git -C full add file.txt &&
> +	git -C full commit -m "first commit" &&

This is a stylistic nit, but I think using test_commit is better here
for a non-superficial reason. My guess is that you wanted to avoid
specifying a message and file (which are required positional arguments
to test_commit before you can specify the contents). But I think there
are two good reasons to use test_commit here:

  - It saves three lines of test script here.
  - You don't have to make the expected size a magic number (i.e.,
    because you knew ahead of time that the contents was "12345").

I probably would have expected this test to end with:

  git -C full cat-file -s $FILE_HASH >expect &&
  git -C partial.git cat-file -s $FILE_HASH >actual &&
  test_cmp expect actual

which reads more clearly to me (although I think the much more important
test is that $FILE_HASH doesn't show up in the output of the rev-list
--missing=print that is run in the partial clone).

> +
> +	test_config -C full uploadpack.allowfilter 1 &&
> +	test_config -C full uploadpack.allowanysha1inwant 1 &&
> +	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> +	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&

This works for me, although I wouldn't have been sad to see the
sub-shell contain "git -C full rev-parse HEAD:file.txt" instead.

> +	# Sanity check that the file is missing
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	grep "[?]$FILE_HASH" out &&
> +
> +	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&

Coming back to my point about the utility of the partial-clone helper,
could this be replaced by saying just OUT="$(git -C partial.git cat-file
-s "$FILE_HASH")" instead?

Thanks,
Taylor

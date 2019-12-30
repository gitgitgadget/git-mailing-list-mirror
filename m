Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C57C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DAE206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mpgNEgnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfL3Swg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:52:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfL3Swf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:52:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B93B94980;
        Mon, 30 Dec 2019 13:52:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EZj+1d7jeAaOZHgf+Wb7x8ZWl60=; b=mpgNEg
        nSTD789SqRvIaMK8M8AJm4U72a/ymCtRxQ4CwwcxhsRwD+McM923jYxKc2V2Jc+K
        z8yGvNWzg9ifnhvTbduTJju8JILVzpC4A0eIJmuFfIsoEWZNLW9zgyuD1qoO+5WM
        VUubTNoyXn9irmuV7VCalsM2Jn5Dnkx5786fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G/MNOJOW+ayvR3GaJ+5izx1NGHVucwfJ
        +i6TzSHWkQdzYblfqqNf2I9YbtDbLHD42Xk2xJ6x1KEuab+cNRqOkbQYnS2+NVBB
        APXhGptE3l3XEUh5KNcNYRxY2NJGGyAI6Kka+Onfxw1iOK0VCmGv0Icaqj35DPK0
        88GCoBDkihU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64B6D9497F;
        Mon, 30 Dec 2019 13:52:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CAA79497E;
        Mon, 30 Dec 2019 13:52:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/3] t: directly test parse_pathspec_file()
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
        <27383a5b084b5e68152b08eb96fb4ddaf6d87f82.1577727747.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 10:52:28 -0800
In-Reply-To: <27383a5b084b5e68152b08eb96fb4ddaf6d87f82.1577727747.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 30 Dec 2019
        17:42:26 +0000")
Message-ID: <xmqq8smthcib.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 881FC01E-2B35-11EA-BB86-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
> new file mode 100644
> index 0000000000..e7f525feb9
> --- /dev/null
> +++ b/t/helper/test-parse-pathspec-file.c
> @@ -0,0 +1,34 @@
> +#include "test-tool.h"
> +#include "parse-options.h"
> +#include "pathspec.h"
> +#include "gettext.h"
> + ...
> +	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
> +			    pathspec_file_nul);
> +
> +	for (i = 0; i < pathspec.nr; i++) {
> +		printf("%s\n", pathspec.items[i].original);
> +	}

No need for {} around a single statement block.

> diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
> new file mode 100755
> index 0000000000..df7b319713
> --- /dev/null
> +++ b/t/t0067-parse_pathspec_file.sh
> @@ -0,0 +1,89 @@
> +#!/bin/sh
> +
> +test_description='Test parse_pathspec_file()'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'one item from stdin' '
> +	echo fileA.t | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	fileA.t
> +	EOF
> +	test_cmp expect actual
> +'

The use of the blank lines are somewhat inconsistent here.

> + ...
> +test_expect_success 'NUL delimiters' '
> +	printf "fileA.t\0fileB.t\0" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&

Fold line immediately after the pipe (same for the earlier and later ones).

> +	cat >expect <<-\EOF &&
> +	fileA.t
> +	fileB.t
> +	EOF
> +	test_cmp expect actual
> +'

If you want to have a gap between the steps, i.e. "capturing the
actual output", "creating the ideal output", and "seeing how they
differ", using blank like this is OK:

	printf "fileA.t\0fileB.t\0" |
	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&

	cat >expect <<-\EOF &&
	fileA.t
	fileB.t
	EOF

	test_cmp expect actual

I thought we typically prepare the ideal output sample before
capturing the actual output, so if we follow that convention, the
above becomes

	cat >expect <<-\EOF &&
	fileA.t
	fileB.t
	EOF

	printf "fileA.t\0fileB.t\0" |
	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&

	test_cmp expect actual


> +test_expect_success 'quotes' '
> +	# shell  takes \\\\101 and spits \\101
> +	# printf takes   \\101 and spits  \101
> +	# git    takes    \101 and spits     A
> +	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	fileA.t
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--pathspec-file-nul takes quotes literally' '
> +	# shell  takes \\\\101 and spits \\101
> +	# printf takes   \\101 and spits  \101
> +	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	"file\101.t"
> +	EOF
> +	test_cmp expect actual
> +'

Testing low level machinery like this is of course a good idea, in
addition to the end-to-end tests that make sure that the machinery
is called correctly from the higher layer.

Thanks.

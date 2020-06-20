Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA34C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36C123F57
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xS/BIlRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgFTQyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:54:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50380 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFTQyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 12:54:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FAC276DC4;
        Sat, 20 Jun 2020 12:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=40BdrOWpvBhz9Aqi37jVC+raemE=; b=xS/BIl
        RLK/s/ZB8cDitaTfNK067kIVisQK/xFnpeGJJPejRkjVL9iNHr8uQA5+JCXQsSrr
        frdoRgC8KjpPzj55DCtIqYcCJJqqf5NufWipcOmHZ59fhz85AOWBuGYgBNZj/Z37
        am0cF9r70T0ob0JfpYX2YHJpxOQ6zIOzcg+c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7pvwQDuH7TVt8EYcXk/m0r+8myuw2Cp
        RgNnlA3SKvkpW5mZynM3ytKdufew+z4T450ZybSHD+4RJa2fiBEMoVl5Pdq3mhE3
        iqaxMRShYir2xrLltgal/6OLM8p93Loz7urciWRIZ5A/zS7KY24tWQk8f3wozyG5
        3yzCUe99LjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7848076DC3;
        Sat, 20 Jun 2020 12:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3C1276DC1;
        Sat, 20 Jun 2020 12:54:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
        <20200620163845.871-1-shrinidhi.kaushik@gmail.com>
Date:   Sat, 20 Jun 2020 09:54:16 -0700
In-Reply-To: <20200620163845.871-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 20 Jun 2020 22:08:45 +0530")
Message-ID: <xmqqsgepekzr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD862CE4-B316-11EA-B34A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> The `diff-files' command and related commands which call the function
> `cmd_diff_files()', consider the "intent-to-add" files as a part of the
> index when comparing the work-tree against it. This was previously
> addressed in commits [1] and [2] by turning the option
> `--ita-invisible-in-index' (introduced in [3]) on by default.
>
> For `diff-files' (and `add -p' as a consequence) to show the i-t-a
> files as as new, `ita_invisible_in_index' will be enabled by default
> here as well.
>
> [1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default,
>                 2018-05-26)
> [2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
>                 in index", 2016-10-24)
> [3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)
>
> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---

Thanks.

> -test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
> +test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new for "diff --cached"' '
>  	git reset --hard &&
> +	: >empty &&
> +	content="foo" &&
> +	echo "$content" >not-empty &&
> +
> +	hash_e=$(git hash-object empty) &&
> +	hash_n=$(git hash-object not-empty) &&
> +	hash_t=$(git hash-object -t tree /dev/null) &&
> +
> +	cat >expect.diff_p <<-EOF &&
> +	diff --git a/empty b/empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_e)
> +	diff --git a/not-empty b/not-empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_n)
> +	--- /dev/null
> +	+++ b/not-empty
> +	@@ -0,0 +1 @@
> +	+$content
> +	EOF
> +	cat >expect.diff_s <<-EOF &&
> +	 create mode 100644 empty
> +	 create mode 100644 not-empty
> +	EOF
> +	cat >expect.diff_a <<-EOF &&
> +	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
> +	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty

This is good, but just FYI you did not have to use printf --- "<<-"
treats only leading tab specially, and not in the middle of a line.

> +	EOF
> +
> +	git add -N empty not-empty &&

OK.  So with two paths...

> +
> +	git diff >actual &&
> +	test_cmp expect.diff_p actual &&

... the patch output of "git diff", and

>  	git diff --summary >actual &&

... the summary part, and

> -	echo " create mode 100644 new-ita" >expected &&
> -	test_cmp expected actual &&
> -	git diff --cached --summary >actual2 &&
> -	test_must_be_empty actual2
> -'
> +	test_cmp expect.diff_s actual &&
> +
> +	git diff-files -p >actual &&
> +	test_cmp expect.diff_p actual &&
>
> +	git diff-files --abbrev >actual &&
> +	test_cmp expect.diff_a actual &&

... the same for "diff-files" and

> +	git diff --cached >actual &&

... "diff -cached" are all checked.

Looking good.

> +	test_must_be_empty actual
> +'
>
>  test_expect_success '"diff HEAD" includes ita as new files' '
>  	git reset --hard &&
> --
> 2.27.0

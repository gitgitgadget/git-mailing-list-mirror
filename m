Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F35C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DF6206A1
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIUs1Mzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbgJLWrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgJLWrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 18:47:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B7C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 15:47:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r4so11822706ioh.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAEELHbEfyhgF9t2qbXcHs1PbJdsn+tfzkZEnx+e0W0=;
        b=JIUs1MzlfWRJ5G6c6Q3NtWprHGoOyLYPj9b6WU0Qc+h0q0CpJ4KudL/dPWSabuBoFR
         hbTi2x++oIvp2WxUcroVTQR89nKCc7Mx0m+gvMMbyVWRTTKK7oOKbn32AORRsIhX6dlp
         yeb9RBtguAQ9xWWaDp+W/raCCzGTvWpKr15ZrtRmX8C7snTURoCR3pKifGztFXdiXDTE
         Gn5+TRQt4u+NNReEODNo9GZUsMyFUag8ZY4Fnve9bKeghdu5RG/sFqO6yGEVukwbTWxl
         t+3Cn6P8olsN4KbzvJcPSVMhMDYV79HQq4+1sV7cqxAW72wodGXmsbllOoe2LdteQC2k
         00+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TAEELHbEfyhgF9t2qbXcHs1PbJdsn+tfzkZEnx+e0W0=;
        b=MmP7c6wlsFfSfogud7NQ6C1jCYTANPdVIoSCtMfffJtaUcfXdZLx8m3RyMc4LRIOQk
         dk293VcOYmCvNwKnE8GUSQ1F21MDQe7SYvvfeH5RpSHQzw3UEpUE2vQ5O9scDCVFL5Dl
         GBAMrMG/5ESsTdbtbGvtvLoL8JptTfdbNlc9jLo0DklGvI1OhU//G2P6rsDNNyagVchU
         o6js0dPqTMx/WWu+WAXxDg2LFVVs1NQPI95/3vQB5ZDkBIERt2wZ7+8zvHD28o9ekWGK
         drsw11En2Cy62B+Oq7cYUwssSWapBQFctan0UUOAZ/cs65SLNFPoRP1E66/fAlF5Bea2
         M5Eg==
X-Gm-Message-State: AOAM532Hct12rFZfeNletOYFuKcUE4GOiA5uKRO0oD0AGUpuLkBKlJ+r
        VyYx6uNgPaTBqHaEMorJG40=
X-Google-Smtp-Source: ABdhPJzc0CpaQB3VdU/iFZOdOXYyErtCnexDjCfSUEWbygAOEKoiwb0aSLUnniUWDu91XY/47DDfjw==
X-Received: by 2002:a02:17ca:: with SMTP id 193mr7900725jah.115.1602542834919;
        Mon, 12 Oct 2020 15:47:14 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s69sm10287632ili.54.2020.10.12.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:47:14 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Mon, 12 Oct 2020 18:47:06 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages
 containing CRLF
Message-ID: <20201012224706.GA4318@flurp.local>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
 <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
 <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 06:09:27PM +0000, Philippe Blain via GitGitGadget wrote:
> Add a test library (t/lib-crlf-messages.sh) that creates refs with such
> commit messages, so that we can easily test that this bug does not
> appear in other commands in the future.

In addition to Junio's review comments...

> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/t/lib-crlf-messages.sh b/t/lib-crlf-messages.sh
> @@ -0,0 +1,90 @@
> +create_crlf_ref () {
> +	message="$1" &&
> +	subject="$2" &&
> +	body="$3" &&
> +	branch="$4" &&
> +	printf "${message}" >.crlf-message-${branch}.txt &&
> +	printf "${subject}" >.crlf-subject-${branch}.txt &&
> +	printf "${body}" >.crlf-body-${branch}.txt &&
> +	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}"

Broken &&-chain.

> +	test_tick &&
> +	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
> +	git branch ${branch} ${hash} &&
> +	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
> +}
> +
> +create_crlf_refs () {
> +	message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
> +	body="Body first line\r\nBody second line\r\n" &&
> +	subject="Subject first line" &&
> +	branch="crlf" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&

This is somewhat onerous to digest and compose. Have you considered
making it more automated and easier to read? Perhaps something like
this:

    create_crlf_ref () {
        branch=$1
        cat >.crlf-message-$branch.txt &&
        sed -n "1,/^$/p" <.crlf-message-$branch.txt | sed "/^$/d" | append_cr >.crlf-subject-$branch.txt &&
        sed -n "/^$/,\$p" <.crlf-message-$branch.txt | sed "1d" | append_cr >.crlf-body-$branch.txt &&
        ...
    }

    create_crlf_refs () {
        create_crlf_ref crlf <<-\EOF
        Subject first line

        Body first line
        Body second line
        EOF
        ...
    }

> +test_create_crlf_refs () {
> +	test_expect_success 'setup refs with CRLF commit messages' '
> +		create_crlf_refs
> +	'
> +}

This almost seems like an unnecessary indirection since callers could
just as easily do this on their own, like this:

    test_expect_success 'setup refs with CRLF commit messages' '
        create_crlf_refs
    '

which isn't very burdensome. However, I suppose doing it this way
gives consistent test titles between scripts, so not necessarily a
strong objection on my part.

> +cleanup_crlf_refs () {
> +	for branch in ${LIB_CRLF_BRANCHES}; do

Our style is to place 'do' on its own line:

    for branch in $LIB_CRLF_BRANCHES
    do
        ...

This would be a syntax error if LIB_CRLF_BRANCHES is empty for some
reason, but I suppose we don't really have to worry about it here(?).

> +		git branch -D ${branch} &&
> +		git tag -d tag-${branch} &&
> +		rm .crlf-message-${branch}.txt &&
> +		rm .crlf-subject-${branch}.txt &&
> +		rm .crlf-body-${branch}.txt
> +	done
> +}
> +
> +test_cleanup_crlf_refs () {
> +	test_expect_success 'cleanup refs with CRLF commit messages' '
> +		cleanup_crlf_refs
> +	'
> +}
> +
> +test_crlf_subject_body_and_contents() {
> +	command_and_args="$@" &&
> +	command=$1 &&
> +	if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
> +		atoms="(contents:subject) (contents:body) (contents)"
> +	elif [ ${command} = "log" ] || [ ${command} = "show" ]; then
> +		atoms="s b B"
> +	fi &&

Style:

    if test "$command" = "branch" || test ...
    then
        ...
    elif test ...
    then
        ...
    fi &&

> +	files="subject body message" &&
> +	while  [ -n "${atoms}" ]; do

Too many spaces after 'while'.

Style:

    while tests -n "..."
    do
        ...

> +		set ${atoms} && atom=$1 && shift && atoms="$*" &&
> +		set ${files} &&	file=$1 && shift && files="$*" &&
> +		test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
> +			rm -f expect &&
> +			for ref in ${LIB_CRLF_BRANCHES}; do

Style.

> +				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
> +				printf \"\n\" >>expect
> +			done &&
> +			git $command_and_args --format=\"%${atom}\" >actual &&
> +			test_cmp expect actual
> +		"
> +	done
> +}

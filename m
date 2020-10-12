Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331CC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E4E20797
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xE8kWVk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgJLWYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:24:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388361AbgJLWYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 18:24:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33F3F69DD1;
        Mon, 12 Oct 2020 18:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vIVuqjsNKRagc8qgQO+RkIB8PyA=; b=xE8kWV
        k10qTh1g8+Glq+BUOEMSz3z3C/RmY9rW40yIb6pF+yzMS01DSW3uXNrKgSkadhzc
        8bMTIEAa4l25fQ4K5107W4m1eamoQWC1JpOBCRTj0hVEY5cn2k0iqU+/PgcT75Vj
        Zd7C4io+xb81Z855lLesLoNHOp9cNclJoLrN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6ZLfdhmybXSR781uZ1xITZBtQO5LlVi
        YNaheHsa3/23W/e+1mc2EVKPMijJwnv061Z3qOXLOnvjUbOAeaib0ZNYCNE2bfv0
        qFmRh/bsne/RIq8iw+6uKWFQ5syfYZCPCg1cxFOnVM79oi4OCuJkq4D9+1b/IIWq
        Y7d9IUNAKHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A68A69DD0;
        Mon, 12 Oct 2020 18:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 993ED69DCF;
        Mon, 12 Oct 2020 18:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 2/3] ref-filter: handle CRLF at end-of-line more
 gracefully
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
        <11d044a4f7feccdf20da6364a1f9bbe934e9981f.1602526169.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 15:24:37 -0700
In-Reply-To: <11d044a4f7feccdf20da6364a1f9bbe934e9981f.1602526169.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 12 Oct 2020
        18:09:28 +0000")
Message-ID: <xmqqh7qzm6ai.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B73B17AA-0CD9-11EB-9A6D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	for (i = 0; i < len; i++)
> -		if (r[i] == '\n')
> -			r[i] = ' ';
> +	for (int i = 0; i < len; i++) {

We do not allow this in our codebase (yet).

cf. Documentation/CodingGuidelines

 - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
   is still not allowed in this codebase.

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 71818b90f0..c06eca774f 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -3,13 +3,11 @@
>  test_description='git branch display tests'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
> +. "$TEST_DIRECTORY"/lib-crlf-messages.sh
>  
>  test_expect_success 'make commits' '
> -	echo content >file &&
> -	git add file &&
> -	git commit -m one &&
> -	echo content >>file &&
> -	git commit -a -m two
> +	test_commit one &&
> +	test_commit two
>  '

What does this change have to do with the topic at hand?

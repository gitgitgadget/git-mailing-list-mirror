Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D30C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829622074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yikxBWJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgCYGlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:41:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58487 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCYGlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:41:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA46EAC7B0;
        Wed, 25 Mar 2020 02:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wahgASUwkPu2QvCV+hfObE3RHho=; b=yikxBW
        JFRiF7kXKKARxUZXgOsNDNyEgSCevoO1zr1tibbeSIvxjh/4nS8CIrNvA9n+o1kg
        jZgucgvd7khmbIvWeMb2JMGKIHiBVT1FCxOUjA/y8iTV1+FGKLVwrqaLNe5cvt0k
        JJ4RPaiY5pe/mRZEh9qNZrKyJ0BaEqw6lCe3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jocMpYpEduHcqJLnqc1576hunNGwTuQw
        A6A9vgzOxpHnVNnnsW/bf8Q2UaW8Q0ucrBWES/3FXXCFCysCLX2AzrHNV8nAjlwn
        gj+f96eBcM8Hb5t4G74/4ExwPmVsVd+RnwWqPZ1Ny08XBQZG6Ms+biLrQjz1Dvqi
        UfGDbxIDrrk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B26C0AC7AE;
        Wed, 25 Mar 2020 02:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5FEDAC7AA;
        Wed, 25 Mar 2020 02:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] t5512: generate references with generate_references()
References: <cover.1585115341.git.liu.denton@gmail.com>
        <674de50db28a50554d7af6e5c869c427d06f78aa.1585115341.git.liu.denton@gmail.com>
Date:   Tue, 24 Mar 2020 23:41:31 -0700
In-Reply-To: <674de50db28a50554d7af6e5c869c427d06f78aa.1585115341.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 25 Mar 2020 01:54:49 -0400")
Message-ID: <xmqqmu85x7fo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA804266-6E63-11EA-BD17-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +generate_references () {
> +	for i

Is it just me who thinks variables used in iteration should be
called i, j, etc. only when they are integers?

> +	do
> +		oid=$(git rev-parse "$i") || return 1
> +		printf '%s\t%s\n' "$oid" "$i"
> +	done
> +}
> +
>  test_expect_success setup '
>  	>file &&
>  	git add file &&
> @@ -43,34 +51,19 @@ test_expect_success 'ls-remote self' '
>  '
>  
>  test_expect_success 'ls-remote --sort="version:refname" --tags self' '
> -	cat >expect <<-EOF &&
> -	$(git rev-parse mark)	refs/tags/mark
> -	$(git rev-parse mark1.1)	refs/tags/mark1.1
> -	$(git rev-parse mark1.2)	refs/tags/mark1.2
> -	$(git rev-parse mark1.10)	refs/tags/mark1.10
> -	EOF
> +	generate_references refs/tags/mark refs/tags/mark1.1 refs/tags/mark1.2 refs/tags/mark1.10 >expect &&

Hmph, can we avoid overlong lines like this one?

	generate_references >expect <<-EOF
	refs/tags/mark
	refs/tags/mark1.1
	refs/tags/mark1.2
	refs/tags/mark1.10
	EOF

i.e. teaching the helper function to read from its standard input
stream, may make it more readable (i.e. it is more obvious what the
order of expected output lines are, as you are listing them one by
one on a line of its own).


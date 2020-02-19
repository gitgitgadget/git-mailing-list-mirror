Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68836C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CF72465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mqF7969/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBSR3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:29:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55688 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSR3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:29:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBCC346FE3;
        Wed, 19 Feb 2020 12:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/V5Sju2Cymh+ph5VQC+MB02Oc4=; b=mqF796
        9/rH5Wo4WnXTv7xAsKAEtdKTGCACo7NDuVWNbsUOiN9v17nr8eAlXUU4LzRtzi9v
        avjzwe+UkL8+vgEzB+890JN9NYjTDZE4LIDye1I5gDlvzwXFurIsqxJQaatBjjue
        oDIzUBmCn5qQ2DGgb0j9zvnv93eKwa7kOYe1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K7c5UanM/1lNIB2tMNQmjevVgVBQAJ0a
        AaBchq1sovvNeHYqPwz8atCA3kghUOwtFPXjVEK6J+rfXKG/TWQJwdktaEbKz3A3
        j/usmRV65tJjVPbk/l7YwdAulf0is5Bmq/d7xgXU27n3GP/rSDtVOa/Rdh7UC344
        H+s7TvFsPtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E292546FE2;
        Wed, 19 Feb 2020 12:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5447346FE1;
        Wed, 19 Feb 2020 12:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 4/5] t4214: use lib-log-graph functions
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200216134750.18947-4-abhishekkumar8222@gmail.com>
Date:   Wed, 19 Feb 2020 09:29:34 -0800
In-Reply-To: <20200216134750.18947-4-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sun, 16 Feb 2020 19:17:49 +0530")
Message-ID: <xmqqpneafptt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65C2BDFC-533D-11EA-8EA9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> @@ -24,7 +25,7 @@ test_expect_success 'set up merge history' '
>  '
>  
>  test_expect_success 'log --graph with tricky octopus merge, no color' '
> -	cat >expect.uncolored <<-\EOF &&
> +	test_cmp_graph --pretty=tformat:%s --color=never --date-order left octopus-merge <<-\EOF
>  	* left
>  	| *-.   octopus-merge
>  	|/|\ \
> @@ -37,14 +38,11 @@ test_expect_success 'log --graph with tricky octopus merge, no color' '
>  	|/
>  	* initial
>  	EOF
> -	git log --color=never --graph --date-order --pretty=tformat:%s left octopus-merge >actual.raw &&
> -	sed "s/ *\$//" actual.raw >actual &&
> -	test_cmp expect.uncolored actual
>  '
>  
>  test_expect_success 'log --graph with tricky octopus merge with colors' '
>  	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
> -	cat >expect.colors <<-\EOF &&
> +	test_cmp_colored_graph --pretty=tformat:%s --date-order left octopus-merge <<-\EOF
>  	* left
>  	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
>  	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET>
> @@ -57,16 +55,13 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
>  	<MAGENTA>|<RESET><MAGENTA>/<RESET>
>  	* initial
>  	EOF
> -	git log --color=always --graph --date-order --pretty=tformat:%s left octopus-merge >actual.colors.raw &&
> -	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
> -	test_cmp expect.colors actual.colors
>  '
> ...

Unlike the previous two steps, this does seem to make the script
cleaner and slightly more readable (it is still unreadable but that
is mostly due to the contents of the here-doc text and cannot be
helped ;-).


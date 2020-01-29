Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B9C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB5920661
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jqj8ZITi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgA2St4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:49:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57178 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2St4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:49:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9AF9419B8;
        Wed, 29 Jan 2020 13:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q5x3xTTCF8ZJ
        Tc4YeOqAwfxnvDA=; b=Jqj8ZITiuD7PqM/E+SDttvrLVhHjvwv32vix38RgnIxk
        ij1ykClULNWbELWVDkESZcnUWVxLy5Fth1pza2ox7zd1R6Sku5catNJjVmMveGRP
        duQmawXV1L915Fzi4a0c8wgtLa0804Inas2HPHHl1wer759JzqIBNRX6Tw1/udM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KkLC5A
        8dNZeeT6rCW2wrfANGd1CyxX4lLK0MPGgn8m3qByI5/H8kNyOSX6eIqHstxwejzM
        LLV0CBwHnf8JD3TAjIahymqrujikYUYWWGcnAA6tylPIw+k9wnMWjGZv1KSRbivo
        CM4pSgU6IJlg4XjIzrC6pjMh9TqgcNu+Vk5ZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C09A1419B7;
        Wed, 29 Jan 2020 13:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E9AC419B6;
        Wed, 29 Jan 2020 13:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 08/12] grep: allow submodule functions to run in parallel
References: <cover.1579141989.git.matheus.bernardino@usp.br>
        <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
        <20200129112613.GE10482@szeder.dev>
Date:   Wed, 29 Jan 2020 10:49:51 -0800
In-Reply-To: <20200129112613.GE10482@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 29 Jan 2020 12:26:13 +0100")
Message-ID: <xmqq36byf67k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22BF2836-42C8-11EA-9C60-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> this patch below and a7f3240877 (grep: ignore --recurse-submodules if
> --no-index is given, 2020-01-26) on topic
> 'pb/do-not-recurse-grep-no-index' don't work well together, and cause
> failure of the test 'grep --recurse-submodules --no-index ignores
> --recurse-submodules' in 't7814-grep-recurse-submodules.sh', i.e. in
> the new test added in a7f3240877.

Yup, I was looking at it and trying to see what was going on.

>> +	if (recurse_submodules && (!use_index || untracked))
>> +		die(_("option not supported with --recurse-submodules"));
>
> So this patch moves this condition here, expecting git to die with=20
> '--recurse-submodules --no-index'.  However, a7f3240877 removes the
> '!use_index' part of the condition, so we won't die here ...
>
>>  	if (list.nr || cached || show_in_pager) {
>>  		if (num_threads > 1)
>>  			warning(_("invalid option combination, ignoring --threads"));
>> @@ -1071,6 +1072,14 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
>>  		    && (opt.pre_context || opt.post_context ||
>>  			opt.file_break || opt.funcbody))
>>  			skip_first_line =3D 1;
>> +
>> +		/*
>> +		 * Pre-read gitmodules (if not read already) to prevent racy
>> +		 * lazy reading in worker threads.
>> +		 */
>> +		if (recurse_submodules)
>> +			repo_read_gitmodules(the_repository, 1);
>
> ... and eventually reach this condition, which then reads the
> submodules even with '--no-index', which is just what a7f3240877 tried
> to avoid, thus triggering the test failure.
>
> It might be that all we need is changing this condition to:
>
>   if (recurse_submodules && use_index)
>
> Or maybe not, but this change on top of 'pu' makes t7814 succeed
> again.

Sounds like a sensible idea.

Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F1C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32654227BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgmqAsLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLRWCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:02:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65447 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:02:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECF42A683A;
        Wed, 18 Dec 2019 17:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vzCVKWDwd6tyEyUX7V4N8tZX9/k=; b=rgmqAs
        Ln7H9qa0W6EiChzZ8472a5mkbgHozMjt5ulzjybZdqZcNhGAPvk/nMMQaIjaW8hM
        /47b9eOweb+YUJaNFr8NF9fgJ9gV+yscUpUOkX9lXRWQehVxv2nXP/+vhIdUVStU
        lKLRxg2zb/p7i/PkucxrFj5yKBZSLaXfQgqpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eWaDxiixQm9JSOC/z+y+BOYV8RGLLqvi
        36c1j4kae7wiwt+YB5iaGpcv0lknJOJpa3V7wLRyhhrx2QpESkbpp7r4X6GwZ5MQ
        /0KJRhxaTfBrO25boKJdpfYKgf/fIZ/W+jG5dX50R5jszlbhmZOOu6qwn9qs04Zj
        HkGzR3s+meI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E46FCA6839;
        Wed, 18 Dec 2019 17:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18E79A6838;
        Wed, 18 Dec 2019 17:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 02/18] t7526: add tests for error conditions
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <c7cd46d3a3bcbf4a5cfe2aa6aa71b3713801892b.1576511287.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 14:02:01 -0800
In-Reply-To: <c7cd46d3a3bcbf4a5cfe2aa6aa71b3713801892b.1576511287.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 16 Dec 2019
        15:47:50 +0000")
Message-ID: <xmqqr211cmxy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 065B4276-21E2-11EA-8964-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	test_must_fail git commit --pathspec-from-file=- --interactive -m "Commit" <list 2>err &&
> +	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patc
h" err &&

What's with the overly-noisy quoting of dashes here?  To match a
string that happens to begin with a dash, either one of

	$ grep -e "-this string begins with and has-many-dashes-in-it" file
	$ grep "[-]this string begins with and has-many-dashes-in-it" file

would be sufficient and more idiomatic.

Or am I missing some other reason why the test is written this way?

> +	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
> +	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
> +
> +	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
> +	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
> +
> +	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
> +	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
> +
> +	test_must_fail git commit --pathspec-from-file=- --include -m "Commit" <empty_list 2>err &&
> +	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err &&
> +
> +	test_must_fail git commit --pathspec-from-file=- --only -m "Commit" <empty_list 2>err &&
> +	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err
> +'
> +
>  test_done

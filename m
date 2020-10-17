Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F450C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E959207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o/JH90fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439815AbgJQW2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:28:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50421 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439616AbgJQW2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 18:28:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C55458B6B0;
        Sat, 17 Oct 2020 18:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qoSJZ23U0lsHi50ndffohGXEYgk=; b=o/JH90
        fq3x+8FZ4eiEFK+nFsThtkE7yg/TfqNRF1qz8YYgnGS3cDyAKuKZZOtW/e1+YsFO
        VdxWYfCqtKyb6ilfD8O4kpPF/Lt14w3Syi6frZQx9Jb/BwCr6uKKuzOUaTMSImRn
        jmEC1q83MVkcC6WSaRTRSEMt23PloSr7FV2mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpFqR3vBx7NsM7qvms7TthvCeNqdHXvq
        UN1vjQUQuW9EfBMcYkvmVpjSeDJhoC76LdeiJzONVuypQl/l3WFxbtxLdaut4Zux
        ZyfkY+LZrs/DesDm2zQy0jJ08k8yKbAoSiPr9o5/+17P1LIahI0N3W1wiAqoh+Uu
        60n5KlNgjd4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD3668B6AF;
        Sat, 17 Oct 2020 18:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AD448B6AC;
        Sat, 17 Oct 2020 18:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH 4/4] t/perf: add fsmonitor perf test for git diff
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <0613b07676e8abd0b4f342784b94d11174981537.1602968677.git.gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 15:28:01 -0700
In-Reply-To: <0613b07676e8abd0b4f342784b94d11174981537.1602968677.git.gitgitgadget@gmail.com>
        (Nipunn Koorapati via GitGitGadget's message of "Sat, 17 Oct 2020
        21:04:36 +0000")
Message-ID: <xmqqa6wk8p3i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04B61C04-10C8-11EB-B3FA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
> +	git diff

This is a whole-tree diff.  It would be interesting to also see if a
meaningful tradeoff exists if a test is run with a tree with say 100
top-level subdirectories but with just one of them covered by a
pathspec, with many modified paths sprinkled all over.

> +'
> +
>  if test_have_prereq WATCHMAN
>  then
>  	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&

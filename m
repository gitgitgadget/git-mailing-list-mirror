Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A09C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE23206EB
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rzSN6PBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHYVoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:44:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60996 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYVoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 17:44:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C119DF9B5;
        Tue, 25 Aug 2020 17:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Yfccct5rdoKNP1seISO72CKbKQ=; b=rzSN6P
        BiR+IMDjjLBLZGXkXfumVMKK2bss8XHP5NBOSZpvM5XhIjjipHnlIPPIklafD/LU
        iyVAbWtRYYlK/w1tVcS6HdyPCZ0Ng52QqVGly9yfaqfXbQrZVhCEhgMrduuGKkQp
        MHrIj1eMF4eFMsxHC8ErWp3vIoW9JPiYWkb0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ic8K3Y9mEFmrTc44vDQiRv2AaNERKlXA
        CaFp0ab9FrPGU/CQn8z7+zzIWMdp96kgn9WwDUFK2QgC1CXwRqlpXgHhsyTSejX2
        eGuyJYZUfOSwh275ZV7Z3BMXtLrceodMlQ9rMdTADRavTCki4HJdpM/ccvrW5GZu
        LxsMpK4YQuE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73FF5DF9B3;
        Tue, 25 Aug 2020 17:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D01B3DF9AD;
        Tue, 25 Aug 2020 17:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/7] maintenance: optionally skip --auto process
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598380805.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 14:44:14 -0700
In-Reply-To: <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598380805.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 25 Aug 2020
        18:39:58 +0000")
Message-ID: <xmqqlfi2z9ht.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FE96984-E71C-11EA-9A09-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Some commands run 'git maintenance run --auto --[no-]quiet' after doing
> their normal work, as a way to keep repositories clean as they are used.
> Currently, users who do not want this maintenance to occur would set the
> 'gc.auto' config option to 0 to avoid the 'gc' task from running.
> However, this does not stop the extra process invocation.

OK, that is because the configuration is checked on the other side,
and the new check is implemented on this side before we decide to
spawn the maintenance task.

It sounds like a change worth having without even waiting for the
"git maintenance" to materialize ;-).

> @@ -1868,8 +1869,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
>  
>  int run_auto_maintenance(int quiet)
>  {
> +	int enabled;
>  	struct child_process maint = CHILD_PROCESS_INIT;
>  
> +	if (!git_config_get_bool("maintenance.auto", &enabled) &&
> +	    !enabled)
> +		return 0;

So in a repository without this configuration, get_bool would fail
and we do not short-circuit.  Only if the value get_bool sees is
false, we return without running the command.  Makes sense.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF19D201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 01:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdKMBCT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 20:02:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751698AbdKMBCR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 20:02:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB8CDC0EBF;
        Sun, 12 Nov 2017 20:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YdZGYAq5il+ZMatdTaXGgoFhKo0=; b=XYBqc7
        pbOQwyz1QZy3Q7WMpQEaJL2BjScdYJxGjYG1VWxCIGa+7obfE/0BOOVzwrGGSfPr
        iN2ZWWT5r9JRGPaw5HF5Loznl9h3NRZ0+x60FidoPejppbprFIl0hawgicFEzlpd
        vl0G4m+KbhbAC8LkE1T7rQuMdkcxIIlDAJniM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBVH3HqIA2f3r4cJDaEzRXNffTnJ0DS8
        JlVGxWZCuwarEwh2XrAtG/WNBw4uTT6xE9Pr3IH97ZLvahlO70IyuxenfaG7AysV
        WKw9nWxJhd/1r8tAf76UPnec/DXIZh+cYwwHu7dhGbNsZkuBCyP+GQnBob1jnLnb
        YCVL/nua9xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C36E5C0EBE;
        Sun, 12 Nov 2017 20:02:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F396C0EBD;
        Sun, 12 Nov 2017 20:02:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Johannes.Schindelin@gmx.de, alexmv@dropbox.com,
        git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH v1] fsmonitor: simplify determining the git worktree under Windows
References: <xmqqzi7ug1w2.fsf@gitster.mtv.corp.google.com>
        <20171110210311.11036-1-benpeart@microsoft.com>
Date:   Mon, 13 Nov 2017 10:02:13 +0900
In-Reply-To: <20171110210311.11036-1-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 10 Nov 2017 16:03:11 -0500")
Message-ID: <xmqqzi7rat4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49498118-C80E-11E7-936F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> I haven't tested the non Windows paths but the patch looks reasonable.

I do not think the above line part of the proposed log message for
this patch ;-)  I guess I'll strip these earlier parts and leave
only the last paragraph while queuing.

>
> This inspired me to get someone more familiar with perl (thanks Johannes)
> to revisit this code for the Windows side as well.  The logic for
> determining the git worktree when running on Windows is more complex
> than necessary.  It also spawns multiple processes (uname and cygpath)
> which slows things down.
>
> Simplify and speed up the process of finding the git worktree when
> running on Windows by keeping it in perl and avoiding spawning helper
> processes.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The patch looks reasonable ;-)  Thanks.

> +if ($^O =~ 'msys' || $^O =~ 'cygwin') {
> +	$git_work_tree = Win32::GetCwd();
> +	$git_work_tree =~ tr/\\/\//;
>  } else {
>  	require Cwd;
>  	$git_work_tree = Cwd::cwd();
